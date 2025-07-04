USE [Billpayment]
GO
/****** Object:  Table [dbo].[AuditLogs]    Script Date: 7/1/2025 5:59:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLogs](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[Action] [varchar](100) NOT NULL,
	[Timestamp] [datetime] NULL,
	[Details] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 7/1/2025 5:59:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[ReferenceNumber] [varchar](50) NOT NULL,
	[CustomerName] [varchar](100) NOT NULL,
	[Email] [varchar](100) NULL,
	[Phone] [varchar](20) NULL,
	[UtilityID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginAttempts]    Script Date: 7/1/2025 5:59:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginAttempts](
	[AttemptID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[AttemptTime] [datetime] NULL,
	[Success] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AttemptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MobileMoneyTransactions]    Script Date: 7/1/2025 5:59:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MobileMoneyTransactions](
	[MoMoID] [int] IDENTITY(1,1) NOT NULL,
	[TransactionID] [uniqueidentifier] NULL,
	[VendorID] [int] NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Status] [varchar](20) NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MoMoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReceivedTransactions]    Script Date: 7/1/2025 5:59:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReceivedTransactions](
	[TransactionID] [uniqueidentifier] NOT NULL,
	[VendorID] [int] NULL,
	[CustomerID] [int] NULL,
	[UtilityID] [int] NULL,
	[ReferenceNumber] [varchar](50) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Status] [varchar](20) NULL,
	[SentToMomo] [bit] NULL,
	[MomoRequestTime] [datetime] NULL,
	[UtilityToken] [varchar](100) NULL,
	[UtilityReceiptNo] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[ProcessedAt] [datetime] NULL,
	[PackageID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 7/1/2025 5:59:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 7/1/2025 5:59:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[PasswordHash] [varchar](256) NOT NULL,
	[RoleID] [int] NULL,
	[Email] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[FailedLoginAttempts] [int] NULL,
	[LastFailedLoginAttempt] [datetime] NULL,
	[AccountLockedUntil] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Utilities]    Script Date: 7/1/2025 5:59:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Utilities](
	[UtilityID] [int] IDENTITY(1,1) NOT NULL,
	[UtilityName] [varchar](100) NOT NULL,
	[UtilityCode] [varchar](10) NOT NULL,
	[CreatedBy] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[HasPackages] [bit] NOT NULL,
	[MinimumAmount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[UtilityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UtilityPackages]    Script Date: 7/1/2025 5:59:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UtilityPackages](
	[PackageID] [int] IDENTITY(1,1) NOT NULL,
	[UtilityID] [int] NOT NULL,
	[PackageName] [varchar](100) NOT NULL,
	[PackageCode] [varchar](20) NOT NULL,
	[Amount] [decimal](10, 2) NOT NULL,
	[Description] [varchar](500) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_UtilityPackages] PRIMARY KEY CLUSTERED 
(
	[PackageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vendors]    Script Date: 7/1/2025 5:59:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendors](
	[VendorID] [int] IDENTITY(1,1) NOT NULL,
	[VendorCode] [varchar](20) NOT NULL,
	[VendorName] [varchar](100) NOT NULL,
	[Balance] [decimal](18, 2) NULL,
	[CreatedBy] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[ContactEmail] [varchar](100) NULL,
	[ContactPhone] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[VendorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AuditLogs] ON 

INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1, NULL, N'SuperAdmin Created', CAST(N'2025-06-25T08:18:55.937' AS DateTime), N'Username: superadmin')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (2, 1, N'Utility Created', CAST(N'2025-06-25T09:30:36.633' AS DateTime), N'UtilityName: NWSC UtilityCode: NW')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (3, 1, N'Customer Created', CAST(N'2025-06-25T09:31:34.860' AS DateTime), N'ReferenceNumber: NW563474324387 UtilityCode: NW')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (4, 2, N'Customer Created', CAST(N'2025-06-25T11:39:58.410' AS DateTime), N'ReferenceNumber: NW7854897987, UserID: 2')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (5, 2, N'Vendor Created', CAST(N'2025-06-25T11:58:51.923' AS DateTime), N'VendorCode: MTN01, UserID: 3')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (12, 1, N'Utility Created', CAST(N'2025-06-25T15:11:35.733' AS DateTime), N'UtilityName: UEDCL UtilityCode: UE2001')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (13, 1, N'Utility Created', CAST(N'2025-06-25T15:12:50.170' AS DateTime), N'UtilityName: GOTv UtilityCode: 2000')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (14, 1, N'Utility Created', CAST(N'2025-06-25T15:13:08.777' AS DateTime), N'UtilityName: DSTv UtilityCode: 2001')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (18, 1, N'Utility Created', CAST(N'2025-06-25T16:24:17.890' AS DateTime), N'UtilityName: StarTimes UtilityCode: st76')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (19, 1, N'Vendor Created', CAST(N'2025-06-25T16:26:42.297' AS DateTime), N'VendorCode: stKato, UserID: 8')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (20, 1, N'Vendor Created', CAST(N'2025-06-25T16:32:38.877' AS DateTime), N'VendorCode: MaxTest, Created UserID: 9')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (21, 1, N'Initiated Payment', CAST(N'2025-06-25T17:44:46.750' AS DateTime), N'TransactionID: 192F3725-E2E9-4598-954A-E7921365BDE4, Amount: 465.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (22, 1, N'Utility Created', CAST(N'2025-06-25T18:18:08.477' AS DateTime), N'UtilityName: 7584764 UtilityCode: 563454')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (23, 2, N'Initiated Payment', CAST(N'2025-06-26T08:23:21.637' AS DateTime), N'TransactionID: 227FEDB1-0567-4622-954F-91F8D0A618AE, Amount: 5000.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (24, 3, N'Initiated Payment', CAST(N'2025-06-26T09:09:16.010' AS DateTime), N'TransactionID: 7EBFE996-2F54-481B-9D9B-E43383FA65BE, Amount: 50000.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (28, 3, N'Initiated Payment', CAST(N'2025-06-26T16:45:44.207' AS DateTime), N'TransactionID: 0C5E1A37-2185-4A97-899E-AAADC054C351, Amount: 33.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (30, 1, N'Utility Created', CAST(N'2025-06-26T18:28:20.667' AS DateTime), N'UtilityName: PegPay UtilityCode: PP')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1023, 1, N'Customer Created', CAST(N'2025-06-27T09:06:57.643' AS DateTime), N'ReferenceNumber: PP236346743764, UserID: 10')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1024, 3, N'Initiated Payment', CAST(N'2025-06-27T09:09:01.247' AS DateTime), N'TransactionID: F0C3C3F8-6205-4E2A-B7BD-241F67323370, Amount: 100000.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1026, 5, N'Initiated Payment', CAST(N'2025-06-27T12:04:09.657' AS DateTime), N'TransactionID: A3090B3A-BC7B-44D6-B30E-B2B9A3AF38CC, Amount: 1000000.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1028, 5, N'Initiated Payment', CAST(N'2025-06-27T12:06:55.100' AS DateTime), N'TransactionID: 221D7800-B9F9-4B29-A1D0-9568C089F1C5, Amount: 1000000.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1030, 1, N'Vendor Created', CAST(N'2025-06-27T12:46:39.023' AS DateTime), N'VendorCode: MWM, Created UserID: 11')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1031, 11, N'Initiated Payment', CAST(N'2025-06-27T12:48:21.530' AS DateTime), N'TransactionID: 7633979F-111A-4E15-A78F-CD04D4E9D9BA, Amount: 150000.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1039, 1, N'Test Insert', CAST(N'2025-06-27T13:59:02.223' AS DateTime), N'This is a manual test insert for AuditLogs table')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1042, 1, N'CreateUtility', CAST(N'2025-06-27T14:09:43.473' AS DateTime), N'UtilityName: fggf, UtilityCode: f')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1043, 1, N'Utility Created', CAST(N'2025-06-27T14:09:43.670' AS DateTime), N'UtilityName: fggf UtilityCode: f')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1044, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T15:07:18.183' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1045, 3, N'GetSuperAdminSummary', CAST(N'2025-06-27T15:08:38.173' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1046, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T15:09:07.457' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1047, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T15:13:21.357' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1048, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T15:16:00.793' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1049, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T15:19:08.760' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1050, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T15:19:14.603' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1051, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T15:20:15.557' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1052, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T15:23:32.777' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1053, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T15:25:25.107' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1055, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T15:37:04.890' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1056, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T15:45:47.973' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1058, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T15:46:21.963' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1059, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T16:05:00.307' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1061, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T16:05:30.217' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1062, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T16:05:45.690' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1065, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-27T16:16:48.967' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1066, 3, N'GetCompletedTransactions', CAST(N'2025-06-27T16:16:49.080' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1068, 1, N'GetSuperAdminSummary', CAST(N'2025-06-27T16:17:47.087' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1079, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-27T17:54:24.253' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1080, 3, N'GetCompletedTransactions', CAST(N'2025-06-27T17:54:24.273' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1081, 1, N'CreateUtilityAdvanced', CAST(N'2025-06-28T16:56:30.597' AS DateTime), N'UtilityName: DSTIV, UtilityCode: DSTV001, HasPackages: true, MinimumAmount: ')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1082, 1, N'Utility Created', CAST(N'2025-06-28T16:56:30.830' AS DateTime), N'UtilityName: DSTIV, UtilityCode: DSTV001, HasPackages: 1, MinimumAmount: 0.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1083, 1, N'CreateUtilityPackage', CAST(N'2025-06-29T07:33:35.660' AS DateTime), N'UtilityID: 1014, PackageName: Compact plus, PackageCode: COMP, Amount: 31000')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1084, 1, N'Package Created', CAST(N'2025-06-29T07:33:36.007' AS DateTime), N'UtilityID: 1014, PackageName: Compact plus, PackageCode: COMP, Amount: 31000.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1094, 1, N'GetSuperAdminSummary', CAST(N'2025-06-29T09:12:24.947' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1096, 1, N'GetSuperAdminSummary', CAST(N'2025-06-29T09:13:14.890' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1098, 1, N'GetSuperAdminSummary', CAST(N'2025-06-29T10:49:04.583' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1099, 1, N'CreateUtilityAdvanced', CAST(N'2025-06-29T10:49:40.850' AS DateTime), N'UtilityName: StarTimes, UtilityCode: St, HasPackages: true, MinimumAmount: 10000')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1100, 1, N'Utility Created', CAST(N'2025-06-29T10:49:41.107' AS DateTime), N'UtilityName: StarTimes, UtilityCode: St, HasPackages: 1, MinimumAmount: 10000.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1101, 1, N'GetSuperAdminSummary', CAST(N'2025-06-29T10:49:41.113' AS DateTime), N'Fetching SuperAdmin dashboard summary')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1107, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T14:27:37.263' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1108, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T14:27:37.290' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1112, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T14:36:21.720' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1113, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T14:36:21.737' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1117, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T14:40:23.610' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1118, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T14:40:23.637' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1121, 3, N'InitiateVendorPayment', CAST(N'2025-06-29T14:40:55.833' AS DateTime), N'VendorID: 3, ReferenceNumber: PP236346743764, UtilityCode: PegPay, Amount: 50000, PackageID: ')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1122, 3, N'InitiateVendorPayment', CAST(N'2025-06-29T14:44:15.317' AS DateTime), N'VendorID: 3, ReferenceNumber: PP236346743764, UtilityCode: PegPay, Amount: 50000, PackageID: ')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1134, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T15:09:49.457' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1135, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T15:09:49.480' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1139, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T15:35:29.710' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1140, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T15:35:29.753' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1143, 3, N'InitiateVendorPayment', CAST(N'2025-06-29T15:35:57.927' AS DateTime), N'VendorID: 3, ReferenceNumber: PP236346743764, UtilityCode: PP, Amount: 66765, PackageID: ')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1144, 3, N'Initiated Payment', CAST(N'2025-06-29T15:35:58.320' AS DateTime), N'TransactionID: B208BB91-48D4-484A-8FEE-01B6D71A010D, Amount: 66765.00, UtilityCode: PP')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1146, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T15:43:22.217' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1147, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T15:43:22.240' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1150, 1, N'CreateCustomer', CAST(N'2025-06-29T15:46:56.620' AS DateTime), N'Ref: St43784785478, Name: Adam, Email: adamssebatat14@gmail.com, Phone: 3456768y76, Utility: St')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1151, 1, N'Customer Created', CAST(N'2025-06-29T15:46:56.910' AS DateTime), N'ReferenceNumber: St43784785478, UserID: 12')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1155, 1, N'CreateUtilityPackage', CAST(N'2025-06-29T15:50:00.467' AS DateTime), N'UtilityID: 1015, PackageName: StarTimes Plus, PackageCode: plus300, Amount: 15000')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1156, 1, N'Package Created', CAST(N'2025-06-29T15:50:00.660' AS DateTime), N'UtilityID: 1015, PackageName: StarTimes Plus, PackageCode: plus300, Amount: 15000.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1160, 3, N'InitiateVendorPayment', CAST(N'2025-06-29T15:50:39.017' AS DateTime), N'VendorID: 3, ReferenceNumber: St43784785478, UtilityCode: St, Amount: 15000, PackageID: 2')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1161, 3, N'Initiated Payment', CAST(N'2025-06-29T15:50:39.030' AS DateTime), N'TransactionID: D92489BC-D29A-4182-92D3-0E9BF007EF8F, Amount: 15000.00, UtilityCode: St, PackageID: 2, PackageName: StarTimes Plus, PackageCode: plus300')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1162, 1, N'CreateUtilityPackage', CAST(N'2025-06-29T15:59:49.457' AS DateTime), N'UtilityID: 1014, PackageName: Super sport , PackageCode: superselct, Amount: 150000')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1163, 1, N'Package Created', CAST(N'2025-06-29T15:59:49.480' AS DateTime), N'UtilityID: 1014, PackageName: Super sport , PackageCode: superselct, Amount: 150000.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1164, 1, N'CreateCustomer', CAST(N'2025-06-29T16:01:58.073' AS DateTime), N'Ref: Dstv00135676467347, Name: Max Maciano, Email: adamoscar1414@gmail.com, Phone: 0755684172, Utility: DSTV001')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1165, 1, N'Customer Created', CAST(N'2025-06-29T16:01:58.100' AS DateTime), N'ReferenceNumber: Dstv00135676467347, UserID: 13')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1170, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T18:12:56.043' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1171, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T18:12:56.070' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1173, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T18:22:37.877' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1174, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T18:22:37.900' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1176, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T18:30:17.223' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1177, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T18:30:17.243' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1181, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T18:31:31.660' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1182, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T18:31:31.687' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1187, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T18:42:03.077' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1188, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T18:42:03.103' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1192, 3, N'InitiateVendorPayment', CAST(N'2025-06-29T18:42:29.877' AS DateTime), N'VendorID: 3, ReferenceNumber: St43784785478, UtilityCode: St, Amount: 15000, PackageID: 2')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1193, 3, N'Initiated Payment', CAST(N'2025-06-29T18:42:29.890' AS DateTime), N'TransactionID: E4D466C4-5692-434F-8E1C-26004C8A87D0, Amount: 15000.00, UtilityCode: St, PackageID: 2, PackageName: StarTimes Plus, PackageCode: plus300')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1194, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T18:42:29.890' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1195, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T18:42:29.903' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1196, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T18:44:51.213' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1197, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T18:44:51.243' AS DateTime), N'Fetching completed transactions for vendor')
GO
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1200, 3, N'InitiateVendorPayment', CAST(N'2025-06-29T18:45:19.513' AS DateTime), N'VendorID: 3, ReferenceNumber: PP236346743764, UtilityCode: PP, Amount: 4368, PackageID: ')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1201, 3, N'Initiated Payment', CAST(N'2025-06-29T18:45:19.527' AS DateTime), N'TransactionID: 1B34ED69-EC37-44D6-8CCB-A659B5BB81FB, Amount: 4368.00, UtilityCode: PP')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1202, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T18:45:19.527' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1203, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T18:45:19.543' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1205, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T18:47:19.477' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1206, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T18:47:19.493' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1210, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T18:59:21.490' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1211, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T18:59:21.513' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1215, 3, N'InitiateVendorPayment', CAST(N'2025-06-29T18:59:42.857' AS DateTime), N'VendorID: 3, ReferenceNumber: St43784785478, UtilityCode: St, Amount: 15000, PackageID: 2')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1216, 3, N'Initiated Payment', CAST(N'2025-06-29T18:59:42.877' AS DateTime), N'TransactionID: DA9CB60A-57E1-42F4-8301-6DAAE7F1485D, Amount: 15000.00, UtilityCode: St, PackageID: 2, PackageName: StarTimes Plus, PackageCode: plus300')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1217, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T18:59:42.870' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1218, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T18:59:42.887' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1220, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T19:01:41.573' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1221, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T19:01:41.593' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1226, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T19:04:56.717' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1227, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T19:04:56.737' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1231, 3, N'InitiateVendorPayment', CAST(N'2025-06-29T19:05:49.260' AS DateTime), N'VendorID: 3, ReferenceNumber: St43784785478, UtilityCode: St, Amount: 15000, PackageID: 2')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1232, 3, N'Initiated Payment', CAST(N'2025-06-29T19:05:49.273' AS DateTime), N'TransactionID: B60ABA8C-1526-446E-8E47-278980B3D5A5, Amount: 15000.00, UtilityCode: St, PackageID: 2, PackageName: StarTimes Plus, PackageCode: plus300')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1233, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T19:05:49.283' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1234, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T19:05:49.287' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1236, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T19:12:15.160' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1237, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T19:12:15.190' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1241, 3, N'InitiateVendorPayment', CAST(N'2025-06-29T19:12:42.703' AS DateTime), N'VendorID: 3, ReferenceNumber: St43784785478, UtilityCode: St, Amount: 15000, PackageID: 2')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1242, 3, N'Initiated Payment', CAST(N'2025-06-29T19:12:42.717' AS DateTime), N'TransactionID: 614BA3F2-9D22-4D3D-B834-8B17FD68A70A, Amount: 15000.00, UtilityCode: St, PackageID: 2, PackageName: StarTimes Plus, PackageCode: plus300')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1244, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T19:14:13.363' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1245, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T19:14:13.373' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1248, 3, N'InitiateVendorPayment', CAST(N'2025-06-29T19:14:48.990' AS DateTime), N'VendorID: 3, ReferenceNumber: PP236346743764, UtilityCode: PP, Amount: 577, PackageID: ')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1249, 3, N'Initiated Payment', CAST(N'2025-06-29T19:14:49.000' AS DateTime), N'TransactionID: 1559B3D3-3E10-46C1-807B-F33C48DD651B, Amount: 577.00, UtilityCode: PP')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1251, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T19:19:59.827' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1252, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T19:19:59.833' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1256, 3, N'InitiateVendorPayment', CAST(N'2025-06-29T19:20:21.947' AS DateTime), N'VendorID: 3, ReferenceNumber: St43784785478, UtilityCode: St, Amount: 15000, PackageID: 2')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1257, 3, N'Initiated Payment', CAST(N'2025-06-29T19:20:22.020' AS DateTime), N'TransactionID: 071C19F9-EF20-488C-B6E5-E50C1CD12026, Amount: 15000.00, UtilityCode: St, PackageID: 2, PackageName: StarTimes Plus, PackageCode: plus300')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1258, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T19:20:22.030' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1259, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T19:20:22.037' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1260, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T19:22:05.043' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1261, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T19:22:05.050' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1263, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T19:22:37.320' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1264, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T19:22:37.333' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1267, 3, N'InitiateVendorPayment', CAST(N'2025-06-29T19:23:04.450' AS DateTime), N'VendorID: 3, ReferenceNumber: PP236346743764, UtilityCode: PP, Amount: 780, PackageID: ')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1268, 3, N'Initiated Payment', CAST(N'2025-06-29T19:23:04.470' AS DateTime), N'TransactionID: 1E2F4468-59D4-4195-84DF-6E3E2FFFFD21, Amount: 780.00, UtilityCode: PP')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1269, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T19:23:04.473' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1270, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T19:23:04.480' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1272, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T19:24:17.020' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1273, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T19:24:17.043' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1276, 3, N'InitiateVendorPayment', CAST(N'2025-06-29T19:24:35.017' AS DateTime), N'VendorID: 3, ReferenceNumber: PP236346743764, UtilityCode: PP, Amount: 656, PackageID: ')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1277, 3, N'Initiated Payment', CAST(N'2025-06-29T19:24:35.033' AS DateTime), N'TransactionID: 3B4C7AB0-2985-4917-995E-B88F01884BBF, Amount: 656.00, UtilityCode: PP')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1278, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T19:24:35.040' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1279, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T19:24:35.047' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1281, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T19:26:36.970' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1282, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T19:26:36.997' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1285, 3, N'InitiateVendorPayment', CAST(N'2025-06-29T19:26:52.543' AS DateTime), N'VendorID: 3, ReferenceNumber: PP236346743764, UtilityCode: PP, Amount: 7676, PackageID: ')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1286, 3, N'Initiated Payment', CAST(N'2025-06-29T19:26:52.560' AS DateTime), N'TransactionID: 1F6EDE15-86A7-41CD-A77A-94F430DB0740, Amount: 7676.00, UtilityCode: PP')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1287, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T19:26:52.560' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1288, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T19:26:52.573' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1291, 3, N'GetVendorDashboardInfo', CAST(N'2025-06-29T19:28:36.563' AS DateTime), N'Fetching vendor dashboard info')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1292, 3, N'GetCompletedTransactions', CAST(N'2025-06-29T19:28:36.580' AS DateTime), N'Fetching completed transactions for vendor')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1293, 3, N'Initiated Payment', CAST(N'2025-06-30T08:27:45.440' AS DateTime), N'TransactionID: C1F355EB-1089-467E-8C8E-440BFDF82A0B, Amount: 4344.00, UtilityCode: NW, PackageID: 1, PackageName: Compact plus, PackageCode: COMP')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1294, 3, N'Initiated Payment', CAST(N'2025-06-30T09:43:45.577' AS DateTime), N'TransactionID: 399C2065-B46B-4015-A7D2-07EE7FF1526C, Amount: 31000.00, UtilityCode: DSTV001, PackageID: 1, PackageName: Compact plus, PackageCode: COMP')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1295, 3, N'Initiated Payment', CAST(N'2025-06-30T09:57:38.430' AS DateTime), N'TransactionID: 025F0490-85FB-40CD-BFE4-9F7FFAC1F318, Amount: 31000.00, UtilityCode: DSTV001, PackageID: 1, PackageName: Compact plus, PackageCode: COMP')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1296, 3, N'Initiated Payment', CAST(N'2025-06-30T10:13:57.863' AS DateTime), N'TransactionID: 86F1AEEC-5C13-4DAE-A61E-8F75B405ABFD, Amount: 31000.00, UtilityCode: DSTV001, PackageID: 1, PackageName: Compact plus, PackageCode: COMP')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1297, 3, N'Initiated Payment', CAST(N'2025-06-30T10:15:10.130' AS DateTime), N'TransactionID: D06D3BF2-F7A8-47A9-9ACC-BEFF3C67BB25, Amount: 31000.00, UtilityCode: DSTV001, PackageID: 1, PackageName: Compact plus, PackageCode: COMP')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1298, 3, N'Initiated Payment', CAST(N'2025-06-30T10:31:38.287' AS DateTime), N'TransactionID: CE7B15D8-E143-4C05-A03E-D8930B91DEFD, Amount: 15000.00, UtilityCode: St, PackageID: 2, PackageName: StarTimes Plus, PackageCode: plus300')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1299, 3, N'Initiated Payment', CAST(N'2025-06-30T10:50:00.160' AS DateTime), N'TransactionID: 3F16551B-0EC4-4031-A6BC-6461F18767B9, Amount: 15000.00, UtilityCode: St, PackageID: 2, PackageName: StarTimes Plus, PackageCode: plus300')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1300, 3, N'Initiated Payment', CAST(N'2025-06-30T11:00:50.057' AS DateTime), N'TransactionID: 068AD500-5D35-4E35-BB2C-E639B572FE6F, Amount: 30000.00, UtilityCode: St, PackageID: 2, PackageName: StarTimes Plus, PackageCode: plus300')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1341, 1, N'Utility Created', CAST(N'2025-06-30T15:23:21.660' AS DateTime), N'UtilityName: rtffrtftr, UtilityCode: tfr, HasPackages: 0, MinimumAmount: 0.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1342, 1, N'Utility Created', CAST(N'2025-06-30T15:52:22.087' AS DateTime), N'UtilityName: rrrwrw, UtilityCode: rfef, HasPackages: 0, MinimumAmount: 0.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1343, 1, N'Utility Created', CAST(N'2025-06-30T15:59:31.850' AS DateTime), N'UtilityName: rtvttr, UtilityCode: tet, HasPackages: 0, MinimumAmount: 0.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1344, 1, N'Utility Created', CAST(N'2025-06-30T15:59:50.043' AS DateTime), N'UtilityName: t, UtilityCode: kti, HasPackages: 0, MinimumAmount: 0.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1345, 1, N'Customer Created', CAST(N'2025-06-30T17:53:49.987' AS DateTime), N'ReferenceNumber: Dstv00156782345, UserID: 14')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1346, 4, N'Initiated Payment', CAST(N'2025-06-30T18:18:36.767' AS DateTime), N'TransactionID: AD1F3D52-5DF2-462D-824F-81F56FFB90EC, Amount: 31000.00, UtilityCode: DSTV001, PackageID: 1, PackageName: Compact plus, PackageCode: COMP')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1348, 1, N'Utility Created', CAST(N'2025-06-30T18:30:15.883' AS DateTime), N'UtilityName: startime, UtilityCode: startimes, HasPackages: 0, MinimumAmount: 10000.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1349, 1, N'Utility Created', CAST(N'2025-06-30T18:31:55.297' AS DateTime), N'UtilityName: jhmnyjm, UtilityCode: ty, HasPackages: 0, MinimumAmount: 20000.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1350, 1, N'Customer Created', CAST(N'2025-07-01T09:22:41.377' AS DateTime), N'ReferenceNumber: st6775868979898, UserID: 15')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1351, 1, N'Vendor Created', CAST(N'2025-07-01T10:06:25.870' AS DateTime), N'VendorCode: MT22, Created UserID: 16')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1352, 1, N'Vendor Created', CAST(N'2025-07-01T10:08:39.947' AS DateTime), N'VendorCode: MTN22, Created UserID: 17')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1353, 1, N'Vendor Created', CAST(N'2025-07-01T10:12:02.997' AS DateTime), N'VendorCode: MTN223, Created UserID: 18')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1354, 1, N'Vendor Created', CAST(N'2025-07-01T10:35:55.370' AS DateTime), N'VendorCode: MTN33, Created UserID: 19')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1355, 1, N'Utility Created', CAST(N'2025-07-01T14:05:03.697' AS DateTime), N'UtilityName: pgPAY, UtilityCode: PEG, HasPackages: 0, MinimumAmount: 10000.00')
INSERT [dbo].[AuditLogs] ([LogID], [UserID], [Action], [Timestamp], [Details]) VALUES (1356, 11, N'Initiated Payment', CAST(N'2025-07-01T17:38:01.433' AS DateTime), N'TransactionID: AC247959-CE52-45AB-A72F-8BF97EC6C710, Amount: 700000.00, UtilityCode: NW')
SET IDENTITY_INSERT [dbo].[AuditLogs] OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerID], [ReferenceNumber], [CustomerName], [Email], [Phone], [UtilityID]) VALUES (1, N'NW563474324387', N'Adam', N'67674343', N'adam@gmail.com', 1)
INSERT [dbo].[Customers] ([CustomerID], [ReferenceNumber], [CustomerName], [Email], [Phone], [UtilityID]) VALUES (2, N'NW7854897987', N'MAX', N'maxi@gmail.com', N'4356566767', 1)
INSERT [dbo].[Customers] ([CustomerID], [ReferenceNumber], [CustomerName], [Email], [Phone], [UtilityID]) VALUES (3, N'PP236346743764', N'Wily Gafabusa', N'adamoscar1414@gmail.com', N'07000384387', 12)
INSERT [dbo].[Customers] ([CustomerID], [ReferenceNumber], [CustomerName], [Email], [Phone], [UtilityID]) VALUES (4, N'St43784785478', N'Adam', N'adamssebatat14@gmail.com', N'3456768y76', 1015)
INSERT [dbo].[Customers] ([CustomerID], [ReferenceNumber], [CustomerName], [Email], [Phone], [UtilityID]) VALUES (5, N'Dstv00135676467347', N'Max Maciano', N'adamoscar1414@gmail.com', N'0755684172', 1014)
INSERT [dbo].[Customers] ([CustomerID], [ReferenceNumber], [CustomerName], [Email], [Phone], [UtilityID]) VALUES (6, N'Dstv00156782345', N'Trevor', N'trevor@gmail.com', N'0755894231', 1014)
INSERT [dbo].[Customers] ([CustomerID], [ReferenceNumber], [CustomerName], [Email], [Phone], [UtilityID]) VALUES (7, N'st6775868979898', N'Adam Oscar', N'ssebattaadam14@gmail.com', N'4367348747389', 1015)
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'b208bb91-48d4-484a-8fee-01b6d71a010d', 3, 3, 12, N'PP236346743764', CAST(66765.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-29T15:35:58.317' AS DateTime), N'TOKEN-af68b427', N'RECPT-638868903396808687', CAST(N'2025-06-29T15:35:58.317' AS DateTime), CAST(N'2025-06-30T14:25:39.840' AS DateTime), NULL)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'399c2065-b46b-4015-a7d2-07ee7ff1526c', 3, 5, 1014, N'Dstv00135676467347', CAST(31000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-30T09:43:45.577' AS DateTime), N'TOKEN-a23362bb', N'RECPT-638868908447388324', CAST(N'2025-06-30T09:43:45.577' AS DateTime), CAST(N'2025-06-30T14:34:04.733' AS DateTime), 1)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'd92489bc-d29a-4182-92d3-0e9bf007ef8f', 3, 4, 1015, N'St43784785478', CAST(15000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-29T15:50:39.030' AS DateTime), N'TOKEN-06f55edc', N'RECPT-638868903403620279', CAST(N'2025-06-29T15:50:39.030' AS DateTime), CAST(N'2025-06-30T14:25:40.363' AS DateTime), 2)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'f0c3c3f8-6205-4e2a-b7bd-241f67323370', 1, 3, 12, N'PP236346743764', CAST(100000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-27T09:09:01.247' AS DateTime), N'TOKEN-2e10708c', N'RECPT-638866123018841258', CAST(N'2025-06-27T09:09:01.247' AS DateTime), CAST(N'2025-06-27T09:11:42.017' AS DateTime), NULL)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'e4d466c4-5692-434f-8e1c-26004c8a87d0', 3, 4, 1015, N'St43784785478', CAST(15000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-29T18:42:29.890' AS DateTime), N'TOKEN-d9f43de9', N'RECPT-638868903408899322', CAST(N'2025-06-29T18:42:29.890' AS DateTime), CAST(N'2025-06-30T14:25:40.893' AS DateTime), 2)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'b60aba8c-1526-446e-8e47-278980b3d5a5', 3, 4, 1015, N'St43784785478', CAST(15000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-29T19:05:49.273' AS DateTime), N'TOKEN-3aab0e71', N'RECPT-638868903424759617', CAST(N'2025-06-29T19:05:49.273' AS DateTime), CAST(N'2025-06-30T14:25:42.483' AS DateTime), 2)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'c1f355eb-1089-467e-8c8e-440bfdf82a0b', 3, 1, 1, N'NW563474324387', CAST(4344.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-30T08:27:45.440' AS DateTime), N'TOKEN-be44fd24', N'RECPT-638868908442075921', CAST(N'2025-06-30T08:27:45.440' AS DateTime), CAST(N'2025-06-30T14:34:04.210' AS DateTime), 1)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'3f16551b-0ec4-4031-a6bc-6461f18767b9', 3, 4, 1015, N'St43784785478', CAST(15000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-30T10:50:00.160' AS DateTime), N'TOKEN-fe49d848', N'RECPT-638868908473481488', CAST(N'2025-06-30T10:50:00.160' AS DateTime), CAST(N'2025-06-30T14:34:07.350' AS DateTime), 2)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'da9cb60a-57e1-42f4-8301-6daae7f1485d', 3, 4, 1015, N'St43784785478', CAST(15000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-29T18:59:42.877' AS DateTime), N'TOKEN-b1653087', N'RECPT-638868903419480179', CAST(N'2025-06-29T18:59:42.877' AS DateTime), CAST(N'2025-06-30T14:25:41.953' AS DateTime), 2)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'1e2f4468-59d4-4195-84df-6e3e2ffffd21', 3, 3, 12, N'PP236346743764', CAST(780.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-29T19:23:04.470' AS DateTime), N'TOKEN-a73e55e4', N'RECPT-638868903445751295', CAST(N'2025-06-29T19:23:04.470' AS DateTime), CAST(N'2025-06-30T14:25:44.580' AS DateTime), NULL)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'ad1f3d52-5df2-462d-824f-81f56ffb90ec', 4, 6, 1014, N'Dstv00156782345', CAST(31000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-30T18:18:36.763' AS DateTime), N'TOKEN-f0330451', N'RECPT-638869044134597648', CAST(N'2025-06-30T18:18:36.763' AS DateTime), CAST(N'2025-06-30T18:20:13.777' AS DateTime), 1)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'614ba3f2-9d22-4d3d-b834-8b17fd68a70a', 3, 4, 1015, N'St43784785478', CAST(15000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-29T19:12:42.717' AS DateTime), N'TOKEN-3cce1564', N'RECPT-638868903430051995', CAST(N'2025-06-29T19:12:42.717' AS DateTime), CAST(N'2025-06-30T14:25:43.010' AS DateTime), 2)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'ac247959-ce52-45ab-a72f-8bf97ec6c710', 11, 2, 1, N'NW7854897987', CAST(700000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-07-01T17:38:01.433' AS DateTime), N'TOKEN-9a0b8ac0', N'RECPT-638869885239384826', CAST(N'2025-07-01T17:38:01.433' AS DateTime), CAST(N'2025-07-01T17:42:04.090' AS DateTime), NULL)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'86f1aeec-5c13-4dae-a61e-8f75b405abfd', 3, 5, 1014, N'Dstv00135676467347', CAST(31000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-30T10:13:57.863' AS DateTime), N'TOKEN-441d12fb', N'RECPT-638868908457700562', CAST(N'2025-06-30T10:13:57.863' AS DateTime), CAST(N'2025-06-30T14:34:05.770' AS DateTime), 1)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'227fedb1-0567-4622-954f-91f8d0a618ae', 2, 2, 1, N'NW7854897987', CAST(5000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-26T08:23:21.637' AS DateTime), N'TOKEN-80a16238', N'RECPT-638865489943558558', CAST(N'2025-06-26T08:23:21.637' AS DateTime), CAST(N'2025-06-26T15:36:42.283' AS DateTime), NULL)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'1f6ede15-86a7-41cd-a77a-94f430db0740', 3, 3, 12, N'PP236346743764', CAST(7676.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-29T19:26:52.560' AS DateTime), N'TOKEN-855b44a5', N'RECPT-638868908436763538', CAST(N'2025-06-29T19:26:52.560' AS DateTime), CAST(N'2025-06-30T14:34:03.683' AS DateTime), NULL)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'221d7800-b9f9-4b29-a1d0-9568c089f1c5', 3, 3, 12, N'PP236346743764', CAST(1000000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-27T12:06:55.100' AS DateTime), N'TOKEN-19b6fed0', N'RECPT-638866241342117487', CAST(N'2025-06-27T12:06:55.100' AS DateTime), CAST(N'2025-06-27T12:28:54.233' AS DateTime), NULL)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'025f0490-85fb-40cd-bfe4-9f7ffac1f318', 3, 5, 1014, N'Dstv00135676467347', CAST(31000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-30T09:57:38.430' AS DateTime), N'TOKEN-bd82a467', N'RECPT-638868908452544491', CAST(N'2025-06-30T09:57:38.430' AS DateTime), CAST(N'2025-06-30T14:34:05.253' AS DateTime), 1)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'1b34ed69-ec37-44d6-8ccb-a659b5bb81fb', 3, 3, 12, N'PP236346743764', CAST(4368.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-29T18:45:19.527' AS DateTime), N'TOKEN-f39e4278', N'RECPT-638868903414161630', CAST(N'2025-06-29T18:45:19.527' AS DateTime), CAST(N'2025-06-30T14:25:41.420' AS DateTime), NULL)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'0c5e1a37-2185-4a97-899e-aaadc054c351', 3, 1, 1, N'NW563474324387', CAST(33.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-26T16:45:44.207' AS DateTime), N'TOKEN-c8ea4d8e', N'RECPT-638865532750181318', CAST(N'2025-06-26T16:45:44.207' AS DateTime), CAST(N'2025-06-26T16:47:55.150' AS DateTime), NULL)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'a3090b3a-bc7b-44d6-b30e-b2b9a3af38cc', 3, 3, 12, N'PP236346743764', CAST(1000000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-27T12:04:09.657' AS DateTime), N'TOKEN-c755140e', N'RECPT-638866227163565005', CAST(N'2025-06-27T12:04:09.657' AS DateTime), CAST(N'2025-06-27T12:05:16.497' AS DateTime), NULL)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'3b4c7ab0-2985-4917-995e-b88f01884bbf', 3, 3, 12, N'PP236346743764', CAST(656.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-29T19:24:35.033' AS DateTime), N'TOKEN-e8ccea34', N'RECPT-638868908431451147', CAST(N'2025-06-29T19:24:35.033' AS DateTime), CAST(N'2025-06-30T14:34:03.160' AS DateTime), NULL)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'd06d3bf2-f7a8-47a9-9acc-beff3c67bb25', 3, 5, 1014, N'Dstv00135676467347', CAST(31000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-30T10:15:10.130' AS DateTime), N'TOKEN-f36785a6', N'RECPT-638868908462856719', CAST(N'2025-06-30T10:15:10.130' AS DateTime), CAST(N'2025-06-30T14:34:06.287' AS DateTime), 1)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'7633979f-111a-4e15-a78f-cd04d4e9d9ba', 8, 3, 12, N'PP236346743764', CAST(150000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-27T12:48:21.530' AS DateTime), N'TOKEN-b651f270', N'RECPT-638866255988013325', CAST(N'2025-06-27T12:48:21.530' AS DateTime), CAST(N'2025-06-27T12:53:18.800' AS DateTime), NULL)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'ce7b15d8-e143-4c05-a03e-d8930b91defd', 3, 4, 1015, N'St43784785478', CAST(15000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-30T10:31:38.287' AS DateTime), N'TOKEN-dbc147d2', N'RECPT-638868908468169098', CAST(N'2025-06-30T10:31:38.287' AS DateTime), CAST(N'2025-06-30T14:34:06.817' AS DateTime), 2)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'7ebfe996-2f54-481b-9d9b-e43383fa65be', 1, 2, 1, N'NW7854897987', CAST(50000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-26T09:09:16.010' AS DateTime), N'TOKEN-ffc16462', N'RECPT-638865490028464275', CAST(N'2025-06-26T09:09:16.010' AS DateTime), CAST(N'2025-06-26T15:36:44.090' AS DateTime), NULL)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'071c19f9-ef20-488c-b6e5-e50c1cd12026', 3, 4, 1015, N'St43784785478', CAST(15000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-29T19:20:22.017' AS DateTime), N'TOKEN-e8eda1dd', N'RECPT-638868903440600861', CAST(N'2025-06-29T19:20:22.017' AS DateTime), CAST(N'2025-06-30T14:25:44.060' AS DateTime), 2)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'068ad500-5d35-4e35-bb2c-e639b572fe6f', 3, 4, 1015, N'St43784785478', CAST(30000.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-30T11:00:50.057' AS DateTime), N'TOKEN-9c28f88e', N'RECPT-638868908478793866', CAST(N'2025-06-30T11:00:50.057' AS DateTime), CAST(N'2025-06-30T14:34:07.880' AS DateTime), 2)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'192f3725-e2e9-4598-954a-e7921365bde4', 1, 1, 1, N'NW563474324387', CAST(465.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-25T17:44:46.750' AS DateTime), N'TOKEN-63b7a908', N'RECPT-638865489006686259', CAST(N'2025-06-25T17:44:46.750' AS DateTime), CAST(N'2025-06-26T15:35:18.690' AS DateTime), NULL)
INSERT [dbo].[ReceivedTransactions] ([TransactionID], [VendorID], [CustomerID], [UtilityID], [ReferenceNumber], [Amount], [Status], [SentToMomo], [MomoRequestTime], [UtilityToken], [UtilityReceiptNo], [CreatedAt], [ProcessedAt], [PackageID]) VALUES (N'1559b3d3-3e10-46c1-807b-f33c48dd651b', 3, 3, 12, N'PP236346743764', CAST(577.00 AS Decimal(18, 2)), N'Success', 1, CAST(N'2025-06-29T19:14:49.000' AS DateTime), N'TOKEN-ecee7bc7', N'RECPT-638868903435327291', CAST(N'2025-06-29T19:14:49.000' AS DateTime), CAST(N'2025-06-30T14:25:43.537' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (2, N'Admin')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (4, N'Customer')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (1, N'SuperAdmin')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (3, N'Vendor')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (1, N'superadmin', N'Godsplan', 1, N'adamssebatta@gmail.com', 1, CAST(N'2025-06-25T08:18:55.933' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (2, N'NW7854897987', N'Godsplan', 4, N'maxi@gmail.com', 0, CAST(N'2025-06-25T11:39:58.407' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (3, N'MTN01', N'Godsplan', 3, N'max@gmail.com', 1, CAST(N'2025-06-25T11:58:51.920' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (4, N'MTN02', N'Godsplan', 3, N'bell@gmail.com', 1, CAST(N'2025-06-25T13:50:20.100' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (5, N'MTN03', N'Godsplan', 3, N'tric@gmail.com', 1, CAST(N'2025-06-25T14:31:29.083' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (6, N'MtN04', N'Godsplan', 3, N'will@gmail.com', 1, CAST(N'2025-06-25T14:34:23.807' AS DateTime), 2, CAST(N'2025-06-30T08:24:18.923' AS DateTime), NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (7, N'Aitel', N'Godsplan', 3, N'kasuku@gmail.com', 1, CAST(N'2025-06-25T15:15:03.603' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (8, N'stKato', N'Godsplan', 3, N'kato@gmail.com', 1, CAST(N'2025-06-25T16:26:42.293' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (9, N'MaxTest', N'Godsplan', 3, N'mm@gmail.com', 1, CAST(N'2025-06-25T16:32:38.873' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (10, N'PP236346743764', N'Godsplan', 4, N'adamoscar1414@gmail.com', 1, CAST(N'2025-06-27T09:06:57.640' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (11, N'MWM', N'Maxi', 3, N'mwebemaxi12345@gmail.com', 1, CAST(N'2025-06-27T12:46:39.023' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (12, N'St43784785478', N'Godsplan', 4, N'adamssebatat14@gmail.com', 1, CAST(N'2025-06-29T15:46:56.903' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (13, N'Dstv00135676467347', N'Godsplan', 4, N'adamoscar1414@gmail.com', 1, CAST(N'2025-06-29T16:01:58.097' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (14, N'Dstv00156782345', N'abf39473382424bbb1cc182d4c74d5308f8cc238f7d81d3a32f82949ad5b443b', 4, N'trevor@gmail.com', 1, CAST(N'2025-06-30T17:53:49.983' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (15, N'st6775868979898', N'abf39473382424bbb1cc182d4c74d5308f8cc238f7d81d3a32f82949ad5b443b', 4, N'ssebattaadam14@gmail.com', 1, CAST(N'2025-07-01T09:22:41.377' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (16, N'MT22', N'abf39473382424bbb1cc182d4c74d5308f8cc238f7d81d3a32f82949ad5b443b', 3, N'adamoscar1414@gmail.com', 0, CAST(N'2025-07-01T10:06:25.867' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (17, N'MTN22', N'abf39473382424bbb1cc182d4c74d5308f8cc238f7d81d3a32f82949ad5b443b', 3, N'oscar@gmail.com', 1, CAST(N'2025-07-01T10:08:39.947' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (18, N'MTN223', N'Godsplan', 3, N'PPEG@GMAIL.COM', 1, CAST(N'2025-07-01T10:12:02.993' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [RoleID], [Email], [IsActive], [CreatedAt], [FailedLoginAttempts], [LastFailedLoginAttempt], [AccountLockedUntil]) VALUES (19, N'MTN33', N'abf39473382424bbb1cc182d4c74d5308f8cc238f7d81d3a32f82949ad5b443b', 3, N'mwebemax1@gmail.com', 1, CAST(N'2025-07-01T10:35:55.370' AS DateTime), 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[Utilities] ON 

INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (1, N'NWSC', N'NW', 1, CAST(N'2025-06-25T09:30:36.633' AS DateTime), 0, NULL)
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (5, N'UEDCL', N'UE2001', 1, CAST(N'2025-06-25T15:11:35.733' AS DateTime), 0, NULL)
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (6, N'GOTv', N'2000', 1, CAST(N'2025-06-25T15:12:50.170' AS DateTime), 0, NULL)
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (7, N'DSTv', N'2001', 1, CAST(N'2025-06-25T15:13:08.767' AS DateTime), 0, NULL)
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (10, N'StarTimes', N'st76', 1, CAST(N'2025-06-25T16:24:17.890' AS DateTime), 0, NULL)
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (11, N'7584764', N'563454', 1, CAST(N'2025-06-25T18:18:08.477' AS DateTime), 0, NULL)
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (12, N'PegPay', N'PP', 1, CAST(N'2025-06-26T18:28:20.667' AS DateTime), 0, NULL)
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (1013, N'fggf', N'f', 1, CAST(N'2025-06-27T14:09:43.670' AS DateTime), 0, NULL)
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (1014, N'DSTIV', N'DSTV001', 1, CAST(N'2025-06-28T16:56:30.817' AS DateTime), 1, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (1015, N'StarTimes', N'St', 1, CAST(N'2025-06-29T10:49:41.103' AS DateTime), 1, CAST(10000.00 AS Decimal(10, 2)))
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (1016, N'rtffrtftr', N'tfr', 1, CAST(N'2025-06-30T15:23:21.660' AS DateTime), 0, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (1017, N'rrrwrw', N'rfef', 1, CAST(N'2025-06-30T15:52:22.087' AS DateTime), 0, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (1018, N'rtvttr', N'tet', 1, CAST(N'2025-06-30T15:59:31.850' AS DateTime), 0, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (1019, N't', N'kti', 1, CAST(N'2025-06-30T15:59:50.043' AS DateTime), 0, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (1020, N'startime', N'startimes', 1, CAST(N'2025-06-30T18:30:15.883' AS DateTime), 0, CAST(10000.00 AS Decimal(10, 2)))
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (1021, N'jhmnyjm', N'ty', 1, CAST(N'2025-06-30T18:31:55.297' AS DateTime), 0, CAST(20000.00 AS Decimal(10, 2)))
INSERT [dbo].[Utilities] ([UtilityID], [UtilityName], [UtilityCode], [CreatedBy], [CreatedAt], [HasPackages], [MinimumAmount]) VALUES (1022, N'pgPAY', N'PEG', 1, CAST(N'2025-07-01T14:05:03.697' AS DateTime), 0, CAST(10000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Utilities] OFF
GO
SET IDENTITY_INSERT [dbo].[UtilityPackages] ON 

INSERT [dbo].[UtilityPackages] ([PackageID], [UtilityID], [PackageName], [PackageCode], [Amount], [Description], [IsActive], [CreatedBy], [CreatedAt]) VALUES (1, 1014, N'Compact plus', N'COMP', CAST(31000.00 AS Decimal(10, 2)), N'This comes wit', 1, 1, CAST(N'2025-06-29T07:33:36.007' AS DateTime))
INSERT [dbo].[UtilityPackages] ([PackageID], [UtilityID], [PackageName], [PackageCode], [Amount], [Description], [IsActive], [CreatedBy], [CreatedAt]) VALUES (2, 1015, N'StarTimes Plus', N'plus300', CAST(15000.00 AS Decimal(10, 2)), N'This is for all ', 1, 1, CAST(N'2025-06-29T15:50:00.660' AS DateTime))
INSERT [dbo].[UtilityPackages] ([PackageID], [UtilityID], [PackageName], [PackageCode], [Amount], [Description], [IsActive], [CreatedBy], [CreatedAt]) VALUES (3, 1014, N'Super sport ', N'superselct', CAST(150000.00 AS Decimal(10, 2)), N'For all  kinds of suports ', 1, 1, CAST(N'2025-06-29T15:59:49.480' AS DateTime))
SET IDENTITY_INSERT [dbo].[UtilityPackages] OFF
GO
SET IDENTITY_INSERT [dbo].[Vendors] ON 

INSERT [dbo].[Vendors] ([VendorID], [VendorCode], [VendorName], [Balance], [CreatedBy], [CreatedAt], [ContactEmail], [ContactPhone]) VALUES (1, N'MTN01', N'Mwebe Max', CAST(649535.00 AS Decimal(18, 2)), 3, CAST(N'2025-06-25T11:58:51.923' AS DateTime), N'max@gmail.com', N'67789437843')
INSERT [dbo].[Vendors] ([VendorID], [VendorCode], [VendorName], [Balance], [CreatedBy], [CreatedAt], [ContactEmail], [ContactPhone]) VALUES (2, N'MTN02', N'BELL', CAST(78542845.00 AS Decimal(18, 2)), 4, CAST(N'2025-06-25T13:50:20.100' AS DateTime), N'bell@gmail.com', N'765457887')
INSERT [dbo].[Vendors] ([VendorID], [VendorCode], [VendorName], [Balance], [CreatedBy], [CreatedAt], [ContactEmail], [ContactPhone]) VALUES (3, N'MTN03', N'TRIC', CAST(5328698.00 AS Decimal(18, 2)), 5, CAST(N'2025-06-25T14:31:29.083' AS DateTime), N'tric@gmail.com', N'5467688787')
INSERT [dbo].[Vendors] ([VendorID], [VendorCode], [VendorName], [Balance], [CreatedBy], [CreatedAt], [ContactEmail], [ContactPhone]) VALUES (4, N'MtN04', N'Willy', CAST(869000.00 AS Decimal(18, 2)), 6, CAST(N'2025-06-25T14:34:23.807' AS DateTime), N'will@gmail.com', N'6754877887')
INSERT [dbo].[Vendors] ([VendorID], [VendorCode], [VendorName], [Balance], [CreatedBy], [CreatedAt], [ContactEmail], [ContactPhone]) VALUES (5, N'Aitel', N'Kasuku', CAST(900000.00 AS Decimal(18, 2)), 7, CAST(N'2025-06-25T15:15:03.603' AS DateTime), N'kasuku@gmail.com', N'85478954789')
INSERT [dbo].[Vendors] ([VendorID], [VendorCode], [VendorName], [Balance], [CreatedBy], [CreatedAt], [ContactEmail], [ContactPhone]) VALUES (6, N'stKato', N'Kato Collins', CAST(500000.00 AS Decimal(18, 2)), 8, CAST(N'2025-06-25T16:26:42.297' AS DateTime), N'kato@gmail.com', N'4378934437829')
INSERT [dbo].[Vendors] ([VendorID], [VendorCode], [VendorName], [Balance], [CreatedBy], [CreatedAt], [ContactEmail], [ContactPhone]) VALUES (7, N'MaxTest', N'maxi', CAST(687568.00 AS Decimal(18, 2)), 1, CAST(N'2025-06-25T16:32:38.877' AS DateTime), N'mm@gmail.com', N'438754789789')
INSERT [dbo].[Vendors] ([VendorID], [VendorCode], [VendorName], [Balance], [CreatedBy], [CreatedAt], [ContactEmail], [ContactPhone]) VALUES (8, N'MWM', N'mweeebe', CAST(0.00 AS Decimal(18, 2)), 1, CAST(N'2025-06-27T12:46:39.023' AS DateTime), N'mwebemaxi12345@gmail.com', N'45327438734')
INSERT [dbo].[Vendors] ([VendorID], [VendorCode], [VendorName], [Balance], [CreatedBy], [CreatedAt], [ContactEmail], [ContactPhone]) VALUES (9, N'MT22', N'Oscar', CAST(80000.00 AS Decimal(18, 2)), 1, CAST(N'2025-07-01T10:06:25.867' AS DateTime), N'adamoscar1414@gmail.com', N'7895489754')
INSERT [dbo].[Vendors] ([VendorID], [VendorCode], [VendorName], [Balance], [CreatedBy], [CreatedAt], [ContactEmail], [ContactPhone]) VALUES (10, N'MTN22', N'OSCA', CAST(100000.00 AS Decimal(18, 2)), 1, CAST(N'2025-07-01T10:08:39.947' AS DateTime), N'oscar@gmail.com', N'657437437')
INSERT [dbo].[Vendors] ([VendorID], [VendorCode], [VendorName], [Balance], [CreatedBy], [CreatedAt], [ContactEmail], [ContactPhone]) VALUES (11, N'MTN223', N'pEGG', CAST(100000.00 AS Decimal(18, 2)), 1, CAST(N'2025-07-01T10:12:02.993' AS DateTime), N'PPEG@GMAIL.COM', N'875487547854')
INSERT [dbo].[Vendors] ([VendorID], [VendorCode], [VendorName], [Balance], [CreatedBy], [CreatedAt], [ContactEmail], [ContactPhone]) VALUES (12, N'MTN33', N'MAX33', CAST(70000.00 AS Decimal(18, 2)), 1, CAST(N'2025-07-01T10:35:55.370' AS DateTime), N'mwebemax1@gmail.com', N'7845784598')
SET IDENTITY_INSERT [dbo].[Vendors] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__C5ADBE4D477B5FF6]    Script Date: 7/1/2025 5:59:35 PM ******/
ALTER TABLE [dbo].[Customers] ADD UNIQUE NONCLUSTERED 
(
	[ReferenceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__8A2B61603BEF633C]    Script Date: 7/1/2025 5:59:35 PM ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E43BA4FC7B]    Script Date: 7/1/2025 5:59:35 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_UtilityPackages_Code]    Script Date: 7/1/2025 5:59:35 PM ******/
ALTER TABLE [dbo].[UtilityPackages] ADD  CONSTRAINT [UQ_UtilityPackages_Code] UNIQUE NONCLUSTERED 
(
	[UtilityID] ASC,
	[PackageCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Vendors__10C18F5CAAED8BB8]    Script Date: 7/1/2025 5:59:35 PM ******/
ALTER TABLE [dbo].[Vendors] ADD UNIQUE NONCLUSTERED 
(
	[VendorCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuditLogs] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[LoginAttempts] ADD  DEFAULT (getdate()) FOR [AttemptTime]
GO
ALTER TABLE [dbo].[MobileMoneyTransactions] ADD  DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[MobileMoneyTransactions] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[ReceivedTransactions] ADD  DEFAULT (newid()) FOR [TransactionID]
GO
ALTER TABLE [dbo].[ReceivedTransactions] ADD  DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[ReceivedTransactions] ADD  DEFAULT ((0)) FOR [SentToMomo]
GO
ALTER TABLE [dbo].[ReceivedTransactions] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [FailedLoginAttempts]
GO
ALTER TABLE [dbo].[Utilities] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Utilities] ADD  DEFAULT ((0)) FOR [HasPackages]
GO
ALTER TABLE [dbo].[UtilityPackages] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[UtilityPackages] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Vendors] ADD  DEFAULT ((0)) FOR [Balance]
GO
ALTER TABLE [dbo].[Vendors] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[AuditLogs]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD FOREIGN KEY([UtilityID])
REFERENCES [dbo].[Utilities] ([UtilityID])
GO
ALTER TABLE [dbo].[LoginAttempts]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[MobileMoneyTransactions]  WITH CHECK ADD FOREIGN KEY([TransactionID])
REFERENCES [dbo].[ReceivedTransactions] ([TransactionID])
GO
ALTER TABLE [dbo].[MobileMoneyTransactions]  WITH CHECK ADD FOREIGN KEY([VendorID])
REFERENCES [dbo].[Vendors] ([VendorID])
GO
ALTER TABLE [dbo].[ReceivedTransactions]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[ReceivedTransactions]  WITH CHECK ADD FOREIGN KEY([UtilityID])
REFERENCES [dbo].[Utilities] ([UtilityID])
GO
ALTER TABLE [dbo].[ReceivedTransactions]  WITH CHECK ADD FOREIGN KEY([VendorID])
REFERENCES [dbo].[Vendors] ([VendorID])
GO
ALTER TABLE [dbo].[ReceivedTransactions]  WITH CHECK ADD  CONSTRAINT [FK_ReceivedTransactions_UtilityPackages] FOREIGN KEY([PackageID])
REFERENCES [dbo].[UtilityPackages] ([PackageID])
GO
ALTER TABLE [dbo].[ReceivedTransactions] CHECK CONSTRAINT [FK_ReceivedTransactions_UtilityPackages]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Utilities]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UtilityPackages]  WITH CHECK ADD  CONSTRAINT [FK_UtilityPackages_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UtilityPackages] CHECK CONSTRAINT [FK_UtilityPackages_Users]
GO
ALTER TABLE [dbo].[UtilityPackages]  WITH CHECK ADD  CONSTRAINT [FK_UtilityPackages_Utilities] FOREIGN KEY([UtilityID])
REFERENCES [dbo].[Utilities] ([UtilityID])
GO
ALTER TABLE [dbo].[UtilityPackages] CHECK CONSTRAINT [FK_UtilityPackages_Utilities]
GO
ALTER TABLE [dbo].[Vendors]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
/****** Object:  StoredProcedure [dbo].[CreateCustomer]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[CreateCustomer]
    @ReferenceNumber VARCHAR(50),
    @CustomerName VARCHAR(100),
    @Email VARCHAR(100),
    @Phone VARCHAR(20),
    @UtilityCode VARCHAR(10),
    @AdminUserID INT
AS
BEGIN
    DECLARE @UtilityID INT;
    DECLARE @CustomerID INT;

   
    SELECT @UtilityID = UtilityID
    FROM Utilities
    WHERE UtilityCode = @UtilityCode;

    IF @UtilityID IS NULL
    BEGIN
        RAISERROR('Utility not found!', 16, 1);
        RETURN;
    END

   
    INSERT INTO Customers (ReferenceNumber, CustomerName, Email, Phone, UtilityID )
    VALUES (@ReferenceNumber, @CustomerName, @Email, @Phone, @UtilityID );


    INSERT INTO AuditLogs (UserID, Action, Details)
    VALUES (@AdminUserID, 'Customer Created', CONCAT('ReferenceNumber: ', @ReferenceNumber, ' UtilityCode: ', @UtilityCode));

   
    SELECT SCOPE_IDENTITY() AS CustomerID;
END;
GO
/****** Object:  StoredProcedure [dbo].[CreateSuperAdmin]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateSuperAdmin]
    @Username VARCHAR(50),
    @PasswordHash VARCHAR(256),
    @Email VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RoleID INT;
    DECLARE @UserID INT;

    -- Fetch RoleID for SuperAdmin
    SELECT @RoleID = RoleID FROM Roles WHERE RoleName = 'SuperAdmin';

    IF @RoleID IS NULL
    BEGIN
        RAISERROR('SuperAdmin role not found. Run InsertDefaultRoles first.', 16, 1);
        RETURN;
    END

    -- Check if a SuperAdmin already exists
    IF EXISTS (
        SELECT 1 FROM Users U
        INNER JOIN Roles R ON U.RoleID = R.RoleID
        WHERE R.RoleName = 'SuperAdmin'
    )
    BEGIN
        RAISERROR('A SuperAdmin already exists.', 16, 1);
        RETURN;
    END

    -- Create SuperAdmin user
    INSERT INTO Users (Username, PasswordHash, RoleID, Email)
    VALUES (@Username, @PasswordHash, @RoleID, @Email);

    SET @UserID = SCOPE_IDENTITY();

    -- Log the creation with UserID = NULL (system action)
    INSERT INTO AuditLogs (UserID, Action, Details)
    VALUES (NULL, 'SuperAdmin Created', CONCAT('Username: ', @Username));

    SELECT @UserID AS SuperAdminUserID;
END;
GO
/****** Object:  StoredProcedure [dbo].[CreateUser]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateUser]
    @Username VARCHAR(50),
    @PasswordHash VARCHAR(256),
    @Email VARCHAR(100),
    @RoleName VARCHAR(50) = 'Customer',
    @AdminUserID INT
AS
BEGIN
    DECLARE @RoleID INT;
    DECLARE @UserID INT;

   
    SELECT @RoleID = RoleID
    FROM Roles
    WHERE RoleName = @RoleName;

    IF @RoleID IS NULL
    BEGIN
        RAISERROR('Role not found!', 16, 1);
        RETURN;
    END

   
    INSERT INTO Users (Username, PasswordHash, RoleID, Email)
    VALUES (@Username, @PasswordHash, @RoleID, @Email);

   
    SELECT @UserID = SCOPE_IDENTITY();

   
    INSERT INTO AuditLogs (UserID, Action, Details)
    VALUES (@AdminUserID, 'User Created', CONCAT('Username: ', @Username, ' Role: ', @RoleName));

   
    SELECT @UserID AS UserID;
END;
GO
/****** Object:  StoredProcedure [dbo].[CreateUtility]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateUtility]
    @UtilityName VARCHAR(100),
    @UtilityCode VARCHAR(10),
    @HasPackages BIT = 0,
    @MinimumAmount DECIMAL(10,2) = 0,
    @AdminUserID INT
AS
BEGIN
    DECLARE @UtilityID INT;
    
    -- Check if the UtilityCode already exists
    IF EXISTS (SELECT 1 FROM Utilities WHERE UtilityCode = @UtilityCode)
    BEGIN
        RAISERROR('UtilityCode already exists!', 16, 1);
        RETURN;
    END
    
    -- Insert new utility
    INSERT INTO Utilities (UtilityName, UtilityCode, HasPackages, MinimumAmount, CreatedBy, CreatedAt)
    VALUES (@UtilityName, @UtilityCode, @HasPackages, @MinimumAmount, @AdminUserID, GETDATE());
    
    SELECT @UtilityID = SCOPE_IDENTITY();
    
    -- Audit log
    INSERT INTO AuditLogs (UserID, Action, Details)
    VALUES (@AdminUserID, 'Utility Created', 
            CONCAT('UtilityName: ', @UtilityName, 
                   ', UtilityCode: ', @UtilityCode,
                   ', HasPackages: ', CAST(@HasPackages AS VARCHAR),
                   ', MinimumAmount: ', CAST(@MinimumAmount AS VARCHAR)));
    
    SELECT @UtilityID AS UtilityID;
END;
GO
/****** Object:  StoredProcedure [dbo].[CreateVendor]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[CreateVendor]
    @VendorCode VARCHAR(20),
    @VendorName VARCHAR(100),
    @ContactEmail VARCHAR(100),
    @ContactPhone VARCHAR(20),
    @AdminUserID INT
AS
BEGIN
    DECLARE @VendorID INT;

    -- Check if VendorCode already exists
    IF EXISTS (SELECT 1 FROM Vendors WHERE VendorCode = @VendorCode)
    BEGIN
        RAISERROR('VendorCode already exists!', 16, 1);
        RETURN;
    END

    -- Insert new vendor
    INSERT INTO Vendors (VendorCode, VendorName, ContactEmail, ContactPhone, CreatedBy, CreatedAt)
    VALUES (@VendorCode, @VendorName, @ContactEmail, @ContactPhone, @AdminUserID, GETDATE());

    -- Get the new VendorID
    SELECT @VendorID = SCOPE_IDENTITY();

    -- Audit log
    INSERT INTO AuditLogs (UserID, Action, Details)
    VALUES (@AdminUserID, 'Vendor Created', CONCAT('VendorCode: ', @VendorCode, ', VendorName: ', @VendorName));

    -- Return new VendorID
    SELECT @VendorID AS VendorID;
END;
GO
/****** Object:  StoredProcedure [dbo].[DeductVendorBalance]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE PROCEDURE [dbo].[DeductVendorBalance]
    @TransactionID UNIQUEIDENTIFIER,
    @Amount DECIMAL(18,2)
AS
BEGIN
    DECLARE @VendorID INT;
    DECLARE @CurrentBalance DECIMAL(18,2);

   
    SELECT @VendorID = VendorID, @CurrentBalance = Balance
    FROM Vendors
    WHERE VendorID IN (SELECT VendorID FROM ReceivedTransactions WHERE TransactionID = @TransactionID);

   
    IF @VendorID IS NULL
    BEGIN
        RAISERROR('Vendor not found for this transaction.', 16, 1);
        RETURN;
    END

    IF @CurrentBalance < @Amount
    BEGIN
        RAISERROR('Vendor does not have enough balance to complete this transaction.', 16, 1);
        RETURN;
    END

   
    UPDATE Vendors
    SET Balance = Balance - @Amount
    WHERE VendorID = @VendorID;

   
    UPDATE ReceivedTransactions
    SET SentToMomo = 1, MomoRequestTime = GETDATE()
    WHERE TransactionID = @TransactionID;

   
    INSERT INTO AuditLogs (UserID, Action, Details)
    VALUES (NULL, 'Vendor Balance Deducted', CONCAT('VendorID: ', @VendorID, ' Amount: ', @Amount));

   
    SELECT 'Successful' AS Status;

END;
GO
/****** Object:  StoredProcedure [dbo].[GetCustomerTransactionsByReference]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCustomerTransactionsByReference]
    @ReferenceNumber VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        rt.TransactionID,
        rt.ReferenceNumber,
        rt.Amount,
        rt.Status,
        rt.SentToMomo,
        rt.MomoRequestTime,
        rt.UtilityToken,
        rt.UtilityReceiptNo,
        rt.CreatedAt,
        rt.ProcessedAt,

        -- Customer Details
        c.CustomerName,
        c.Email AS CustomerEmail,
        c.Phone AS CustomerPhone,

        -- Vendor Details
        v.VendorName,
        v.ContactEmail AS VendorEmail,
        v.ContactPhone AS VendorPhone,

        -- Utility Details
        u.UtilityName,
        u.UtilityCode

    FROM 
        ReceivedTransactions rt
        INNER JOIN Customers c ON rt.CustomerID = c.CustomerID
        INNER JOIN Utilities u ON rt.UtilityID = u.UtilityID
        LEFT JOIN Vendors v ON rt.VendorID = v.VendorID
    WHERE 
        rt.ReferenceNumber = @ReferenceNumber
    ORDER BY 
        rt.CreatedAt DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetUtilityPackagesByUtilityCode]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUtilityPackagesByUtilityCode]
    @UtilityCode VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        up.PackageID,
        up.PackageName,
        up.PackageCode,
        up.Description,
        up.Amount,
        up.IsActive,
        u.UtilityCode,
        u.UtilityName
    FROM UtilityPackages up
    INNER JOIN Utilities u ON up.UtilityID = u.UtilityID
    WHERE u.UtilityCode = @UtilityCode 
      AND up.IsActive = 1
      AND u.HasPackages = 1
    ORDER BY up.Amount ASC;
END;
GO
/****** Object:  StoredProcedure [dbo].[InitiatePayment]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[InitiatePayment]
    @VendorCode VARCHAR(20),
    @CustomerReference VARCHAR(50),
    @Amount DECIMAL(18,2),
    @VendorUserID INT
AS
BEGIN
    DECLARE @VendorID INT;
    DECLARE @UtilityID INT;
    DECLARE @CustomerID INT;
    DECLARE @TransactionID UNIQUEIDENTIFIER;

 
    SELECT @VendorID = VendorID
    FROM Vendors
    WHERE VendorCode = @VendorCode;

    IF @VendorID IS NULL
    BEGIN
        RAISERROR('Vendor not found!', 16, 1);
        RETURN;
    END

   
    SELECT @CustomerID = CustomerID
    FROM Customers
    WHERE ReferenceNumber = @CustomerReference;

    IF @CustomerID IS NULL
    BEGIN
        RAISERROR('Customer not found!', 16, 1);
        RETURN;
    END

   
    SET @TransactionID = NEWID();
    INSERT INTO ReceivedTransactions (TransactionID, VendorID, CustomerID, UtilityID, ReferenceNumber, Amount, Status)
    VALUES (@TransactionID, @VendorID, @CustomerID, @UtilityID, @CustomerReference, @Amount, 'Pending');

   
    INSERT INTO AuditLogs (UserID, Action, Details)
    VALUES (@VendorUserID, 'Payment Initiated', CONCAT('TransactionID: ', @TransactionID, ' Amount: ', @Amount));

   
    SELECT @TransactionID AS TransactionID;
END;
GO
/****** Object:  StoredProcedure [dbo].[InitiateVendorPaymentTransaction]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InitiateVendorPaymentTransaction]
    @VendorID INT,
    @CustomerReference VARCHAR(50),
    @UtilityCode VARCHAR(20),
    @Amount DECIMAL(18,2),
    @PackageID INT = NULL,
    @VendorUserID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CustomerID INT, @UtilityID INT;
    DECLARE @TransactionID UNIQUEIDENTIFIER = NEWID();
    DECLARE @CurrentBalance DECIMAL(18,2);
    DECLARE @HasPackages BIT, @MinimumAmount DECIMAL(18,2);
    DECLARE @PackageAmount DECIMAL(18,2);

    -- 1. Get Vendor Balance
    SELECT @CurrentBalance = Balance
    FROM Vendors
    WHERE VendorID = @VendorID;

    IF @CurrentBalance IS NULL
    BEGIN
        RAISERROR('Vendor not found.', 16, 1);
        RETURN;
    END

    -- 2. Check if vendor has enough balance
    IF @CurrentBalance < @Amount
    BEGIN
        RAISERROR('Insufficient vendor balance.', 16, 1);
        RETURN;
    END

    -- 3. Get CustomerID
    SELECT @CustomerID = CustomerID
    FROM Customers
    WHERE ReferenceNumber = @CustomerReference;

    IF @CustomerID IS NULL
    BEGIN
        RAISERROR('Customer not found.', 16, 1);
        RETURN;
    END

    -- 4. Get Utility Info
    SELECT @UtilityID = UtilityID, @HasPackages = HasPackages, @MinimumAmount = MinimumAmount
    FROM Utilities
    WHERE UtilityCode = @UtilityCode;

    IF @UtilityID IS NULL
    BEGIN
        RAISERROR('Utility not found.', 16, 1);
        RETURN;
    END

    -- 5. Validate Package or Minimum Amount
    IF @HasPackages = 1
    BEGIN
        -- Utility has packages
        IF @PackageID IS NULL
        BEGIN
            RAISERROR('Package selection is required for this utility.', 16, 1);
            RETURN;
        END

        -- Get package amount
        SELECT @PackageAmount = Amount
        FROM UtilityPackages
        WHERE PackageID = @PackageID AND UtilityID = @UtilityID AND IsActive = 1;

        IF @PackageAmount IS NULL
        BEGIN
            RAISERROR('Invalid package selected for this utility.', 16, 1);
            RETURN;
        END

        -- ALLOW amount >= package amount
        IF @Amount < @PackageAmount
        BEGIN
            RAISERROR('Amount must be equal to or greater than the selected package amount.', 16, 1);
            RETURN;
        END
    END
    ELSE
    BEGIN
        -- No package
        IF @Amount < @MinimumAmount
        BEGIN
            RAISERROR('Amount must be equal to or greater than the minimum required.', 16, 1);
            RETURN;
        END
    END

    -- 6. Deduct balance
    UPDATE Vendors
    SET Balance = Balance - @Amount
    WHERE VendorID = @VendorID;

    -- 7. Insert into ReceivedTransactions
    INSERT INTO ReceivedTransactions (
        TransactionID, VendorID, CustomerID, UtilityID,
        ReferenceNumber, Amount, PackageID, Status, SentToMomo, MomoRequestTime
    ) VALUES (
        @TransactionID, @VendorID, @CustomerID, @UtilityID,
        @CustomerReference, @Amount, @PackageID, 'Pending', 1, GETDATE()
    );

    -- 8. Audit Log
    DECLARE @PackageInfo VARCHAR(200) = '';
    IF @PackageID IS NOT NULL
    BEGIN
        SELECT @PackageInfo = CONCAT(', PackageID: ', @PackageID, ', PackageName: ', PackageName, ', PackageCode: ', PackageCode)
        FROM UtilityPackages WHERE PackageID = @PackageID;
    END

    INSERT INTO AuditLogs (UserID, Action, Details)
    VALUES (
        @VendorUserID,
        'Initiated Payment',
        CONCAT('TransactionID: ', @TransactionID, ', Amount: ', @Amount, ', UtilityCode: ', @UtilityCode, @PackageInfo)
    );

    -- 9. Return Transaction ID
    SELECT @TransactionID AS TransactionID;
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertDefaultRoles]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertDefaultRoles]
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert default roles if they don't already exist
    IF NOT EXISTS (SELECT 1 FROM Roles WHERE RoleName = 'SuperAdmin')
        INSERT INTO Roles (RoleName) VALUES ('SuperAdmin');

    IF NOT EXISTS (SELECT 1 FROM Roles WHERE RoleName = 'Admin')
        INSERT INTO Roles (RoleName) VALUES ('Admin');

    IF NOT EXISTS (SELECT 1 FROM Roles WHERE RoleName = 'Vendor')
        INSERT INTO Roles (RoleName) VALUES ('Vendor');

    IF NOT EXISTS (SELECT 1 FROM Roles WHERE RoleName = 'Customer')
        INSERT INTO Roles (RoleName) VALUES ('Customer');

    -- Return the inserted (or existing) roles
    SELECT * FROM Roles;
END;
GO
/****** Object:  StoredProcedure [dbo].[ProcessTransaction]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[ProcessTransaction]
    @TransactionID UNIQUEIDENTIFIER,
    @AdminUserID INT
AS
BEGIN
    DECLARE @Status VARCHAR(20);
    DECLARE @UtilityToken VARCHAR(100);
    DECLARE @UtilityReceiptNo VARCHAR(50);

    SELECT @Status = Status
    FROM ReceivedTransactions
    WHERE TransactionID = @TransactionID;

    IF @Status = 'Success' OR @Status = 'Failed'
    BEGIN
        RAISERROR('Transaction already processed!', 16, 1);
        RETURN;
    END

   
    UPDATE ReceivedTransactions
    SET Status = 'Success', UtilityToken = 'SimulatedToken123', UtilityReceiptNo = 'Receipt123', ProcessedAt = GETDATE()
    WHERE TransactionID = @TransactionID;

   
    INSERT INTO AuditLogs (UserID, Action, Details)
    VALUES (@AdminUserID, 'Transaction Processed', CONCAT('TransactionID: ', @TransactionID, ' Status: Success'));

   
    SELECT ' Successful' AS Message;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckUserExists]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CheckUserExists]
    @UsernameOrEmail VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM Users
        WHERE (Username = @UsernameOrEmail OR Email = @UsernameOrEmail)
    )
    BEGIN
        SELECT 
            UserID,
            Username,
            Email,
            RoleID,
            IsActive,
            'User exists' AS Message,
            1 AS ResultCode
        FROM Users
        WHERE (Username = @UsernameOrEmail OR Email = @UsernameOrEmail);
    END
    ELSE
    BEGIN
        SELECT 
            CAST(NULL AS INT) AS UserID,
            CAST(NULL AS VARCHAR(100)) AS Username,
            CAST(NULL AS VARCHAR(100)) AS Email,
            CAST(NULL AS INT) AS RoleID,
            CAST(NULL AS BIT) AS IsActive,
            'User not found' AS Message,
            -1 AS ResultCode;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateCustomer]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateCustomer]
    @ReferenceNumber VARCHAR(50),
    @CustomerName VARCHAR(100),
    @Email VARCHAR(100),
    @Phone VARCHAR(20),
    @PasswordHash VARCHAR(256),
    @UtilityCode VARCHAR(10),
    @AdminUserID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UtilityID INT;
    DECLARE @CustomerID INT;
    DECLARE @UserID INT;
    DECLARE @RoleID INT;

    -- Get UtilityID
    SELECT @UtilityID = UtilityID FROM Utilities WHERE UtilityCode = @UtilityCode;

    IF @UtilityID IS NULL
    BEGIN
        RAISERROR('Utility not found!', 16, 1);
        RETURN;
    END

    -- Get RoleID for 'Customer'
    SELECT @RoleID = RoleID FROM Roles WHERE RoleName = 'Customer';

    IF @RoleID IS NULL
    BEGIN
        RAISERROR('Customer role does not exist!', 16, 1);
        RETURN;
    END

    -- Create User for Customer
    INSERT INTO Users (Username, PasswordHash, RoleID, Email)
    VALUES (@ReferenceNumber, @PasswordHash, @RoleID, @Email);

    SELECT @UserID = SCOPE_IDENTITY();

    -- Insert Customer
    INSERT INTO Customers (ReferenceNumber, CustomerName, Email, Phone, UtilityID)
    VALUES (@ReferenceNumber, @CustomerName, @Email, @Phone, @UtilityID);

    SELECT @CustomerID = SCOPE_IDENTITY();

    -- Log audit
    INSERT INTO AuditLogs (UserID, Action, Details)
    VALUES (@AdminUserID, 'Customer Created', CONCAT('ReferenceNumber: ', @ReferenceNumber, ', UserID: ', @UserID));

    -- Return created CustomerID and UserID
    SELECT @CustomerID AS CustomerID, @UserID AS UserID;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUtilityPackage]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CreateUtilityPackage]
    @UtilityID INT,
    @PackageName VARCHAR(100),
    @PackageCode VARCHAR(20),
    @Amount DECIMAL(10,2),
    @Description VARCHAR(500) = NULL,
    @CreatedBy INT
AS
BEGIN
    DECLARE @PackageID INT;
    
    -- Check if utility exists and has packages enabled
    IF NOT EXISTS (SELECT 1 FROM Utilities WHERE UtilityID = @UtilityID AND HasPackages = 1)
    BEGIN
        RAISERROR('Utility does not exist or does not support packages!', 16, 1);
        RETURN;
    END
    
    -- Check if package code already exists for this utility
    IF EXISTS (SELECT 1 FROM UtilityPackages WHERE UtilityID = @UtilityID AND PackageCode = @PackageCode)
    BEGIN
        RAISERROR('Package code already exists for this utility!', 16, 1);
        RETURN;
    END
    
    -- Insert package
    INSERT INTO UtilityPackages (UtilityID, PackageName, PackageCode, Amount, Description, CreatedBy)
    VALUES (@UtilityID, @PackageName, @PackageCode, @Amount, @Description, @CreatedBy);
    
    SELECT @PackageID = SCOPE_IDENTITY();
    
    -- Audit log
    INSERT INTO AuditLogs (UserID, Action, Details)
    VALUES (@CreatedBy, 'Package Created', 
            CONCAT('UtilityID: ', @UtilityID, 
                   ', PackageName: ', @PackageName,
                   ', PackageCode: ', @PackageCode,
                   ', Amount: ', CAST(@Amount AS VARCHAR)));
    
    SELECT @PackageID AS PackageID;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateVendor]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateVendor]
    @VendorCode VARCHAR(20),
    @VendorName VARCHAR(100),
    @ContactEmail VARCHAR(100),
    @ContactPhone VARCHAR(20),
    @PasswordHash VARCHAR(256),
    @Balance DECIMAL(18,2),
    @AdminUserID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @VendorID INT;
    DECLARE @UserID INT;
    DECLARE @RoleID INT;

    -- Check for duplicate vendor code
    IF EXISTS (SELECT 1 FROM Vendors WHERE VendorCode = @VendorCode)
    BEGIN
        RAISERROR('VendorCode already exists!', 16, 1);
        RETURN;
    END

    -- Get RoleID for 'Vendor'
    SELECT @RoleID = RoleID FROM Roles WHERE RoleName = 'Vendor';

    IF @RoleID IS NULL
    BEGIN
        RAISERROR('Vendor role does not exist!', 16, 1);
        RETURN;
    END

    -- Create user account for vendor
    INSERT INTO Users (Username, PasswordHash, RoleID, Email)
    VALUES (@VendorCode, @PasswordHash, @RoleID, @ContactEmail);

    SELECT @UserID = SCOPE_IDENTITY();

    -- Create vendor, correctly assigning CreatedBy as the AdminUserID
    INSERT INTO Vendors (
        VendorCode, VendorName, ContactEmail, ContactPhone, Balance, CreatedBy, CreatedAt
    )
    VALUES (
        @VendorCode, @VendorName, @ContactEmail, @ContactPhone, @Balance, @AdminUserID, GETDATE()
    );

    SET @VendorID = SCOPE_IDENTITY();

    -- Log audit
    INSERT INTO AuditLogs (UserID, Action, Details)
    VALUES (@AdminUserID, 'Vendor Created', CONCAT('VendorCode: ', @VendorCode, ', Created UserID: ', @UserID));

    -- Return vendor ID and user ID
    SELECT @VendorID AS VendorID, @UserID AS UserID;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllUtilities]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_GetAllUtilities]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
       
        [UtilityName],
        [UtilityCode],
        [CreatedBy],
        [CreatedAt],
        [HasPackages],
        [MinimumAmount]
    FROM [Billpayment].[dbo].[Utilities];
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllVendors]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create or alter the stored procedure
CREATE PROCEDURE [dbo].[sp_GetAllVendors]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        v.VendorID,
        v.VendorCode,
        v.VendorName,
        v.ContactEmail,
        v.ContactPhone,
        v.Balance,
        v.CreatedAt,
        u.Email AS UserEmail,
        u.UserID
    FROM 
        Vendors v
    INNER JOIN 
        Users u ON u.Username = v.VendorCode
    ORDER BY 
        v.CreatedAt DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCompletedTransactionsForEmail]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCompletedTransactionsForEmail]
    @VendorID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1
        rt.TransactionID,
        v.VendorName,
        v.ContactEmail AS VendorEmail,
        c.CustomerName,
        c.Email AS CustomerEmail,
        rt.ReferenceNumber,
        rt.Amount,
        rt.UtilityToken,
        rt.UtilityReceiptNo,
        rt.ProcessedAt
    FROM ReceivedTransactions rt
    INNER JOIN Vendors v ON rt.VendorID = v.VendorID
    INNER JOIN Customers c ON rt.CustomerID = c.CustomerID
    WHERE rt.VendorID = @VendorID
      AND rt.Status = 'Success'
      AND rt.UtilityToken IS NOT NULL
      AND rt.UtilityReceiptNo IS NOT NULL
      AND rt.SentToMomo = 1
    ORDER BY rt.ProcessedAt DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCompletedTransactionsForEmail_AllVendors]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCompletedTransactionsForEmail_AllVendors]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        rt.TransactionID,
        v.VendorID,
        v.VendorName,
        v.ContactEmail AS VendorEmail,
        c.CustomerName,
        c.Email AS CustomerEmail,
        rt.ReferenceNumber,
        rt.Amount,
        rt.UtilityToken,
        rt.UtilityReceiptNo,
        rt.ProcessedAt,
        rt.SentToMomo
    FROM ReceivedTransactions rt
    INNER JOIN Vendors v ON rt.VendorID = v.VendorID
    INNER JOIN Customers c ON rt.CustomerID = c.CustomerID
    WHERE rt.Status = 'Success'
      AND rt.UtilityToken IS NOT NULL
      AND rt.UtilityReceiptNo IS NOT NULL
      AND rt.SentToMomo = 1
    ORDER BY rt.ProcessedAt DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCompletedTransactionsForEmail12]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCompletedTransactionsForEmail12]
    @VendorID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        rt.TransactionID,
        v.VendorName,
        v.ContactEmail AS VendorEmail,
        c.CustomerName,
        c.Email AS CustomerEmail,
        rt.ReferenceNumber,
        rt.Amount,
        rt.UtilityToken,
        rt.UtilityReceiptNo,
        rt.ProcessedAt
    FROM ReceivedTransactions rt
    INNER JOIN Vendors v ON rt.VendorID = v.VendorID
    INNER JOIN Customers c ON rt.CustomerID = c.CustomerID
    WHERE rt.VendorID = @VendorID
      AND rt.Status = 'Success'
      AND rt.UtilityToken IS NOT NULL
      AND rt.UtilityReceiptNo IS NOT NULL
      AND rt.SentToMomo = 1
    ORDER BY rt.ProcessedAt DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCompletedTransactionsForEmailNotification]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCompletedTransactionsForEmailNotification]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        rt.TransactionID,
        v.VendorName,
        v.ContactEmail AS VendorEmail,
        c.CustomerName,
        c.Email AS CustomerEmail,
        rt.ReferenceNumber,
        rt.Amount,
        rt.UtilityToken,
        rt.UtilityReceiptNo,
        rt.ProcessedAt
    FROM ReceivedTransactions rt
    INNER JOIN Vendors v ON rt.VendorID = v.VendorID
    INNER JOIN Customers c ON rt.CustomerID = c.CustomerID
    WHERE rt.Status = 'Success'
      AND rt.UtilityToken IS NOT NULL
      AND rt.UtilityReceiptNo IS NOT NULL
      AND rt.SentToMomo = 0 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCompletedTransactionsForVendor]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCompletedTransactionsForVendor]
    @VendorID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        rt.TransactionID,
        v.VendorID,
        v.VendorName,
        v.ContactEmail AS VendorEmail,
        c.CustomerName,
        c.Email AS CustomerEmail,
        rt.ReferenceNumber,
        rt.Amount,
        rt.UtilityToken,
        rt.UtilityReceiptNo,
        rt.ProcessedAt,
        rt.SentToMomo
    FROM ReceivedTransactions rt
    INNER JOIN Vendors v ON rt.VendorID = v.VendorID
    INNER JOIN Customers c ON rt.CustomerID = c.CustomerID
    WHERE rt.Status = 'Success'
      AND rt.UtilityToken IS NOT NULL
      AND rt.UtilityReceiptNo IS NOT NULL
      AND rt.SentToMomo = 1
      AND v.VendorID = @VendorID
    ORDER BY rt.ProcessedAt DESC;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetCustomerInfoByReference]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetCustomerInfoByReference]
    @VendorID INT,                    -- Changed from VendorCode to VendorID
    @ReferenceNumber VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Check if the vendor exists (using VendorID)
    IF NOT EXISTS (
        SELECT 1 FROM Vendors WHERE VendorID = @VendorID
    )
    BEGIN
        RAISERROR('Vendor not found.', 16, 1);
        RETURN;
    END
    
    -- Get customer details, utility info, and package support info
    SELECT TOP 1 
        c.CustomerID,
        c.ReferenceNumber,
        c.CustomerName,
        c.Email,
        c.Phone,
        c.UtilityID,
        u.UtilityCode,
        u.UtilityName,
        u.HasPackages,
        u.MinimumAmount
    FROM Customers c
    INNER JOIN Utilities u ON c.UtilityID = u.UtilityID
    WHERE c.ReferenceNumber = @ReferenceNumber;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetFailedTransactionsForVendor]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_GetFailedTransactionsForVendor]
    @VendorID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        rt.TransactionID,
        v.VendorID,
        v.VendorName,
        v.ContactEmail AS VendorEmail,
        c.CustomerName,
        c.Email AS CustomerEmail,
        rt.ReferenceNumber,
        rt.Amount,
        rt.Status,
        rt.SentToMomo
    FROM ReceivedTransactions rt
    INNER JOIN Vendors v ON rt.VendorID = v.VendorID
    INNER JOIN Customers c ON rt.CustomerID = c.CustomerID
    WHERE rt.Status = 'Failed'
      AND v.VendorID = @VendorID
    ORDER BY rt.ProcessedAt DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPendingTransactionsForUtility]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetPendingTransactionsForUtility]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 10
        TransactionID,
        VendorID,
        CustomerID,
        UtilityID,
        ReferenceNumber,
        Amount,
        UtilityToken,
        UtilityReceiptNo
    FROM ReceivedTransactions
    WHERE Status = 'Pending' AND SentToMomo = 1
    ORDER BY CreatedAt ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPendingTransactionsForVendor]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_GetPendingTransactionsForVendor]
    @VendorID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        rt.TransactionID,
        v.VendorID,
        v.VendorName,
        v.ContactEmail AS VendorEmail,
        c.CustomerName,
        c.Email AS CustomerEmail,
        rt.ReferenceNumber,
        rt.Amount,
        rt.Status,
        rt.SentToMomo
    FROM ReceivedTransactions rt
    INNER JOIN Vendors v ON rt.VendorID = v.VendorID
    INNER JOIN Customers c ON rt.CustomerID = c.CustomerID
    WHERE rt.Status = 'Pending'
      AND v.VendorID = @VendorID
    ORDER BY rt.ProcessedAt DESC;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetSuperAdminSummary]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetSuperAdminSummary]
    @UserID INT,
    @TotalVendors INT OUTPUT,
    @TotalCustomers INT OUTPUT,
    @TotalUtilities INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validate the user is SuperAdmin (RoleID = 1)
    IF NOT EXISTS (
        SELECT 1
        FROM Users
        WHERE UserID = @UserID AND RoleID = 1
    )
    BEGIN
        RAISERROR('User is not authorized. Only SuperAdmin can access this summary.', 16, 1);
        RETURN;
    END

    -- Return Vendors created by the SuperAdmin
    SELECT 
        V.VendorID,
        V.VendorCode,
        V.VendorName,
        V.ContactEmail,
        V.ContactPhone,
        V.CreatedAt
    FROM Vendors V
    WHERE V.CreatedBy = @UserID;

    -- Return Customers created by the SuperAdmin (via logs)
    SELECT 
        C.CustomerID,
        C.ReferenceNumber,
        C.CustomerName,
        C.Email,
        C.Phone,
        U.UtilityName
    FROM Customers C
    INNER JOIN Utilities U ON C.UtilityID = U.UtilityID
    WHERE EXISTS (
        SELECT 1 FROM AuditLogs A 
        WHERE A.Action = 'Customer Created' 
          AND A.UserID = @UserID 
          AND A.Details LIKE CONCAT('%', C.ReferenceNumber, '%')
    );

    -- Return Utilities created by the SuperAdmin
    SELECT 
        UtilityID,
        UtilityName,
        UtilityCode,
        CreatedAt
    FROM Utilities
    WHERE CreatedBy = @UserID;

    -- Set output parameters for counts
    SELECT
        @TotalVendors = (SELECT COUNT(*) FROM Vendors WHERE CreatedBy = @UserID),
        @TotalCustomers = (SELECT COUNT(*) FROM Customers WHERE EXISTS (
            SELECT 1 FROM AuditLogs A 
            WHERE A.Action = 'Customer Created' 
              AND A.UserID = @UserID 
              AND A.Details LIKE CONCAT('%', Customers.ReferenceNumber, '%')
        )),
        @TotalUtilities = (SELECT COUNT(*) FROM Utilities WHERE CreatedBy = @UserID);
END;


EXEC sp_GetSuperAdminSummary @UserID = 1;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSuperAdminSummary2]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetSuperAdminSummary2]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validate user is SuperAdmin (RoleID = 1)
    IF NOT EXISTS (
        SELECT 1 FROM Users WHERE UserID = @UserID AND RoleID = 1
    )
    BEGIN
        RAISERROR('User is not authorized. Only SuperAdmin can access this summary.', 16, 1);
        RETURN;
    END

    -- 1. Vendors created by this SuperAdmin
    SELECT 
        V.VendorID,
        V.VendorCode,
        V.VendorName,
        V.ContactEmail,
        V.ContactPhone,
        V.CreatedAt
    FROM Vendors V
    WHERE V.CreatedBy = @UserID;

    -- 2. Customers created by this SuperAdmin (via audit logs)
    SELECT 
        C.CustomerID,
        C.ReferenceNumber,
        C.CustomerName,
        C.Email,
        C.Phone,
        U.UtilityName
    FROM Customers C
    INNER JOIN Utilities U ON C.UtilityID = U.UtilityID
    WHERE EXISTS (
        SELECT 1 FROM AuditLogs A
        WHERE A.Action = 'Customer Created'
          AND A.UserID = @UserID
          AND A.Details LIKE '%' + C.ReferenceNumber + '%'
    );

    -- 3. Utilities created by this SuperAdmin
    SELECT 
        UtilityID,
        UtilityName,
        UtilityCode,
        CreatedAt
    FROM Utilities
    WHERE CreatedBy = @UserID;

    -- 4. Summary row: counts as scalars
    SELECT 
        (SELECT COUNT(*) FROM Vendors WHERE CreatedBy = @UserID) AS TotalVendors,
        (SELECT COUNT(*) FROM Customers WHERE EXISTS (
            SELECT 1 FROM AuditLogs A 
            WHERE A.Action = 'Customer Created' AND A.UserID = @UserID 
            AND A.Details LIKE '%' + Customers.ReferenceNumber + '%'
        )) AS TotalUsers,
        (SELECT COUNT(*) FROM Utilities WHERE CreatedBy = @UserID) AS TotalUtilities;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUtilityPackages]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetUtilityPackages]
    @UtilityID INT
AS
BEGIN
    SELECT 
        p.PackageID,
        p.PackageName,
        p.PackageCode,
        p.Amount,
        p.Description,
        p.IsActive,
        p.CreatedAt,
        u.UtilityName,
        u.UtilityCode
    FROM UtilityPackages p
    INNER JOIN Utilities u ON p.UtilityID = u.UtilityID
    WHERE p.UtilityID = @UtilityID 
      AND p.IsActive = 1
    ORDER BY p.PackageName;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVendorDashboardSummaryByUser]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetVendorDashboardSummaryByUser]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @VendorID INT;
    DECLARE @VendorName VARCHAR(100);
    DECLARE @Balance DECIMAL(18,2);
    DECLARE @TotalCustomers INT;
    DECLARE @TotalPayments DECIMAL(18,2);
    DECLARE @FailedPayments INT;
    DECLARE @TotalTransactions INT;

    -- Find VendorID for this user
    SELECT @VendorID = v.VendorID
    FROM Vendors v
    JOIN Users u ON u.Username = v.VendorCode
    WHERE u.UserID = @UserID;

    IF @VendorID IS NULL
    BEGIN
        -- User not linked to any vendor - return empty or default
        SELECT 
            CAST(NULL AS VARCHAR(100)) AS VendorName,
            CAST(0 AS DECIMAL(18,2)) AS AccountBalance,
            0 AS CustomersWorked,
            0 AS TotalPaymentsMade,
            0 AS FailedPayments,
            0 AS TotalTransactions;
        RETURN;
    END

    -- Get Vendor info
    SELECT @VendorName = VendorName, @Balance = Balance
    FROM Vendors
    WHERE VendorID = @VendorID;

    -- Count customers worked on by vendor
    SELECT @TotalCustomers = COUNT(DISTINCT CustomerID)
    FROM ReceivedTransactions
    WHERE VendorID = @VendorID;

    -- Sum of successful payments made by vendor
    SELECT @TotalPayments = ISNULL(SUM(Amount), 0)
    FROM ReceivedTransactions
    WHERE VendorID = @VendorID AND Status = 'Success';

    -- Count failed payments by vendor
    SELECT @FailedPayments = COUNT(*)
    FROM ReceivedTransactions
    WHERE VendorID = @VendorID AND Status = 'Failed';

    -- Count total transactions by vendor
    SELECT @TotalTransactions = COUNT(*)
    FROM ReceivedTransactions
    WHERE VendorID = @VendorID;

    -- Return data
    SELECT
        @VendorName AS VendorName,
        @Balance AS AccountBalance,
        @TotalCustomers AS CustomersWorked,
        @TotalPayments AS TotalPaymentsMade,
        @FailedPayments AS FailedPayments,
        @TotalTransactions AS TotalTransactions;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertAuditLog]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertAuditLog]
    @UserID INT,
    @Action NVARCHAR(100),
    @Timestamp DATETIME = NULL, -- Optional: defaults to current time if not provided
    @Details NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- If @Timestamp is NULL, set it to current date/time
    IF @Timestamp IS NULL
        SET @Timestamp = GETDATE();

    INSERT INTO [BillPayments].[dbo].[AuditLogs] (
        [UserID],
        [Action],
        [Timestamp],
        [Details]
    )
    VALUES (
        @UserID,
        @Action,
        @Timestamp,
        @Details
    );
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_LoginUser]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_LoginUser]
    @UsernameOrEmail VARCHAR(100),
    @PasswordHash VARCHAR(256)
AS
BEGIN
    DECLARE @UserID INT, @IsActive BIT, @AttemptCount INT;

    SELECT 
        @UserID = UserID,
        @IsActive = IsActive
    FROM Users 
    WHERE (Username = @UsernameOrEmail OR Email = @UsernameOrEmail)
      AND PasswordHash = @PasswordHash;

    IF @UserID IS NOT NULL
    BEGIN
        -- Check account status
        IF @IsActive = 0
        BEGIN
            SELECT -2 AS ResultCode; -- Account locked
            RETURN;
        END

        -- Reset previous failed attempts on successful login
        DELETE FROM LoginAttempts WHERE UserID = @UserID AND Success = 0;

        SELECT u.UserID, u.Username, u.Email, r.RoleName, u.RoleID
        FROM Users u
        INNER JOIN Roles r ON u.RoleID = r.RoleID
        WHERE u.UserID = @UserID;
    END
    ELSE
    BEGIN
        -- Track failed login attempt
        SELECT @UserID = UserID FROM Users 
        WHERE (Username = @UsernameOrEmail OR Email = @UsernameOrEmail);

        IF @UserID IS NOT NULL
        BEGIN
            INSERT INTO LoginAttempts (UserID, Success) VALUES (@UserID, 0);

            -- Lock account if 3 failed attempts
            SELECT @AttemptCount = COUNT(*) 
            FROM LoginAttempts 
            WHERE UserID = @UserID AND Success = 0;

            IF @AttemptCount >= 3
            BEGIN
                UPDATE Users SET IsActive = 0 WHERE UserID = @UserID;
                SELECT -2 AS ResultCode; -- Account locked
                RETURN;
            END
        END

        SELECT -1 AS ResultCode; -- Invalid login
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_LoginUser2]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_LoginUser2]
    @UsernameOrEmail VARCHAR(100),
    @PasswordHash VARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;

    -- Attempt to find a user matching the username/email and password
    SELECT TOP 1
        UserID,
        RoleID
    FROM Users
    WHERE (Username = @UsernameOrEmail OR Email = @UsernameOrEmail)
      AND PasswordHash = @PasswordHash
      AND IsActive = 1;  -- Assuming you have an IsActive flag
END
GO
/****** Object:  StoredProcedure [dbo].[sp_LoginUser2WithLockout]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_LoginUser2WithLockout]
    @UsernameOrEmail VARCHAR(100),
    @PasswordHash VARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @UserID INT = NULL;
    DECLARE @RoleID INT = NULL;
    DECLARE @IsActive BIT = 0;
    DECLARE @FailedAttempts INT = 0;
    DECLARE @AccountLockedUntil DATETIME = NULL;
    DECLARE @CurrentDateTime DATETIME = GETDATE();
    
    -- First, check if user exists
    SELECT 
        @UserID = UserID,
        @RoleID = RoleID,
        @IsActive = IsActive,
        @FailedAttempts = ISNULL(FailedLoginAttempts, 0),
        @AccountLockedUntil = AccountLockedUntil
    FROM Users
    WHERE (Username = @UsernameOrEmail OR Email = @UsernameOrEmail);
    
    -- If user doesn't exist, return empty result
    IF @UserID IS NULL
    BEGIN
        SELECT 
            -1 as LoginResult, -- User not found
            NULL as UserID,
            NULL as RoleID,
            0 as FailedAttempts,
            'User not found' as Message;
        RETURN;
    END
    
    -- Check if account is currently locked
    IF @AccountLockedUntil IS NOT NULL AND @AccountLockedUntil > @CurrentDateTime
    BEGIN
        SELECT 
            -3 as LoginResult, -- Account locked
            NULL as UserID,
            NULL as RoleID,
            @FailedAttempts as FailedAttempts,
            'Account is locked. Please contact administrator.' as Message;
        RETURN;
    END
    
    -- Check if account is inactive
    IF @IsActive = 0
    BEGIN
        SELECT 
            -4 as LoginResult, -- Account inactive
            NULL as UserID,
            NULL as RoleID,
            @FailedAttempts as FailedAttempts,
            'Account is inactive. Please contact administrator.' as Message;
        RETURN;
    END
    
    -- Check password
    IF EXISTS (
        SELECT 1 FROM Users 
        WHERE (Username = @UsernameOrEmail OR Email = @UsernameOrEmail)
        AND PasswordHash = @PasswordHash
        AND IsActive = 1
    )
    BEGIN
        -- Successful login - reset failed attempts
        UPDATE Users 
        SET FailedLoginAttempts = 0,
            LastFailedLoginAttempt = NULL,
            AccountLockedUntil = NULL
        WHERE UserID = @UserID;
        
        SELECT 
            1 as LoginResult, -- Success
            @UserID as UserID,
            @RoleID as RoleID,
            0 as FailedAttempts,
            'Login successful' as Message;
    END
    ELSE
    BEGIN
        -- Wrong password - increment failed attempts
        SET @FailedAttempts = @FailedAttempts + 1;
        
        IF @FailedAttempts >= 3
        BEGIN
            -- Lock account after 3 failed attempts
            UPDATE Users 
            SET FailedLoginAttempts = @FailedAttempts,
                LastFailedLoginAttempt = @CurrentDateTime,
                IsActive = 0,
                AccountLockedUntil = DATEADD(HOUR, 24, @CurrentDateTime) -- Lock for 24 hours
            WHERE UserID = @UserID;
            
            SELECT 
                -2 as LoginResult, -- Account locked due to failed attempts
                NULL as UserID,
                NULL as RoleID,
                @FailedAttempts as FailedAttempts,
                'Account has been locked due to multiple failed login attempts. Please contact administrator.' as Message;
        END
        ELSE
        BEGIN
            -- Update failed attempts count
            UPDATE Users 
            SET FailedLoginAttempts = @FailedAttempts,
                LastFailedLoginAttempt = @CurrentDateTime
            WHERE UserID = @UserID;
            
            DECLARE @RemainingAttempts INT = 3 - @FailedAttempts;
            DECLARE @WarningMessage VARCHAR(200);
            
            IF @RemainingAttempts = 1
            BEGIN
                SET @WarningMessage = 'Invalid password. Warning: One more failed attempt will lock your account.';
            END
            ELSE
            BEGIN
                SET @WarningMessage = 'Invalid password. You have ' + CAST(@RemainingAttempts AS VARCHAR(10)) + ' attempts remaining.';
            END
            
            SELECT 
                0 as LoginResult, -- Failed login
                NULL as UserID,
                NULL as RoleID,
                @FailedAttempts as FailedAttempts,
                @WarningMessage as Message;
        END
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ResetUserPassword]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ResetUserPassword]
    @UsernameOrEmail VARCHAR(100),
    @NewPasswordHash VARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 FROM Users WHERE (Username = @UsernameOrEmail OR Email = @UsernameOrEmail)
    )
    BEGIN
        UPDATE Users
        SET PasswordHash = @NewPasswordHash,
            FailedLoginAttempts = 0,
            LastFailedLoginAttempt = NULL,
            AccountLockedUntil = NULL,
            IsActive = 1
        WHERE (Username = @UsernameOrEmail OR Email = @UsernameOrEmail);

        SELECT 
            1 AS ResultCode,
            'Password reset successful.' AS Message;
    END
    ELSE
    BEGIN
        SELECT 
            -1 AS ResultCode,
            'User not found. Cannot reset password.' AS Message;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UnlockUserAccount]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_UnlockUserAccount]
    @UsernameOrEmail VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @UserID INT = NULL;
    
    -- Check if user exists
    SELECT @UserID = UserID
    FROM Users
    WHERE (Username = @UsernameOrEmail OR Email = @UsernameOrEmail);
    
    IF @UserID IS NULL
    BEGIN
        SELECT 0 as Success, 'User not found' as Message;
        RETURN;
    END
    
    -- Unlock and activate the account
    UPDATE Users 
    SET IsActive = 1,
        FailedLoginAttempts = 0,
        LastFailedLoginAttempt = NULL,
        AccountLockedUntil = NULL
    WHERE UserID = @UserID;
    
    SELECT 1 as Success, 'Account has been unlocked and activated successfully' as Message;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateUtilityTransactionResult]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_UpdateUtilityTransactionResult]
    @TransactionID UNIQUEIDENTIFIER,
    @UtilityToken NVARCHAR(100),
    @UtilityReceiptNo NVARCHAR(100),
    @Status VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE ReceivedTransactions
    SET 
        UtilityToken = @UtilityToken,
        UtilityReceiptNo = @UtilityReceiptNo,
        Status = @Status,
        ProcessedAt = GETDATE()
    WHERE TransactionID = @TransactionID;

    -- Optionally: Log success/failure
    INSERT INTO AuditLogs (UserID, Action, Details)
    VALUES (
        0, -- system user
        'Processed Utility Transaction',
        CONCAT('TransactionID: ', @TransactionID, ', Status: ', @Status)
    );
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateUtilityReference]    Script Date: 7/1/2025 5:59:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ValidateUtilityReference]
    @VendorCode VARCHAR(20),
    @ReferenceNumber VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @VendorID INT;

    SELECT @VendorID = VendorID
    FROM Vendors
    WHERE VendorCode = @VendorCode;

    IF @VendorID IS NULL
    BEGIN
        RAISERROR('Vendor not found', 16, 1);
        RETURN;
    END

    -- Validate Customer and fetch Utility info
    SELECT TOP 1 
        c.ReferenceNumber, 
        c.CustomerName, 
        c.Email, 
        c.Phone, 
        c.UtilityID,
        u.UtilityCode,
        u.UtilityName
    FROM Customers c
    INNER JOIN Utilities u ON c.UtilityID = u.UtilityID
    WHERE c.ReferenceNumber = @ReferenceNumber;
END
GO
