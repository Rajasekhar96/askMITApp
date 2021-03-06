USE [master]
GO
/****** Object:  Database [mit]    Script Date: 8/25/2019 2:19:26 PM ******/
CREATE DATABASE [mit]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'mit', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\mit.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'mit_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\mit_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [mit] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [mit].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [mit] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [mit] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [mit] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [mit] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [mit] SET ARITHABORT OFF 
GO
ALTER DATABASE [mit] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [mit] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [mit] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [mit] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [mit] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [mit] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [mit] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [mit] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [mit] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [mit] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [mit] SET  DISABLE_BROKER 
GO
ALTER DATABASE [mit] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [mit] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [mit] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [mit] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [mit] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [mit] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [mit] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [mit] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [mit] SET  MULTI_USER 
GO
ALTER DATABASE [mit] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [mit] SET DB_CHAINING OFF 
GO
ALTER DATABASE [mit] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [mit] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [mit]
GO
/****** Object:  StoredProcedure [dbo].[sp_b_studRegister]    Script Date: 8/25/2019 2:19:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_b_studRegister] 
@studentID int = null, 
@studentRegNo varchar(50) = null, 
@studentName varchar(50) = null, 
@dateOfBirth date = null, 
@fatherName varchar(50) = null, 
@motherName varchar(50) = null, 
@mathsMarks int = null, 
@physicsMarks int = null, 
@chemistryMarks int = null, 
@child int = null, 
@gender varchar(10) = null,

@qtype varchar(50) = null,
@MSG varchar(100) = null OUTPUT
as
	
	if @qtype = 'insStudReg'
	begin
		INSERT INTO  studentRegistration ( studentRegNo, studentName, dateOfBirth, fatherName, motherName, mathsMarks, physicsMarks, chemistryMarks, child, gender, registeredYear)
								  VALUES ( @studentRegNo, @studentName, @dateOfBirth, @fatherName, @motherName, @mathsMarks, @physicsMarks, @chemistryMarks, @child, @gender, YEAR(getdate()))
		set @MSG = 'Student Registration Create'
	end

	Else If @qtype='selectList' 
		Begin
			-- select * from studentRegistration order by studentID desc
			select row_number() over( order by studentID desc) as  slNo,* from studentRegistration
			set @MSG = 'Select Success'
		End

	Else if @qtype = 'rankings'
	Begin
		-- select * from studentRegistration order by (mathsMarks + physicsMarks + chemistryMarks ) desc
		select row_number() over( order by (mathsMarks + physicsMarks + chemistryMarks ) desc) as  slNo,
		* from studentRegistration
		set @MSG = 'Select Success'
	end



GO
/****** Object:  StoredProcedure [dbo].[usp_h_mit]    Script Date: 8/25/2019 2:19:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_h_mit]
	(
	@userID int = null,
	@userName varchar(50) = null,
	@userRole varchar(20) = null,
	@userMobileNo varchar(20) = null,
	@userIsActive bit = null,
	@userEmail varchar(50) = null,
	@userPassword varchar(50) = null,
	@qtype varchar(50),
	@MSG varchar(100) = null OUTPUT
	)
	
AS
	/* SET NOCOUNT ON */
	begin
		if @qtype = 'selectAll'			 --==>Handlers / mit.ashx
		begin
			 select * from userMaster
			 set @MSG = 'Select Success'
		end

		else if @qtype = 'selectLogin'   --==>Handlers / mit.ashx
		begin
			 select * from userMaster where userEmail = @userEmail and userPassword = @userPassword
			  set @MSG = 'Select Success'
		end

		else if @qtype = 'selectByID'   --==>Handlers / mit.ashx
		begin
			 select * from userMaster where userID = @userID
			  set @MSG = 'Select Success'
		end

		else if @qtype = 'insRegister'
		begin 
			insert into userMaster (userName,userEmail,userPassword,userRole,userMobileNo,userIsActive)
			values (@userName,@userEmail,@userPassword,@userRole,@userMobileNo,@userIsActive)
		end

	end
GO
/****** Object:  Table [dbo].[studentRegistration]    Script Date: 8/25/2019 2:19:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[studentRegistration](
	[studentID] [int] IDENTITY(1,1) NOT NULL,
	[studentRegNo] [varchar](50) NULL,
	[studentName] [varchar](50) NULL,
	[dateOfBirth] [date] NULL,
	[fatherName] [varchar](50) NULL,
	[motherName] [varchar](50) NULL,
	[mathsMarks] [int] NULL,
	[physicsMarks] [int] NULL,
	[chemistryMarks] [int] NULL,
	[child] [int] NULL,
	[gender] [varchar](10) NULL,
	[registeredYear] [varchar](4) NULL,
 CONSTRAINT [PK_studentRegistration] PRIMARY KEY CLUSTERED 
(
	[studentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[userMaster]    Script Date: 8/25/2019 2:19:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[userMaster](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[userName] [varchar](50) NULL,
	[userEmail] [varchar](50) NULL,
	[userPassword] [varchar](20) NULL,
	[userMobileNo] [varchar](20) NULL,
	[userImageName] [varchar](50) NULL,
	[userRole] [varchar](10) NULL,
	[userIsActive] [bit] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[studentRegistration] ON 

INSERT [dbo].[studentRegistration] ([studentID], [studentRegNo], [studentName], [dateOfBirth], [fatherName], [motherName], [mathsMarks], [physicsMarks], [chemistryMarks], [child], [gender], [registeredYear]) VALUES (1, N'6089', N'suresh', CAST(0x4F1F0B00 AS Date), N'sreenivasalue', N'sudha rani', 150, 160, 170, 1, N'Male', N'2019')
INSERT [dbo].[studentRegistration] ([studentID], [studentRegNo], [studentName], [dateOfBirth], [fatherName], [motherName], [mathsMarks], [physicsMarks], [chemistryMarks], [child], [gender], [registeredYear]) VALUES (2, N'1303', N'raj', CAST(0x0F400B00 AS Date), N'raja', N'rani', 140, 160, 170, 1, N'Male', N'2019')
INSERT [dbo].[studentRegistration] ([studentID], [studentRegNo], [studentName], [dateOfBirth], [fatherName], [motherName], [mathsMarks], [physicsMarks], [chemistryMarks], [child], [gender], [registeredYear]) VALUES (3, N'001', N'fail', CAST(0x0F400B00 AS Date), N's', N's', 100, 110, 120, 3, N'Female', N'2019')
SET IDENTITY_INSERT [dbo].[studentRegistration] OFF
SET IDENTITY_INSERT [dbo].[userMaster] ON 

INSERT [dbo].[userMaster] ([userID], [userName], [userEmail], [userPassword], [userMobileNo], [userImageName], [userRole], [userIsActive]) VALUES (1, N'admin', N'admin@gmail.com', N'admin123', N'123456789', N'noimage.png', N'admin', 1)
INSERT [dbo].[userMaster] ([userID], [userName], [userEmail], [userPassword], [userMobileNo], [userImageName], [userRole], [userIsActive]) VALUES (2, N'user', N'user@gmail.com', N'user123', N'987456123', N'imge.png', N'user', 1)
INSERT [dbo].[userMaster] ([userID], [userName], [userEmail], [userPassword], [userMobileNo], [userImageName], [userRole], [userIsActive]) VALUES (3, N'rajasekhar', N'raja@gmail.com', N'Raja123', N'9874626622', NULL, N'user', 1)
INSERT [dbo].[userMaster] ([userID], [userName], [userEmail], [userPassword], [userMobileNo], [userImageName], [userRole], [userIsActive]) VALUES (4, N'rajase', N'raja@gmail.com', N'Raja123', N'9874561232', NULL, N'user', 1)
SET IDENTITY_INSERT [dbo].[userMaster] OFF
USE [master]
GO
ALTER DATABASE [mit] SET  READ_WRITE 
GO
