using BillEmails.BusinessLogicEmail; // Import your logic class
using System;
using System.Diagnostics;
using System.Messaging;
using System.ServiceProcess;
using System.Threading.Tasks;

namespace BillPaymentWindowsServicve2
{
    public partial class Service1 : ServiceBase
    {
        private const string queueName = @".\private$\TransactionQueueEmail";
        private System.Timers.Timer pollingTimer;
        private EmailProcessorService emailProcessor;

        public Service1()
        {
            InitializeComponent();
            emailProcessor = new EmailProcessorService(); // Instantiate the logic class
        }

        protected override void OnStart(string[] args)
        {
            try
            {
                if (!MessageQueue.Exists(queueName))
                    MessageQueue.Create(queueName);

                LogToQueue("Email Service started.");

                
                pollingTimer = new System.Timers.Timer(10000);
                pollingTimer.Elapsed += (s, e) =>
                {
                    emailProcessor.FetchAndQueueTransactions();
                };
                pollingTimer.Start();

                // Start processing in background
                Task.Run(() => emailProcessor.ProcessTransactions());
            }
            catch (Exception ex)
            {
                EventLog.WriteEntry("Service1", "Service start error: " + ex.Message, EventLogEntryType.Error);
            }
        }

        protected override void OnStop()
        {
            pollingTimer?.Stop();
            pollingTimer?.Dispose();

            LogToQueue("Email Service stopped.");
        }

        private void LogToQueue(string message)
        {
            try
            {
                if (!MessageQueue.Exists(queueName))
                    MessageQueue.Create(queueName);

                using (MessageQueue queue = new MessageQueue(queueName))
                {
                    queue.Send($"[LOG] {DateTime.Now}: {message}");
                }
            }
            catch
            {
                // Optional: write to EventLog or fallback
            }
        }
    }
}
