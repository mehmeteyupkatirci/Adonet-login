USE [master]
GO
/****** Object:  Database [CRMDBB]    Script Date: 16.04.2020 20:10:07 ******/
CREATE DATABASE [CRMDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CRMDBB', FILENAME = N'F:\SQL SERVER\MSSQL14.SQLEXPRESS\MSSQL\DATA\CRMDBB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CRMDBB_log', FILENAME = N'F:\SQL SERVER\MSSQL14.SQLEXPRESS\MSSQL\DATA\CRMDBB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [CRMDBB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CRMDBB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CRMDBB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CRMDBB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CRMDBB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CRMDBB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CRMDBB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CRMDBB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [CRMDBB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CRMDBB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CRMDBB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CRMDBB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CRMDBB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CRMDBB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CRMDBB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CRMDBB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CRMDBB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CRMDBB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CRMDBB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CRMDBB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CRMDBB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CRMDBB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CRMDBB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CRMDBB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CRMDBB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CRMDBB] SET  MULTI_USER 
GO
ALTER DATABASE [CRMDBB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CRMDBB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CRMDBB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CRMDBB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CRMDBB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CRMDBB] SET QUERY_STORE = OFF
GO
USE [CRMDBB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [CRMDBB]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 16.04.2020 20:10:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](50) NULL,
	[Price] [int] NULL,
	[Stock] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 16.04.2020 20:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[UserName] [varchar](50) NULL,
	[Password] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [ProductName], [Price], [Stock]) VALUES (2, N'sasd', 27452, 1)
SET IDENTITY_INSERT [dbo].[Products] OFF
/****** Object:  StoredProcedure [dbo].[SP_GetCategory]    Script Date: 16.04.2020 20:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PRoc [dbo].[SP_GetCategory]
	@Id Int
As
	Select * FRom Categories Where CategoryID =@Id
GO
/****** Object:  StoredProcedure [dbo].[SP_product_create]    Script Date: 16.04.2020 20:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_product_create]
	-- Add the parameters for the stored procedure here
	@ProductName varchar(50),
	@Price int,
	@Stock int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	begin try
		insert into Products (ProductName,Price,Stock) values(@ProductName,@Price,@Stock)
	end try
	begin catch
		print 'Bir hata oluştu'
	end catch
END
GO
/****** Object:  StoredProcedure [dbo].[SP_product_delete]    Script Date: 16.04.2020 20:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_product_delete]
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Delete from Products where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[SP_product_select]    Script Date: 16.04.2020 20:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_product_select]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Products 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_product_update]    Script Date: 16.04.2020 20:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_product_update]
	-- Add the parameters for the stored procedure here
	@Id int,
	@ProductName varchar(50),
	@Price int,
	@Stock int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	begin try
		Update Products Set ProductName=@ProductName, Price=@Price,Stock=@Stock where Id=@Id
	end try
	begin catch
		Print 'Bir Hata Oluştu!'
	end catch

END
GO
USE [master]
GO
ALTER DATABASE [CRMDBB] SET  READ_WRITE 
GO
