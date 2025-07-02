using BillPaymentProject.objectControls;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Security.Policy;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;

namespace BillPaymentProject.classobjects
{



    public class DatabaseHandler
    {
        private DbCommand command;
        private Database db;
        private Database db2;
        public DatabaseHandler()
        {
            DatabaseProviderFactory factory = new DatabaseProviderFactory();
            db = factory.Create("BillPayment");
            db2 = factory.Create("NationalWaterDB");
            


        }



        public string ValidateUtilityReference2(string referenceNumber)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(referenceNumber))
                    return "Error: Reference number is required.";

                command = db2.GetStoredProcCommand("sp_ValidateUtilityReference", referenceNumber);

                DataSet ds = db2.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    DataRow row = ds.Tables[0].Rows[0];
                    var result = new
                    {
                        ReferenceNumber = row["ReferenceNumber"].ToString(),
                        CustomerName = row["CustomerName"].ToString(),
                        Email = row["Email"].ToString(),
                        Phone = row["Phone"].ToString(),
                        UtilityID = Convert.ToInt32(row["UtilityID"]),
                        UtilityCode = row["UtilityCode"].ToString(),
                        UtilityName = row["UtilityName"].ToString(),
                        HasPackages = Convert.ToBoolean(row["HasPackages"]),
                        MinimumAmount = row["MinimumAmount"] != DBNull.Value ? Convert.ToDecimal(row["MinimumAmount"]) : 0
                    };

                    return Newtonsoft.Json.JsonConvert.SerializeObject(result);
                }

                return "Customer not found.";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }


        public int CreateUser(BillPaymnet createuser)
        {
            try
            {
                command = db.GetStoredProcCommand("CreateUser", new object[]
                {

                    createuser.UserID,
                     createuser.Username,
                     createuser.PasswordHash,
                    createuser.Email,
                    createuser.PhoneNumber



                });
                DataSet ds = db.ExecuteDataSet(command);
                int newId = Convert.ToInt32(ds.Tables[0].Rows[0]["newUserId"]);

                return newId;


            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        public int CreateUtyility(BillPaymnet createUtility)
        {
            try
            {
                command = db.GetStoredProcCommand("CreateUtility", new object[]
                {
            createUtility.UtilityName,
            createUtility.UtilityCode,
            createUtility.HasPackages ?? false,
            createUtility.MinimumAmount ?? 0,
            createUtility.CreatedBy
                });
                DataSet ds = db.ExecuteDataSet(command);
                int newId = Convert.ToInt32(ds.Tables[0].Rows[0]["UtilityID"]);
                return newId;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error creating utility: " + ex.Message);
                return 0;
            }
        }

        public int CreateUtilityPackage(BillPaymnet package)
        {
            try
            {
                command = db.GetStoredProcCommand("sp_CreateUtilityPackage", new object[]
                {
            package.UtilityID,
            package.PackageName,
            package.PackageCode,
            package.Amount,
            package.PackageDescription,
            package.CreatedBy
                });
                DataSet ds = db.ExecuteDataSet(command);
                int newId = Convert.ToInt32(ds.Tables[0].Rows[0]["PackageID"]);
                return newId;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error creating package: " + ex.Message);
                return 0;
            }
        }

        public List<BillPaymnet> GetUtilityPackages(int utilityId)
        {
            try
            {
                command = db.GetStoredProcCommand("sp_GetUtilityPackages", utilityId);
                DataSet ds = db.ExecuteDataSet(command);
                var packages = new List<BillPaymnet>();

                if (ds != null && ds.Tables.Count > 0)
                {
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        packages.Add(new BillPaymnet
                        {
                            PackageID = Convert.ToInt32(row["PackageID"]),
                            PackageName = row["PackageName"].ToString(),
                            PackageCode = row["PackageCode"].ToString(),
                            Amount = Convert.ToDecimal(row["Amount"]),
                            PackageDescription = row["Description"]?.ToString(),
                            UtilityName = row["UtilityName"].ToString(),
                            UtilityCode = row["UtilityCode"].ToString(),
                            IsActive = Convert.ToBoolean(row["IsActive"]),
                            CreatedAt = Convert.ToDateTime(row["CreatedAt"])
                        });
                    }
                }
                return packages;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error getting packages: " + ex.Message);
                return new List<BillPaymnet>();
            }
        }
        public BillPaymnet GetUtilityById(int utilityId)
        {
            try
            {
                command = db.GetStoredProcCommand("sp_GetUtilityById", utilityId);
                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    DataRow row = ds.Tables[0].Rows[0];
                    return new BillPaymnet
                    {
                        UtilityID = Convert.ToInt32(row["UtilityID"]),
                        UtilityName = row["UtilityName"].ToString(),
                        UtilityCode = row["UtilityCode"].ToString(),
                        HasPackages = Convert.ToBoolean(row["HasPackages"]),
                        MinimumAmount = Convert.ToDecimal(row["MinimumAmount"]),
                        CreatedAt = Convert.ToDateTime(row["CreatedAt"])
                    };
                }
                return null;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error getting utility: " + ex.Message);
                return null;
            }
        }

        public bool ValidatePaymentAmount(int utilityId, int? packageId, decimal amount)
        {
            try
            {
                command = db.GetStoredProcCommand("sp_ValidatePaymentAmount", new object[]
                {
            utilityId,
            packageId,
            amount
                });
                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    return Convert.ToBoolean(ds.Tables[0].Rows[0]["IsValid"]);
                }
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error validating payment amount: " + ex.Message);
                return false;
            }
        }


        public List<BillPaymnet> GetAllUtilities()
        {
            try
            {
                command = db.GetStoredProcCommand("sp_GetAllUtilities");
                DataSet ds = db.ExecuteDataSet(command);
                var utilities = new List<BillPaymnet>();

                if (ds != null && ds.Tables.Count > 0)
                {
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        utilities.Add(new BillPaymnet
                        {
                            UtilityName = row["UtilityName"]?.ToString() ?? string.Empty,
                            UtilityCode = row["UtilityCode"]?.ToString() ?? string.Empty,
                            HasPackages = row["HasPackages"] != DBNull.Value && Convert.ToBoolean(row["HasPackages"]),
                            MinimumAmount = row["MinimumAmount"] != DBNull.Value ? Convert.ToDecimal(row["MinimumAmount"]) : 0,
                            CreatedAt = row["CreatedAt"] != DBNull.Value ? Convert.ToDateTime(row["CreatedAt"]) : DateTime.MinValue
                        });

                    }
                }
                return utilities;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error getting utilities: " + ex.Message);
                return new List<BillPaymnet>();
            }
        }

        public List<BillPaymnet> GetAllVendors()
        {
            try
            {
                command = db.GetStoredProcCommand("sp_GetAllVendors");
                DataSet ds = db.ExecuteDataSet(command);
                var vendors = new List<BillPaymnet>();

                if (ds != null && ds.Tables.Count > 0)
                {
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        vendors.Add(new BillPaymnet
                        {
                            VendorID = row["VendorID"] != DBNull.Value ? Convert.ToInt32(row["VendorID"]) : 0,
                            VendorCode = row["VendorCode"]?.ToString() ?? string.Empty,
                            VendorName = row["VendorName"]?.ToString() ?? string.Empty,
                            ContactEmail = row["ContactEmail"]?.ToString() ?? string.Empty,
                            ContactPhone = row["ContactPhone"]?.ToString() ?? string.Empty,
                            Balance = row["Balance"] != DBNull.Value ? Convert.ToDecimal(row["Balance"]) : 0,
                            CreatedAt = row["CreatedAt"] != DBNull.Value ? Convert.ToDateTime(row["CreatedAt"]) : DateTime.MinValue,
                            Email = row["UserEmail"]?.ToString() ?? string.Empty,
                            UserID = row["UserID"] != DBNull.Value ? Convert.ToInt32(row["UserID"]) : 0
                        });
                    }
                }

                return vendors;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error getting vendors: " + ex.Message);
                return new List<BillPaymnet>();
            }
        }



        public int CreateCustomer(BillPaymnet customer)
        {
            try
            {
                command = db.GetStoredProcCommand("sp_CreateCustomer", new object[] {
                customer.ReferenceNumber,
                customer.CustomerName,
                 customer.Email,
                customer.PhoneNumber,
                customer.PasswordHash,
                customer.UtilityCode,
                customer.CreatedBy


                });
                DataSet ds = db.ExecuteDataSet(command);
                int newId = Convert.ToInt32(ds.Tables[0].Rows[0]["CustomerId"]);

                return newId;


            }
            catch (Exception ex)
            {

                return 0;

            }
        }

        public BillPaymnet CreateVendor(BillPaymnet vendor)
        {
            try
            {
                command = db.GetStoredProcCommand("sp_CreateVendor", new object[]
                {
            vendor.VendorCode,
            vendor.VendorName,
            vendor.ContactEmail,
            vendor.ContactPhone,
            vendor.PasswordHash,
            vendor.Balance,
            vendor.CreatedBy
                });

                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    var row = ds.Tables[0].Rows[0];
                    return new BillPaymnet
                    {
                        VendorID = row["VendorID"] != DBNull.Value ? Convert.ToInt32(row["VendorID"]) : 0,
                        UserID = row["UserID"] != DBNull.Value ? Convert.ToInt32(row["UserID"]) : 0,
                        Message = "Vendor created successfully."
                    };
                }

                return new BillPaymnet
                {
                    VendorID = 0,
                    UserID = 0,
                    Message = "No data returned from stored procedure."
                };
            }
            catch (Exception ex)
            {
                return new BillPaymnet
                {
                    VendorID = 0,
                    UserID = 0,
                    Message = "Error: " + ex.Message
                };
            }
        }


        public int LoginUser(BillPaymnet loginuser)
        {


            try
            {

                string usernameOrEmail = string.IsNullOrEmpty(loginuser.Email) ? loginuser.Username : loginuser.Email;

                command = db.GetStoredProcCommand("sp_LoginUser", new object[]
                {
            usernameOrEmail,
            loginuser.PasswordHash
                });

                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];

                    if (dt.Rows.Count == 0)
                    {

                        return -1;
                    }


                    if (dt.Columns.Contains("ResultCode"))
                    {
                        return Convert.ToInt32(dt.Rows[0]["ResultCode"]);
                    }
                    else
                    {

                        int roleId = Convert.ToInt32(dt.Rows[0]["RoleID"]);

                        return roleId;
                    }
                }

                return -1;
            }
            catch (Exception ex)
            {

                Console.WriteLine("Login error: " + ex.Message);
                return -99;
            }

        }

        public string ValidateUtilityReference(BillPaymnet input)
        {
            try
            {
                // Basic validation
                if (input.VendorID == null || input.VendorID <= 0)
                {
                    return "Error: VendorID is required and must be greater than 0";
                }

                if (string.IsNullOrWhiteSpace(input.ReferenceNumber))
                {
                    return "Error: ReferenceNumber is required";
                }

                // Execute stored procedure
                command = db.GetStoredProcCommand("sp_GetCustomerInfoByReference", new object[]
                {
            input.VendorID.Value,
            input.ReferenceNumber
                });

                DataSet ds = db.ExecuteDataSet(command);

                // Check and read results
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    DataRow row = ds.Tables[0].Rows[0];
                    var customerInfo = new
                    {
                        CustomerName = row["CustomerName"].ToString(),
                        UtilityName = row["UtilityName"].ToString(),
                        UtilityCode = row["UtilityCode"].ToString(),
                        ReferenceNumber = row["ReferenceNumber"].ToString(),
                        HasPackages = Convert.ToBoolean(row["HasPackages"]),
                        MinimumAmount = row["MinimumAmount"] != DBNull.Value ? Convert.ToDecimal(row["MinimumAmount"]) : 0
                    };

                    // Return serialized customer info
                    return Newtonsoft.Json.JsonConvert.SerializeObject(customerInfo);
                }

                return "Customer not found";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }



        public string InitiateVendorPaymentTransaction(BillPaymnet bill)
        {
            try
            {
                command = db.GetStoredProcCommand("InitiateVendorPaymentTransaction", new object[]
                {
            bill.VendorID,  // Use VendorID instead of VendorCode
            bill.ReferenceNumber,
            bill.UtilityCode,
            bill.Amount,
            bill.PackageID,  // Add PackageID parameter
            bill.CreatedBy
                });

                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    return ds.Tables[0].Rows[0]["TransactionID"].ToString();
                }

                return "Transaction failed";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }

        public List<BillPaymnet> GetUtilityPackagesByUtilityCode(string utilityCode)
        {
            try
            {
                command = db.GetStoredProcCommand("GetUtilityPackagesByUtilityCode", new object[] { utilityCode });
                DataSet ds = db.ExecuteDataSet(command);

                List<BillPaymnet> packages = new List<BillPaymnet>();

                if (ds != null && ds.Tables.Count > 0)
                {
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        packages.Add(new BillPaymnet
                        {
                            PackageID = Convert.ToInt32(row["PackageID"]),
                            PackageName = row["PackageName"].ToString(),
                            PackageCode = row["PackageCode"].ToString(),
                            PackageDescription = row["Description"].ToString(),
                            Amount = Convert.ToDecimal(row["Amount"]),
                            UtilityCode = row["UtilityCode"].ToString(),
                            UtilityName = row["UtilityName"].ToString(),
                            IsActive = Convert.ToBoolean(row["IsActive"])
                        });
                    }
                }

                return packages;
            }
            catch (Exception ex)
            {
                throw new Exception("Error retrieving utility packages: " + ex.Message);
            }
        }

        public DataTable GetAllPendingTransaction()
        {
            command = db.GetStoredProcCommand("sp_GetPendingTransactionsForUtility");
            DataTable dt = db.ExecuteDataSet(command).Tables[0];

            return dt;
        }


        public void UpdateUtilityTransactionResult(Guid transactionID, string utilityToken, string utilityReceiptNo, string status)
        {
            try
            {
                command = db.GetStoredProcCommand(
                    "sp_UpdateUtilityTransactionResult",
                    transactionID,
                    utilityToken,
                    utilityReceiptNo,
                    status
                );

                db.ExecuteNonQuery(command);
            }
            catch (Exception ex)
            {
                // Log exception properly
                Console.WriteLine("Error updating transaction result: " + ex.Message);
            }
        }


        public BillPaymnet GetVendorDashboardSummary(int userId)
        {
            try
            {
                command = db.GetStoredProcCommand("sp_GetVendorDashboardSummaryByUser", userId);
                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    DataRow row = ds.Tables[0].Rows[0];

                    return new BillPaymnet
                    {
                        VendorName = row["VendorName"].ToString(),
                        AccountBalance = Convert.ToDecimal(row["AccountBalance"]),
                        CustomersWorked = Convert.ToInt32(row["CustomersWorked"]),
                        TotalPaymentsMade = Convert.ToDecimal(row["TotalPaymentsMade"]),
                        FailedPayments = Convert.ToInt32(row["FailedPayments"]),
                        TotalTransactions = Convert.ToInt32(row["TotalTransactions"])
                    };
                }

                return null;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Dashboard fetch error: " );
                return null;
            }
        }



        public List<BillPaymnet> GetCustomerAndVendorInfoEmail(int userId)
        {
            try
            {
                command = db.GetStoredProcCommand("sp_GetCompletedTransactionsForEmail");
                db.AddInParameter(command, "@VendorID", DbType.Int32, userId);

                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    var billPayments = new List<BillPaymnet>();

                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        billPayments.Add(new BillPaymnet
                        {
                            TransactionID = row["TransactionID"] != DBNull.Value
                                ? (Guid?)Guid.Parse(row["TransactionID"].ToString())
                                : null,

                            VendorName = row["VendorName"]?.ToString(),
                            ContactEmail = row["VendorEmail"]?.ToString(),

                            CustomerName = row["CustomerName"]?.ToString(),
                            Email = row["CustomerEmail"]?.ToString(),

                            ReferenceNumber = row["ReferenceNumber"]?.ToString(),
                            Amount = row["Amount"] != DBNull.Value
                                ? Convert.ToDecimal(row["Amount"])
                                : 0,

                            UtilityToken = row["UtilityToken"]?.ToString(),
                            UtilityReceiptNo = row["UtilityReceiptNo"]?.ToString(),

                            ProcessedAt = row["ProcessedAt"] != DBNull.Value
                                ? Convert.ToDateTime(row["ProcessedAt"])
                                : (DateTime?)null
                        });
                    }

                    return billPayments;
                }

                return null;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error fetching vendor/customer info: " + ex.Message);
                return null;
            }
        }




        public List<BillPaymnet> GetCompletedTransactionsForAllVendors()
        {
            try
            {
                command = db.GetStoredProcCommand("sp_GetCompletedTransactionsForEmail_AllVendors");

                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    var billPayments = new List<BillPaymnet>();

                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        billPayments.Add(new BillPaymnet
                        {
                            TransactionID = row["TransactionID"] != DBNull.Value ? (Guid?)Guid.Parse(row["TransactionID"].ToString()) : null,
                            VendorID = row["VendorID"] != DBNull.Value ? Convert.ToInt32(row["VendorID"]) : (int?)null,
                            VendorName = row["VendorName"]?.ToString(),
                            ContactEmail = row["VendorEmail"]?.ToString(),
                            CustomerName = row["CustomerName"]?.ToString(),
                            Email = row["CustomerEmail"]?.ToString(),
                            ReferenceNumber = row["ReferenceNumber"]?.ToString(),
                            Amount = row["Amount"] != DBNull.Value ? Convert.ToDecimal(row["Amount"]) : 0,
                            UtilityToken = row["UtilityToken"]?.ToString(),
                            UtilityReceiptNo = row["UtilityReceiptNo"]?.ToString(),
                            ProcessedAt = row["ProcessedAt"] != DBNull.Value ? Convert.ToDateTime(row["ProcessedAt"]) : (DateTime?)null,
                            SentToMomo = row["SentToMomo"] != DBNull.Value ? Convert.ToBoolean(row["SentToMomo"]) : (bool?)null
                        });
                    }

                    return billPayments;
                }

                return null;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error fetching all vendor/customer transactions: " + ex.Message);
                return null;
            }
        }





        public List<BillPaymnet> GetCompletedTransactionsByVendor(int vendorId)
        {
            try
            {
                command = db.GetStoredProcCommand("sp_GetCompletedTransactionsForVendor");
                db.AddInParameter(command, "@VendorID", DbType.Int32, vendorId);

                DataSet ds = db.ExecuteDataSet(command);
                var list = new List<BillPaymnet>();

                if (ds != null && ds.Tables.Count > 0)
                {
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        list.Add(new BillPaymnet
                        {
                            TransactionID = row["TransactionID"] != DBNull.Value ? (Guid?)Guid.Parse(row["TransactionID"].ToString()) : null,
                            VendorName = row["VendorName"]?.ToString(),
                            ContactEmail = row["VendorEmail"]?.ToString(),
                            CustomerName = row["CustomerName"]?.ToString(),
                            Email = row["CustomerEmail"]?.ToString(),
                            ReferenceNumber = row["ReferenceNumber"]?.ToString(),
                            Amount = row["Amount"] != DBNull.Value ? Convert.ToDecimal(row["Amount"]) : 0,
                            UtilityToken = row["UtilityToken"]?.ToString(),
                            UtilityReceiptNo = row["UtilityReceiptNo"]?.ToString(),
                            ProcessedAt = row["ProcessedAt"] != DBNull.Value ? Convert.ToDateTime(row["ProcessedAt"]) : (DateTime?)null
                        });
                    }
                }

                return list;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error fetching completed transactions: " + ex.Message);
                return null;
            }
        }


        public List<BillPaymnet> GetPendingTransactionsByVendor(int vendorId)
        {
            try
            {
                command = db.GetStoredProcCommand("sp_GetPendingTransactionsForVendor");
                db.AddInParameter(command, "@VendorID", DbType.Int32, vendorId);

                DataSet ds = db.ExecuteDataSet(command);
                var list = new List<BillPaymnet>();

                if (ds != null && ds.Tables.Count > 0)
                {
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        list.Add(new BillPaymnet
                        {
                            TransactionID = row["TransactionID"] != DBNull.Value ? (Guid?)Guid.Parse(row["TransactionID"].ToString()) : null,
                            VendorName = row["VendorName"]?.ToString(),
                            ContactEmail = row["VendorEmail"]?.ToString(),
                            CustomerName = row["CustomerName"]?.ToString(),
                            Email = row["CustomerEmail"]?.ToString(),
                            ReferenceNumber = row["ReferenceNumber"]?.ToString(),
                            Amount = row["Amount"] != DBNull.Value ? Convert.ToDecimal(row["Amount"]) : 0,
                            UtilityToken = row["UtilityToken"]?.ToString(),
                            UtilityReceiptNo = row["UtilityReceiptNo"]?.ToString(),
                            ProcessedAt = row["ProcessedAt"] != DBNull.Value ? Convert.ToDateTime(row["ProcessedAt"]) : (DateTime?)null
                        });
                    }
                }

                return list;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error fetching pending transactions: " + ex.Message);
                return null;
            }
        }

        public List<BillPaymnet> GetFailedTransactionsByVendor(int vendorId)
        {
            try
            {
                command = db.GetStoredProcCommand("sp_GetFailedTransactionsForVendor");
                db.AddInParameter(command, "@VendorID", DbType.Int32, vendorId);

                DataSet ds = db.ExecuteDataSet(command);
                var list = new List<BillPaymnet>();

                if (ds != null && ds.Tables.Count > 0)
                {
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        list.Add(new BillPaymnet
                        {
                            TransactionID = row["TransactionID"] != DBNull.Value ? (Guid?)Guid.Parse(row["TransactionID"].ToString()) : null,
                            VendorName = row["VendorName"]?.ToString(),
                            ContactEmail = row["VendorEmail"]?.ToString(),
                            CustomerName = row["CustomerName"]?.ToString(),
                            Email = row["CustomerEmail"]?.ToString(),
                            ReferenceNumber = row["ReferenceNumber"]?.ToString(),
                            Amount = row["Amount"] != DBNull.Value ? Convert.ToDecimal(row["Amount"]) : 0,
                            UtilityToken = row["UtilityToken"]?.ToString(),
                            UtilityReceiptNo = row["UtilityReceiptNo"]?.ToString(),
                            ProcessedAt = row["ProcessedAt"] != DBNull.Value ? Convert.ToDateTime(row["ProcessedAt"]) : (DateTime?)null
                        });
                    }
                }

                return list;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error fetching Failed transactions: " + ex.Message);
                return null;
            }
        }




        public BillPaymnet LoginUser2(BillPaymnet loginuser)
        {
            try
            {
                string usernameOrEmail = string.IsNullOrEmpty(loginuser.Email) ? loginuser.Username : loginuser.Email;

                command = db.GetStoredProcCommand("sp_LoginUser2", new object[]
                {
            usernameOrEmail,
            loginuser.PasswordHash
                });

                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];

                    if (dt.Rows.Count == 0)
                    {
                        // No user found
                        return null;
                    }

                    // Fill your BillPaymnet object with UserID and RoleID
                    return new BillPaymnet
                    {
                        UserID = Convert.ToInt32(dt.Rows[0]["UserID"]),
                        RoleID = Convert.ToInt32(dt.Rows[0]["RoleID"])
                    };
                }

                return null;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Login error: " + ex.Message);
                return null;
            }
        }
        public int InsertAuditLog(AuditLog log)
        {
            try
            {
                command = db.GetStoredProcCommand("sp_InsertAuditLog", new object[]
                {
            log.UserID,
            log.Action,
            log.Timestamp == DateTime.MinValue ? (object)DBNull.Value : log.Timestamp,
            log.Details
                });

                DataSet ds = db.ExecuteDataSet(command);

                int newLogId = Convert.ToInt32(ds.Tables[0].Rows[0]["LogID"]);

                return newLogId;
            }
            catch (Exception ex)
            {
                // Optional: log error
                return 0;
            }
        }
        public List<BillPaymnet> GetSuperAdminSummary(int userId)
        {
            try
            {
                command = db.GetStoredProcCommand("sp_GetSuperAdminSummary2");
                db.AddInParameter(command, "@UserID", DbType.Int32, userId);

                DataSet ds = db.ExecuteDataSet(command);

                if (ds == null || ds.Tables.Count < 4)
                {
                    Console.WriteLine("sp_GetSuperAdminSummary returned insufficient data.");
                    return new List<BillPaymnet>();
                }

                var result = new List<BillPaymnet>();

                // 1. Vendors
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    result.Add(new BillPaymnet
                    {
                        VendorID = row["VendorID"] != DBNull.Value ? Convert.ToInt32(row["VendorID"]) : (int?)null,
                        VendorCode = row["VendorCode"]?.ToString(),
                        VendorName = row["VendorName"]?.ToString(),
                        ContactEmail = row["ContactEmail"]?.ToString(),
                        ContactPhone = row["ContactPhone"]?.ToString(),
                        CreatedAt = row["CreatedAt"] != DBNull.Value ? Convert.ToDateTime(row["CreatedAt"]) : (DateTime?)null,
                        Role = "Vendor"
                    });
                }

                // 2. Customers
                foreach (DataRow row in ds.Tables[1].Rows)
                {
                    result.Add(new BillPaymnet
                    {
                        CustomerID = row["CustomerID"] != DBNull.Value ? Convert.ToInt32(row["CustomerID"]) : (int?)null,
                        CustomerName = row["CustomerName"]?.ToString(),
                        Email = row["Email"]?.ToString(),
                        PhoneNumber = row["Phone"]?.ToString(),
                        ReferenceNumber = row["ReferenceNumber"]?.ToString(),
                        UtilityName = row["UtilityName"]?.ToString(),
                        Role = "Customer"
                    });
                }

                // 3. Utilities
                foreach (DataRow row in ds.Tables[2].Rows)
                {
                    result.Add(new BillPaymnet
                    {
                        UtilityID = row["UtilityID"] != DBNull.Value ? Convert.ToInt32(row["UtilityID"]) : (int?)null,
                        UtilityName = row["UtilityName"]?.ToString(),
                        UtilityCode = row["UtilityCode"]?.ToString(),
                        CreatedAt = row["CreatedAt"] != DBNull.Value ? Convert.ToDateTime(row["CreatedAt"]) : (DateTime?)null,
                        Role = "Utility"
                    });
                }

                // 4. Summary counts - add a single BillPaymnet object with totals
                if (ds.Tables[3].Rows.Count > 0)
                {
                    DataRow row = ds.Tables[3].Rows[0];

                    result.Add(new BillPaymnet
                    {
                        TotalVendors = row["TotalVendors"] != DBNull.Value ? Convert.ToInt32(row["TotalVendors"]) : 0,
                        TotalUsers = row["TotalUsers"] != DBNull.Value ? Convert.ToInt32(row["TotalUsers"]) : 0,
                        TotalUtilities = row["TotalUtilities"] != DBNull.Value ? Convert.ToInt32(row["TotalUtilities"]) : 0,
                        Role = "Summary"
                    });
                }

                return result;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error fetching SuperAdmin summary: " + ex.Message);
                return new List<BillPaymnet>();
            }
        }


        public DataTable GetCustomerTransactionsByReference(string referenceNumber)
        {
            try
            {
                command = db.GetStoredProcCommand("GetCustomerTransactionsByReference", new object[]
                {
            referenceNumber
                });

                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0)
                {
                    return ds.Tables[0];
                }

                return null;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error retrieving transactions: " + ex.Message);
                return null;
            }
        }


        public BillPaymnet LoginUser2WithLockout(BillPaymnet loginuser)
        {
            try
            {
                string usernameOrEmail = string.IsNullOrEmpty(loginuser.Email) ? loginuser.Username : loginuser.Email;
                command = db.GetStoredProcCommand("sp_LoginUser2WithLockout2", new object[] { usernameOrEmail, loginuser.PasswordHash });
                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        var row = dt.Rows[0];
                        return new BillPaymnet
                        {
                            LoginResultCode = Convert.ToInt32(row["LoginResult"]),
                            UserID = row["UserID"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["UserID"]),
                            RoleID = row["RoleID"] == DBNull.Value ? 0 : Convert.ToInt32(row["RoleID"]),
                            VendorID = row["VendorID"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["VendorID"]),
                            FailedAttempts = Convert.ToInt32(row["FailedAttempts"]),
                            Message = row["Message"].ToString()
                        };
                    }
                }

                return new BillPaymnet
                {
                    LoginResultCode = -1,
                    Message = "Login failed"
                };
            }
            catch (Exception ex)
            {
                Console.WriteLine("Login error: " + ex.Message);
                return new BillPaymnet
                {
                    LoginResultCode = -1,
                    Message = "Login error: " + ex.Message
                };
            }
        }


        public bool UnlockUserAccount(string usernameOrEmail)
        {
            try
            {
                command = db.GetStoredProcCommand("sp_UnlockUserAccount", new object[] { usernameOrEmail });
                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        return Convert.ToBoolean(dt.Rows[0]["Success"]);
                    }
                }
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Unlock account error: " + ex.Message);
                return false;
            }
        }




        public string CheckUserExists(string usernameOrEmail)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(usernameOrEmail))
                {
                    return "Error: Username or Email is required.";
                }

                // Call the stored procedure
                command = db.GetStoredProcCommand("sp_CheckUserExists");
                db.AddInParameter(command, "@UsernameOrEmail", DbType.String, usernameOrEmail);

                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    DataRow row = ds.Tables[0].Rows[0];

                    int resultCode = Convert.ToInt32(row["ResultCode"]);
                    string message = row["Message"].ToString();

                    if (resultCode == 1)
                    {
                        var userInfo = new
                        {
                            UserID = row["UserID"],
                            Username = row["Username"],
                            Email = row["Email"],
                            RoleID = row["RoleID"],
                            IsActive = row["IsActive"],
                            Message = message
                        };

                        return Newtonsoft.Json.JsonConvert.SerializeObject(userInfo);
                    }
                    else
                    {
                        return message; 
                    }
                }

                return "Unexpected error: No data returned.";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }
        public BillPaymnet ResetUserPassword(BillPaymnet resetPassword)
        {
            BillPaymnet result = new BillPaymnet();

            try
            {

                string usernameOrEmail = string.IsNullOrEmpty(resetPassword.Email) ? resetPassword.Username : resetPassword.Email;

                if (string.IsNullOrWhiteSpace(usernameOrEmail) || string.IsNullOrWhiteSpace(resetPassword.PasswordHash))
                {
                    result.LoginResultCode = -1;
                    result.Message = "Username/Email and new password are required.";
                    return result;
                }

                // Call the stored procedure with correct parameters
                command = db.GetStoredProcCommand("sp_ResetUserPassword", new object[]
                {
                    usernameOrEmail,
                    resetPassword.PasswordHash,
                });
                

                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    DataRow row = ds.Tables[0].Rows[0];
                    result.LoginResultCode = Convert.ToInt32(row["ResultCode"]);
                    result.Message = row["Message"].ToString();
                }
                else
                {
                    result.LoginResultCode = -99;
                    result.Message = "Unexpected error: No data returned.";
                }
            }
            catch (Exception ex)
            {
                result.LoginResultCode = -500;
                result.Message = "Reset error: " + ex.Message;
            }

            return result;
        }

        public string UpdateVendor(BillPaymnet vendor)
        {
            try
            {
                command = db.GetStoredProcCommand("sp_UpdateVendor", new object[]
                {
            vendor.VendorID,
            vendor.VendorCode,
            vendor.VendorName,
            vendor.ContactEmail,
            vendor.ContactPhone,
            vendor.Balance,
            vendor.CreatedBy
                });

                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    return ds.Tables[0].Rows[0]["Message"].ToString();
                }

                return "Vendor update failed.";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }

        public List<BillPaymnet> CheckPasswordExpiry()
        {
            List<BillPaymnet> expiredUsers = new List<BillPaymnet>();

            try
            {
                command = db.GetStoredProcCommand("sp_CheckPasswordExpiry");

                DataSet ds = db.ExecuteDataSet(command);

                if (ds != null && ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];

                    foreach (DataRow row in dt.Rows)
                    {
                        expiredUsers.Add(new BillPaymnet
                        {
                            UserID = row["UserID"] != DBNull.Value ? Convert.ToInt32(row["UserID"]) : (int?)null,
                            Username = row["Username"]?.ToString(),
                            IsPasswordExpired = Convert.ToBoolean(row["IsPasswordExpired"]),
                            Message = "Your password has expired. Please reset your password to continue."
                        });
                    }
                }

                return expiredUsers;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Password expiry check failed: " + ex.Message);
                return new List<BillPaymnet>
        {
            new BillPaymnet
            {
                Message = "Error checking password expiry: " + ex.Message
            }
        };
            }
        }

       




    }
}

