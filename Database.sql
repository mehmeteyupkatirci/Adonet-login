USE [CRMDB]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 20.04.2020 23:22:26 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 20.04.2020 23:22:26 ******/
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

INSERT [dbo].[Products] ([Id], [ProductName], [Price], [Stock]) VALUES (4, N'uyhyh', 129, 222)
INSERT [dbo].[Products] ([Id], [ProductName], [Price], [Stock]) VALUES (5, N'Deneme3', 1133, 12)
INSERT [dbo].[Products] ([Id], [ProductName], [Price], [Stock]) VALUES (6, N'Dene222', 1133, 12)
INSERT [dbo].[Products] ([Id], [ProductName], [Price], [Stock]) VALUES (7, N'doga', 12, 111)
INSERT [dbo].[Products] ([Id], [ProductName], [Price], [Stock]) VALUES (8, N'dfgsdfga', 222, 11)
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [UserName], [Password]) VALUES (1, N'root', N'123', N'root', N'123')
SET IDENTITY_INSERT [dbo].[Users] OFF
/****** Object:  StoredProcedure [dbo].[SP_GetCategory]    Script Date: 20.04.2020 23:22:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PRoc [dbo].[SP_GetCategory]
	@Id Int
As
	Select * FRom Categories Where CategoryID =@Id
GO
/****** Object:  StoredProcedure [dbo].[SP_Login]    Script Date: 20.04.2020 23:22:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Login](@username VARCHAR(50), @password VARCHAR(50))  
AS  
BEGIN  
   IF ((SELECT COUNT(*)  
   FROM Users  
   WHERE UserName=@username AND Password<>@password) = 1)  
	RETURN -1  
ELSE  
   IF ((SELECT COUNT(*)  
   FROM Users  
   WHERE UserName=@username AND Password=@password) = 1)  
	RETURN 1
   ELSE
	RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[SP_product_create]    Script Date: 20.04.2020 23:22:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
/****** Object:  StoredProcedure [dbo].[SP_product_delete]    Script Date: 20.04.2020 23:22:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
/****** Object:  StoredProcedure [dbo].[SP_product_select]    Script Date: 20.04.2020 23:22:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
/****** Object:  StoredProcedure [dbo].[SP_product_update]    Script Date: 20.04.2020 23:22:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
