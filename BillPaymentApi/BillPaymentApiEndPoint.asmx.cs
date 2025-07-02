using BillPaymentProject.classobjects;
using BillPaymentProject.objectControls;
using log4net;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Services;

namespace BillPaymentApi
{
    [WebService(Namespace = "https://localhost:44313/BillPaymentApiEndPoint.asmx")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class BillPaymentApiEndPoint : WebService
    {
        private readonly BillPaymentBusinessLogic _logic;
        private static readonly ILog log = LogManager.GetLogger(typeof(BillPaymentApiEndPoint));
        public BillPaymentApiEndPoint()
        {
            _logic = new BillPaymentBusinessLogic();
        }

        [WebMethod]
        public ApiResponse<int> CreateUser(string ReferenceNumber, string CustomerName, string phoneNumer, string UtilityCodse, int CreatedBy)
        {
            string action = "CreateUser";
            string details = $"Ref: {ReferenceNumber}, Name: {CustomerName}, Phone: {phoneNumer}, Utility: {UtilityCodse}";
            log.Info($"[{action}] Called with: {details}");
            _logic.LogAction(CreatedBy, action, details);

            try
            {
                BillPaymnet createUser = new BillPaymnet
                {
                    ReferenceNumber = ReferenceNumber,
                    CustomerName = CustomerName,
                    ContactPhone = phoneNumer,
                    UtilityCode = UtilityCodse,
                    CreatedBy = CreatedBy
                };

                return ApiOperationHandler.Handle(() => _logic.CreateUser(createUser), "User created successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(CreatedBy, $"{action} Failed", ex.Message);
                throw;
            }
        }

        [WebMethod]
        public ApiResponse<int> CreateCustomer(string ReferenceNumber, string CustomerName, string email, string phoneNumer, string password, string UtilityCodse, int CreatedBy)
        {
            string hashedPassword = PasswordHashing.Hash(password); // 🔒 Hash it here

            BillPaymnet createCustomer = new BillPaymnet
            {
                ReferenceNumber = ReferenceNumber,
                CustomerName = CustomerName,
                Email = email,
                PhoneNumber = phoneNumer,
                PasswordHash = hashedPassword, // 🔒 Save hashed password
                UtilityCode = UtilityCodse,
                CreatedBy = CreatedBy
            };

            return ApiOperationHandler.Handle(() => _logic.CreateCustomer(createCustomer), "Customer created successfully.");
        }
       
        [WebMethod]
        public ApiResponse<int> CreateVendor(string vendorCode, string vendorName, string conatactEmail, string conatatPhone, string password, decimal balance, int createdBy)
        {
            string action = "CreateVendor";
            string details = $"VendorCode: {vendorCode}, VendorName: {vendorName}, Email: {conatactEmail}, Phone: {conatatPhone}, Balance: {balance}";
            log.Info($"[{action}] Called with: {details}");
            _logic.LogAction(createdBy, action, details);

            try
            {
                BillPaymnet vendor = new BillPaymnet
                {
                    VendorCode = vendorCode,
                    VendorName = vendorName,
                    ContactEmail = conatactEmail,
                    ContactPhone = conatatPhone,
                    PasswordHash = password,
                    Balance = balance,
                    CreatedBy = createdBy
                };

                return ApiOperationHandler.Handle(() => _logic.CreateVendor(vendor), "Vendor created successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(createdBy, $"{action} Failed", ex.Message);
                throw;
            }
        }

        [WebMethod(EnableSession = true)]
        public ApiResponse<int> LoginUser(string username, string password)
        {
            string action = "LoginUser";
            string details = $"Username: {username}";
            log.Info($"[{action}] Called with: {details}");
            _logic.LogAction(0, action, details); // user ID not known yet

            try
            {
                BillPaymnet loginUser = new BillPaymnet
                {
                    Username = username,
                    PasswordHash = password
                };

                var result = _logic.LoginUsers(loginUser);
                return ApiOperationHandler.Handle(() => result, "Login successful.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);
                throw;
            }
        }
        [WebMethod]
        public ApiResponse<string> ValidateReference(int vendorID, string referenceNumber)
        {
            string action = "ValidateReference";
            string details = $"VendorID: {vendorID}, ReferenceNumber: {referenceNumber}";
            log.Info($"[{action}] Called with: {details}");
            _logic.LogAction(0, action, details);
            try
            {
                var input = new BillPaymnet
                {
                    VendorID = vendorID,
                    ReferenceNumber = referenceNumber
                };
                return ApiOperationHandler.Handle(() => _logic.ValidateUtilityReference(input), "Reference validated successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);
                throw;
            }
        }

        [WebMethod]
        public ApiResponse<List<BillPaymnet>> GetUtilityPackagesByUtilityCode(string utilityCode)
        {
            string action = "GetUtilityPackagesByUtilityCode";
            string details = $"UtilityCode: {utilityCode}";
            log.Info($"[{action}] Called with: {details}");
            _logic.LogAction(0, action, details);

            try
            {
                return ApiOperationHandler.Handle(() => _logic.GetUtilityPackagesByUtilityCode(utilityCode), "Packages retrieved successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);
                throw;
            }
        }



        [WebMethod]
        public ApiResponse<string> InitiateVendorPayment(int vendorID, string referenceNumber, string utilityCode, decimal amount, string packageID, int vendorUserID)
        {
            string action = "InitiateVendorPayment";
            string details = $"VendorID: {vendorID}, ReferenceNumber: {referenceNumber}, UtilityCode: {utilityCode}, Amount: {amount}, PackageID: {packageID}";
            log.Info($"[{action}] Called with: {details}");
            _logic.LogAction(vendorUserID, action, details);
            try
            {
                int? packageId = null;
                if (!string.IsNullOrEmpty(packageID) && int.TryParse(packageID, out int parsedPackageId))
                {
                    packageId = parsedPackageId;
                }

                var bill = new BillPaymnet
                {
                    VendorID = vendorID,
                    ReferenceNumber = referenceNumber,
                    UtilityCode = utilityCode,
                    Amount = amount,
                    PackageID = packageId,
                    CreatedBy = vendorUserID
                };
                return ApiOperationHandler.Handle(() => _logic.InitiateVendorPaymentTransaction(bill), "Transaction initiated successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(vendorUserID, $"{action} Failed", ex.Message);

                return new ApiResponse<string>
                {
                    Success = false,
                    Message = ex.Message,
                    Data = null
                };
            }

        }
       
        [WebMethod]
        public ApiResponse<List<BillPaymnet>> GetPendingTransactions()
        {
            string action = "GetPendingTransactions";
            log.Info($"[{action}] Called");
            _logic.LogAction(0, action, "Fetching all pending transactions");

            try
            {
                return ApiOperationHandler.Handle(() => _logic.GetPendingTransactions(), "Fetched pending transactions successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);
                throw;
            }
        }

        [WebMethod]
        public ApiResponse<string> UpdateUtilityTransactionResult(BillPaymnet bill)
        {
            string action = "UpdateUtilityTransactionResult";
            string details = $"ReferenceNumber: {bill.ReferenceNumber}, VendorCode: {bill.VendorCode}, UtilityCode: {bill.UtilityCode}, Amount: {bill.Amount}";

            log.Info($"[{action}] Called with: {details}");
            _logic.LogAction(Convert.ToInt32(bill.CreatedBy), action, details);

            try
            {
                return ApiOperationHandler.Handle(() =>
                {
                    _logic.UpdateUtilityTransactionResult(bill);
                    return "Success";
                }, "Transaction updated successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(Convert.ToInt32(bill.CreatedBy), $"{action} Failed", ex.Message);
                throw;
            }
        }

        [WebMethod]
        public ApiResponse<BillPaymnet> GetVendorDashboardInfo(int userId)
        {
            string action = "GetVendorDashboardInfo";
            log.Info($"[{action}] Called for UserID: {userId}");
            _logic.LogAction(userId, action, "Fetching vendor dashboard info");

            try
            {
                DatabaseHandler loged = new DatabaseHandler();
                var vendorDashboard = loged.GetVendorDashboardSummary(userId);

                return ApiOperationHandler.Handle(() => vendorDashboard, "Fetched vendor dashboard info successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(userId, $"{action} Failed", ex.Message);
                throw;
            }
        }

        [WebMethod]
        public ApiResponse<List<BillPaymnet>> GetVendersCustomerInformation(int userId)
        {
            string action = "GetVendersCustomerInformation";
            log.Info($"[{action}] Called for UserID: {userId}");
            _logic.LogAction(userId, action, "Fetching vendor's customer info");

            try
            {
                DatabaseHandler loged = new DatabaseHandler();
                var vendorCustomers = loged.GetCustomerAndVendorInfoEmail(userId);

                return ApiOperationHandler.Handle(() => vendorCustomers, "Fetched vendor's customer info successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(userId, $"{action} Failed", ex.Message);
                throw;
            }
        }

        [WebMethod]
        public ApiResponse<List<BillPaymnet>> GetCompletedTransactionsForAllVendors()
        {
            string action = "GetCompletedTransactionsForAllVendors";
            log.Info($"[{action}] Called");
            _logic.LogAction(0, action, "Fetching all completed vendor transactions");

            try
            {
                DatabaseHandler dbHandler = new DatabaseHandler();
                var transactions = dbHandler.GetCompletedTransactionsForAllVendors();

                return ApiOperationHandler.Handle(() => transactions, "Fetched all completed vendor transactions successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);
                throw;
            }
        }

        [WebMethod]
        public ApiResponse<List<BillPaymnet>> GetCompletedTransactions(int vendorId)
        {
            string action = "GetCompletedTransactions";
            log.Info($"[{action}] Called for VendorID: {vendorId}");
            _logic.LogAction(vendorId, action, "Fetching completed transactions for vendor");

            try
            {
                DatabaseHandler db = new DatabaseHandler();
                var transactions = db.GetCompletedTransactionsByVendor(vendorId);

                return ApiOperationHandler.Handle(() => transactions, "Fetched completed transactions.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(vendorId, $"{action} Failed", ex.Message);
                throw;
            }
        }

        [WebMethod(EnableSession = true)]
        public ApiResponse<BillPaymnet> LoginUser2(string username, string password)
        {
            string action = "LoginUser2";
            string details = $"Username: {username}";
            log.Info($"[{action}] Called with: {details}");
            _logic.LogAction(0, action, details);

            




            try
            {
                string hashedPassword = PasswordHashing.Hash(password);
                BillPaymnet loginUser = new BillPaymnet
                {
                    Username = username,
                    PasswordHash = hashedPassword
                };

                DatabaseHandler db = new DatabaseHandler();
                var result = db.LoginUser2(loginUser);

                return ApiOperationHandler.Handle(() => result, "Login successful.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);
                throw;
            }
        }




        [WebMethod]
        public ApiResponse<List<BillPaymnet>> GetSuperAdminSummary(int userId)
        {
            string action = "GetSuperAdminSummary";
            log.Info($"[{action}] Called for UserID: {userId}");
            _logic.LogAction(userId, action, "Fetching SuperAdmin dashboard summary");

            try
            {
                DatabaseHandler db = new DatabaseHandler();

                // Call the method that runs the stored procedure and maps the data
                var data = db.GetSuperAdminSummary(userId);

                return ApiOperationHandler.Handle(() => data, "Fetched SuperAdmin summary successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(userId, $"{action} Failed", ex.Message);
                throw;
            }
        }


        [WebMethod]
        public ApiResponse<DataTable> GetCustomerTransactionsByReference(string referenceNumber)
        {
            string action = "GetCustomerTransactionsByReference";
            log.Info($"[{action}] Called with ReferenceNumber: {referenceNumber}");
            _logic.LogAction(0, action, $"Fetching transactions for reference: {referenceNumber}");

            try
            {
                DatabaseHandler dbHandler = new DatabaseHandler();
                DataTable dt = dbHandler.GetCustomerTransactionsByReference(referenceNumber);

                if (dt == null || dt.Rows.Count == 0)
                {
                    return ApiOperationHandler.Handle(() => dt, "No transactions found for the given reference number.");
                }

                return ApiOperationHandler.Handle(() => dt, "Transactions fetched successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);
                throw;
            }
        }



        [WebMethod]
        public ApiResponse<int> CreateUtilityAdvanced(string UtilityName, string UtilityCode, string HasPackages, string MinimumAmount, int CreatedBy)
        {
            string action = "CreateUtilityAdvanced";
            string details = $"UtilityName: {UtilityName}, UtilityCode: {UtilityCode}, HasPackages: {HasPackages}, MinimumAmount: {MinimumAmount}";
            log.Info($"[{action}] Called with: {details}");
            _logic.LogAction(CreatedBy, action, details);

            try
            {
                // Convert string parameters to proper types
                bool hasPackages = !string.IsNullOrEmpty(HasPackages) &&
                                  (HasPackages.ToLower() == "true" || HasPackages == "1");

                decimal? minimumAmount = null;
                if (!string.IsNullOrEmpty(MinimumAmount) && decimal.TryParse(MinimumAmount, out decimal parsedAmount))
                {
                    minimumAmount = parsedAmount;
                }

                BillPaymnet utility = new BillPaymnet
                {
                    UtilityCode = UtilityCode,
                    UtilityName = UtilityName,
                    HasPackages = hasPackages,
                    MinimumAmount = minimumAmount,
                    CreatedBy = CreatedBy
                };

                return ApiOperationHandler.Handle(() => _logic.CreateUtility(utility), "Utility created successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(CreatedBy, $"{action} Failed", ex.Message);
                throw;
            }
        }

        // Add these additional WebMethods for complete testing:

        [WebMethod]
        public ApiResponse<int> CreateUtilityPackage(int UtilityID, string PackageName, string PackageCode, decimal Amount, string PackageDescription, int CreatedBy)
        {
            string action = "CreateUtilityPackage";
            string details = $"UtilityID: {UtilityID}, PackageName: {PackageName}, PackageCode: {PackageCode}, Amount: {Amount}";
            log.Info($"[{action}] Called with: {details}");
            _logic.LogAction(CreatedBy, action, details);

            try
            {
                BillPaymnet package = new BillPaymnet
                {
                    UtilityID = UtilityID,
                    PackageName = PackageName,
                    PackageCode = PackageCode,
                    Amount = Amount,
                    PackageDescription = PackageDescription,
                    CreatedBy = CreatedBy
                };

                return ApiOperationHandler.Handle(() => _logic.CreateUtilityPackage(package), "Package created successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(CreatedBy, $"{action} Failed", ex.Message);
                throw;
            }
        }

        [WebMethod]
        public ApiResponse<List<BillPaymnet>> GetUtilityPackages(int UtilityID)
        {
            string action = "GetUtilityPackages";
            log.Info($"[{action}] Called for UtilityID: {UtilityID}");
            _logic.LogAction(0, action, $"Fetching packages for UtilityID: {UtilityID}");

            try
            {
                return ApiOperationHandler.Handle(() => _logic.GetUtilityPackages(UtilityID), "Packages retrieved successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);
                throw;
            }
        }

        [WebMethod]
        public ApiResponse<List<BillPaymnet>> GetAllUtilities()
        {
            string action = "GetAllUtilities";
            log.Info($"[{action}] Called");
            _logic.LogAction(0, action, "Fetching all utilities");

            try
            {
                return ApiOperationHandler.Handle(() => _logic.GetAllUtilities(), "Utilities retrieved successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);
                throw;
            }
        }
        [WebMethod]
        public ApiResponse<List<BillPaymnet>> GetAllvendors()
        {
            string action = "GetAllVendors";
            log.Info($"[{action}] Called");
            _logic.LogAction(0, action, "Fetching all Vendors");

            try
            {
                return ApiOperationHandler.Handle(() => _logic.GetAllVendors(), "Vendors retrieved successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);
                throw;
            }
        }

        [WebMethod]
        public ApiResponse<BillPaymnet> GetUtilityById(int UtilityID)
        {
            string action = "GetUtilityById";
            log.Info($"[{action}] Called for UtilityID: {UtilityID}");
            _logic.LogAction(0, action, $"Fetching utility with ID: {UtilityID}");

            try
            {
                return ApiOperationHandler.Handle(() => _logic.GetUtilityById(UtilityID), "Utility retrieved successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);
                throw;
            }
        }

        [WebMethod]
        public ApiResponse<bool> ValidatePaymentAmount(int UtilityID, string PackageID, decimal Amount)
        {
            string action = "ValidatePaymentAmount";
            string details = $"UtilityID: {UtilityID}, PackageID: {PackageID}, Amount: {Amount}";
            log.Info($"[{action}] Called with: {details}");
            _logic.LogAction(0, action, details);

            try
            {
                int? packageId = null;
                if (!string.IsNullOrEmpty(PackageID) && int.TryParse(PackageID, out int parsedPackageId))
                {
                    packageId = parsedPackageId;
                }

                return ApiOperationHandler.Handle(() => _logic.ValidatePaymentAmount(UtilityID, packageId, Amount), "Payment amount validated successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);
                throw;
            }
        }


        [WebMethod(EnableSession = true)]
        public ApiResponse<BillPaymnet> LoginUser2WithLockout(string username, string password)
        {
            string action = "LoginUser2WithLockout";
            string details = $"Username: {username}";
            log.Info($"[{action}] Called with: {details}");
            _logic.LogAction(0, action, details);

            try
            {
                //string hashedPassword = PasswordHashing.Hash(password);
                BillPaymnet loginUser = new BillPaymnet
                {
                    Username = username,
                    PasswordHash = password
                };

                DatabaseHandler db = new DatabaseHandler();
                var result = db.LoginUser2WithLockout(loginUser);

                if (result.IsSuccess)
                {
                    return ApiOperationHandler.Handle(() => result, "Login successful.");
                }
                else
                {
                    return ApiResponse<BillPaymnet>.Fail(result.Message);
                }
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);
                throw;
            }
        }

        [WebMethod(EnableSession = true)]
        public ApiResponse<BillPaymnet> CheckUserExists(string usernameOrEmail)
        {
            string action = "CheckUserExists";
            string details = $"UsernameOrEmail: {usernameOrEmail}";
            log.Info($"[{action}] Called with: {details}");
            _logic.LogAction(0, action, details);

            try
            {
                if (string.IsNullOrWhiteSpace(usernameOrEmail))
                {
                    return ApiResponse<BillPaymnet>.Fail("Username or Email is required.");
                }

                DatabaseHandler db = new DatabaseHandler();
                // Call your business logic which returns a JSON string currently
                string jsonResult = db.CheckUserExists(usernameOrEmail);

                if (string.IsNullOrWhiteSpace(jsonResult) || jsonResult.StartsWith("Error") || jsonResult.StartsWith("User not found"))
                {
                    return ApiResponse<BillPaymnet>.Fail(jsonResult ?? "User not found.");
                }

                // Deserialize JSON string to BillPaymnet object
                BillPaymnet user = Newtonsoft.Json.JsonConvert.DeserializeObject<BillPaymnet>(jsonResult);

                if (user == null)
                {
                    return ApiResponse<BillPaymnet>.Fail("Failed to parse user data.");
                }

                return ApiOperationHandler.Handle(() => user, "User exists.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);
                return ApiResponse<BillPaymnet>.Fail("Error checking user existence: " + ex.Message);
            }
        }

        [WebMethod]
        public ApiResponse<BillPaymnet> ResetUserPassword(string usernameOrEmail, string password)
        {
            string action = "ResetUserPassword";
            string details = $"UsernameOrEmail: {usernameOrEmail}";
            log.Info($"[{action}] Called with: {details}");
            _logic.LogAction(0, action, details);

            try
            {
                if (string.IsNullOrWhiteSpace(usernameOrEmail) || string.IsNullOrWhiteSpace(password))
                {
                    return ApiResponse<BillPaymnet>.Fail("Username/Email and password are required.");
                }

                //// Optional: Hash password before resetting
                //string hashedPassword = PasswordHashing.Hash(password);

                BillPaymnet resetRequest = new BillPaymnet
                {
                    Username = usernameOrEmail, // fallback if Email is null
                   
                    PasswordHash = password
                };

                DatabaseHandler db = new DatabaseHandler();
                BillPaymnet result = db.ResetUserPassword(resetRequest);

                if (result != null && result.LoginResultCode == 1)
                {
                    return ApiOperationHandler.Handle(() => result, result.Message);
                }
                else
                {
                    return ApiResponse<BillPaymnet>.Fail(result?.Message ?? "Unknown failure.");
                }
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);
                return ApiResponse<BillPaymnet>.Fail("Error while resetting password: " + ex.Message);
            }
        }


        [WebMethod]
        public ApiResponse<string> UpdateVendorInfo(int vendorID, string vendorCode, string vendorName, string contactEmail, string contactPhone, decimal balance, int modifiedBy)
        {
            string action = "UpdateVendorInfo";
            string details = $"VendorID: {vendorID}, VendorCode: {vendorCode}, VendorName: {vendorName}, Email: {contactEmail}, Phone: {contactPhone}, Balance: {balance}";

            log.Info($"[{action}] Called with: {details}");
            _logic.LogAction(modifiedBy, action, details);

            try
            {
                BillPaymnet vendor = new BillPaymnet
                {
                    VendorID = vendorID,
                    VendorCode = vendorCode,
                    VendorName = vendorName,
                    ContactEmail = contactEmail,
                    ContactPhone = contactPhone,
                    Balance = balance,
                   CreatedBy = modifiedBy
                };

                return ApiOperationHandler.Handle(() =>
                {
                    string resultMessage = _logic.UpdateVendorInDb(vendor);  // Logic layer
                    return resultMessage;
                }, "Vendor updated successfully.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(modifiedBy, $"{action} Failed", ex.Message);

                return new ApiResponse<string>
                {
                    Success = false,
                    Message = ex.Message,
                    Data = null
                };
            }
        }




        [WebMethod]
        public ApiResponse<List<BillPaymnet>> CheckPasswordExpiry()
        {
            string action = "CheckPasswordExpiry";
            log.Info($"[{action}] Called");
            _logic.LogAction(0, action, "Checking for expired passwords");

            try
            {
                DatabaseHandler db = new DatabaseHandler();
                var expiredUsers = db.CheckPasswordExpiry(); // this is the method we wrote earlier

                return ApiOperationHandler.Handle(() => expiredUsers, "Password expiry check completed.");
            }
            catch (Exception ex)
            {
                log.Error($"[{action}] Error: {ex}");
                _logic.LogAction(0, $"{action} Failed", ex.Message);

                return new ApiResponse<List<BillPaymnet>>
                {
                    Success = false,
                    Message = "Error checking password expiry: " + ex.Message,
                    Data = null
                };
            }
        }


        [WebMethod]
        public string Get(string refrenceNo) 
        {
            DatabaseHandler obg = new DatabaseHandler();
          

            string results = obg.ValidateUtilityReference2(refrenceNo);

            return results;

        }

    }


}

public static class PasswordHashing
{
    public static string Hash(string password)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] bytes = Encoding.UTF8.GetBytes(password);
            byte[] hash = sha256.ComputeHash(bytes);
            return BitConverter.ToString(hash).Replace("-", "").ToLower();
        }
    }
}
