USE [master]
GO
/****** Object:  Database [Contacts]    Script Date: 2022/4/30 14:36:04 ******/
CREATE DATABASE [Contacts]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Contacts', FILENAME = N'D:\Study\大二下\asp.net\慕课\第九单元  数据高级处理\9.3-6\Contacts.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Contacts_log', FILENAME = N'D:\Study\大二下\asp.net\慕课\第九单元  数据高级处理\9.3-6\Contacts_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Contacts] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Contacts].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Contacts] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Contacts] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Contacts] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Contacts] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Contacts] SET ARITHABORT OFF 
GO
ALTER DATABASE [Contacts] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Contacts] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Contacts] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Contacts] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Contacts] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Contacts] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Contacts] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Contacts] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Contacts] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Contacts] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Contacts] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Contacts] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Contacts] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Contacts] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Contacts] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Contacts] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Contacts] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Contacts] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Contacts] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Contacts] SET  MULTI_USER 
GO
ALTER DATABASE [Contacts] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Contacts] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Contacts] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Contacts] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Contacts', N'ON'
GO
USE [Contacts]
GO
/****** Object:  StoredProcedure [dbo].[DeleteContactById]    Script Date: 2022/4/30 14:36:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[DeleteContactById]  /*通过编号删除联系人*/
@Id int
As
begin
	delete from Contact where Id=@Id
end


GO
/****** Object:  StoredProcedure [dbo].[GetAllContactGroup]    Script Date: 2022/4/30 14:36:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[GetAllContactGroup]  /*获取所有分组信息*/
As
begin
	select * from ContactGroup
end



GO
/****** Object:  StoredProcedure [dbo].[GetContactById]    Script Date: 2022/4/30 14:36:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetContactById]  /*通过联系人编号获取联系人信息*/
@Id int
As
begin
	select * from Contact where id=@Id
end


GO
/****** Object:  StoredProcedure [dbo].[GetContactListByGroupName]    Script Date: 2022/4/30 14:36:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetContactListByGroupName]  /*根据分组名称获取联系人信息*/
@GroupName varchar(50)
As
begin
  select Name,Phone,Email,QQ from Contact,ContactGroup where Contact.GroupId=ContactGroup.Id
and ContactGroup.GroupName=@GroupName
end


GO
/****** Object:  StoredProcedure [dbo].[GetContactListByName]    Script Date: 2022/4/30 14:36:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[GetContactListByName]  /*根据联系人姓名获取联系人信息*/
@Name nvarchar(50)
As
begin
	select Contact.Id,Contact.Name,Phone,Email,QQ,GroupName from Contact,ContactGroup
 where Contact.GroupId=ContactGroup.Id and Name like '%'+@Name+'%'  order by Contact.Id desc
end




GO
/****** Object:  StoredProcedure [dbo].[GetContactListByPhone]    Script Date: 2022/4/30 14:36:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[GetContactListByPhone]  /*根据联系人手机获取联系人信息*/
@Phone varchar(11)
As
begin
	select Contact.Id,Contact.Name,Phone,Email,QQ,GroupName from Contact,ContactGroup
 where Contact.GroupId=ContactGroup.Id and Phone like '%'+@Phone+'%'  order by Contact.Id desc
end



GO
/****** Object:  StoredProcedure [dbo].[GetGroupById]    Script Date: 2022/4/30 14:36:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetGroupById]  /*根据分组编号获取分组信息*/
 @GroupName nvarchar(50) OUTPUT,
 @Memo nvarchar(200) OUTPUT,
 @id int
AS
BEGIN
 select @GroupName=GroupName,@Memo=Memo from ContactGroup where id=@id
 if @@Error<>0
  RETURN -1
 else 
  RETURN 0 
END

GO
/****** Object:  StoredProcedure [dbo].[GetPageData]    Script Date: 2022/4/30 14:36:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetPageData] 
(@startIndex int,
@endIndex int
)
as
begin
 with temptbl as (
SELECT ROW_NUMBER() OVER (ORDER BY contact.id )AS Row, contact.id,name,phone,email,groupname from contact inner join contactgroup on contact.groupid=contactgroup.id )
 SELECT * FROM temptbl where Row between @startIndex and @endIndex
end
GO
/****** Object:  StoredProcedure [dbo].[InsertContact]    Script Date: 2022/4/30 14:36:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[InsertContact]  /*新增联系人*/
@Name nvarchar(50),
@Phone varchar(11),
@Email nvarchar(50),
@QQ varchar(20),
@WorkUnit nvarchar(200),
@OfficePhone varchar(20),
@HomeAddress nvarchar(200),
@HomePhone varchar(20),
@Memo nvarchar(200),
@GroupId int
As
begin
	insert into Contact values(@Name,@Phone,@Email,@QQ,@WorkUnit,
@OfficePhone,@HomeAddress,@HomePhone,@Memo,@GroupId)
end


GO
/****** Object:  StoredProcedure [dbo].[InsertContactGroup]    Script Date: 2022/4/30 14:36:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[InsertContactGroup]  /*新增分组*/
@GroupName nvarchar(50),
@Memo nvarchar(200)
As
begin
	insert into ContactGroup(GroupName,Memo) values(@GroupName,@Memo)
end

GO
/****** Object:  StoredProcedure [dbo].[UpdateContact]    Script Date: 2022/4/30 14:36:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[UpdateContact]  /*修改联系人信息*/
@Name nvarchar(50),
@Phone varchar(11),
@Email nvarchar(50),
@QQ varchar(20),
@WorkUnit nvarchar(200),
@OfficePhone varchar(20),
@HomeAddress nvarchar(200),
@HomePhone varchar(20),
@Memo nvarchar(200),
@GroupId int,
@Id int
As
begin
	update Contact set Name=@Name,Phone=@Phone,Email=@Email,QQ=@QQ,
WorkUnit=@WorkUnit,OfficePhone=@OfficePhone,HomeAddress=@HomeAddress,
HomePhone=@HomePhone,Memo=@Memo,GroupId=@GroupId where Id=@Id
end


GO
/****** Object:  Table [dbo].[Contact]    Script Date: 2022/4/30 14:36:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Contact](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Phone] [varchar](11) NULL,
	[Email] [nvarchar](50) NULL,
	[QQ] [varchar](20) NULL,
	[WorkUnit] [nvarchar](200) NULL,
	[OfficePhone] [varchar](20) NULL,
	[HomeAddress] [nvarchar](200) NULL,
	[HomePhone] [varchar](20) NULL,
	[Memo] [nvarchar](200) NULL,
	[GroupId] [int] NOT NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContactGroup]    Script Date: 2022/4/30 14:36:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](50) NOT NULL,
	[Memo] [nvarchar](200) NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 2022/4/30 14:36:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Contact] ON 

INSERT [dbo].[Contact] ([Id], [Name], [Phone], [Email], [QQ], [WorkUnit], [OfficePhone], [HomeAddress], [HomePhone], [Memo], [GroupId]) VALUES (1, N'张玉', N'13923081612', N'zhangyu@163.com', N'5625526', N'张家港梁丰集团', N'56730601', N'杨舍镇万红2村', N'58916868', N'工作积极的一个人！', 2)
INSERT [dbo].[Contact] ([Id], [Name], [Phone], [Email], [QQ], [WorkUnit], [OfficePhone], [HomeAddress], [HomePhone], [Memo], [GroupId]) VALUES (2, N'王安娜', N'13892281618', N'wangna@qq.com', N'262551', N'张家港天士力集团', N'56730608', N'杨舍镇万红1村', N'58996869', N'一个村的。', 3)
INSERT [dbo].[Contact] ([Id], [Name], [Phone], [Email], [QQ], [WorkUnit], [OfficePhone], [HomeAddress], [HomePhone], [Memo], [GroupId]) VALUES (3, N'周一鸣', N'15678999044', N'yming@qq.com', N'6761589', N'沙洲职工学院', N'56730608
', N'凤凰镇', N'58910869', N'', 2)
INSERT [dbo].[Contact] ([Id], [Name], [Phone], [Email], [QQ], [WorkUnit], [OfficePhone], [HomeAddress], [HomePhone], [Memo], [GroupId]) VALUES (4, N'李小明', N'13862269891', N'xiao@qq.com', N'8925798', N'张家港人才交流中心', N'56730609
', N'杨舍镇农联村', N'58918869', N'', 3)
INSERT [dbo].[Contact] ([Id], [Name], [Phone], [Email], [QQ], [WorkUnit], [OfficePhone], [HomeAddress], [HomePhone], [Memo], [GroupId]) VALUES (7, N'李明', N'13962269891', N'xiaoming@qq.com', N'8925799', N'苏州科大贸易', N'56730610
', N'苏州大巷村', N'58916829', N'', 9)
INSERT [dbo].[Contact] ([Id], [Name], [Phone], [Email], [QQ], [WorkUnit], [OfficePhone], [HomeAddress], [HomePhone], [Memo], [GroupId]) VALUES (8, N'杨小明', N'13262269891', N'yang@qq.com', N'8825798', N'苏州华健集团', N'56780609
', N'苏州苏安新村', N'58916867', N'', 3)
INSERT [dbo].[Contact] ([Id], [Name], [Phone], [Email], [QQ], [WorkUnit], [OfficePhone], [HomeAddress], [HomePhone], [Memo], [GroupId]) VALUES (9, N'李捷', N'13862269896', N'lee@qq.com', N'8928798', N'江苏明日集团', N'52730608
', N'南京高新区', N'58916866', N'', 3)
INSERT [dbo].[Contact] ([Id], [Name], [Phone], [Email], [QQ], [WorkUnit], [OfficePhone], [HomeAddress], [HomePhone], [Memo], [GroupId]) VALUES (11, N'周明', N'13863269891', N'zhouming@qq.com', N'8925898', N'江苏今日集团', N'56730780
', N'南京高新区', N'58916862', N'', 3)
INSERT [dbo].[Contact] ([Id], [Name], [Phone], [Email], [QQ], [WorkUnit], [OfficePhone], [HomeAddress], [HomePhone], [Memo], [GroupId]) VALUES (12, N'邵一梅', N'13762269891', N'yimei@qq.com', N'8625798', N'上海一强集团', N'587306092', N'上海静安区', N'58916861', N'', 3)
SET IDENTITY_INSERT [dbo].[Contact] OFF
SET IDENTITY_INSERT [dbo].[ContactGroup] ON 

INSERT [dbo].[ContactGroup] ([Id], [GroupName], [Memo]) VALUES (1, N'未分组', N'未分组')
INSERT [dbo].[ContactGroup] ([Id], [GroupName], [Memo]) VALUES (2, N'同事', N'单位同事')
INSERT [dbo].[ContactGroup] ([Id], [GroupName], [Memo]) VALUES (3, N'大学同学', N'大学同窗')
INSERT [dbo].[ContactGroup] ([Id], [GroupName], [Memo]) VALUES (4, N'老师', N'师恩永存')
INSERT [dbo].[ContactGroup] ([Id], [GroupName], [Memo]) VALUES (9, N'网友', N'来自网络世界')
SET IDENTITY_INSERT [dbo].[ContactGroup] OFF
INSERT [dbo].[User] ([UserName], [Password]) VALUES (N'aa', N'aa')
INSERT [dbo].[User] ([UserName], [Password]) VALUES (N'admin', N'admin')
INSERT [dbo].[User] ([UserName], [Password]) VALUES (N'cc', N'cc')
INSERT [dbo].[User] ([UserName], [Password]) VALUES (N'dd', N'dd')
INSERT [dbo].[User] ([UserName], [Password]) VALUES (N'ee', N'ee')
ALTER TABLE [dbo].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_ContactGroup] FOREIGN KEY([GroupId])
REFERENCES [dbo].[ContactGroup] ([Id])
GO
ALTER TABLE [dbo].[Contact] CHECK CONSTRAINT [FK_Contact_ContactGroup]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自动编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contact', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系人姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contact', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contact', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contact', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'QQ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contact', @level2type=N'COLUMN',@level2name=N'QQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工作单位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contact', @level2type=N'COLUMN',@level2name=N'WorkUnit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'办公电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contact', @level2type=N'COLUMN',@level2name=N'OfficePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'家庭住址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contact', @level2type=N'COLUMN',@level2name=N'HomeAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'家庭电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contact', @level2type=N'COLUMN',@level2name=N'HomePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contact', @level2type=N'COLUMN',@level2name=N'Memo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分组编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contact', @level2type=N'COLUMN',@level2name=N'GroupId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自动编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContactGroup', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分组名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContactGroup', @level2type=N'COLUMN',@level2name=N'GroupName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContactGroup', @level2type=N'COLUMN',@level2name=N'Memo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Password'
GO
USE [master]
GO
ALTER DATABASE [Contacts] SET  READ_WRITE 
GO
