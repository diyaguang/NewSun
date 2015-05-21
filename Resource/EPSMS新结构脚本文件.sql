
ALTER DATABASE [EPSMSTEST] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EPSMSTEST].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EPSMSTEST] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EPSMSTEST] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EPSMSTEST] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EPSMSTEST] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EPSMSTEST] SET ARITHABORT OFF 
GO
ALTER DATABASE [EPSMSTEST] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EPSMSTEST] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EPSMSTEST] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EPSMSTEST] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EPSMSTEST] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EPSMSTEST] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EPSMSTEST] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EPSMSTEST] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EPSMSTEST] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EPSMSTEST] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EPSMSTEST] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EPSMSTEST] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EPSMSTEST] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EPSMSTEST] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EPSMSTEST] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EPSMSTEST] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EPSMSTEST] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EPSMSTEST] SET RECOVERY FULL 
GO
ALTER DATABASE [EPSMSTEST] SET  MULTI_USER 
GO
ALTER DATABASE [EPSMSTEST] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EPSMSTEST] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EPSMSTEST] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EPSMSTEST] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [EPSMSTEST] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'EPSMSTEST', N'ON'
GO
USE [EPSMSTEST]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Account](
	[Code] [varchar](100) NULL,
	[Type] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[ApproveState] [int] NULL,
	[IsDel] [int] NULL,
	[Note] [nvarchar](500) NULL,

    [ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,


 CONSTRAINT [PK_ACCOUNT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountBill]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountBill](
	[Code] [varchar](100) NULL,
	[Date] [datetime] NULL,
	[BillID] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[ApproveState] [int] NULL,
	[IsDel] [int] NULL,
	[Note] [nvarchar](500) NULL,
	[Type] [int] NULL,
	[Money] [decimal](18, 2) NULL,
	[UniqueID] [nvarchar](50) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,

 CONSTRAINT [PK_ACCOUNTBILL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Allot]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Allot](
	[Code] [varchar](50) NULL,
	[InDepotID] [int] NULL,
	[OutDepotID] [int] NULL,
	[UserID] [int] NULL,
	[CarID] [int] NULL,
	[Address] [nvarchar](500) NULL,
	[IsUseCar] [int] NULL,
	[OutDate] [date] NULL,
	[InDate] [date] NULL,
	[Note] [nvarchar](500) NULL,
	[State] [int] NULL,
	[ApproveState] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[IsDel] [int] NULL,
	[EditID] [varchar](50) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,

 CONSTRAINT [PK_ALLOT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AllotDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AllotDetail](
	[AllotID] [int] NULL,
	[ProductID] [int] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Unit] [nvarchar](50) NULL,
	[Money] [decimal](18, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[Price] [decimal](18, 2) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_ALLOTDETAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Announcement]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Announcement](
	[Code] [varchar](50) NULL,
	[AnnouncementType] [int] NULL,
	[Title] [nvarchar](100) NULL,
	[Contents] [text] NULL,
	[AnnouncementDate] [date] NULL,
	[Note] [nvarchar](500) NULL,
	[ApproveState] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[State] [int] NULL,
	[IsDel] [int] NULL,
	[EditID] [varchar](50) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_ANNOUNCEMENT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Announcement_Date_link]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Announcement_Date_link](
	[AnnouncementID] [int] NULL,
	[DataID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_ANNOUNCEMENT_DATE_LINK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Bad]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bad](
	[Code] [varchar](50) NULL,
	[DepotID] [int] NULL,
	[BadDate] [datetime] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[UserID] [int] NULL,
	[Note] [nvarchar](500) NULL,
	[EditID] [varchar](50) NULL,
	[ApproveState] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [datetime] NULL,
	[IsDel] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_Bad] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BadDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BadDetail](
	[BadID] [int] NULL,
	[ProductID] [int] NULL,
	[Price] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[Amount] [decimal](18, 2) NULL,
	[Note] [nvarchar](200) NULL,
	[BzPrice] [decimal](18, 2) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_BadDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Balance]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Balance](
	[Code] [varchar](100) NULL,
	[ClientID] [int] NULL,
	[OpUserName] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[BillCode] [nvarchar](100) NULL,
	[RealMoney] [decimal](18, 2) NULL,
	[BeforehandMoney] [decimal](18, 2) NULL,
	[UseBeforehand] [int] NULL,
	[UserID] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[ApproveState] [int] NULL,
	[IsDel] [int] NULL,
	[EditID] [varchar](50) NULL,
	[Note] [nvarchar](500) NULL,
	[IsUsed] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_BALANCE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BalanceAccountDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BalanceAccountDetail](
	[AccountID] [int] NULL,
	[RealMoney] [decimal](18, 2) NULL,
	[BalanceID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_BALANCEACCOUNTDETAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BalanceExpenseDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BalanceExpenseDetail](
	[Type] [int] NULL,
	[Money] [decimal](18, 2) NULL,
	[BalanceID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_BALANCEEXPENSEDETAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BalanceSaleDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BalanceSaleDetail](
	[BalanceID] [int] NULL,
	[AccountBillID] [int] NULL,
	[BalanceMoney] [decimal](18, 2) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_BALANCESALEDETAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Beforehand]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Beforehand](
	[Code] [varchar](200) NULL,
	[ClientID] [int] NULL,
	[OpUserName] [nvarchar](50) NULL,
	[OpDate] [date] NULL,
	[UserID] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[ApproveState] [int] NULL,
	[IsDel] [int] NULL,
	[EditID] [varchar](50) NULL,
	[Note] [nvarchar](500) NULL,
	[Money] [decimal](18, 2) NULL,
	[BalanceID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_BEFOREHAND] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BeforehandDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BeforehandDetail](
	[BeforehandID] [int] NULL,
	[AccountID] [int] NULL,
	[Money] [decimal](18, 2) NULL,
	[BillCode] [nvarchar](100) NULL,
	[Note] [nvarchar](500) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_BEFOREHANDDETAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Bom]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bom](
	[Code] [varchar](100) NULL,
	[Name] [nvarchar](200) NULL,
	[ProductID] [int] NULL,
	[Amount] [decimal](18, 0) NULL,
	[Note] [nvarchar](500) NULL,
	[State] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModfiyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[IsDel] [int] NULL,
	[Price] [decimal](18, 2) NULL,
	[EditID] [varchar](50) NULL,
	[ApproveState] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_BOM] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BomDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BomDetail](
	[BomID] [int] NULL,
	[ProductID] [int] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_BOMDETAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BusinessActivity]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BusinessActivity](
	[Code] [varchar](50) NULL,
	[Name] [nvarchar](200) NULL,
	[Contents] [text] NULL,
	[ActivityDate] [datetime] NULL,
	[InputUser] [int] NULL,
	[InputDate] [datetime] NULL,
	[ApproveState] [int] NULL,
	[ApproveUser] [int] NULL,
	[ApprpveDate] [datetime] NULL,
	[IsDel] [int] NULL,
	[EditID] [varchar](50) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_BUSINESSACTIVITY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BusinessActivityData]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BusinessActivityData](
	[BusinessActivityID] [int] NULL,
	[DataID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_BUSINESSACTIVITY_DATA_LINK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Check]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Check](
	[Code] [varchar](50) NULL,
	[CheckDate] [datetime] NULL,
	[DepotID] [int] NULL,
	[UserID] [int] NULL,
	[Note] [nvarchar](500) NULL,
	[EditID] [varchar](50) NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[IsDel] [int] NULL,
	[ApproveState] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_Check] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CheckDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheckDetail](
	[CheckID] [int] NULL,
	[ProductID] [int] NULL,
	[CheckCount] [decimal](18, 2) NULL,
	[AccountCount] [decimal](18, 2) NULL,
	[CheckMoney] [decimal](18, 2) NULL,
	[Note] [nvarchar](100) NULL,
	[Price] [decimal](18, 2) NULL,
	[Amount] [decimal](18, 2) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_CheckDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Client]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Client](
	[Name] [nvarchar](100) NULL,
	[Code] [varchar](100) NULL,
	[UserID] [int] NULL,
	[DeliveryAddress] [nvarchar](500) NULL,
	[DutyName] [nvarchar](100) NULL,
	[DutyID] [nvarchar](100) NULL,
	[RegisterAddress] [nvarchar](200) NULL,
	[RegisterPhone] [nvarchar](50) NULL,
	[Bank] [nvarchar](50) NULL,
	[BankAccount] [varchar](100) NULL,
	[OwnerName] [nvarchar](100) NULL,
	[OwnerPhone] [varchar](100) NULL,
	[CompanyPhone] [varchar](100) NULL,
	[CompanyAddress] [nvarchar](200) NULL,
	[CreditTerm] [int] NULL,
	[CreditLevel] [int] NULL,
	[CreditLimit] [nvarchar](100) NULL,
	[BalanceDate] [int] NULL,
	[ReceiptDate] [int] NULL,
	[PriceType] [int] NULL,
	[PayCondition] [nvarchar](200) NULL,
	[MarketType] [int] NULL,
	[DependencyType] [int] NULL,
	[DependencyName] [int] NULL,
	[ClientType] [int] NULL,
	[Note] [nvarchar](500) NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[State] [int] NULL,
	[IsDel] [int] NULL,
	[Web] [varchar](350) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_CLIENT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClientAccount]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientAccount](
	[OpType] [int] NULL,
	[OpCode] [nvarchar](200) NULL,
	[OpID] [int] NULL,
	[Money] [decimal](18, 2) NULL,
	[Date] [date] NULL,
	[UserID] [int] NULL,
	[ClientID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_CLIENTACCOUNT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CommInOutDepot]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CommInOutDepot](
	[Code] [varchar](100) NULL,
	[ClientID] [int] NULL,
	[DepotID] [int] NOT NULL,
	[UserID] [int] NULL,
	[DepotDate] [datetime] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[State] [int] NULL,
	[IsDel] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[ApproveState] [int] NULL,
	[EditID] [varchar](50) NULL,
	[Type] [int] NULL,
	[Note] [nvarchar](500) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_CommInOutDepot] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CommInOutDepotDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommInOutDepotDetail](
	[CommInOutDepotID] [int] NULL,
	[ProductID] [int] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[Note] [nvarchar](500) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_CommInOutDepotDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Commission]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Commission](
	[Name] [nvarchar](200) NULL,
	[BillID] [int] NULL,
	[BillCode] [varchar](50) NULL,
	[Url] [varchar](200) NULL,
	[IsRead] [int] NULL,
	[PermissionsCode] [varchar](50) NULL,
	[CreateUser] [int] NULL,
	[CreateDate] [datetime] NULL,
	[ReadUser] [int] NULL,
	[ReadDate] [datetime] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_Commission] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Consignment]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Consignment](
	[Code] [varchar](100) NULL,
	[ExpressID] [int] NULL,
	[SaleID] [nvarchar](500) NULL,
	[SendDate] [datetime] NULL,
	[AnticipateArriveDate] [datetime] NULL,
	[UserID] [int] NULL,
	[SendPlace] [nvarchar](200) NULL,
	[InputUserID] [int] NULL,
	[InputDate] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [datetime] NULL,
	[IsDel] [int] NULL,
	[Note] [nvarchar](500) NULL,
	[ExpressCode] [nvarchar](100) NULL,
	[EditID] [nchar](50) NULL,
	[SaleCode] [nvarchar](500) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_CONSIGNMENT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CustomSN]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomSN](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Number] [int] NULL,
	[Date] [int] NULL,
	[Type] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Data]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Data](
	[Code] [varchar](50) NULL,
	[Name] [nvarchar](300) NULL,
	[Path] [nvarchar](500) NULL,
	[DataType] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[State] [int] NULL,
	[IsDel] [int] NULL,
	[ApproveState] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_DATA] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Depot]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Depot](
	[Code] [varchar](100) NULL,
	[Name] [nvarchar](100) NULL,
	[UserID] [int] NULL,
	[Phone] [varchar](100) NULL,
	[Address] [nvarchar](300) NULL,
	[Note] [nvarchar](500) NULL,
	[State] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [datetime] NULL,
	[IsDel] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_DEPOT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Dept]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Dept](
	[Code] [varchar](50) NULL,
	[ParentID] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[State] [int] NULL,
	[Sort] [int] NULL,
	[Level] [int] NULL,
	[UserID] [int] NULL,
	[Note] [nvarchar](500) NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[IsDel] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_DEPT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Dictionary]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Dictionary](
	[Type] [int] NULL,
	[Code] [varchar](100) NULL,
	[Name] [nvarchar](200) NULL,
	[State] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_DICTIONARYDATA] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Email]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Email](
	[UserID] [int] NULL,
	[Title] [nvarchar](200) NULL,
	[Contents] [text] NULL,
	[SendDate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[Status] [int] NULL,
	[IsDel] [int] NULL,
	[EditID] [varchar](50) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_EMAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Email_User_Link]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Email_User_Link](
	[EmailID] [int] NULL,
	[UserID] [int] NULL,
	[IsDel] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_EMAIL_USER_LINK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmailAttachment]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailAttachment](
	[EmailID] [int] NULL,
	[Name] [nvarchar](200) NULL,
	[Path] [nvarchar](500) NULL,
	[UpLoadDate] [datetime] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_EMAILATTACHMENT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Express]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Express](
	[Code] [varchar](100) NULL,
	[Name] [nvarchar](200) NULL,
	[Phone] [nvarchar](50) NULL,
	[UserName] [nvarchar](50) NULL,
	[UserPhone] [nvarchar](50) NULL,
	[TakeType] [int] NULL,
	[TakePlace] [nvarchar](200) NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[IsDel] [int] NULL,
	[Note] [nvarchar](500) NULL,
	[SystemPath] [varchar](1000) NULL,
	[QueryUrl] [nvarchar](1000) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_EXPRESS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ExpressState]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ExpressState](
	[Code] [varchar](100) NULL,
	[ConsignmentID] [int] NULL,
	[StateType] [int] NULL,
	[OpDate] [datetime] NULL,
	[UserID] [int] NULL,
	[IsDel] [int] NULL,
	[Note] [nvarchar](500) NULL,
	[EditID] [varchar](50) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_EXPRESSSTATE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ExpressStateLog]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExpressStateLog](
	[ExpressStateID] [int] NULL,
	[OpDate] [datetime] NULL,
	[StateType] [int] NULL,
	[UserID] [int] NULL,
	[Note] [nvarchar](200) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_ExpressStateLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Functions]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Functions](
	[ParentID] [int] NULL,
	[FuncName] [nvarchar](100) NULL,
	[FuncCode] [varchar](100) NULL,
	[State] [int] NULL,
	[Level] [int] NULL,
	[UrlPath] [varchar](500) NULL,
	[Sort] [int] NULL,
	[ImagePath] [varchar](100) NULL,
	[IconName] [varchar](50) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_FUNCTIONS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InOutDepot]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InOutDepot](
	[Code] [varchar](100) NULL,
	[BillID] [int] NULL,
	[BillType] [int] NULL,
	[OpDate] [datetime] NULL,
	[UserID] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[ApproveState] [int] NULL,
	[IsDel] [int] NULL,
	[Note] [nvarchar](500) NULL,
	[IsChange] [int] NULL,
	[UniqueID] [nvarchar](50) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_INOUTDEPOT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Lend]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Lend](
	[Code] [varchar](50) NULL,
	[ClientID] [int] NULL,
	[DeliveryType] [int] NULL,
	[LendType] [int] NULL,
	[DepotID] [int] NULL,
	[Address] [nvarchar](200) NULL,
	[BuyDate] [date] NULL,
	[DeliveryDate] [date] NULL,
	[OrderID] [int] NULL,
	[Discount] [decimal](18, 2) NULL,
	[Amount] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[EditID] [varchar](50) NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[IsDel] [int] NULL,
	[ApproveState] [int] NULL,
	[State] [int] NULL,
	[PriceTypeName] [nvarchar](50) NULL,
	[UserName] [nvarchar](50) NULL,
	[IsSend] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_Lend] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LendDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LendDetail](
	[LendID] [int] NULL,
	[IsLargess] [int] NULL,
	[ProductID] [int] NULL,
	[Price] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[Amount] [decimal](18, 2) NULL,
	[RealPrice] [decimal](18, 2) NULL,
	[RealMoney] [decimal](18, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[Discount] [decimal](18, 2) NULL,
	[DepotCount] [int] NULL,
	[PriceTypeName] [nvarchar](50) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_LENDDETAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LendLog]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LendLog](
	[LendID] [int] NULL,
	[ChangeSaleAmount] [decimal](18, 2) NULL,
	[ChangeSaleMoney] [decimal](18, 2) NULL,
	[Amount] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[OpDate] [datetime] NULL,
	[OpUser] [int] NULL,
	[ProductID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_LendLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoginGroup]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginGroup](
	[Name] [nvarchar](50) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_LoginGroup] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoginGroup_User_Link]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginGroup_User_Link](
	[UserID] [int] NOT NULL,
	[LoginGroupID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_LoginGroup_User_Link_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Manufacture]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Manufacture](
	[Code] [varchar](100) NULL,
	[CreateDate] [date] NULL,
	[BomID] [int] NULL,
	[UserID] [int] NULL,
	[OutDepotID] [int] NULL,
	[InDepotID] [int] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[IsDel] [int] NULL,
	[ApproveState] [int] NULL,
	[State] [int] NULL,
	[Note] [nvarchar](500) NULL,
	[ManufacturePH] [nvarchar](50) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_MANUFACTURE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ManufactureDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManufactureDetail](
	[ManufactureID] [int] NULL,
	[ProductID] [int] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_ManufactureDETAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Meeting]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Meeting](
	[Code] [varchar](50) NULL,
	[Name] [nvarchar](200) NULL,
	[MeetingRoomID] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[ApplyUserID] [int] NULL,
	[ApplyDate] [datetime] NULL,
	[ApproveState] [int] NULL,
	[ApproveUserID] [int] NULL,
	[ApproveDate] [datetime] NULL,
	[EditID] [nvarchar](50) NULL,
	[IsDel] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_MEETING] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MeetingUser]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MeetingUser](
	[MeetingID] [int] NULL,
	[UserID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_MEETINGUSER] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OpLog]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpLog](
	[Model] [nvarchar](50) NULL,
	[OpType] [nvarchar](50) NULL,
	[UserID] [int] NULL,
	[OpDate] [datetime] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_OpLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[IsLargess] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_ORDERDETAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Orders](
	[Code] [varchar](100) NULL,
	[ClientID] [int] NULL,
	[UserName] [nvarchar](50) NULL,
	[OpDate] [datetime] NULL,
	[AllAmount] [decimal](18, 0) NULL,
	[AllMoney] [decimal](18, 0) NULL,
	[RealMoney] [decimal](18, 0) NULL,
	[OrderState] [int] NULL,
	[UserID] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[ApproveState] [int] NULL,
	[IsDel] [int] NULL,
	[EditID] [varchar](50) NULL,
	[Note] [nvarchar](500) NULL,
	[ExpressState] [int] NULL,
	[AccountID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_ORDER] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Price]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Price](
	[PriceType] [int] NULL,
	[ProductID] [int] NULL,
	[Model] [nvarchar](300) NULL,
	[Price] [float] NULL,
	[ModifyPrice] [float] NULL,
	[MasterUnit] [int] NULL,
	[LastModifyDate] [date] NULL,
	[ApproveUserID] [int] NULL,
	[ApproveDate] [date] NULL,
	[Note] [nvarchar](500) NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[State] [int] NULL,
	[IsDel] [int] NULL,
	[ApproveState] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_PRICE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[Name] [nvarchar](100) NULL,
	[Code] [varchar](100) NULL,
	[Model] [nvarchar](300) NULL,
	[Area] [nvarchar](50) NULL,
	[BarCode] [varchar](100) NULL,
	[Duty] [decimal](18, 2) NULL,
	[MasterUnit] [int] NULL,
	[AssistUnit] [int] NULL,
	[UnitChange] [decimal](18, 2) NULL,
	[Type] [int] NULL,
	[ProviderID] [int] NULL,
	[DepositPlace] [nvarchar](200) NULL,
	[Note] [nvarchar](500) NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[State] [int] NULL,
	[IsDel] [int] NULL,
	[ImagePath] [varchar](300) NULL,
	[ShortName] [nvarchar](50) NULL,
	[CategoryOne] [int] NULL,
	[CategoryTwo] [int] NULL,
	[DepotID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_PRODUCT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Provider]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Provider](
	[Code] [varchar](100) NULL,
	[Name] [nvarchar](100) NULL,
	[CompanyName] [nvarchar](200) NULL,
	[UserID] [int] NULL,
	[Industry] [nvarchar](100) NULL,
	[DutyID] [varchar](100) NULL,
	[RegisterAddress] [nvarchar](200) NULL,
	[Bank] [nvarchar](50) NULL,
	[BankAccount] [varchar](50) NULL,
	[Web] [nvarchar](200) NULL,
	[ProvideType] [int] NULL,
	[DependencyType] [int] NULL,
	[OwenName] [nvarchar](20) NULL,
	[Phone] [varchar](20) NULL,
	[Address] [nvarchar](200) NULL,
	[PayMode] [nvarchar](200) NULL,
	[Note] [nvarchar](500) NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[State] [int] NULL,
	[IsDel] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_PROVIDER] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Rebate]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Rebate](
	[Code] [varchar](50) NULL,
	[RebateType] [int] NULL,
	[RebateDate] [datetime] NULL,
	[Money] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 4) NULL,
	[Note] [nvarchar](500) NULL,
	[EditID] [varchar](50) NULL,
	[InputUserID] [int] NULL,
	[InputDate] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [datetime] NULL,
	[IsDel] [int] NULL,
	[ApproveState] [int] NULL,
	[ClientID] [int] NULL,
	[BalanceMoney] [decimal](18, 2) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_REBATE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RebateDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RebateDetail](
	[RebateID] [int] NULL,
	[BalanceID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
CONSTRAINT [PK_REBATE_DETAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleName] [nvarchar](50) NULL,
	[State] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_ROLE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role_Func_Link]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role_Func_Link](
	[RoleID] [int] NULL,
	[FuncID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_ROLE_FUNC_LINK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sale]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sale](
	[Code] [varchar](50) NULL,
	[ClientID] [int] NULL,
	[DeliveryType] [int] NULL,
	[SaleType] [int] NULL,
	[DepotID] [int] NULL,
	[Address] [nvarchar](200) NULL,
	[BuyDate] [date] NULL,
	[DeliveryDate] [date] NULL,
	[OrderID] [int] NULL,
	[Discount] [decimal](18, 2) NULL,
	[Amount] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[EditID] [varchar](50) NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[IsDel] [int] NULL,
	[ApproveState] [int] NULL,
	[State] [int] NULL,
	[PriceTypeName] [nvarchar](50) NULL,
	[UserName] [nvarchar](50) NULL,
	[IsSend] [int] NULL,
	[IsChange] [int] NULL,
	[AccountID] [int] NULL,
	[ConsignmentID] [int] NULL,
	[ExpressState] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_SALE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SaleDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleDetail](
	[SaleID] [int] NULL,
	[IsLargess] [int] NULL,
	[ProductID] [int] NULL,
	[Price] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[Amount] [decimal](18, 2) NULL,
	[RealPrice] [decimal](18, 2) NULL,
	[RealMoney] [decimal](18, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[Discount] [decimal](18, 2) NULL,
	[DepotCount] [decimal](18, 2) NULL,
	[PriceTypeName] [nvarchar](50) NULL,
	[BzPrice] [decimal](18, 2) NULL,
	[BzDiscount] [decimal](18, 2) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_SALEDETAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SaleInvoice]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SaleInvoice](
	[Code] [varchar](200) NULL,
	[ClientID] [int] NULL,
	[OpUserName] [nvarchar](50) NULL,
	[OpDate] [date] NULL,
	[InvoiceType] [int] NULL,
	[NoDutyMoney] [decimal](18, 2) NULL,
	[Duty] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[BalanceState] [int] NULL,
	[UserID] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[ApproveState] [int] NULL,
	[IsDel] [int] NULL,
	[EditID] [varchar](50) NULL,
	[Note] [nvarchar](500) NULL,
	[BillCode] [nvarchar](200) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_SALEINVOICE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SaleInvoiceDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleInvoiceDetail](
	[SaleInvoiceID] [int] NOT NULL,
	[SaleID] [int] NULL,
	[BillType] [int] NULL,
	[BillDate] [date] NULL,
	[Money] [decimal](18, 2) NULL,
	[BillCode] [nvarchar](200) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_SALEINVOICEDETAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SaleReturn]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SaleReturn](
	[Code] [varchar](100) NULL,
	[ClientID] [int] NULL,
	[DepotID] [int] NULL,
	[SaleType] [int] NULL,
	[OpUserName] [nvarchar](50) NULL,
	[InDepotDate] [date] NULL,
	[Address] [nvarchar](200) NULL,
	[Amount] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[UserID] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[ApproveState] [int] NULL,
	[IsDel] [int] NULL,
	[EditID] [varchar](50) NULL,
	[Note] [nvarchar](500) NULL,
	[PriceTypeName] [nvarchar](50) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_SALERETURN] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SaleReturnDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleReturnDetail](
	[SaleReturnID] [int] NOT NULL,
	[ProductID] [int] NULL,
	[Amount] [decimal](18, 0) NULL,
	[Money] [decimal](18, 0) NULL,
	[BillCode] [nvarchar](500) NULL,
	[PriceTypeName] [nvarchar](50) NULL,
	[Price] [decimal](18, 2) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_SALERETURNDETAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Service]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Service](
	[Code] [varchar](50) NULL,
	[ClientID] [int] NULL,
	[Title] [nvarchar](300) NULL,
	[Contents] [text] NULL,
	[InputDate] [datetime] NULL,
	[IsRevert] [int] NULL,
	[RevertContents] [text] NULL,
	[RevertDate] [datetime] NULL,
	[UserID] [int] NULL,
	[IsDel] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_SERVICE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SMS]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SMS](
	[Code] [varchar](50) NULL,
	[Message] [nvarchar](1000) NULL,
	[UserID] [int] NULL,
	[CreateDate] [datetime] NULL,
	[ErrorInfo] [nvarchar](1000) NULL,
	[OpType] [int] NULL,
	[CreateType] [int] NULL,
	[Address] [varchar](20) NULL,
	[SendDate] [datetime] NULL,
	[Status] [int] NULL,
	[IsDel] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_SMS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Stock]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Stock](
	[Code] [varchar](100) NULL,
	[ProviderID] [int] NULL,
	[BespeakDate] [date] NULL,
	[ForecastDate] [date] NULL,
	[InDepotCode] [varchar](100) NULL,
	[DepotID] [int] NULL,
	[UserID] [int] NULL,
	[StockType] [int] NULL,
	[ConveyanceType] [int] NULL,
	[PayNote] [nvarchar](500) NULL,
	[Note] [nvarchar](500) NULL,
	[ProductState] [int] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[State] [int] NULL,
	[IsDel] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[ApproveState] [int] NULL,
	[EditID] [varchar](50) NULL,
	[InDepot] [int] NULL,
	[InDepotDate] [date] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_STOCK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StockDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockDetail](
	[StockID] [int] NULL,
	[ProductID] [int] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[AlreadyArrive] [decimal](18, 0) NULL,
	[NoDutyMoney] [decimal](18, 2) NULL,
	[NoDutyPrice] [decimal](18, 2) NULL,
	[Duty] [decimal](18, 2) NULL,
	[StockType] [nvarchar](50) NULL,
	[StockTax] [decimal](18, 2) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_STOCKDETAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StorageAccount]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StorageAccount](
	[DepotID] [int] NULL,
	[ProductID] [int] NULL,
	[BillID] [nvarchar](200) NULL,
	[UserID] [int] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[OpType] [int] NULL,
	[OpSource] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[IsUsed] [int] NULL,
	[IsDel] [int] NULL,
	[UniqueID] [nvarchar](50) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_STORAGEACCOUNT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StorageAccountTotal]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StorageAccountTotal](
	[DepotID] [int] NULL,
	[ProductID] [int] NULL,
	[UserID] [int] NULL,
	[OpDate] [date] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[IsUsed] [int] NULL,
	[IsDel] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_STORAGEACCOUNTTOTAL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SysLog]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysLog](
	[ShortMessage] [nvarchar](512) NOT NULL,
	[FullMessage] [nvarchar](max) NULL,
	[IpAddress] [nvarchar](32) NOT NULL,
	[PageUrl] [nvarchar](256) NOT NULL,
	[ReferrerUrl] [nvarchar](256) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[LogLevelID] [int] NOT NULL,
	[UserID] [nvarchar](36) NULL,
	[UserName] [nvarchar](64) NULL,
	[LoggerName] [nvarchar](64) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_SysLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Task]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Task](
	[Code] [varchar](50) NULL,
	[TaskType] [int] NULL,
	[Title] [nvarchar](200) NULL,
	[Contents] [nvarchar](1000) NULL,
	[Date] [date] NULL,
	[TaskState] [int] NULL,
	[Note] [nvarchar](200) NULL,
	[NextUserID] [int] NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[IsDel] [int] NULL,
	[EditID] [nvarchar](50) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_TASK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TaskOpDetail]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskOpDetail](
	[TaskID] [int] NULL,
	[UserID] [int] NULL,
	[OpDate] [date] NULL,
	[OpType] [int] NULL,
	[Contents] [nvarchar](500) NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_TASKOPDETAIL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TestTable]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestTable](
	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_TestTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Todo]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Todo](
	[Code] [varchar](100) NULL,
	[Title] [nvarchar](200) NULL,
	[OpUrl] [varchar](300) NULL,
	[CreateDate] [datetime] NULL,
	[Status] [int] NULL,
	[IsDel] [int] NULL,
	[UserID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_TODO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Todo_Data_Link]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Todo_Data_Link](
	[TodoID] [int] NULL,
	[DataID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_Todo_Data_Link] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User_Role_Link]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Role_Link](
	[UserID] [int] NULL,
	[RoleID] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_USER_ROLE_LINK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[USERS]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[USERS](
	[Code] [varchar](100) NULL,
	[UserName] [nvarchar](100) NULL,
	[DeptID] [int] NULL,
	[Password] [varchar](50) NULL,
	[State] [int] NULL,
	[Sort] [int] NULL,
	[Headship] [nvarchar](100) NULL,
	[Sex] [int] NULL,
	[Birthday] [date] NULL,
	[JoinDate] [date] NULL,
	[CardID] [varchar](50) NULL,
	[Attribute] [nvarchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Mobile] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Address] [nvarchar](500) NULL,
	[Note] [nvarchar](1000) NULL,
	[InputUserID] [int] NULL,
	[InputDate] [date] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyDate] [date] NULL,
	[Market] [int] NULL,
	[IsDel] [int] NULL,
	[ClientID] [int] NULL,
	[IsClient] [int] NULL,
	[LoginName] [nvarchar](50) NULL,
	[IsSuper] [int] NULL,

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
 CONSTRAINT [PK_USERS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WebOption]    Script Date: 2015/5/21 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WebOption](
	[SetKey] [varchar](50) NULL,
	[SetName] [nvarchar](50) NULL,
	[SetValue] [nvarchar](500) NULL

	[ID] [nvarchar](50) NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[Modified] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
USE [master]
GO
ALTER DATABASE [EPSMSTEST] SET  READ_WRITE 
GO
