using BillEmails.EmaiApi;

using MongoDB.Bson.IO;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Messaging;
using System.Net;
using System.Net.Mail;
using System.Threading;
using JsonConvert = Newtonsoft.Json.JsonConvert;

namespace BillEmails.BusinessLogicEmail
{
    public class EmailProcessorService
    {
        private const string queueName = @".\private$\TransactionQueueEmail";
        private const string logPath = @"C:\BillEmailService\log.txt";

        public void FetchAndQueueTransactions()
        {
            try
            {
                var api = new BillPaymentApiEndPoint();
                var response = api.GetCompletedTransactionsForAllVendors();

                if (response != null && response.Success && response.Data != null)
                {
                    if (!MessageQueue.Exists(queueName))
                        MessageQueue.Create(queueName);

                    using (MessageQueue queue = new MessageQueue(queueName))
                    {
                        foreach (var txn in response.Data)
                        {
                            string json = JsonConvert.SerializeObject(txn);
                            queue.Send(json);
                            LogToFile($"Queued Transaction: {txn.TransactionID}");
                        }
                    }
                }
                else
                {
                    LogToFile("No transactions fetched or API returned null.");
                }
            }
            catch (Exception ex)
            {
                LogToFile("Error fetching and queuing: " + ex.Message);
            }
        }

        public void ProcessTransactions()
        {
            try
            {
                if (!MessageQueue.Exists(queueName))
                    MessageQueue.Create(queueName);

                using (MessageQueue queue = new MessageQueue(queueName))
                {
                    queue.Formatter = new XmlMessageFormatter(new string[] { "System.String,mscorlib" });

                    while (true)
                    {
                        try
                        {
                            Message message = queue.Receive();
                            string json = message.Body.ToString();
                            var txn = JsonConvert.DeserializeObject<BillPaymnet>(json);

                            SendTransactionEmails(txn);
                            LogToFile($"Processed and emailed Transaction {txn.TransactionID}");
                        }
                        catch (Exception ex)
                        {
                            LogToFile("Queue processing error: " + ex.Message);
                        }

                        Thread.Sleep(1000); // avoid tight loop
                    }
                }
            }
            catch (Exception ex)
            {
                LogToFile("Queue processing setup failed: " + ex.Message);
            }
        }

        private void SendTransactionEmails(BillPaymnet txn)
        {
            try
            {
                string subject = $"Transaction Completed - {txn.TransactionID}";
                string body = $"Hello,\n\nTransaction Ref: {txn.ReferenceNumber}\nToken: {txn.UtilityToken}\nReceipt No: {txn.UtilityReceiptNo}\nAmount: {txn.Amount}\nProcessed At: {txn.ProcessedAt}";

                SendEmail(txn.ContactEmail, subject, body); // Vendor
                SendEmail(txn.Email, subject, body);        // Customer
            }
            catch (Exception ex)
            {
                LogToFile("Email send error: " + ex.Message);
            }
        }

        private void SendEmail(string to, string subject, string body)
        {
            try
            {
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("adamssebatta@gmail.com");
                mail.To.Add(to);
                mail.Subject = subject;
                mail.Body = body;

                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587)
                {
                    Credentials = new NetworkCredential("adamssebatta@gmail.com", "xhuh cpqf cqnr rpzr"),
                    EnableSsl = true
                };

                smtp.Send(mail);
            }
            catch (Exception ex)
            {
                LogToFile("SMTP Error for " + to + ": " + ex.Message);
            }
        }

        private void LogToFile(string message)
        {
            try
            {
                string dir = Path.GetDirectoryName(logPath);
                if (!Directory.Exists(dir))
                {
                    Directory.CreateDirectory(dir);
                }

                File.AppendAllText(logPath, $"{DateTime.Now}: {message}{Environment.NewLine}");
            }
            catch
            {
                // Optional: log elsewhere
            }
        }
    }
}
