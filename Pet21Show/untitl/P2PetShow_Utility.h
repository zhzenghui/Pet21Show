//
//  P2PetShow.h
//  Pet21Show
//
//  Created by zeng on 12-8-13.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

//hand
typedef enum{
	EIHeldHandLeft = 0,
	EIHeldHandRight
}EIHeldHand;
EIHeldHand heldhand;


/**
 *	EI_SERVER_ACTIONS
 *	Communication with EWS
 */
typedef struct _SYNC_SERVER_PACKET_RECORD {
	UIProgressView *progressIndicator;
	SEL setRequestDidFinishSelector;
	SEL setRequestDidFailSelector;
	id delegate;
	NSString *dbPath;
	int action;
    id dataDict;
} SYNC_SERVER_PACKET_RECORD;


typedef enum _EI_IP_ACTIONS
{
    EI_IP_ACTION_SYNC_SERVER = 1,
    EI_IP_ACTION_UPDATE_INVOICE = 2,
    EI_IP_ACTION_ADD_NEW_INVOICE = 3
}EI_IP_ACTIONS;


/**
 *	EI_SERVER_ACTIONS
 *	Communication with EWS
 */
typedef enum _SERVER_ACTIONS
{
//    EI_SERVER_ACTIONS_GETHANDHELDID = 1,
//    EI_SERVER_ACTIONS_GETSETTINGS = 2,
//    EI_SERVER_ACTIONS_PREPAREDB_ONSERVER = 3,
//    EI_SERVER_ACTIONS_DOWNLOADDB = 4,
//    EI_SERVER_ACTIONS_IMPORT = 5,
//    EI_SERVER_ACTIONS_FINISHEDEXPORT = 6,
//    EI_SERVER_ACTIONS_CHECKUPDAE = 7,
//    EI_SERVER_ACTIONS_UPDAE = 8,
//    SurveyList = 9,
//    GetSurveyQuestions = 10,
//    SaveSurveys = 11,
//    EI_SERVER_ACTIONS_DOWNLOAD_LOADSHEETS = 12,
//    EI_SERVER_ACTIONS_LSLIST = 13,
//    EI_SERVER_ACTIONS_USERLIST = 14,
//    EI_SERVER_ACTIONS_MAIL_WITHDB = 15,
//    EI_SERVER_ACTIONS_DBLIST = 16,
//    EI_SERVER_ACTIONS_RESTOREDB = 17,
//    EI_SERVER_ACTIONS_CHANGE_PASSWORD = 18,
//    EI_SERVER_ACTIONS_USER_ROLE = 19,
//    EI_SERVER_ACTIONS_UPLOAD_LOGS = 20,
//    EI_SERVER_ACTIONS_UPLOAD_IMAGES = 21,
    
    SERVER_ACTIONS_ADDUSER = 22,
    SERVER_ACTIONS_UPDATEUSER = 23,
    SERVER_ACTIONS_LOGINUSER = 24,
    SERVER_ACTIONS_CHECKUSERNAME = 25,
    SERVER_ACTIONS_CHECKEMAIL = 26,
    

    SERVER_ACTIONS_STATUES = 27,
    SERVER_ACTIONS_ADDSTATUES = 28,
    
    
    SERVER_ACTIONS_UPLOADIMAGE = 40,
    
    
    SERVER_ACTIONS_ADDONLINE = 41,
    SERVER_ACTIONS_GETONLINE = 42,
    
    
    
    
}EI_SERVER_ACTIONS;



typedef enum _SyncStep
{
    /// <summary>
    /// 0, No step
    /// </summary>
    SyncStep_None = 0,
    
    /// <summary>
    /// 1, Sync with server
    /// </summary>
    SyncStep_SyncOnly = 1,
    
    /// <summary>
    /// 2, Download loadsheets
    /// </summary>
    SyncStep_DownloadLoadSheet = 2,
    
    /// <summary>
    /// 3, Password has expired, set new password
    /// </summary>
    SyncStep_ChangePassword = 3,
    
    SyncStep_ChangePasswordAndDownloadLoadSheet = 4,
    
    SyncStep_Start_DownloadLoadSheet = 5,
    
    SyncStep_DeleteAllCurrentData = 6,
    
    SyncStep_UploadDataBase = 7,
    
    SyncStep_RestoreDataBase = 8,
    
    SyncStep_ForceUpgrade = 9,
    
    SyncStep_DownloadCustomers = 10
}SyncStep;


typedef struct _CUSTOMER_DATA_PACKET {
	NSString *CustomerID;
	NSString *CustomerNum;
	NSString *Company;
	NSString *Address;
	NSString *City;
	NSString *State;
	NSString *PostalCode;
	NSString *Contact;
	NSString *Phone;
	NSString *StateLicenseNum;
	NSString *LicenseExpDate;
	NSString *AROnInvoice;
	NSString *DiscountsOnInvoice;
	NSString *Memo;
	NSString *Active;
	NSString *Edited;
	NSString *UserName;
	NSString *TerritoryID;
	NSString *ProductGroupID;
	NSString *AreaID;
	NSString *TaxAreaID;
	NSString *DepositAreaID;
	NSString *TermID;
	NSString *RequireSignature;
	NSString *InvoiceSequence;
	
} CUSTOMER_DATA_PACKET;

//[SQL appendString:customerPacket->CustomerID];
//			struct _CUSTOMER_DATA_PACKET *newCustomer=(struct _CUSTOMER_DATA_PACKET *)malloc(sizeof(struct _CUSTOMER_DATA_PACKET));
//			newCustomer->CustomerNum=_CustomerNum ;

//app info
#define EiPhone_Ver		  @"1.000"
#define EiPhone_App_Name  @"LifeLine"

#define EiPhone_DB_NAME   @"MainDB.db"

#define strSplitRow       @"|"
#define strSplitCol       @"~"
#define strSplitTable     @"=====-----====="

//links
#define ServerDataProcessFile @"EiPhoneDataProcess21.aspx"

#define Server_Url @"http://127.0.0.1:8000/"

//weibo
#define kWBSDKDemoAppKey @"2211441265"
#define kWBSDKDemoAppSecret @"f7f9dc3a88cc93bc819b92a127d7d2f5"

#define kDOUBANSDKDemoAppKey @"2211441265"
#define kDOUBANSDKDemoAppSecret @"f7f9dc3a88cc93bc819b92a127d7d2f5"

#pragma mark Color
#define color(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define COOKBOOK_PURPLE_COLOR	[UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define BARBUTTON(TITLE, SELECTOR) 	[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

#define BARBUTTONMORE(TITLE, UIBarButtonItemStyle,SELECTOR) 	[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStyle target:self action:SELECTOR]
#define alertShow(title, message, cancelString) [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];



#define RADIUS   12



#import "Common.h"


