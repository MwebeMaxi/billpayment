using BillPaymentProject.objectControls;
using System;
using System.Collections.Generic;
using System.Data;

namespace BillPaymentProject.classobjects
{
    public class BillPaymentBusinessLogic
    {
        private readonly DatabaseHandler _databaseHandler;

        public BillPaymentBusinessLogic()
        {
            _databaseHandler = new DatabaseHandler();
        }

        public int CreateUser(BillPaymnet createUser)
        {
            if (string.IsNullOrWhiteSpace(createUser.Username) || string.IsNullOrWhiteSpace(createUser.PasswordHash))
            {
                throw new ArgumentException("Username and Password are required.");
            }

            return _databaseHandler.CreateUser(createUser);
        }

        public int CreateUtility(BillPaymnet utility)
        {
            if (string.IsNullOrWhiteSpace(utility.UtilityName) || string.IsNullOrWhiteSpace(utility.UtilityCode))
            {
                throw new ArgumentException("Utility Name and Code are required.");
            }

            if (utility.MinimumAmount.HasValue && utility.MinimumAmount < 0)
            {
                throw new ArgumentException("Minimum amount cannot be negative.");
            }

            if (utility.CreatedBy == null || utility.CreatedBy <= 0)
            {
                throw new ArgumentException("Valid CreatedBy user ID is required.");
            }

            return _databaseHandler.CreateUtyility(utility);
        }

        public int CreateUtilityPackage(BillPaymnet package)
        {
            if (package.UtilityID == null || package.UtilityID <= 0)
                throw new ArgumentException("Valid Utility ID is required.");

            if (string.IsNullOrWhiteSpace(package.PackageName) || string.IsNullOrWhiteSpace(package.PackageCode))
                throw new ArgumentException("Package Name and Code are required.");

            if (package.Amount == null || package.Amount <= 0)
                throw new ArgumentException("Package amount must be greater than 0.");

            if (package.CreatedBy == null || package.CreatedBy <= 0)
                throw new ArgumentException("Valid CreatedBy user ID is required.");

            return _databaseHandler.CreateUtilityPackage(package);
        }

        public List<BillPaymnet> GetUtilityPackages(int utilityId)
        {
            if (utilityId <= 0)
                throw new ArgumentException("Valid Utility ID is required.");

            return _databaseHandler.GetUtilityPackages(utilityId);
        }

        public List<BillPaymnet> GetAllUtilities()
        {
            return _databaseHandler.GetAllUtilities();
        }
        public List<BillPaymnet> GetAllVendors()
        {
            return _databaseHandler.GetAllVendors();
        }

        public BillPaymnet GetUtilityById(int utilityId)
        {
            if (utilityId <= 0)
                throw new ArgumentException("Valid Utility ID is required.");

            return _databaseHandler.GetUtilityById(utilityId);
        }

        public bool ValidatePaymentAmount(int utilityId, int? packageId, decimal amount)
        {
            if (utilityId <= 0)
                throw new ArgumentException("Valid Utility ID is required.");

            if (amount <= 0)
                throw new ArgumentException("Amount must be greater than 0.");

            return _databaseHandler.ValidatePaymentAmount(utilityId, packageId, amount);
        }



        public int CreateCustomer(BillPaymnet customer)
        {
            if (string.IsNullOrWhiteSpace(customer.CustomerName) || string.IsNullOrWhiteSpace(customer.PhoneNumber))
            {
                throw new ArgumentException("Customer name and phone number are required.");
            }

            return _databaseHandler.CreateCustomer(customer);
        }
        public int CreateVendor(BillPaymnet vendor)
        {
            if (string.IsNullOrWhiteSpace(vendor.VendorCode) || string.IsNullOrWhiteSpace(vendor.VendorName))
            {
                throw new ArgumentException("Vendor Code and Name are required.");
            }

            BillPaymnet result = _databaseHandler.CreateVendor(vendor);

            if (result.VendorID > 0)
            {
                return (int)result.VendorID;
            }


            throw new Exception(result.Message ?? "Unknown error creating vendor.");
        }

        public int LoginUsers(BillPaymnet users)
        {
            // Input validation
            if (string.IsNullOrWhiteSpace(users.Email) && string.IsNullOrWhiteSpace(users.Username))
            {
                throw new ArgumentException("Username or Email is required.");
            }

            if (string.IsNullOrWhiteSpace(users.PasswordHash))
            {
                throw new ArgumentException("Password is required.");
            }

            // Call DB handler to perform login
            int loginResult = _databaseHandler.LoginUser(users);


            // Handle the result
            switch (loginResult)
            {
                case -1:
                    throw new UnauthorizedAccessException("Invalid username/email or password.");
                case -2:
                    throw new UnauthorizedAccessException("Your account is locked due to multiple failed login attempts.");
                case -99:
                    throw new Exception("An internal error occurred while attempting login.");
                default:
                    
                    return loginResult; // This is the RoleID
            }
        }

        public string ValidateUtilityReference(BillPaymnet referenceInfo)
        {
            // Validate VendorID
            if (referenceInfo.VendorID == null || referenceInfo.VendorID <= 0)
                throw new ArgumentException("Valid Vendor ID is required.");

            // Validate ReferenceNumber
            if (string.IsNullOrWhiteSpace(referenceInfo.ReferenceNumber))
                throw new ArgumentException("Reference Number is required.");

            // Log the values being passed for debugging
            LogAction(0, "ValidateUtilityReference", $"VendorID: {referenceInfo.VendorID}, ReferenceNumber: {referenceInfo.ReferenceNumber}");

            var result = _databaseHandler.ValidateUtilityReference(referenceInfo);

            if (string.IsNullOrEmpty(result) || result == "Customer not found")
                throw new KeyNotFoundException("Customer not found for the given reference.");

            if (result.StartsWith("Error:"))
                throw new Exception(result);

            return result;
        }
        public string InitiateVendorPaymentTransaction(BillPaymnet transaction)
        {
            // Basic validations
            if (transaction.VendorID == null || transaction.VendorID <= 0)
                throw new ArgumentException("Valid Vendor ID is required.");

            if (string.IsNullOrWhiteSpace(transaction.ReferenceNumber))
                throw new ArgumentException("Reference Number is required.");

            if (string.IsNullOrWhiteSpace(transaction.UtilityCode))
                throw new ArgumentException("Utility Code is required.");

            if (transaction.Amount <= 0)
                throw new ArgumentException("Amount must be greater than 0.");

            if (transaction.CreatedBy == null || transaction.CreatedBy <= 0)
                throw new ArgumentException("Valid User ID is required.");

            // Validate customer reference and get utility info (including minimum amount)
            var customerValidation = new BillPaymnet
            {
                VendorID = transaction.VendorID,
                ReferenceNumber = transaction.ReferenceNumber
            };

            var customerInfoResult = _databaseHandler.ValidateUtilityReference(customerValidation);

            if (string.IsNullOrEmpty(customerInfoResult) || customerInfoResult == "Customer not found")
                throw new KeyNotFoundException("Customer not found for the given reference.");

            if (customerInfoResult.StartsWith("Error:"))
                throw new Exception(customerInfoResult);

            // Parse customer info to get utility details
            try
            {
                var customerInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(customerInfoResult);

                bool hasPackages = customerInfo.HasPackages;
                decimal minimumAmount = customerInfo.MinimumAmount;

                // Validate amount based on utility type
                if (hasPackages)
                {
                    // For utilities with packages, PackageID is required
                    if (transaction.PackageID == null)
                        throw new ArgumentException("Package selection is required for this utility.");

                   
                }
                else
                {
                    // For utilities without packages, validate minimum amount
                    if (transaction.Amount < minimumAmount)
                        throw new ArgumentException($"Amount must be at least {minimumAmount:C} for this utility.");
                }
            }
            catch (Newtonsoft.Json.JsonException)
            {
                throw new Exception("Invalid customer information format received.");
            }

            // Proceed with transaction initiation
            var result = _databaseHandler.InitiateVendorPaymentTransaction(transaction);

            if (string.IsNullOrEmpty(result) || result == "Transaction failed")
                throw new Exception("Failed to initiate payment transaction.");

            if (result.StartsWith("Error:"))
                throw new Exception(result);

            return result;
        }

        public List<BillPaymnet> GetUtilityPackagesByUtilityCode(string utilityCode)
        {
            if (string.IsNullOrWhiteSpace(utilityCode))
                throw new ArgumentException("Utility Code is required.");

            return _databaseHandler.GetUtilityPackagesByUtilityCode(utilityCode);
        }

        public List<BillPaymnet> GetPendingTransactions()
        {
            

            
            DataTable dt = _databaseHandler.GetAllPendingTransaction();

            List<BillPaymnet> transactionList = new List<BillPaymnet>();

            
            foreach (DataRow dr in dt.Rows)
            {
                BillPaymnet transaction = new BillPaymnet
                {
                    TransactionID = Guid.Parse(dr["TransactionID"].ToString()), 
                    VendorID = Convert.ToInt32(dr["VendorID"]),
                    CustomerID = Convert.ToInt32(dr["CustomerID"]),
                    UtilityID = Convert.ToInt32(dr["UtilityID"]),
                    ReferenceNumber = dr["ReferenceNumber"].ToString(),
                    Amount = Convert.ToDecimal(dr["Amount"]),
                    UtilityToken = dr["UtilityToken"].ToString(),
                    UtilityReceiptNo = dr["UtilityReceiptNo"].ToString(),
                 
                };

                transactionList.Add(transaction);
            }

            return transactionList;
        }
        public ApiResponse<string> UpdateUtilityTransactionResult(BillPaymnet bill)
        {
            try
            {
                _databaseHandler.UpdateUtilityTransactionResult(
                    (Guid)bill.TransactionID,
                    bill.UtilityToken,
                    bill.UtilityReceiptNo,
                    bill.Status
                );

                return new ApiResponse<string> { Success = true, Data = bill.TransactionID.ToString() };
            }
            catch (Exception ex)
            {
                return new ApiResponse<string> { Success = false, Message = ex.Message };
            }
        }


        public void UpdateUtilityTransactionResult(Guid? transactionID, string utilityToken, string receiptNo, string status)
        {
            throw new NotImplementedException();
        }


        public int LogAction(int userId, string action, string details, DateTime? timestamp = null)
        {
            var log = new AuditLog
            {
                UserID = userId,
                Action = action,
                Timestamp = timestamp ?? DateTime.Now,
                Details = details
            };

            return _databaseHandler.InsertAuditLog(log);
        }

        public string UpdateVendorInDb(BillPaymnet vendor)
        {
            try
            {
                DatabaseHandler dbHandler = new DatabaseHandler();
                return dbHandler.UpdateVendor(vendor);
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Failed to update vendor: " + ex.Message, ex);
            }
        }


    }
}
