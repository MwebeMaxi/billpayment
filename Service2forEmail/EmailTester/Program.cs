
using BillEmails.BusinessLogicEmail;
using System;

namespace EmailTester
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Starting email processor test...");

            try
            {
                var emailProcessor = new EmailProcessorService();

                //  Fetch and queue completed transactions for all vendors
                Console.WriteLine("Fetching and queuing transactions...");
                emailProcessor.FetchAndQueueTransactions();
                Console.WriteLine("Queueing completed.");

                //  Process queue and send emails
                Console.WriteLine("Processing queued transactions and sending emails...");
                emailProcessor.ProcessTransactions();  // This runs continuously, Ctrl+C to stop
            }
            catch (Exception ex)
            {
                Console.WriteLine("Test failed: " + ex.Message);
            }

            Console.WriteLine("Done.");
            Console.ReadLine(); // Keep console open if needed
        }
    }
}
