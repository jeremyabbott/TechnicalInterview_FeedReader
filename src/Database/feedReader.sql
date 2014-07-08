USE [master]
GO
/****** Object:  Database [FeedReader]    Script Date: 7/8/2014 2:50:20 PM ******/
CREATE DATABASE [FeedReader]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FeedReader', FILENAME = N'X:\Code\FeedReader\src\Database\FeedReader.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'FeedReader_log', FILENAME = N'X:\Code\FeedReader\src\Database\FeedReader_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [FeedReader] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FeedReader].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FeedReader] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FeedReader] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FeedReader] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FeedReader] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FeedReader] SET ARITHABORT OFF 
GO
ALTER DATABASE [FeedReader] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [FeedReader] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FeedReader] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FeedReader] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FeedReader] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FeedReader] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FeedReader] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FeedReader] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FeedReader] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FeedReader] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FeedReader] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FeedReader] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FeedReader] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FeedReader] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FeedReader] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FeedReader] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FeedReader] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FeedReader] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FeedReader] SET  MULTI_USER 
GO
ALTER DATABASE [FeedReader] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FeedReader] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FeedReader] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FeedReader] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [FeedReader]
GO
USE [FeedReader]
GO
/****** Object:  Sequence [dbo].[ItemSequence]    Script Date: 7/8/2014 2:50:20 PM ******/
CREATE SEQUENCE [dbo].[ItemSequence] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO
/****** Object:  Table [dbo].[Channel]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Channel](
	[ChannelID] [int] IDENTITY(1,1) NOT NULL,
	[ChannelGuid] [uniqueidentifier] NOT NULL,
	[LastChecked] [datetime] NOT NULL,
	[Link] [varchar](512) NOT NULL,
	[Rss] [varchar](512) NOT NULL,
	[Title] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_Channel] PRIMARY KEY CLUSTERED 
(
	[ChannelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Item]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Item](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[ItemGuid] [uniqueidentifier] NOT NULL,
	[ChannelID] [int] NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[Link] [varchar](512) NOT NULL,
	[Sequence] [int] NOT NULL,
	[Title] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Subscription]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subscription](
	[ChannelID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_Subscription_1] PRIMARY KEY CLUSTERED 
(
	[ChannelID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Token]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Token](
	[TokenID] [int] IDENTITY(1,1) NOT NULL,
	[TokenGuid] [uniqueidentifier] NOT NULL,
	[UserID] [int] NOT NULL,
	[Created] [datetimeoffset](7) NOT NULL,
	[TokenName] [nvarchar](256) NOT NULL,
	[TokenType] [tinyint] NOT NULL,
 CONSTRAINT [PK_Token] PRIMARY KEY CLUSTERED 
(
	[TokenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserGuid] [uniqueidentifier] NOT NULL,
	[HashedPassword] [varchar](64) NOT NULL,
	[UserName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserItem]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserItem](
	[ItemID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[Read] [bit] NOT NULL,
 CONSTRAINT [PK_UserItem_1] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Index [IX_UniqueGuid]    Script Date: 7/8/2014 2:50:20 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_UniqueGuid] ON [dbo].[Channel]
(
	[ChannelGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UniqueRss]    Script Date: 7/8/2014 2:50:20 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_UniqueRss] ON [dbo].[Channel]
(
	[Rss] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Sequence]    Script Date: 7/8/2014 2:50:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Sequence] ON [dbo].[Item]
(
	[Sequence] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UniqueChannelIDLink]    Script Date: 7/8/2014 2:50:20 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_UniqueChannelIDLink] ON [dbo].[Item]
(
	[ChannelID] ASC,
	[Link] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UniqueGuid]    Script Date: 7/8/2014 2:50:20 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_UniqueGuid] ON [dbo].[Item]
(
	[ItemGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UniqueGuid]    Script Date: 7/8/2014 2:50:20 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_UniqueGuid] ON [dbo].[Token]
(
	[TokenGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UniqueNameTypeUser]    Script Date: 7/8/2014 2:50:20 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_UniqueNameTypeUser] ON [dbo].[Token]
(
	[TokenName] ASC,
	[TokenType] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UniqueGuid]    Script Date: 7/8/2014 2:50:20 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_UniqueGuid] ON [dbo].[User]
(
	[UserGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UniqueName]    Script Date: 7/8/2014 2:50:20 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_UniqueName] ON [dbo].[User]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Channel] FOREIGN KEY([ChannelID])
REFERENCES [dbo].[Channel] ([ChannelID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_Channel]
GO
ALTER TABLE [dbo].[Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Subscription_Channel] FOREIGN KEY([ChannelID])
REFERENCES [dbo].[Channel] ([ChannelID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Subscription] CHECK CONSTRAINT [FK_Subscription_Channel]
GO
ALTER TABLE [dbo].[Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Subscription_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Subscription] CHECK CONSTRAINT [FK_Subscription_User]
GO
ALTER TABLE [dbo].[Token]  WITH CHECK ADD  CONSTRAINT [FK_Token_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Token] CHECK CONSTRAINT [FK_Token_User]
GO
ALTER TABLE [dbo].[UserItem]  WITH CHECK ADD  CONSTRAINT [FK_UserItem_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([ItemID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserItem] CHECK CONSTRAINT [FK_UserItem_Item]
GO
ALTER TABLE [dbo].[UserItem]  WITH CHECK ADD  CONSTRAINT [FK_UserItem_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserItem] CHECK CONSTRAINT [FK_UserItem_User]
GO
/****** Object:  StoredProcedure [dbo].[addChannel]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addChannel]
	@userGuid uniqueidentifier,
	@link varchar(512),
	@rss varchar(512),
	@title nvarchar(256),
	@channelGuid uniqueidentifier OUTPUT,
	@lastChecked int OUTPUT,
	@existed bit OUTPUT
AS
BEGIN
	DECLARE @channelID int;
	DECLARE @userID int;

	BEGIN TRANSACTION;

	SET @userID = (SELECT [UserID] FROM [dbo].[User] WHERE [UserGuid] = @userGuid);
	IF (@userID IS NULL)
	BEGIN
		ROLLBACK TRANSACTION;
		SET @channelGuid = NULL;
		SET @existed = 0;
		RETURN 1;
	END

	EXEC [dbo].[putChannel] @link, @rss, @title, @channelGuid OUTPUT, @lastChecked OUTPUT, @existed OUTPUT;
	SET @channelID = (SELECT [ChannelID] FROM [dbo].[Channel] WHERE [ChannelGuid] = @channelGuid);

	IF NOT EXISTS(SELECT 1 FROM [dbo].[Subscription] 
		WHERE ([ChannelID] = @channelID) AND ([UserID] = @userID))
	BEGIN
		INSERT INTO [dbo].[Subscription] ([ChannelID], [UserID])
			VALUES (@channelID, @userID);
	END

	COMMIT TRANSACTION;

	return 0;
END



GO
/****** Object:  StoredProcedure [dbo].[addItem]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addItem]
	@channelGuid uniqueidentifier,
	@description nvarchar(4000),
	@link varchar(512),
	@title nvarchar(256),
	@itemGuid uniqueidentifier OUTPUT,
	@sequence int OUTPUT,
	@existed bit OUTPUT
AS
BEGIN
	DECLARE @channelID int;
	DECLARE @itemID int;

	BEGIN TRANSACTION;

	SET @channelID = (SELECT [ChannelID] FROM [dbo].[Channel] WHERE [ChannelGuid] = @channelGuid);
	IF (@channelID IS NULL)
	BEGIN
		ROLLBACK TRANSACTION;
		SET @itemGuid = NULL;
		SET @sequence = NULL;
		SET @existed = 0;
		RETURN 1;
	END

	UPDATE [dbo].[Channel]
		SET [LastChecked] = GETUTCDATE()
		WHERE [ChannelID] = @channelID;

	SELECT @sequence = NEXT VALUE FOR [dbo].ItemSequence;
	IF (@itemGuid IS NULL)
	BEGIN
		SET @itemID = NULL;
		SELECT @itemID = [ItemID],
			@itemGuid = [ItemGuid],
			@sequence = [Sequence]
			FROM [dbo].[Item]
			WHERE ([ChannelID] = @channelID) AND ([Link] = @link);

		IF (@itemID IS NULL)
		BEGIN
			SET @existed = 0;
			SET @itemGuid = NEWID();
			INSERT INTO [dbo].[Item] ([ItemGuid], [ChannelID], [Description], [Link], [Sequence], [Title])
				VALUES (@itemGuid, @channelID, @description, @link, @sequence, @title);
		END
		ELSE
		BEGIN
			SET @existed = 1;
			UPDATE [dbo].[Item]
				SET [Description] = @description,
					[Sequence] = @sequence,
					[Title] = @Title
				WHERE [ItemID] = @itemID;
		END
	END
	ELSE
	BEGIN
		SET @existed = 1;
		UPDATE [dbo].[Item]
			SET [Description] = @description,
				[Link] = @link,
				[Sequence] = @sequence,
				[Title] = @Title
			WHERE [ItemGuid] = @itemGuid;
		if (@@ROWCOUNT = 0)
		BEGIN
			SET @existed = 0;
			INSERT INTO [dbo].[Item] ([ItemGuid], [ChannelID], [Description], [Link], [Sequence], [Title])
				VALUES (@itemGuid, @channelID, @description, @link, @sequence, @title);
		END
	END

	COMMIT TRANSACTION;

	return 0;
END



GO
/****** Object:  StoredProcedure [dbo].[addToken]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addToken]
	@userGuid uniqueidentifier,
	@tokenName nvarchar(255),
	@tokenType tinyint,
	@tokenCreated datetimeoffset OUTPUT,
	@tokenGuid uniqueidentifier OUTPUT,
	@existed bit OUTPUT
AS
BEGIN
	DECLARE @userID int;

	SET @existed = 0;

	BEGIN TRANSACTION;

	SET @userID = (SELECT [UserID] FROM [dbo].[User] WHERE [UserGuid] = @userGuid);
	IF (@userID IS NULL)
	BEGIN
		ROLLBACK TRANSACTION;
		RETURN 1;
	END

	SET @tokenGuid = NULL;
	SELECT @tokenCreated = [Created], 
		   @tokenGuid = [TokenGuid]
		FROM [dbo].[Token]
		WHERE ([TokenName] = @tokenName) AND ([UserID] = @userID);
	IF (@tokenGuid IS NOT NULL)
	BEGIN
		ROLLBACK TRANSACTION;
		SET @existed = 1;
		RETURN 0;		
	END

	SET @tokenCreated = GETUTCDATE();
	SET @tokenGuid = NEWID();
	INSERT INTO [dbo].[Token] ([Created], [TokenGuid], [TokenName], [TokenType], [UserID])
		VALUES (@tokenCreated, @tokenGuid, @tokenName, @tokenType, @userID);

	COMMIT TRANSACTION;

	return 0;
END



GO
/****** Object:  StoredProcedure [dbo].[deleteAll]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[deleteAll]
AS
BEGIN
	DELETE FROM [dbo].[UserItem];
	DELETE FROM [dbo].[Subscription];

	DELETE FROM [dbo].[Item];
	DBCC CHECKIDENT('Item', RESEED, 0);

	DELETE FROM [dbo].[Channel];
	DBCC CHECKIDENT('Channel', RESEED, 0);

	DELETE FROM [dbo].[Token];
	DBCC CHECKIDENT('Token', RESEED, 0);

	DELETE FROM [dbo].[User];
	DBCC CHECKIDENT('User', RESEED, 0);

	ALTER SEQUENCE [dbo].[ItemSequence] RESTART WITH 1;

	RETURN 0;
END



GO
/****** Object:  StoredProcedure [dbo].[deleteChannel]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[deleteChannel]
	@channelGuid uniqueidentifier
AS
BEGIN
	DELETE FROM [dbo].[Channel] WHERE [ChannelGuid] = @channelGuid;

	RETURN 0;
END



GO
/****** Object:  StoredProcedure [dbo].[deleteUser]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[deleteUser]
	@userGuid uniqueidentifier
AS
BEGIN
	DELETE FROM [dbo].[User] WHERE [UserGuid] = @userGuid;

	RETURN 0;
END



GO
/****** Object:  StoredProcedure [dbo].[enumerateChannels]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[enumerateChannels]
	@userGuid uniqueidentifier
AS
BEGIN
	DECLARE @now datetime;
	DECLARE @userID int;

	SET @userID = (SELECT [UserID] FROM [dbo].[User] WHERE [UserGuid] = @userGuid);
	IF (@userID IS NULL)
	BEGIN
		RETURN 1;
	END

	SET @now = GETUTCDATE();
	SELECT C.[ChannelGuid], 
		DATEDIFF(SECOND, C.[LastChecked], @now),
		C.[Link], 
		C.[Rss], 
		C.[Title] 
		FROM [dbo].[Channel] AS C
			JOIN [dbo].[Subscription] AS S
				ON S.[ChannelID] = C.[ChannelID]
		WHERE S.[UserID] = @userID;

	RETURN 0;
END



GO
/****** Object:  StoredProcedure [dbo].[enumerateItems]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[enumerateItems]
	@channelGuid uniqueidentifier,
	@limit int
AS
BEGIN
	DECLARE @channelID int;
	DECLARE @sequence int;

	SET @limit = ISNULL(NULLIF(@limit, 0), 10);

	SET @channelID = (SELECT [ChannelID] FROM [dbo].[Channel] WHERE [ChannelGuid] = @channelGuid);
	IF (@channelID IS NULL)
	BEGIN
		RETURN 1;
	END

	SELECT TOP(@limit)
		I.[ItemGuid], I.[Description], I.[Link], I.[Sequence], I.[Title]
		FROM [dbo].[Item] AS I 
			JOIN [dbo].[Channel] AS C
				ON C.[ChannelID] = I.[ChannelID]
		WHERE C.[ChannelID] = @channelID
		ORDER BY I.[Sequence] DESC

	RETURN 0;
END



GO
/****** Object:  StoredProcedure [dbo].[enumerateUserItemsAfter]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[enumerateUserItemsAfter]
	@userGuid uniqueidentifier,
	@channelGuid uniqueidentifier,
	@limit int,
	@itemGuid uniqueidentifier
AS
BEGIN
	DECLARE @channelID int;
	DECLARE @sequence int;
	DECLARE @userID int;

	SET @limit = ISNULL(NULLIF(@limit, 0), 10);

	SET @userID = (SELECT [UserID] FROM [dbo].[User] WHERE [UserGuid] = @userGuid);
	IF (@userID IS NULL)
	BEGIN
		RETURN 1;
	END

	SET @channelID = (SELECT [ChannelID] FROM [dbo].[Channel] WHERE [ChannelGuid] = @channelGuid);
	IF (@channelID IS NULL)
	BEGIN
		RETURN 2;
	END

	IF (@itemGuid IS NOT NULL)
	BEGIN
		SET @sequence = (SELECT [Sequence] FROM [dbo].[Item] WHERE [ItemGuid] = @itemGuid);
		IF (@channelID IS NULL)
		BEGIN
			RETURN 3;
		END

		SELECT TOP(@limit)
			I.[ItemGuid], I.[Description], I.[Link], I.[Sequence], I.[Title], UI.[Read]
			FROM [dbo].[Item] AS I 
				JOIN [dbo].[Channel] AS C
					ON C.[ChannelID] = I.[ChannelID]
				JOIN [dbo].[Subscription] AS S
					ON S.[ChannelID] = C.[ChannelID]
				JOIN [dbo].[User] AS U
					ON U.[UserID] = S.[UserID]
				LEFT JOIN [dbo].[UserItem] AS UI
					ON (UI.[ItemID] = I.[ItemID]) AND (UI.[UserID] = U.[UserID])
			WHERE (C.[ChannelID] = @channelID) AND 
				(U.[UserID] = @userID) AND
				(I.[Sequence] < @sequence)
			ORDER BY I.[Sequence] DESC
	END
	ELSE
	BEGIN
		SELECT TOP(@limit)
			I.[ItemGuid], I.[Description], I.[Link], I.[Sequence], I.[Title], UI.[Read]
			FROM [dbo].[Item] AS I 
				JOIN [dbo].[Channel] AS C
					ON C.[ChannelID] = I.[ChannelID]
				JOIN [dbo].[Subscription] AS S
					ON S.[ChannelID] = C.[ChannelID]
				JOIN [dbo].[User] AS U
					ON U.[UserID] = S.[UserID]
				LEFT JOIN [dbo].[UserItem] AS UI
					ON (UI.[ItemID] = I.[ItemID]) AND (UI.[UserID] = U.[UserID])
			WHERE (C.[ChannelID] = @channelID) AND (U.[UserID] = @userID)
			ORDER BY I.[Sequence] DESC
	END

	RETURN 0;
END



GO
/****** Object:  StoredProcedure [dbo].[getChannelByGuid]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getChannelByGuid]
	@channelGuid uniqueidentifier,
	@lastChecked int OUTPUT,
	@link varchar(512) OUTPUT,
	@rss varchar(512) OUTPUT,
	@title nvarchar(256) OUTPUT
AS
BEGIN
	SET @lastChecked = NULL;
	SET @link = NULL;
	SET @rss = NULL;
	SET @title = NULL;
	SELECT @lastChecked = DATEDIFF(SECOND, [LastChecked], GETUTCDATE()),
		@link = [Link],
		@rss = [Rss],
		@title = [Title]
		FROM [dbo].[Channel] 
		WHERE [ChannelGuid] = @channelGuid;
	IF (@@ROWCOUNT <> 1)
	BEGIN
		RETURN 1;
	END

	RETURN 0;
END



GO
/****** Object:  StoredProcedure [dbo].[getChannelByRss]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getChannelByRss]
	@rss varchar(512),
	@channelGuid uniqueidentifier OUTPUT,
	@lastChecked int OUTPUT,
	@link varchar(512) OUTPUT,
	@title nvarchar(256) OUTPUT
AS
BEGIN
	SET @channelGuid = NULL;
	SET @lastChecked = NULL;
	SET @link = NULL;
	SET @title = NULL;
	SELECT @channelGuid = [ChannelGuid],
		@lastChecked = DATEDIFF(SECOND, [LastChecked], GETUTCDATE()),
		@link = [Link],
		@title = [Title]
		FROM [dbo].[Channel] 
		WHERE [Rss] = @rss;
	IF (@@ROWCOUNT <> 1)
	BEGIN
		RETURN 1;
	END

	RETURN 0;
END



GO
/****** Object:  StoredProcedure [dbo].[getItem]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getItem]
	@itemGuid uniqueidentifier,
	@description nvarchar(4000) OUTPUT,
	@link varchar(512) OUTPUT,
	@sequence int OUTPUT,
	@title nvarchar(256) OUTPUT
AS
BEGIN
	SET @description = NULL;
	SET @link = NULL;
	SET @sequence = NULL;
	SET @title = NULL;
	SELECT @description = [Description],
		@link = [Link],
		@sequence = [Sequence],
		@title = [Title]
		FROM [dbo].[Item] 
		WHERE [ItemGuid] = @itemGuid;
	IF (@@ROWCOUNT <> 1)
	BEGIN
		RETURN 1;
	END

	RETURN 0;
END



GO
/****** Object:  StoredProcedure [dbo].[getUserByName]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getUserByName]
	@userName nvarchar(255),
	@hashedPassword varchar(64) OUTPUT,
	@userGuid uniqueidentifier OUTPUT
AS
BEGIN
	SET @hashedPassword = NULL;
	SET @userGuid = NULL;
	SELECT @hashedPassword = [HashedPassword],
		@userGuid = [UserGuid]
		FROM [dbo].[User] 
		WHERE [UserName] = @userName;
	IF (@@ROWCOUNT <> 1)
	BEGIN
		RETURN 1;
	END

	RETURN 0;
END



GO
/****** Object:  StoredProcedure [dbo].[getUserByToken]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getUserByToken]
	@tokenGuid uniqueidentifier,
	@hashedPassword varchar(64) OUTPUT,
	@userGuid uniqueidentifier OUTPUT,
	@userName nvarchar(255) OUTPUT,
	@tokenCreated datetimeoffset OUTPUT,
	@tokenName nvarchar(255) OUTPUT,
	@tokenType tinyint OUTPUT
AS
BEGIN
	SET @hashedPassword = NULL;
	SET @userName = NULL;
	SET @tokenCreated = NULL;
	SET @tokenName = NULL;
	SET @tokenType = NULL;
	SELECT @userName = U.[UserName],
			@hashedPassword = U.[HashedPassword],
			@userGuid = U.[UserGuid],
			@tokenCreated = T.[Created],
			@tokenName = T.[TokenName],
			@tokenType = T.[TokenType]
		FROM [dbo].[Token] AS T
			JOIN [dbo].[User] AS U
				ON U.[UserID] = T.[UserID]
		WHERE T.[TokenGuid] = @tokenGuid;
	IF (@@ROWCOUNT <> 1)
	BEGIN
		RETURN 1;
	END

	RETURN 0;
END



GO
/****** Object:  StoredProcedure [dbo].[putChannel]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[putChannel]
	@link varchar(512),
	@rss varchar(512),
	@title nvarchar(256),
	@channelGuid uniqueidentifier OUTPUT,
	@lastChecked int OUTPUT,
	@existed bit OUTPUT
AS
BEGIN
	DECLARE @channelID int;
	DECLARE @lastYear datetime = DATEADD(YEAR, -1, GETUTCDATE());

	BEGIN TRANSACTION;

	IF (@channelGuid IS NULL)
	BEGIN
		SET @channelID = NULL;
		SELECT @channelID = [ChannelID],
			@channelGuid = [ChannelGuid],
			@lastChecked = DATEDIFF(SECOND, [LastChecked], GETUTCDATE())
			FROM [dbo].[Channel]
			WHERE [Rss] = @rss;

		IF (@channelID IS NULL)
		BEGIN
			SET @existed = 0;
			SET @channelGuid = NEWID();
			SET @lastChecked = DATEDIFF(SECOND, @lastYear, GETUTCDATE());
			INSERT INTO [dbo].[Channel] ([ChannelGuid], [LastChecked], [Link], [Rss], [Title])
				VALUES (@channelGuid, @lastYear, @link, @Rss, @title);
		END
		ELSE
		BEGIN
			SET @existed = 1;
			UPDATE [dbo].[Channel]
				SET [Link] = link,
					[Title] = title
				WHERE [ChannelID] = @channelID;
		END
	END
	ELSE
	BEGIN
		SET @channelID = NULL;
		SELECT @channelID = [ChannelID],
			@lastChecked = DATEDIFF(SECOND, [LastChecked], GETUTCDATE())
			FROM [dbo].[Channel]
			WHERE [ChannelGuid] = @channelGuid;

		IF (@channelID IS NULL)
		BEGIN
			SET @existed = 0;
			SET @lastChecked = DATEDIFF(SECOND, @lastYear, GETUTCDATE());
			INSERT INTO [dbo].[Channel] ([ChannelGuid], [LastChecked], [Link], [Rss], [Title])
				VALUES (@channelGuid, @lastYear, @link, @Rss, @title);
		END
		ELSE
		BEGIN
			SET @existed = 1;
			UPDATE [dbo].[Channel]
				SET [Link] = link,
					[Rss] = @rss,
					[Title] = @title
				WHERE [Rss] = @rss;
		END
	END

	COMMIT TRANSACTION;

	RETURN 0;
END



GO
/****** Object:  StoredProcedure [dbo].[putUser]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[putUser]
	@hashedPassword varchar(64),
	@userName nvarchar(255),
	@userGuid uniqueidentifier OUTPUT,
	@existed bit OUTPUT
AS
BEGIN
	DECLARE @userID int;

	BEGIN TRANSACTION;

	IF (@userGuid IS NULL)
	BEGIN
		SET @userID = NULL;
		SELECT @userID = [UserID],
			@userGuid = [UserGuid]
			FROM [dbo].[User]
			WHERE [UserName] = @userName;

		IF (@userID IS NULL)
		BEGIN
			SET @existed = 0;
			SET @userGuid = NEWID();
			INSERT INTO [dbo].[User] ([UserGuid], [HashedPassword], [UserName])
				VALUES (@userGuid, @hashedPassword, @userName);
		END
		ELSE
		BEGIN
			SET @existed = 1;
			UPDATE [dbo].[User]
				SET [HashedPassword] = @hashedPassword
				WHERE [UserID] = @userID;
		END
	END
	ELSE
	BEGIN
		SET @existed = 1;
		UPDATE [dbo].[User]
			SET [HashedPassword] = @hashedPassword,
				[UserName] = @userName
			WHERE [UserGuid] = @userGuid;
		if (@@ROWCOUNT = 0)
		BEGIN
			SET @existed = 0;
			INSERT INTO [dbo].[User] ([UserGuid], [HashedPassword], [UserName])
				VALUES (@userGuid, @hashedPassword, @userName);
		END
	END

	COMMIT TRANSACTION;

	RETURN 0;
END


GO
/****** Object:  StoredProcedure [dbo].[putUserItem]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[putUserItem]
	@userGuid uniqueidentifier,
	@itemGuid uniqueidentifier,
	@read bit,
	@existed bit OUTPUT
AS
BEGIN
	DECLARE @itemID int;
	DECLARE @userID int;

	BEGIN TRANSACTION;

	SET @userID = (SELECT [UserID] FROM [dbo].[User] WHERE [UserGuid] = @userGuid);
	IF (@userID IS NULL)
	BEGIN
		ROLLBACK TRANSACTION;
		SET @existed = 0;
		RETURN 1;
	END

	SET @itemID = (SELECT [ItemID] FROM [dbo].[Item] WHERE [ItemGuid] = @itemGuid);
	IF (@itemID IS NULL)
	BEGIN
		ROLLBACK TRANSACTION;
		SET @existed = 0;
		RETURN 1;
	END

	SET @existed = 1;
	UPDATE [dbo].[UserItem]
		SET [Read] = @read
		WHERE ([ItemID] = @itemID) AND ([UserID] = @userID);
	if (@@ROWCOUNT = 0)
	BEGIN
		SET @existed = 0;
		INSERT INTO [dbo].[UserItem] ([ItemID], [UserID], [Read])
			VALUES (@itemID, @userID, @read);
	END

	COMMIT TRANSACTION;

	return 0;

	RETURN 0;
END



GO
/****** Object:  StoredProcedure [dbo].[removeChannel]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[removeChannel]
	@userGuid uniqueidentifier,
	@channelGuid uniqueidentifier
AS
BEGIN
	DECLARE @userID int;

	SET @userID = (SELECT [UserID] FROM [dbo].[User] WHERE [UserGuid] = @userGuid);
	IF (@userID IS NULL)
	BEGIN
		RETURN 1;
	END

	DELETE S
		FROM [dbo].[Subscription] AS S
			JOIN [dbo].[Channel] AS C
				ON C.[ChannelID] = S.[ChannelID]
		WHERE (S.[UserID] = @userID) AND (C.[ChannelGuid] = @channelGuid);

	RETURN 0;
END



GO
/****** Object:  StoredProcedure [dbo].[removeItem]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[removeItem]
	@itemGuid uniqueidentifier
AS
BEGIN
	DELETE FROM [dbo].[Item] WHERE [ItemGuid] = @itemGuid;

	RETURN 0;
END



GO
/****** Object:  StoredProcedure [dbo].[removeToken]    Script Date: 7/8/2014 2:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[removeToken]
	@tokenGuid uniqueidentifier
AS
BEGIN
	DELETE FROM [dbo].[Token] WHERE [TokenGuid] = @tokenGuid;
	RETURN 0;
END



GO
USE [master]
GO
ALTER DATABASE [FeedReader] SET  READ_WRITE 
GO
