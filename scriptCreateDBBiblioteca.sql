USE [master]
GO
/****** Object:  Database [Biblioteca]    Script Date: 29 mai 2024 20:22:48 ******/
CREATE DATABASE [Biblioteca]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Biblioteca', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL_EXPRESS\MSSQL\DATA\Biblioteca.mdf' , SIZE = 227328KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Biblioteca_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL_EXPRESS\MSSQL\DATA\Biblioteca_log.ldf' , SIZE = 388544KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Biblioteca] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Biblioteca].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Biblioteca] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Biblioteca] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Biblioteca] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Biblioteca] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Biblioteca] SET ARITHABORT OFF 
GO
ALTER DATABASE [Biblioteca] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Biblioteca] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Biblioteca] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Biblioteca] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Biblioteca] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Biblioteca] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Biblioteca] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Biblioteca] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Biblioteca] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Biblioteca] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Biblioteca] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Biblioteca] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Biblioteca] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Biblioteca] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Biblioteca] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Biblioteca] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Biblioteca] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Biblioteca] SET RECOVERY FULL 
GO
ALTER DATABASE [Biblioteca] SET  MULTI_USER 
GO
ALTER DATABASE [Biblioteca] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Biblioteca] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Biblioteca] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Biblioteca] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Biblioteca] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Biblioteca]
GO
/****** Object:  UserDefinedFunction [dbo].[CamelCase]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CamelCase]
(@Str varchar(8000))
RETURNS varchar(8000) AS
BEGIN
  DECLARE @Result varchar(2000)
  SET @Str = LOWER(@Str) + ' '
  SET @Result = ''
  WHILE 1=1
  BEGIN
    IF PATINDEX('% %',@Str) = 0 BREAK
    SET @Result = @Result + UPPER(Left(@Str,1))+
    SubString  (@Str,2,CharIndex(' ',@Str)-1)
    SET @Str = SubString(@Str,
      CharIndex(' ',@Str)+1,Len(@Str))
  END
  SET @Result = Left(@Result,Len(@Result))
  RETURN @Result
END  

GO
/****** Object:  Table [dbo].[Borrow]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Borrow](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[iduser] [int] NOT NULL,
	[idlivre] [int] NOT NULL,
	[returndate] [datetime] NOT NULL,
	[realreturndate] [datetime] NULL,
	[creationdate] [datetime] NOT NULL,
 CONSTRAINT [PK_Borrow_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Casari]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Casari](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idLivre] [int] NOT NULL,
	[codeRegisteredBook] [nvarchar](50) NOT NULL,
	[initialCode] [nvarchar](50) NOT NULL,
	[creationdate] [datetime] NULL,
	[author] [nvarchar](50) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[description] [nvarchar](max) NULL,
	[category] [nvarchar](50) NULL,
	[extrainfo] [nvarchar](50) NULL,
	[price] [decimal](18, 2) NULL,
	[denominativeprice] [decimal](18, 4) NULL,
	[datacasare] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Livre]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Livre](
	[idlivre] [int] IDENTITY(1,1) NOT NULL,
	[codeISBN] [nvarchar](50) NULL,
	[initialcode] [int] NULL,
	[title] [nvarchar](50) NOT NULL,
	[author] [nvarchar](50) NOT NULL,
	[description] [nvarchar](200) NULL,
	[category] [nvarchar](50) NULL,
	[photo] [varbinary](max) NULL,
	[creationdate] [datetime] NOT NULL,
	[extrainfo] [nvarchar](100) NULL,
	[price] [decimal](18, 0) NULL,
	[pages] [int] NULL,
	[availability] [bit] NOT NULL,
	[cartecasata] [bit] NULL,
 CONSTRAINT [PK_Livre] PRIMARY KEY CLUSTERED 
(
	[idlivre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[iduser] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[surname] [nvarchar](100) NOT NULL,
	[clasa] [nvarchar](100) NOT NULL,
	[pswd] [nvarchar](64) NOT NULL,
	[rol] [nvarchar](50) NOT NULL,
	[creationdate] [datetime] NOT NULL CONSTRAINT [DF_User_creationdate]  DEFAULT (getdate()),
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[iduser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Borrow] ADD  CONSTRAINT [DF_Borrow_creationdate]  DEFAULT (getdate()) FOR [creationdate]
GO
ALTER TABLE [dbo].[Livre] ADD  CONSTRAINT [DF_Livre_creationdate]  DEFAULT (getdate()) FOR [creationdate]
GO
ALTER TABLE [dbo].[Livre] ADD  CONSTRAINT [DF_Livre_availability]  DEFAULT ((0)) FOR [availability]
GO
ALTER TABLE [dbo].[Borrow]  WITH CHECK ADD  CONSTRAINT [FK_Borrow_Livre] FOREIGN KEY([idlivre])
REFERENCES [dbo].[Livre] ([idlivre])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Borrow] CHECK CONSTRAINT [FK_Borrow_Livre]
GO
ALTER TABLE [dbo].[Borrow]  WITH CHECK ADD  CONSTRAINT [FK_Borrow_User] FOREIGN KEY([iduser])
REFERENCES [dbo].[User] ([iduser])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Borrow] CHECK CONSTRAINT [FK_Borrow_User]
GO
/****** Object:  StoredProcedure [dbo].[backupDatabase]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE    [dbo].[backupDatabase]
(
@path nvarchar(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;

   BACKUP DATABASE Biblioteca
   TO DISK = @path
   
   DECLARE @newpath NVARCHAR(MAX) 
   SET @newpath = N'D:\PROIECT BIBLIO\BackupBiblioteca\BackupBiblio_' + CONVERT(NVARCHAR(50),GETDATE(),112)+ '.bak'
   
   BACKUP DATABASE Biblioteca
   TO DISK = @newpath
   END
   

GO
/****** Object:  StoredProcedure [dbo].[casarecarti]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Doru Surducan
-- Create date: 15 Noiembrie 2023
-- Description:	selectare carti pentru casare, introducerea acestora in tabelul Casari si stergerea lor 
-- din tabelul Livre
-- =============================================
CREATE PROCEDURE [dbo].[casarecarti]
	-- Add the parameters for the stored procedure here
(
	@idlivre int,
	@codeISBN nvarchar(50),
	@initialCode nvarchar(50),
	@creationdate datetime,
	@title nvarchar(50),
	@author nvarchar(100),
	@description nvarchar(100),
	@category nvarchar(50),
	@extrainfo nvarchar(200),
	@price decimal(18,2),
	@denominativeprice decimal(18,4),
	@datacasare datetime
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [Casari] 
				(idLivre,
				codeRegisteredBook,
				initialCode,
				creationdate,
				author,
				title,
				[description],
				category,
				extrainfo,
				price,
				denominativeprice,
				datacasare)
	VALUES (@idlivre,
			@codeISBN,
			@initialCode,
			@creationdate,
			@title,
			@author,
			@description,
			@category,
			@extrainfo,
			@price,
			@denominativeprice,
			@datacasare)
	SELECT l.idLivre,l.codeISBN,l.initialcode,l.title,l.author,l.[description],l.category,l.creationdate,l.extrainfo,l.price,l.cartecasata
	FROM [dbo].Livre as l
	WHERE L.idlivre = @idlivre

	DELETE FROM [dbo].Livre 
	WHERE idlivre = @idlivre
END

GO
/****** Object:  StoredProcedure [dbo].[cat_getbooks]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE    [dbo].[cat_getbooks]
(
	@category nvarchar(50)
)
AS
BEGIN
	SELECT        initialcode, title, author, category, photo
	FROM            Livre
	WHERE        category = @category
	ORDER BY title
END

GO
/****** Object:  StoredProcedure [dbo].[deletebook]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE    [dbo].[deletebook] 
(@idlivre int)
AS
BEGIN
	SET NOCOUNT ON;

	DELETE
	FROM 
		Livre
	WHERE
		idlivre = @idlivre
END



GO
/****** Object:  StoredProcedure [dbo].[deleteuser]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE    [dbo].[deleteuser]
(@iduser int
)
AS
BEGIN
	SET NOCOUNT ON;

   
	DELETE FROM [User] WHERE iduser = @iduser
END



GO
/****** Object:  StoredProcedure [dbo].[enregistreruser]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery4.sql|7|0|C:\Users\dorus\AppData\Local\Temp\~vs8CCB.sql
CREATE PROCEDURE     [dbo].[enregistreruser]
(
	@username nvarchar(50),
	@name nvarchar(50),
	@surname nvarchar(50),
	@clasa nvarchar(50),
	@pwsd nvarchar(64),
	@rol nvarchar(50)
)
AS
	INSERT INTO 
		[User] 
		(
			username,
			name, 
			surname,
			clasa,
			pswd,
			rol
		) 
		VALUES 
		(
			@username,
			@name,
			@surname,
			@clasa,
			@pwsd,
			@rol
		)


GO
/****** Object:  StoredProcedure [dbo].[getallbooks]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE    [dbo].[getallbooks]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
			idlivre,
			codeISBN,
			initialcode,
			title,
			author, 
			[description],
			dbo.CamelCase(category) as category,
			[availability],
			photo
	FROM 
			Livre
	WHERE 
			price = 0
END



GO
/****** Object:  StoredProcedure [dbo].[getallnewbooks]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE    [dbo].[getallnewbooks]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		idlivre,
		codeISBN,
		title,
		author,
		[description],
		category,
		price,
		pages,
		[availability],
		photo
	FROM
		 Livre
	WHERE
		 price != 0
END



GO
/****** Object:  StoredProcedure [dbo].[getallusers]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE    [dbo].[getallusers] 

AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT 
		iduser,
		username,
		name,
		surname,
		clasa,
		pswd, 
		rol, 
		Cast(cast(creationdate as date) as nvarchar(10)) as creationdate
	FROM 
		[User]
	ORDER BY rol,surname, name,clasa
   
END



GO
/****** Object:  StoredProcedure [dbo].[getbooks]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE    [dbo].[getbooks]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
	  idlivre,
	  codeISBN,
      initialcode,
      title,
      author,
      [description],
      dbo.CamelCase(category) as category,
      photo,
      creationdate,
      extrainfo,
      price,
      pages,
      [availability]
	 FROM Livre
	 ORDER BY category, title
END



GO
/****** Object:  StoredProcedure [dbo].[getbooksborrowedfullhistory]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE    [dbo].[getbooksborrowedfullhistory]
(
	@iduser int = 0 --ALL
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT	u.iduser,
			u.name,
			u.surname,
			u.clasa,
			l.idlivre,
			l.codeISBN,
			l.title,
			l.author,
			l.[description],
			dbo.CamelCase(l.category) as category,
			l.photo,
			l.[availability],
			b.creationdate,
			b.realreturndate,
			CONVERT(char(10), b.returndate, 126) as returndate,
			(CASE WHEN ((l.[availability] = 0) AND (b.realreturndate IS NULL)) THEN 
				Cast(DATEDIFF(day,GETDATE(),b.returndate) as nvarchar(10)) ELSE 
				Cast(DATEDIFF(day,b.creationdate,b.realreturndate) + 1 as nvarchar(10)) END) AS daysleft
	FROM 
		Borrow AS b
		INNER JOIN Livre AS l
		ON l.idlivre = b.idlivre
		INNER JOIN [User] AS u
		ON u.iduser = b.iduser
	WHERE 
		b.iduser = (CASE WHEN @iduser = 0 THEN b.iduser ELSE @iduser END) 
		AND l.[availability] = 0
		
END



GO
/****** Object:  StoredProcedure [dbo].[getbooksborrowedhistory]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[getbooksborrowedhistory]
(@iduser int = 0,
 @searchUser nvarchar(100) = '',
 @searchBook nvarchar(100) = '')

AS
BEGIN
	SET NOCOUNT ON;

	SELECT	u.username,
			u.clasa,
			l.idlivre,
			l.codeISBN,
			l.initialcode,
			l.title,
			l.author,
			l.[description],
			dbo.CamelCase(l.category) as category,
			l.photo,
			l.[availability],
			CONVERT(VARCHAR(10), b.creationdate, 126) as creationdate,
			CONVERT(VARCHAR(10), b.returndate, 126) as returndate,
			CONVERT(VARCHAR(10), b.realreturndate, 126) as realreturndate,
			(CASE WHEN ((l.[availability] = 0) AND (b.realreturndate IS NULL)) THEN 
				Cast(DATEDIFF(day,GETDATE(), b.returndate) as nvarchar(10)) ELSE 
				Cast(DATEDIFF(day, b.creationdate, b.realreturndate) + 1 as nvarchar(10)) END) AS daysleft
	FROM Borrow b
		 INNER JOIN Livre l ON l.idlivre = b.idlivre 
		 INNER JOIN [User] u ON u.iduser = b.iduser
	WHERE
		b.iduser = (CASE WHEN @iduser = 0 THEN b.iduser ELSE @iduser END) AND
		(
			u.name    LIKE '%' + (CASE WHEN @searchUser = '' THEN u.name	ELSE @searchUser END) + '%' OR
			u.surname LIKE '%' + (CASE WHEN @searchUser = '' THEN u.surname ELSE @searchUser END) + '%' OR
			(u.name + ' ' + u.surname) LIKE '%' + (CASE WHEN @searchUser = '' THEN (u.name + ' ' + u.surname) ELSE @searchUser END) + '%' OR
			u.username LIKE '%' + (CASE WHEN @searchUser = '' THEN u.username ELSE @searchUser END) + '%' OR
			u.clasa LIKE '%' + (CASE WHEN @searchUser = '' THEN u.clasa ELSE @searchUser END) + '%'
		) 
		AND
		(
			 l.title   LIKE '%' + (CASE WHEN @searchBook = '' THEN l.title   ELSE @searchBook END) + '%' OR
			 l.codeISBN LIKE '%' + (CASE WHEN @searchBook = '' THEN l.title   ELSE @searchBook END) + '%'
		) 

	ORDER BY b.creationdate DESC
	
END



GO
/****** Object:  StoredProcedure [dbo].[getborrowedbook]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[getborrowedbook]
(
	@iduser int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT	
			l.idlivre,
			l.codeISBN,
			l.initialcode,
			l.title,
			l.author,
			l.[description],
			dbo.CamelCase(l.category) as category,
			l.photo,
			l.[availability],
			b.creationdate,
			CONVERT(char(10), b.returndate, 126) as returndate,
			DATEDIFF(day,GETDATE(),b.returndate) AS 'daysleft'
	FROM Borrow b
		INNER JOIN Livre l ON l.idlivre = b.idlivre 
	WHERE
		b.iduser = @iduser AND (realreturndate is NULL)
	ORDER BY l.title

			 
END



GO
/****** Object:  StoredProcedure [dbo].[getborrowedbooks]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[getborrowedbooks]
(@idlivres nvarchar(20)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SQL nvarchar(600)

	IF @idlivres = ''
		SET @SQL = 
		'SELECT idlivre, codeISBN, initialcode, title, author, description, dbo.CamelCase(category) as category, photo, availability 
		 FROM dbo.Livre
		 WHERE 1=2'
	ELSE
		SET @SQL = 
		'SELECT idlivre, codeISBN, initialcode, title, author, description, dbo.CamelCase(category) as category, photo, availability 
		 FROM dbo.Livre
		 WHERE idlivre IN ('+ @idlivres +')'

	 EXEC(@SQL)
END



GO
/****** Object:  StoredProcedure [dbo].[getinforeturn]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
CREATE PROCEDURE     [dbo].[getinforeturn]
	@ISBN NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @idUser INT
	SELECT 
		@idUser = u.iduser 
	FROM 
		[User] u INNER JOIN Borrow b ON u.iduser = b.iduser
				 INNER JOIN Livre l ON l.idlivre = b.idlivre
	WHERE 
		l.codeISBN = @ISBN AND b.realreturndate IS NULL
	GROUP BY 
		u.iduser

	PRINT @idUser

	SELECT 
		u.username as Numeutilizator, 
		u.name as Prenume, 
		u.surname as Nume, 
		u.clasa as Clasa,
		l.idlivre,
		l.codeISBN,
		l.initialcode, 
		l.title, 
		l.author, 
		dbo.CamelCase(l.category) as category, 
		l.photo,
		l.[availability],
		b.creationdate,
		CONVERT(char(10), b.returndate, 126) as returndate,
		DATEDIFF(day,GETDATE(),b.returndate) AS 'daysleft'
	FROM 
		[User] u INNER JOIN Borrow b ON u.iduser = b.iduser
				 INNER JOIN Livre l ON l.idlivre = b.idlivre
	WHERE 
		b.iduser = @idUser AND b.realreturndate IS NULL
	GROUP BY 
		u.username, u.name, u.surname,u.clasa, l.idlivre,l.codeISBN,l.initialcode, l.title, l.author, l.category, l.photo, l.[availability], b.creationdate, b.returndate

	SELECT @idUser as IdUser
END

GO
/****** Object:  StoredProcedure [dbo].[getoverreturndays]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getoverreturndays] 
	-- Add the parameters for the stored procedure here
	(
	@iduser int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF( SELECT COUNT(*) FROM Borrow WHERE iduser = @iduser AND (realreturndate IS NULL) AND (DATEDIFF(day,GETDATE(),returndate) < 0)) > 0
		SELECT (MIN(DATEDIFF(day,GETDATE(),returndate)))  AS 'întârziere'
		FROM Borrow b 
		WHERE iduser = @iduser AND (realreturndate IS NULL) AND (DATEDIFF(day,GETDATE(),returndate) < 0)
		GROUP BY iduser
		
	ELSE
		SELECT 0
END

GO
/****** Object:  StoredProcedure [dbo].[getpenalty]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE     [dbo].[getpenalty]
(
	@iduser int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   IF( SELECT COUNT(*) FROM Borrow WHERE iduser = @iduser AND (realreturndate IS NULL) AND (DATEDIFF(day,GETDATE(),returndate) < 0)) > 0
		SELECT (MIN(DATEDIFF(day,GETDATE(),returndate)) / 7) * (-1)  AS 'cad'
		FROM Borrow b 
		WHERE iduser = @iduser AND (realreturndate IS NULL) AND (DATEDIFF(day,GETDATE(),returndate) < 0)
		GROUP BY iduser

	ELSE
		SELECT 0

END



GO
/****** Object:  StoredProcedure [dbo].[getPhoto]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[getPhoto]
(@idBook int)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
			photo
	FROM	
			Livre
	WHERE 
		 idlivre = @idBook
END



GO
/****** Object:  StoredProcedure [dbo].[getUsedCategories]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[getUsedCategories]
(@WithAll bit = 1)
AS
BEGIN
	SET NOCOUNT ON;

	IF @withAll = 1
	BEGIN
		SELECT DISTINCT dbo.CamelCase(category) as category, category as categoryValue, 2 as ord FROM Livre 
		UNION
		SELECT 'Toate' as category, '' as categoryValue, 1 as ord 
		ORDER BY ord, category
	END
	ELSE
	BEGIN
		SELECT DISTINCT dbo.CamelCase(category) as category, category as categoryValue, 2 as ord FROM Livre 
	END
END



GO
/****** Object:  StoredProcedure [dbo].[getuserid]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[getuserid]
(
@username nvarchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT iduser 
	FROM [User]
	WHERE username = @username
END



GO
/****** Object:  StoredProcedure [dbo].[insertBook]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[insertBook]
(
	@codeISBN nvarchar(50),
	@initialCod int,
	@title nvarchar(50),
	@author nvarchar(100),
	@description nvarchar(100),
	@category nvarchar(50),
	@photo image,
	@extrainfo nvarchar(200),
	@price decimal(18,0),
	@pages int,
	@availability bit
)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [Livre] 
					(codeISBN,
					initialcode,
					title,
					author, 
					[description],
					category,
					photo,
					 extrainfo,
					 price,
					 pages,
					 [availability])
	 VALUES 
					(@codeISBN,
					@initialCod,
					@title,
					@author,
					@description,
					@category,
					@photo,
					@extrainfo,
					@price,
					@pages,
					@availability)
END



GO
/****** Object:  StoredProcedure [dbo].[insertborrowedbook]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[insertborrowedbook]
(
	@iduser int,
	@idlivre nvarchar(50),
	@returndate datetime,
	@realreturndate datetime
)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO Borrow
				(iduser,
				idlivre,
				returndate,
				realreturndate)
			VALUES
				(@iduser,
				@idlivre,
				@returndate,
				@realreturndate)


	UPDATE Livre 
	SET [availability] = 0
	WHERE idlivre = @idlivre
END



GO
/****** Object:  StoredProcedure [dbo].[loginUser]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[loginUser] 
(
	@username nvarchar(50),
	@password nvarchar(64)
)
as
begin
	set nocount on
	DECLARE @nuser int
			
	SELECT @nuser=COUNT(*) from [User] WHERE @username = username AND @password = pswd

	IF @nuser > 0 
		SELECT rol FROM [User] WHERE @username = username AND @password = pswd
	ELSE 
		SELECT ''
	Return
END




GO
/****** Object:  StoredProcedure [dbo].[rep_booksforsale]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[rep_booksforsale]
	
	
AS
BEGIN
	SELECT 
		title,
		author,
		[description],
		category,
		price,
		photo
	FROM
		 Livre
	WHERE
		 price != 0 
END


GO
/****** Object:  StoredProcedure [dbo].[rep_carticasate]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Doru Surducan
-- Create date: 15 Noiembrie 2023
-- Description:	afisarea unui raport cu cartile casate
-- =============================================
CREATE PROCEDURE [dbo].[rep_carticasate]
	-- Add the parameters for the stored procedure here
	(@dataCasareFrom datetime, @dataCasareTo datetime)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT		idLivre,
				codeRegisteredBook,
				initialCode,
				creationdate,
				author,
				title,
				[description],
				category,
				extrainfo,
				price,
				denominativeprice,
				datacasare
	FROM [Casari]
	WHERE datacasare between @dataCasareFrom and @dataCasareTo
	ORDER BY datacasare
END

GO
/****** Object:  StoredProcedure [dbo].[rep_datacasare]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Doru Surducan
-- Create date: 15 Noiembrie 2023
-- Description:	afisarea data casare
-- =============================================
CREATE PROCEDURE [dbo].[rep_datacasare]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT datacasare 
	FROM Casari
	ORDER BY datacasare
END

GO
/****** Object:  StoredProcedure [dbo].[rep_getallborrowedbooksbyusername]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Doru Surducan
-- Description:	stored  get all borrowed books by username of user
-- =============================================
CREATE PROCEDURE     [dbo].[rep_getallborrowedbooksbyusername] 
	-- Add the parameters for the stored  here
(
	@username nvarchar(100)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for  here
	SELECT u.username, l.title, l.author,l.category, l.photo, b.returndate, b.realreturndate, b.creationdate
	FROM [User] AS u
	INNER JOIN Borrow AS b ON b.iduser = u.iduser
	INNER JOIN Livre AS l ON l.idlivre = b.idlivre
	WHERE u.username LIKE '%' + @username + '%'
END


GO
/****** Object:  StoredProcedure [dbo].[rep_getbooksperclasa]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--procedura pentru obtinrerea unui raport cu cititrea pe clasa

CREATE PROCEDURE [dbo].[rep_getbooksperclasa]
	-- Add the parameters for the stored procedure here
	@clasa nvarchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT COUNT(b.realreturndate) AS NumarImprumuturiUtilizator, u.iduser AS ID, u.username AS NumeUtilizator, u.name AS Prenume, u.surname AS Nume, u.clasa as Clasa
	FROM Borrow b 
	INNER JOIN [User] u
	on b.iduser = u.iduser
	Where @clasa = u.clasa
	Group By u.iduser, u.username,u.name,u.surname, u.clasa
	order by NumarImprumuturiUtilizator desc 
END

GO
/****** Object:  StoredProcedure [dbo].[rep_getCategories]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER PROCEDURE    date: <ALTER PROCEDURE    Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE     [dbo].[rep_getCategories]
AS
BEGIN
	SELECT  DISTINCT category FROm Livre ORDER by category
	END


GO
/****** Object:  StoredProcedure [dbo].[rep_getoverreturndays]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[rep_getoverreturndays]  
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		u.username,
		u.surname, 
		u.name,
		u.clasa,
		(MIN(DATEDIFF(day,GETDATE(),b.returndate))) AS Întârziere
	FROM 
		[User] u INNER JOIN 
		Borrow b ON u.iduser = b.iduser
	WHERE 
		(b.realreturndate IS NULL) AND 
		(DATEDIFF(day,GETDATE(),b.returndate) < 0)
	GROUP BY 
		u.name, u.surname, u.username, u.clasa
	ORDER BY 
		Întârziere DESC
END

GO
/****** Object:  StoredProcedure [dbo].[rep_mostactiveuser]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER PROCEDURE    date: <ALTER PROCEDURE    Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE     [dbo].[rep_mostactiveuser]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT COUNT(b.realreturndate) AS NumarImprumuturiUtilizator, u.iduser AS ID, u.username AS NumeUtilizator, u.clasa AS Clasa
	FROM Borrow b
	INNER JOIN [User] u 
	ON b.iduser = u.iduser
	WHERE (b.realreturndate IS NOT NULL) AND (DATEDIFF(d, b.creationdate, b.realreturndate) >=0)
	GROUP BY u.iduser, u.username, u.clasa
	ORDER BY NumarImprumuturiUtilizator DESC
END


GO
/****** Object:  StoredProcedure [dbo].[rep_mostusedbook]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER PROCEDURE    date: <ALTER PROCEDURE    Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE     [dbo].[rep_mostusedbook]
AS
BEGIN
	SELECT  COUNT(b.realreturndate) AS NumarImprumuturiCarte, l.idlivre as ID, l.title as TitluCarte
	FROM Borrow b
	 INNER JOIN Livre l ON b.idlivre = l.idlivre
	WHERE (b.realreturndate IS NOT NULL) AND (DateDiff(d,b.creationdate, b.realreturndate) >=0) 
	GROUP BY l.title, l.idlivre
	ORDER BY NumarImprumuturiCarte DESC
	END


GO
/****** Object:  StoredProcedure [dbo].[rep_userpenaltyreport]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER PROCEDURE    date: <ALTER PROCEDURE    Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE     [dbo].[rep_userpenaltyreport]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for  here
	SELECT 
		u.username,
		u.surname, 
		u.name,
		u.clasa
		(MIN(DATEDIFF(day,GETDATE(),b.returndate)) / 7) * (-1)  AS Penalizare
	FROM 
		[User] u INNER JOIN 
		Borrow b ON u.iduser = b.iduser
	WHERE 
		(b.realreturndate IS NULL) AND 
		(DATEDIFF(day,GETDATE(),b.returndate) < 0)
	GROUP BY 
		u.name, u.surname, u.username, u.clasa
	ORDER BY 
		Penalizare DESC
END



GO
/****** Object:  StoredProcedure [dbo].[searchallnewbooks]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[searchallnewbooks]
(@searchnewbook nvarchar(100))
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		idlivre, 
		title,
		author, 
		[description],
		category, 
		photo,
		creationdate,
		price,
		pages, 
		[availability] 
	FROM 
		Livre 
	WHERE 
		 title			LIKE '%'+@searchnewbook+'%' 
		OR author		LIKE '%'+@searchnewbook+'%'
		OR creationdate LIKE '%'+@searchnewbook+'%'
		OR category     LIKE '%'+@searchnewbook+'%'
END


GO
/****** Object:  StoredProcedure [dbo].[searchlivre]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE     [dbo].[searchlivre]
(
	@searchString nvarchar(100),
	@availability int = 2,
	@category nvarchar(50) = ''
)
AS
BEGIN
	SET NOCOUNT ON;

	IF (@availability = 0 OR @availability = 1)		
	BEGIN
		SELECT 
			idlivre, 
			codeISBN, 
			initialcode, 
			title, 
			author, 
			[description], 
			dbo.CamelCase(category) as category, 
			creationdate, 
			extrainfo,
			price,
			pages, 
			[availability],
			photo
		FROM 
			Livre 
		WHERE 
			  (title		LIKE '%'+@searchString+'%' 
			OR author		LIKE '%'+@searchString+'%' 
			OR codeISBN		LIKE '%'+@searchString+'%' 
			OR initialcode	LIKE '%'+@searchString+'%'
			OR CAST(idlivre as nvarchar(50)) LIKE '%'+@searchString+'%')
			AND [availability] = @availability  
			AND category LIKE (CASE WHEN @category = '' THEN category ELSE '%' + @category + '%' END)
	END
	ELSE
	BEGIN
		SELECT 
			idlivre, 
			codeISBN, 
			initialcode, 
			title, 
			author, 
			[description], 
			dbo.CamelCase(category) as category, 
			creationdate,
			extrainfo, 
			price,
			pages, 
			[availability],
			photo
		FROM 
			Livre 
		WHERE 
			  (title		LIKE '%'+@searchString+'%' 
			OR author		LIKE '%'+@searchString+'%' 
			OR codeISBN		LIKE '%'+@searchString+'%' 
			OR initialcode	LIKE '%'+@searchString+'%'
			OR CAST(idlivre as nvarchar(50)) LIKE '%'+@searchString+'%')
			AND category LIKE (CASE WHEN @category = '' THEN category ELSE '%' + @category + '%' END)
	END

END



GO
/****** Object:  StoredProcedure [dbo].[searchuserborrow]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[searchuserborrow]
(
@searchstring nvarchar(100)
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
			iduser,
			username,
			name,
			surname,
			clasa 
	FROM 
		[User]
	WHERE
		(username LIKE '%' + @searchstring + '%' OR
		name LIKE '%' + @searchstring + '%' OR
		surname LIKE '%' + @searchstring + '%' OR
		clasa LIKE '%' + @searchstring + '%')
END



GO
/****** Object:  StoredProcedure [dbo].[searchusers]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery20.sql|7|0|C:\Users\dorus\Documents\SQL Server Management Studio\SQLQuery20.sql
CREATE PROCEDURE     [dbo].[searchusers]
(
@searchstring nvarchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT iduser, username, name, surname, clasa, rol,creationdate 
	FROM
		[User]
	WHERE
		username LIKE '%' + @searchstring + '%' OR
		name LIKE '%' + @searchstring + '%' OR
		surname LIKE '%' + @searchstring + '%' OR
		clasa LIKE '%' + @searchstring + '%' OR
		rol LIKE '%' + @searchstring + '%'
	ORDER BY rol,surname, name, clasa
END



GO
/****** Object:  StoredProcedure [dbo].[updatebook]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[updatebook]
(
	@idlivre int,
	@codeISBN nvarchar(50),
	@initialcode int,
	@title nvarchar(50),
	@author nvarchar(50),
	@description nvarchar(200),
	@category nvarchar(50),
	@extrainfo nvarchar(100),
	@price decimal(18,0),
	@pages int
)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE Livre
	SET
		codeISBN = @codeISBN,
		initialcode = @initialcode,
		title = @title, 
		author = @author,
		[description] = @description,
		category = @category,
		extrainfo = @extrainfo,
		price = @price,
		pages = @pages
	WHERE
		idlivre = @idlivre
END



GO
/****** Object:  StoredProcedure [dbo].[updateImageBook]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[updateImageBook]
(@idlivre int,
@photo varbinary(MAX))
AS
BEGIN
	SET NOCOUNT ON;

		UPDATE Livre
		SET photo = @photo
		WHERE idlivre = @idlivre
END



GO
/****** Object:  StoredProcedure [dbo].[updateloanedbook]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER PROCEDURE    date: <ALTER PROCEDURE    Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE     [dbo].[updateloanedbook] 
	-- Add the parameters for the stored  here
	(
		@idlivre int,
		@iduser	 int,
		@days	 int,
		@realreturndate datetime
	)
AS
BEGIN
	
	EXEC updatereturnbook @idlivre, @iduser
	DECLARE @returndate datetime 
	SELECT @returndate =  dateadd(d, @days, getdate())
	EXEC insertborrowedbook @iduser, @idlivre, @returndate, @realreturndate
END


GO
/****** Object:  StoredProcedure [dbo].[updatepassword]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[updatepassword]
(
@iduser int,
@password nvarchar(64)
)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [User]
	SET
		pswd = @password
	WHERE
		iduser = @iduser
END



GO
/****** Object:  StoredProcedure [dbo].[updatereturnbook]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[updatereturnbook]
(
	@idlivre int,
	@iduser int
)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE Borrow
	SET realreturndate = GETDATE()
	WHERE idlivre = @idlivre AND iduser = @iduser AND (realreturndate is NULL)

	UPDATE Livre
	SET [availability] = 1
	WHERE idlivre = @idlivre
END



GO
/****** Object:  StoredProcedure [dbo].[updateuser]    Script Date: 29 mai 2024 20:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE     [dbo].[updateuser]
(
	@iduser int,
	@username nvarchar(50),
	@name nvarchar (100),
	@surname nvarchar (100),
	@clasa nvarchar (100),
	@rol nvarchar(100)
)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [User] 
	SET 
		username = @username,
		name = @name,
		surname = @surname,
		clasa = @clasa,
		rol = @rol 
	WHERE
		iduser=@iduser
END



GO
USE [master]
GO
ALTER DATABASE [Biblioteca] SET  READ_WRITE 
GO
