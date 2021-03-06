USE [master]
GO
/****** Object:  Database [Team5Project]    Script Date: 13/04/2020 5:48:03 PM ******/
CREATE DATABASE [Team5Project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OnlineVehicleBooking', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SANTOSHSQL\MSSQL\DATA\OnlineVehicleBooking.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OnlineVehicleBooking_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SANTOSHSQL\MSSQL\DATA\OnlineVehicleBooking_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Team5Project] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Team5Project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Team5Project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Team5Project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Team5Project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Team5Project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Team5Project] SET ARITHABORT OFF 
GO
ALTER DATABASE [Team5Project] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Team5Project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Team5Project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Team5Project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Team5Project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Team5Project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Team5Project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Team5Project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Team5Project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Team5Project] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Team5Project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Team5Project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Team5Project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Team5Project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Team5Project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Team5Project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Team5Project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Team5Project] SET RECOVERY FULL 
GO
ALTER DATABASE [Team5Project] SET  MULTI_USER 
GO
ALTER DATABASE [Team5Project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Team5Project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Team5Project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Team5Project] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Team5Project] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Team5Project', N'ON'
GO
ALTER DATABASE [Team5Project] SET QUERY_STORE = OFF
GO
USE [Team5Project]
GO
/****** Object:  Table [dbo].[Vehicle_Availability]    Script Date: 13/04/2020 5:48:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle_Availability](
	[Vehicle_id] [nvarchar](10) NOT NULL,
	[Branch_id] [nvarchar](50) NOT NULL,
	[As_On_Date] [date] NOT NULL,
 CONSTRAINT [PK_Vehicle_Availability] PRIMARY KEY CLUSTERED 
(
	[Vehicle_id] ASC,
	[Branch_id] ASC,
	[As_On_Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicle_details]    Script Date: 13/04/2020 5:48:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle_details](
	[Manufactures_name] [nvarchar](50) NULL,
	[Vehicle_Code] [nvarchar](10) NOT NULL,
	[Ex_ShowRoom_Price] [int] NULL,
	[Color] [nvarchar](15) NULL,
	[No_of_Vehicles_Available] [int] NULL,
	[Seating_Capacity] [int] NULL,
	[Stocks_Lasts_Still] [date] NULL,
 CONSTRAINT [PK_Vehicle_details] PRIMARY KEY CLUSTERED 
(
	[Vehicle_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Branch_Admin]    Script Date: 13/04/2020 5:48:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch_Admin](
	[Branch_id] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NULL,
	[Branch_Location] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[Mail_id] [nvarchar](50) NULL,
	[Phone] [char](15) NULL,
	[Status] [nvarchar](10) NOT NULL,
	[Role_Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Branch_Admin] PRIMARY KEY CLUSTERED 
(
	[Branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VehicleSearch]    Script Date: 13/04/2020 5:48:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[VehicleSearch] as
select Manufactures_name,Vehicle_Code,Branch_Location,Ex_ShowRoom_Price PriceRange,Color,Seating_Capacity
from Vehicle_details vd inner join Vehicle_Availability va on vd.Vehicle_Code=va.Vehicle_id inner join Branch_Admin ba on ba.Branch_id=va.Branch_id
GO
/****** Object:  Table [dbo].[Branch_Vehicle_Request]    Script Date: 13/04/2020 5:48:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch_Vehicle_Request](
	[As_On_Date] [date] NOT NULL,
	[Vehicle_id] [nvarchar](10) NOT NULL,
	[Branch_id] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](10) NULL,
	[No_Of_Vehicles_Requested] [int] NULL,
	[No_Of_Vehicles_Approved] [int] NULL,
 CONSTRAINT [PK_Branch_Vehicle_Request] PRIMARY KEY CLUSTERED 
(
	[As_On_Date] ASC,
	[Vehicle_id] ASC,
	[Branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer_Profile]    Script Date: 13/04/2020 5:48:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_Profile](
	[Customer_id] [nvarchar](50) NOT NULL,
	[Customer_name] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Date_of_Birth] [date] NULL,
	[Address] [nvarchar](50) NULL,
	[Mail_id] [nvarchar](50) NULL,
	[Phone] [char](15) NULL,
	[Occupation] [nvarchar](50) NULL,
	[Status] [nvarchar](10) NOT NULL,
	[Role_Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Customer_Profile] PRIMARY KEY CLUSTERED 
(
	[Customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer_Vehicle_Booking1]    Script Date: 13/04/2020 5:48:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_Vehicle_Booking1](
	[Booking_id] [int] IDENTITY(1,1) NOT NULL,
	[Vehicle_id] [nvarchar](10) NULL,
	[Branch_Location] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[Customer_id] [nvarchar](50) NULL,
 CONSTRAINT [PK_Customer_Vehicle_Booking1] PRIMARY KEY CLUSTERED 
(
	[Booking_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Registration]    Script Date: 13/04/2020 5:48:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Registration](
	[Userid] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NULL,
	[Role_Type] [nvarchar](50) NULL,
	[Status] [nvarchar](10) NULL,
	[Create_date] [date] NULL,
 CONSTRAINT [PK_User_Registrations] PRIMARY KEY CLUSTERED 
(
	[Userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Branch_Admin] ([Branch_id], [Password], [Branch_Location], [Address], [Mail_id], [Phone], [Status], [Role_Type]) VALUES (N'ASR001', N'aDMIN@123', N'kukatpally', N'metrostation', N'msr0598@gmail.com', N'011-5575525    ', N'Pending', N'BA')
INSERT [dbo].[Branch_Admin] ([Branch_id], [Password], [Branch_Location], [Address], [Mail_id], [Phone], [Status], [Role_Type]) VALUES (N'BHYD0001', N'Admin@123', N'Hyderabad', N'hyderabad', N'msr0598@gmail.com', N'011-5575525    ', N'Approved', N'BA')
INSERT [dbo].[Branch_Admin] ([Branch_id], [Password], [Branch_Location], [Address], [Mail_id], [Phone], [Status], [Role_Type]) VALUES (N'BHYD001', N'Admin@123', N'kukatpally', N'metrostation', N'msr0598@gmail.com', N'011-5575525    ', N'Pending', N'BA')
INSERT [dbo].[Branch_Admin] ([Branch_id], [Password], [Branch_Location], [Address], [Mail_id], [Phone], [Status], [Role_Type]) VALUES (N'BKBH001', N'Admin@123', N'kukatpally', N'metro station', N'msr0598@gmail.com', N'040-5575525    ', N'Approved', N'BA')
INSERT [dbo].[Branch_Admin] ([Branch_id], [Password], [Branch_Location], [Address], [Mail_id], [Phone], [Status], [Role_Type]) VALUES (N'DLSK001', N'DLSK@1234', N'DILUSUKNAGAR', N'BABATEMPLE', N'dlsk@gmail.com', N'050-6543216    ', N'Pending', N'bd')
INSERT [dbo].[Branch_Admin] ([Branch_id], [Password], [Branch_Location], [Address], [Mail_id], [Phone], [Status], [Role_Type]) VALUES (N'Gayatbr1', N'Admin@123', N'hyderabad', N'hyderabad', N'msr0598@gmail.com', N'011-5575525    ', N'Approved', N'BA')
INSERT [dbo].[Branch_Admin] ([Branch_id], [Password], [Branch_Location], [Address], [Mail_id], [Phone], [Status], [Role_Type]) VALUES (N'GCB001', N'GCB@1234', N'GACHIBOWLI', N'PALMETTO', N'gcb@gmail.com', N'080-9876546    ', N'Pending', N'bd')
INSERT [dbo].[Branch_Admin] ([Branch_id], [Password], [Branch_Location], [Address], [Mail_id], [Phone], [Status], [Role_Type]) VALUES (N'HYD001', N'HYD@1234', N'HYDERABAD', N'CENTRO', N'hyd@gmail.com', N'090-7899876    ', N'Pending', N'bd')
INSERT [dbo].[Branch_Admin] ([Branch_id], [Password], [Branch_Location], [Address], [Mail_id], [Phone], [Status], [Role_Type]) VALUES (N'KPHB001', N'KPHB@1234', N'KUKATPALLY', N'METRO STATION', N'kphb@gmail.com', N'040-1234566    ', N'Pending', N'bd')
INSERT [dbo].[Branch_Admin] ([Branch_id], [Password], [Branch_Location], [Address], [Mail_id], [Phone], [Status], [Role_Type]) VALUES (N'kRISHBR001', N'Admin@123', N'Hyderabad', N'hyderabad', N'msr0598@gmail.com', N'011-5575525    ', N'Approved', N'BA')
INSERT [dbo].[Branch_Admin] ([Branch_id], [Password], [Branch_Location], [Address], [Mail_id], [Phone], [Status], [Role_Type]) VALUES (N'qwer1234', N'Admin@123', N'kukatpally', N'metrostation', N'msr0598@gmail.com', N'011-5575525    ', N'Approved', N'BA')
INSERT [dbo].[Branch_Admin] ([Branch_id], [Password], [Branch_Location], [Address], [Mail_id], [Phone], [Status], [Role_Type]) VALUES (N'Rheabr001', N'Admin@123', N'HYDERABAD', N'hyderabad', N'msr0598@gmail.com', N'040-5575525    ', N'Pending', N'BA')
INSERT [dbo].[Branch_Admin] ([Branch_id], [Password], [Branch_Location], [Address], [Mail_id], [Phone], [Status], [Role_Type]) VALUES (N'saibr001', N'Admin@123', N'hyderabad', N'hyderabad', N'msr0598@gmail.com', N'011-5575525    ', N'Approved', N'BA')
INSERT [dbo].[Branch_Admin] ([Branch_id], [Password], [Branch_Location], [Address], [Mail_id], [Phone], [Status], [Role_Type]) VALUES (N'Sairamm001', N'Admin@123', N'KUKATPALLY', N'metrostation', N'msr0598@gmail.com', N'040-5575525    ', N'Approved', N'BA')
INSERT [dbo].[Branch_Admin] ([Branch_id], [Password], [Branch_Location], [Address], [Mail_id], [Phone], [Status], [Role_Type]) VALUES (N'Venbr001', N'Admin@123', N'HYDERABAD', N'hyderabad', N'msr0598@gmail.com', N'011-5575525    ', N'Approved', N'BA')
INSERT [dbo].[Branch_Vehicle_Request] ([As_On_Date], [Vehicle_id], [Branch_id], [Status], [No_Of_Vehicles_Requested], [No_Of_Vehicles_Approved]) VALUES (CAST(N'2020-04-05' AS Date), N'V001', N'qwer1234', N'Approved', 20, 10)
INSERT [dbo].[Branch_Vehicle_Request] ([As_On_Date], [Vehicle_id], [Branch_id], [Status], [No_Of_Vehicles_Requested], [No_Of_Vehicles_Approved]) VALUES (CAST(N'2020-04-06' AS Date), N'BG001', N'Sairamm001', N'Approved', 10, 5)
INSERT [dbo].[Branch_Vehicle_Request] ([As_On_Date], [Vehicle_id], [Branch_id], [Status], [No_Of_Vehicles_Requested], [No_Of_Vehicles_Approved]) VALUES (CAST(N'2020-04-06' AS Date), N'J001', N'Sairamm001', N'Approved', 10, 5)
INSERT [dbo].[Branch_Vehicle_Request] ([As_On_Date], [Vehicle_id], [Branch_id], [Status], [No_Of_Vehicles_Requested], [No_Of_Vehicles_Approved]) VALUES (CAST(N'2020-04-06' AS Date), N'MC001', N'Sairamm001', N'Approved', 10, 5)
INSERT [dbo].[Branch_Vehicle_Request] ([As_On_Date], [Vehicle_id], [Branch_id], [Status], [No_Of_Vehicles_Requested], [No_Of_Vehicles_Approved]) VALUES (CAST(N'2020-04-11' AS Date), N'DK5681', N'BHYD0001', N'Approved', 20, 10)
INSERT [dbo].[Branch_Vehicle_Request] ([As_On_Date], [Vehicle_id], [Branch_id], [Status], [No_Of_Vehicles_Requested], [No_Of_Vehicles_Approved]) VALUES (CAST(N'2020-04-13' AS Date), N'A001', N'saibr001', N'Approved', 30, 10)
INSERT [dbo].[Branch_Vehicle_Request] ([As_On_Date], [Vehicle_id], [Branch_id], [Status], [No_Of_Vehicles_Requested], [No_Of_Vehicles_Approved]) VALUES (CAST(N'2020-04-13' AS Date), N'BM001', N'Gayatbr1', N'Approved', 30, 15)
INSERT [dbo].[Branch_Vehicle_Request] ([As_On_Date], [Vehicle_id], [Branch_id], [Status], [No_Of_Vehicles_Requested], [No_Of_Vehicles_Approved]) VALUES (CAST(N'2020-04-13' AS Date), N'DK5681', N'kRISHBR001', N'Approved', 20, 10)
INSERT [dbo].[Branch_Vehicle_Request] ([As_On_Date], [Vehicle_id], [Branch_id], [Status], [No_Of_Vehicles_Requested], [No_Of_Vehicles_Approved]) VALUES (CAST(N'2020-04-13' AS Date), N'NS001', N'saibr001', N'Approved', 30, 10)
INSERT [dbo].[Branch_Vehicle_Request] ([As_On_Date], [Vehicle_id], [Branch_id], [Status], [No_Of_Vehicles_Requested], [No_Of_Vehicles_Approved]) VALUES (CAST(N'2020-04-13' AS Date), N'V001', N'Venbr001', N'Approved', 20, 10)
INSERT [dbo].[Customer_Profile] ([Customer_id], [Customer_name], [Password], [Date_of_Birth], [Address], [Mail_id], [Phone], [Occupation], [Status], [Role_Type]) VALUES (N'Cust001', N'Customer', N'Admin@123', CAST(N'1998-05-05' AS Date), N'Hyderabad', N'msr0598@gmail.com', N'011-5575525    ', N'Employee', N'Pending', N'Customer')
INSERT [dbo].[Customer_Profile] ([Customer_id], [Customer_name], [Password], [Date_of_Birth], [Address], [Mail_id], [Phone], [Occupation], [Status], [Role_Type]) VALUES (N'Gayathri001', N'Gayathri', N'Admin@123', CAST(N'1998-05-05' AS Date), N'Hyderabad', N'msr0598@gmail.com', N'011-5575525    ', N'Employee', N'Approved', N'Customer')
INSERT [dbo].[Customer_Profile] ([Customer_id], [Customer_name], [Password], [Date_of_Birth], [Address], [Mail_id], [Phone], [Occupation], [Status], [Role_Type]) VALUES (N'Krishna001', N'krish', N'Admin@123', CAST(N'1998-05-05' AS Date), N'hyderabad', N'msr0598@gmail.com', N'040-5575525    ', N'Employee', N'Approved', N'Customer')
INSERT [dbo].[Customer_Profile] ([Customer_id], [Customer_name], [Password], [Date_of_Birth], [Address], [Mail_id], [Phone], [Occupation], [Status], [Role_Type]) VALUES (N'Raju001', N'RajiReddy', N'Raju@123', CAST(N'2020-06-06' AS Date), N'Hyderabad', N'Raju@gmail.com', N'040-5546625    ', N'Employee', N'Approved', N'Customer')
INSERT [dbo].[Customer_Profile] ([Customer_id], [Customer_name], [Password], [Date_of_Birth], [Address], [Mail_id], [Phone], [Occupation], [Status], [Role_Type]) VALUES (N'Rhea005', N'Rhea', N'Admin@123', CAST(N'1998-05-05' AS Date), N'Hyderabad', N'msr0598@gmail.com', N'040-5575525    ', N'Employee', N'Pending', N'Customer')
INSERT [dbo].[Customer_Profile] ([Customer_id], [Customer_name], [Password], [Date_of_Birth], [Address], [Mail_id], [Phone], [Occupation], [Status], [Role_Type]) VALUES (N'Saikrishna001', N'Saikrishna', N'Admin@123', CAST(N'1998-05-05' AS Date), N'Hyderabad', N'msr0598@gmail.com', N'011-5575525    ', N'Employee', N'Approved', N'Customer')
INSERT [dbo].[Customer_Profile] ([Customer_id], [Customer_name], [Password], [Date_of_Birth], [Address], [Mail_id], [Phone], [Occupation], [Status], [Role_Type]) VALUES (N'sairam001', N'Sairam', N'Admin@123', CAST(N'1998-05-05' AS Date), N'Hyderabad', N'msr0598@gmail.com', N'011-5575525    ', N'Employee', N'Approved', N'Customer')
INSERT [dbo].[Customer_Profile] ([Customer_id], [Customer_name], [Password], [Date_of_Birth], [Address], [Mail_id], [Phone], [Occupation], [Status], [Role_Type]) VALUES (N'Samlokesh', N'sam', N'Admin@123', CAST(N'1998-05-05' AS Date), N'Hyderabad', N'msr0598@gmail.com', N'040-5575525    ', N'Employee', N'Pending', N'Customer')
INSERT [dbo].[Customer_Profile] ([Customer_id], [Customer_name], [Password], [Date_of_Birth], [Address], [Mail_id], [Phone], [Occupation], [Status], [Role_Type]) VALUES (N'San0001', N'santosh', N'Admin@123', CAST(N'1998-05-05' AS Date), N'sfdgfsag', N'msr0598@gmail.com', N'011-5575525    ', N'Employee', N'Approved', N'Customer')
INSERT [dbo].[Customer_Profile] ([Customer_id], [Customer_name], [Password], [Date_of_Birth], [Address], [Mail_id], [Phone], [Occupation], [Status], [Role_Type]) VALUES (N'san12345', N'santosh', N'Admin@123', CAST(N'1998-05-05' AS Date), N'sircilla', N'msr0598@gmail.com', N'010-1234567    ', N'Employee', N'Approved', N'Customer')
INSERT [dbo].[Customer_Profile] ([Customer_id], [Customer_name], [Password], [Date_of_Birth], [Address], [Mail_id], [Phone], [Occupation], [Status], [Role_Type]) VALUES (N'Santhu001', N'rhea', N'Admin@123', CAST(N'1998-05-05' AS Date), N'hyderabad', N'msr0598@gmail.com', N'011-5575525    ', N'Employee', N'Approved', N'Customer')
INSERT [dbo].[Customer_Profile] ([Customer_id], [Customer_name], [Password], [Date_of_Birth], [Address], [Mail_id], [Phone], [Occupation], [Status], [Role_Type]) VALUES (N'Venky001', N'venky', N'Admin@123', CAST(N'1998-05-05' AS Date), N'Hyderabad', N'msr0598@gmail.com', N'011-5575525    ', N'Employee', N'Approved', N'Customer')
SET IDENTITY_INSERT [dbo].[Customer_Vehicle_Booking1] ON 

INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (12, N'AMC001', N'HYDERABAD', N'Approved', N'san12345')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (13, N'BE001', N'HYDERABAD', N'Approved', N'san12345')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (14, N'AMC001', N'HYDERABAD', N'Approved', N'Santhu001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (15, N'BE001', N'HYDERABAD', N'Approved', N'Santhu001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (1012, N'BM001', N'DILUSUKNAGAR', N'Pending', N'Raju001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (1013, N'A001', N'GACHIBOWLI', N'Pending', N'Raju001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (1014, N'BE001', N'HYDERABAD', N'Pending', N'Raju001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (1015, N'L001', N'HYDERABAD', N'Pending', N'Raju001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (1016, N'T001', N'HYDERABAD', N'Pending', N'Raju001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (1017, N'A1001', N'KUKATPALLY', N'Approved', N'sairam001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (1018, N'AMC001', N'HYDERABAD', N'Approved', N'sairam001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (1019, N'BM001', N'DILUSUKNAGAR', N'Approved', N'sairam001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (1020, N'MC001', N'DILUSUKNAGAR', N'Approved', N'sairam001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (1021, N'V001', N'DILUSUKNAGAR', N'Approved', N'sairam001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (2012, N'J001', N'KUKATPALLY', N'Approved', N'san12345')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (2013, N'A1001', N'KUKATPALLY', N'Approved', N'san12345')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (2014, N'BEN001', N'GACHIBOWLI', N'Approved', N'san12345')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (2015, N'BE001', N'HYDERABAD', N'Approved', N'Venky001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (2016, N'L001', N'HYDERABAD', N'Approved', N'Venky001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (2017, N'T001', N'HYDERABAD', N'Approved', N'Krishna001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (2018, N'AS001', N'HYDERABAD', N'Approved', N'Saikrishna001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (2019, N'L001', N'HYDERABAD', N'Approved', N'Saikrishna001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (2020, N'AS001', N'HYDERABAD', N'Approved', N'Gayathri001')
INSERT [dbo].[Customer_Vehicle_Booking1] ([Booking_id], [Vehicle_id], [Branch_Location], [Status], [Customer_id]) VALUES (2021, N'BM001', N'DILUSUKNAGAR', N'Approved', N'Gayathri001')
SET IDENTITY_INSERT [dbo].[Customer_Vehicle_Booking1] OFF
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'Admin001', N'Admin@123', N'admin', N'Approved', CAST(N'2020-04-04' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'BHYD0001', N'Admin@123', N'BA', N'Approved', CAST(N'2020-04-04' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'BKBH001', N'Admin@123', N'BA', N'Approved', CAST(N'2020-04-04' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'Gayatbr1', N'Admin@123', N'BA', N'Approved', CAST(N'2020-04-13' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'Gayathri001', N'Admin@123', N'Customer', N'Approved', CAST(N'2020-04-13' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'kRISHBR001', N'Admin@123', N'BA', N'Approved', CAST(N'2020-04-13' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'Krishna001', N'Admin@123', N'Customer', N'Approved', CAST(N'2020-04-13' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'qwer1234', N'Admin@123', N'BA', N'Approved', CAST(N'2020-04-05' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'Raju001', N'Raju@123', N'Customer', N'Approved', CAST(N'2020-04-05' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'saibr001', N'Admin@123', N'BA', N'Approved', CAST(N'2020-04-13' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'Saikrishna001', N'Admin@123', N'Customer', N'Approved', CAST(N'2020-04-13' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'sairam001', N'Admin@123', N'Customer', N'Approved', CAST(N'2020-04-06' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'Sairamm001', N'Admin@123', N'BA', N'Approved', CAST(N'2020-04-06' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'San0001', N'Admin@123', N'Customer', N'Approved', CAST(N'2020-04-04' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'san12345', N'Admin@123', N'Customer', N'Approved', CAST(N'2020-04-04' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'Santhu001', N'Admin@123', N'Customer', N'Approved', CAST(N'2020-04-04' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'Venbr001', N'Admin@123', N'BA', N'Approved', CAST(N'2020-04-13' AS Date))
INSERT [dbo].[User_Registration] ([Userid], [Password], [Role_Type], [Status], [Create_date]) VALUES (N'Venky001', N'Admin@123', N'Customer', N'Approved', CAST(N'2020-04-13' AS Date))
INSERT [dbo].[Vehicle_Availability] ([Vehicle_id], [Branch_id], [As_On_Date]) VALUES (N'A001', N'GCB001', CAST(N'2020-04-04' AS Date))
INSERT [dbo].[Vehicle_Availability] ([Vehicle_id], [Branch_id], [As_On_Date]) VALUES (N'A1001', N'KPHB001', CAST(N'2020-04-04' AS Date))
INSERT [dbo].[Vehicle_Availability] ([Vehicle_id], [Branch_id], [As_On_Date]) VALUES (N'AMC001', N'HYD001', CAST(N'2020-05-05' AS Date))
INSERT [dbo].[Vehicle_Availability] ([Vehicle_id], [Branch_id], [As_On_Date]) VALUES (N'AS001', N'HYD001', CAST(N'2020-06-04' AS Date))
INSERT [dbo].[Vehicle_Availability] ([Vehicle_id], [Branch_id], [As_On_Date]) VALUES (N'BE001', N'HYD001', CAST(N'2020-03-03' AS Date))
INSERT [dbo].[Vehicle_Availability] ([Vehicle_id], [Branch_id], [As_On_Date]) VALUES (N'BEN001', N'GCB001', CAST(N'2020-03-03' AS Date))
INSERT [dbo].[Vehicle_Availability] ([Vehicle_id], [Branch_id], [As_On_Date]) VALUES (N'BG001', N'KPHB001', CAST(N'2020-03-08' AS Date))
INSERT [dbo].[Vehicle_Availability] ([Vehicle_id], [Branch_id], [As_On_Date]) VALUES (N'BM001', N'DLSK001', CAST(N'2020-05-05' AS Date))
INSERT [dbo].[Vehicle_Availability] ([Vehicle_id], [Branch_id], [As_On_Date]) VALUES (N'DK5681', N'GCB001', CAST(N'2020-02-02' AS Date))
INSERT [dbo].[Vehicle_Availability] ([Vehicle_id], [Branch_id], [As_On_Date]) VALUES (N'J001', N'KPHB001', CAST(N'2020-06-06' AS Date))
INSERT [dbo].[Vehicle_Availability] ([Vehicle_id], [Branch_id], [As_On_Date]) VALUES (N'L001', N'HYD001', CAST(N'2020-08-18' AS Date))
INSERT [dbo].[Vehicle_Availability] ([Vehicle_id], [Branch_id], [As_On_Date]) VALUES (N'MC001', N'DLSK001', CAST(N'2020-09-09' AS Date))
INSERT [dbo].[Vehicle_Availability] ([Vehicle_id], [Branch_id], [As_On_Date]) VALUES (N'NS001', N'GCB001', CAST(N'2020-12-06' AS Date))
INSERT [dbo].[Vehicle_Availability] ([Vehicle_id], [Branch_id], [As_On_Date]) VALUES (N'T001', N'HYD001', CAST(N'2020-08-08' AS Date))
INSERT [dbo].[Vehicle_Availability] ([Vehicle_id], [Branch_id], [As_On_Date]) VALUES (N'V001', N'DLSK001', CAST(N'2020-06-04' AS Date))
INSERT [dbo].[Vehicle_details] ([Manufactures_name], [Vehicle_Code], [Ex_ShowRoom_Price], [Color], [No_of_Vehicles_Available], [Seating_Capacity], [Stocks_Lasts_Still]) VALUES (N'AUDI', N'A001', 500000, N'WHITE', 15, 4, CAST(N'2020-04-04' AS Date))
INSERT [dbo].[Vehicle_details] ([Manufactures_name], [Vehicle_Code], [Ex_ShowRoom_Price], [Color], [No_of_Vehicles_Available], [Seating_Capacity], [Stocks_Lasts_Still]) VALUES (N'FORD-A1', N'A1001', 400000, N'BLACK', 15, 5, CAST(N'2020-04-04' AS Date))
INSERT [dbo].[Vehicle_details] ([Manufactures_name], [Vehicle_Code], [Ex_ShowRoom_Price], [Color], [No_of_Vehicles_Available], [Seating_Capacity], [Stocks_Lasts_Still]) VALUES (N'AMC GREMLIN', N'AMC001', 600000, N'BLUE', 2, 4, CAST(N'2020-05-05' AS Date))
INSERT [dbo].[Vehicle_details] ([Manufactures_name], [Vehicle_Code], [Ex_ShowRoom_Price], [Color], [No_of_Vehicles_Available], [Seating_Capacity], [Stocks_Lasts_Still]) VALUES (N'ASTON MARTIN', N'AS001', 2000000, N'GREY', 2, 2, CAST(N'2020-06-04' AS Date))
INSERT [dbo].[Vehicle_details] ([Manufactures_name], [Vehicle_Code], [Ex_ShowRoom_Price], [Color], [No_of_Vehicles_Available], [Seating_Capacity], [Stocks_Lasts_Still]) VALUES (N'BEETLE', N'BE001', 50000, N'BLUE', 20, 4, CAST(N'2020-03-03' AS Date))
INSERT [dbo].[Vehicle_details] ([Manufactures_name], [Vehicle_Code], [Ex_ShowRoom_Price], [Color], [No_of_Vehicles_Available], [Seating_Capacity], [Stocks_Lasts_Still]) VALUES (N'BENTLEY', N'BEN001', 890000, N'RED', 2, 4, CAST(N'2020-03-03' AS Date))
INSERT [dbo].[Vehicle_details] ([Manufactures_name], [Vehicle_Code], [Ex_ShowRoom_Price], [Color], [No_of_Vehicles_Available], [Seating_Capacity], [Stocks_Lasts_Still]) VALUES (N'BUGGATI', N'BG001', 6000000, N'ORANGE', 2, 2, CAST(N'2020-03-08' AS Date))
INSERT [dbo].[Vehicle_details] ([Manufactures_name], [Vehicle_Code], [Ex_ShowRoom_Price], [Color], [No_of_Vehicles_Available], [Seating_Capacity], [Stocks_Lasts_Still]) VALUES (N'BMW', N'BM001', 800000, N'BLACK', 12, 2, CAST(N'2020-05-05' AS Date))
INSERT [dbo].[Vehicle_details] ([Manufactures_name], [Vehicle_Code], [Ex_ShowRoom_Price], [Color], [No_of_Vehicles_Available], [Seating_Capacity], [Stocks_Lasts_Still]) VALUES (N'BENZ', N'DK5681', 2000000, N'RED', 12, 2, CAST(N'2020-02-02' AS Date))
INSERT [dbo].[Vehicle_details] ([Manufactures_name], [Vehicle_Code], [Ex_ShowRoom_Price], [Color], [No_of_Vehicles_Available], [Seating_Capacity], [Stocks_Lasts_Still]) VALUES (N'JAGUAR', N'J001', 580000, N'BLACK', 25, 2, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[Vehicle_details] ([Manufactures_name], [Vehicle_Code], [Ex_ShowRoom_Price], [Color], [No_of_Vehicles_Available], [Seating_Capacity], [Stocks_Lasts_Still]) VALUES (N'LAMBORGHINI ', N'L001', 850000, N'BLUE', 2, 2, CAST(N'2020-08-18' AS Date))
INSERT [dbo].[Vehicle_details] ([Manufactures_name], [Vehicle_Code], [Ex_ShowRoom_Price], [Color], [No_of_Vehicles_Available], [Seating_Capacity], [Stocks_Lasts_Still]) VALUES (N'MC-LARTEN', N'MC001', 5000000, N'SKYBLUE', 2, 2, CAST(N'2020-09-09' AS Date))
INSERT [dbo].[Vehicle_details] ([Manufactures_name], [Vehicle_Code], [Ex_ShowRoom_Price], [Color], [No_of_Vehicles_Available], [Seating_Capacity], [Stocks_Lasts_Still]) VALUES (N'NISSAN', N'NS001', 500000, N'BLACK', 4, 4, CAST(N'2020-12-06' AS Date))
INSERT [dbo].[Vehicle_details] ([Manufactures_name], [Vehicle_Code], [Ex_ShowRoom_Price], [Color], [No_of_Vehicles_Available], [Seating_Capacity], [Stocks_Lasts_Still]) VALUES (N'TRIUMPH', N'T001', 250000, N'ASH', 4, 4, CAST(N'2020-08-08' AS Date))
INSERT [dbo].[Vehicle_details] ([Manufactures_name], [Vehicle_Code], [Ex_ShowRoom_Price], [Color], [No_of_Vehicles_Available], [Seating_Capacity], [Stocks_Lasts_Still]) VALUES (N'VOLKSWAGEN', N'V001', 2000000, N'RED', 5, 2, CAST(N'2020-06-04' AS Date))
ALTER TABLE [dbo].[Branch_Admin] ADD  CONSTRAINT [DF_Branch_Admin_Status]  DEFAULT (N'Pending') FOR [Status]
GO
ALTER TABLE [dbo].[Branch_Admin] ADD  CONSTRAINT [DF_Branch_Admin_Role_Type]  DEFAULT (N'bd') FOR [Role_Type]
GO
ALTER TABLE [dbo].[Branch_Vehicle_Request] ADD  CONSTRAINT [DF_Branch_Vehicle_Request_Status]  DEFAULT (N'Pending') FOR [Status]
GO
ALTER TABLE [dbo].[Branch_Vehicle_Request] ADD  CONSTRAINT [DF_Branch_Vehicle_Request_No_Of_Vehicles_Requested]  DEFAULT ((0)) FOR [No_Of_Vehicles_Requested]
GO
ALTER TABLE [dbo].[Branch_Vehicle_Request] ADD  CONSTRAINT [DF_Branch_Vehicle_Request_No_Of_Vehicles_Approved]  DEFAULT ((0)) FOR [No_Of_Vehicles_Approved]
GO
ALTER TABLE [dbo].[Customer_Profile] ADD  CONSTRAINT [DF_Customer_Profile_Status]  DEFAULT (N'Pending') FOR [Status]
GO
ALTER TABLE [dbo].[Customer_Profile] ADD  CONSTRAINT [DF_Customer_Profile_Role_Type]  DEFAULT (N'Customer') FOR [Role_Type]
GO
ALTER TABLE [dbo].[Customer_Vehicle_Booking1] ADD  CONSTRAINT [DF_Customer_Vehicle_Booking1_Status]  DEFAULT (N'Pending') FOR [Status]
GO
ALTER TABLE [dbo].[Branch_Vehicle_Request]  WITH CHECK ADD  CONSTRAINT [FK_Branch_Vehicle_Request_Branch_id] FOREIGN KEY([Branch_id])
REFERENCES [dbo].[Branch_Admin] ([Branch_id])
GO
ALTER TABLE [dbo].[Branch_Vehicle_Request] CHECK CONSTRAINT [FK_Branch_Vehicle_Request_Branch_id]
GO
ALTER TABLE [dbo].[Branch_Vehicle_Request]  WITH CHECK ADD  CONSTRAINT [FK_Branch_Vehicle_Request_Vehicle_id] FOREIGN KEY([Vehicle_id])
REFERENCES [dbo].[Vehicle_details] ([Vehicle_Code])
GO
ALTER TABLE [dbo].[Branch_Vehicle_Request] CHECK CONSTRAINT [FK_Branch_Vehicle_Request_Vehicle_id]
GO
ALTER TABLE [dbo].[Customer_Vehicle_Booking1]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Vehicle_Booking_Vehicle_id] FOREIGN KEY([Vehicle_id])
REFERENCES [dbo].[Vehicle_details] ([Vehicle_Code])
GO
ALTER TABLE [dbo].[Customer_Vehicle_Booking1] CHECK CONSTRAINT [FK_Customer_Vehicle_Booking_Vehicle_id]
GO
ALTER TABLE [dbo].[Customer_Vehicle_Booking1]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Vehicle_Booking1_Customer_id] FOREIGN KEY([Customer_id])
REFERENCES [dbo].[Customer_Profile] ([Customer_id])
GO
ALTER TABLE [dbo].[Customer_Vehicle_Booking1] CHECK CONSTRAINT [FK_Customer_Vehicle_Booking1_Customer_id]
GO
ALTER TABLE [dbo].[Vehicle_Availability]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_Availability_Branch] FOREIGN KEY([Branch_id])
REFERENCES [dbo].[Branch_Admin] ([Branch_id])
GO
ALTER TABLE [dbo].[Vehicle_Availability] CHECK CONSTRAINT [FK_Vehicle_Availability_Branch]
GO
ALTER TABLE [dbo].[Vehicle_Availability]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_Availability_Vehicle_details] FOREIGN KEY([Vehicle_id])
REFERENCES [dbo].[Vehicle_details] ([Vehicle_Code])
GO
ALTER TABLE [dbo].[Vehicle_Availability] CHECK CONSTRAINT [FK_Vehicle_Availability_Vehicle_details]
GO
/****** Object:  StoredProcedure [dbo].[Vehicle_Search]    Script Date: 13/04/2020 5:48:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Vehicle_Search] 
@sql nvarchar(150)
as
declare
@s nvarchar(150)
begin
set @s='select * from VehicleSearch where '+@sql
execute (@s)
end
GO
USE [master]
GO
ALTER DATABASE [Team5Project] SET  READ_WRITE 
GO
