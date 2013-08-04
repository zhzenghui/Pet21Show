//
//  P2AddUserViewController.m
//  PetShows
//
//  Created by zeng on 12-8-10.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "P2AddUserViewController.h"

#import "untitl/DataProcess.h"
#import "ASIH/ASIHTTPRequest.h"

#import "KeychainItemWrapper.h"
#import <QuartzCore/QuartzCore.h>


@interface P2AddUserViewController ()



//---------------mainview-------------------//

@property(nonatomic, retain) IBOutlet UIButton *loginButton;
@property(nonatomic, retain) IBOutlet UIButton *joinButton;
@property(nonatomic, retain) IBOutlet UIButton *loginView_loginButton;


- (IBAction)login:(id)sender;
- (IBAction)join:(id)sender;


//----------------------------------//
//---------------loginView-------------------//
//----------------------------------//

@property(nonatomic, retain) IBOutlet UIView *loginView;
@property(nonatomic, retain) IBOutlet UITextField *loginView_emailField;
@property(nonatomic, retain) IBOutlet UITextField *loginView_passwordField;


- (IBAction)loginMethd:(id)sender;
- (IBAction)resetPassword:(id)sender;

//----------------------------------//
//----------------joinView------------------//
//----------------------------------//
@property(nonatomic, retain) IBOutlet UIView *joinView;

//----------------------------------//
//----------------createView------------------//
//----------------------------------//
@property(nonatomic, retain) IBOutlet UIView *createView;
@property(nonatomic, retain) IBOutlet UITextField *createView_nameField;
@property(nonatomic, retain) IBOutlet UITextField *createView_emailField;
@property(nonatomic, retain) IBOutlet UITextField *createView_passwordField;

@end

@implementation P2AddUserViewController
@synthesize loginButton;
@synthesize joinButton;
@synthesize loginView;
@synthesize joinView;

@synthesize loginView_emailField;
@synthesize loginView_passwordField;


@synthesize createView;
@synthesize createView_emailField;
@synthesize createView_nameField;
@synthesize createView_passwordField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (BOOL)validateEmail:(NSString *)inputText {
    NSString *emailRegex = @"[A-Z0-9a-z][A-Z0-9a-z._%+-]*@[A-Za-z0-9][A-Za-z0-9.-]*\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSRange aRange;
    if([emailTest evaluateWithObject:inputText]) {
        aRange = [inputText rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, [inputText length])];
        int indexOfDot = aRange.location;
        //NSLog(@"aRange.location:%d - %d",aRange.location, indexOfDot);
        if(aRange.location != NSNotFound) {
            NSString *topLevelDomain = [inputText substringFromIndex:indexOfDot];
            topLevelDomain = [topLevelDomain lowercaseString];
            //NSLog(@"topleveldomains:%@",topLevelDomain);
            NSSet *TLD;
            TLD = [NSSet setWithObjects:@".aero", @".asia", @".biz", @".cat", @".com", @".coop", @".edu", @".gov", @".info", @".int", @".jobs", @".mil", @".mobi", @".museum", @".name", @".net", @".org", @".pro", @".tel", @".travel", @".ac", @".ad", @".ae", @".af", @".ag", @".ai", @".al", @".am", @".an", @".ao", @".aq", @".ar", @".as", @".at", @".au", @".aw", @".ax", @".az", @".ba", @".bb", @".bd", @".be", @".bf", @".bg", @".bh", @".bi", @".bj", @".bm", @".bn", @".bo", @".br", @".bs", @".bt", @".bv", @".bw", @".by", @".bz", @".ca", @".cc", @".cd", @".cf", @".cg", @".ch", @".ci", @".ck", @".cl", @".cm", @".cn", @".co", @".cr", @".cu", @".cv", @".cx", @".cy", @".cz", @".de", @".dj", @".dk", @".dm", @".do", @".dz", @".ec", @".ee", @".eg", @".er", @".es", @".et", @".eu", @".fi", @".fj", @".fk", @".fm", @".fo", @".fr", @".ga", @".gb", @".gd", @".ge", @".gf", @".gg", @".gh", @".gi", @".gl", @".gm", @".gn", @".gp", @".gq", @".gr", @".gs", @".gt", @".gu", @".gw", @".gy", @".hk", @".hm", @".hn", @".hr", @".ht", @".hu", @".id", @".ie", @" No", @".il", @".im", @".in", @".io", @".iq", @".ir", @".is", @".it", @".je", @".jm", @".jo", @".jp", @".ke", @".kg", @".kh", @".ki", @".km", @".kn", @".kp", @".kr", @".kw", @".ky", @".kz", @".la", @".lb", @".lc", @".li", @".lk", @".lr", @".ls", @".lt", @".lu", @".lv", @".ly", @".ma", @".mc", @".md", @".me", @".mg", @".mh", @".mk", @".ml", @".mm", @".mn", @".mo", @".mp", @".mq", @".mr", @".ms", @".mt", @".mu", @".mv", @".mw", @".mx", @".my", @".mz", @".na", @".nc", @".ne", @".nf", @".ng", @".ni", @".nl", @".no", @".np", @".nr", @".nu", @".nz", @".om", @".pa", @".pe", @".pf", @".pg", @".ph", @".pk", @".pl", @".pm", @".pn", @".pr", @".ps", @".pt", @".pw", @".py", @".qa", @".re", @".ro", @".rs", @".ru", @".rw", @".sa", @".sb", @".sc", @".sd", @".se", @".sg", @".sh", @".si", @".sj", @".sk", @".sl", @".sm", @".sn", @".so", @".sr", @".st", @".su", @".sv", @".sy", @".sz", @".tc", @".td", @".tf", @".tg", @".th", @".tj", @".tk", @".tl", @".tm", @".tn", @".to", @".tp", @".tr", @".tt", @".tv", @".tw", @".tz", @".ua", @".ug", @".uk", @".us", @".uy", @".uz", @".va", @".vc", @".ve", @".vg", @".vi", @".vn", @".vu", @".wf", @".ws", @".ye", @".yt", @".za", @".zm", @".zw", nil];
            if(topLevelDomain != nil && ([TLD containsObject:topLevelDomain])) {
                //NSLog(@"TLD contains topLevelDomain:%@",topLevelDomain);
                return TRUE;
            }
            /*else {
             NSLog(@"TLD DOEST NOT contains topLevelDomain:%@",topLevelDomain);
             }*/
            
        }
    }
    return FALSE;
}

#pragma mark - coumter method

- (void)backRootView:(id)sender
{
}

- (IBAction)login:(id)sender
{
    [self loadLoginView];
    
}

- (IBAction)join:(id)sender
{
    [self loadJoinView];
}

- (void)loadLoginView
{

    ei_userview_statue = EI_USERVIEW_STATUE_LOGIN;
    [self.view addSubview:loginView];
}

- (void)loadJoinView
{
    ei_userview_statue = EI_USERVIEW_STATUE_CRATE;
    
    [createView_nameField becomeFirstResponder];
    [self.view addSubview:createView];
}

- (IBAction)createUser:(id)sender {
    [myTextField resignFirstResponder];
    
    
}

#pragma mark loginView customers

- (IBAction)loginMethd:(id)sender {
    
    if (YES) {
     
        KeychainItemWrapper *wrapper  = [[KeychainItemWrapper alloc] initWithIdentifier:@"Account Number"accessGroup:@"boniu.com.boli.AppIdentifier"];
        
        self.title = [wrapper objectForKey:(id)kSecValueData];
        [wrapper setObject:loginView_emailField.text forKey:(id)kSecAttrAccount];
        [wrapper setObject:loginView_passwordField.text forKey:(id)kSecValueData];
    }
    
}

- (IBAction)resetPassword:(id)sender{
    
}


#pragma mark - view cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    errors = [[NSMutableDictionary alloc] init];
    
    [loginButton setTitle:NSLocalizedString(@"login", nil) forState:UIControlStateNormal];
    [joinButton setTitle:NSLocalizedString(@"join", nil) forState:UIControlStateNormal];

//    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Prout" style:UIBarButtonItemStyleDone target:nil action:nil] autorelease];
//    self.navigationItem.hidesBackButton = YES;
    
//    self.navigationController.navigationBarHidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    
    [super dealloc];
}

#pragma mark -
#pragma mark netWork

- (void)getCallBack:(ASIHTTPRequest *)request{
    switch (ei_userview_statue ) {
        case EI_USERVIEW_STATUE_CRATE:
        {
            NSLog(@"%@", request.responseString);
            
            bool isVerify = [request.responseString intValue];

            switch (ei_network) {
                case EI_NETWORK_CHECKEMAIL:
                {
                    if (isVerify) {
                        createView_emailField.layer.borderColor = [[UIColor greenColor] CGColor];
                    }
                    else {
                        createView_emailField.layer.borderColor = [[UIColor redColor] CGColor];
                    }

                    break;
                }
                case EI_NETWORK_CHECKEUSERNAME:
                {
                    if (isVerify) {
                        createView_nameField.layer.borderColor = [[UIColor greenColor] CGColor];

                    }
                    else {
                        createView_nameField.layer.borderColor = [[UIColor redColor] CGColor];
                    }
                    break;
                }
                default:
                    break;
            }

            break;
        }
        case EI_USERVIEW_STATUE_LOGIN:
        {
            
            break;
        }
        default:
            break;
    }
}


- (void)checkusername:(NSString *)username{

    ei_network = EI_NETWORK_CHECKEUSERNAME;
    
    NSDictionary *userDict = [NSDictionary dictionaryWithObjectsAndKeys:username, @"username", nil];
    [Session setSession:@"vuser" value:userDict];

    
	struct _SYNC_SERVER_PACKET_RECORD *P_SYNC_SERVER_PACKET_RECORD = (struct _SYNC_SERVER_PACKET_RECORD *)malloc(sizeof(struct _SYNC_SERVER_PACKET_RECORD));

	P_SYNC_SERVER_PACKET_RECORD -> delegate = self;
	P_SYNC_SERVER_PACKET_RECORD -> progressIndicator = nil;
	P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFinishSelector = @selector(getCallBack:);
	P_SYNC_SERVER_PACKET_RECORD -> action = SERVER_ACTIONS_CHECKUSERNAME;
	P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFailSelector = @selector(getCallBack:);


    DataProcess *myDataProcess = [[DataProcess alloc] init];
    //add user
    [myDataProcess SyncServer:SERVER_ACTIONS_CHECKUSERNAME syncServerPackedRecord:P_SYNC_SERVER_PACKET_RECORD];
}

- (void)checkemail:(NSString *)email {
    
    ei_network = EI_NETWORK_CHECKEMAIL;

    NSDictionary *userDict = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", nil];
    [Session setSession:@"vuser" value:userDict];

    
	struct _SYNC_SERVER_PACKET_RECORD *P_SYNC_SERVER_PACKET_RECORD = (struct _SYNC_SERVER_PACKET_RECORD *)malloc(sizeof(struct _SYNC_SERVER_PACKET_RECORD));
    
	P_SYNC_SERVER_PACKET_RECORD -> delegate = self;
	P_SYNC_SERVER_PACKET_RECORD -> progressIndicator = nil;
	P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFinishSelector = @selector(getCallBack:);
	P_SYNC_SERVER_PACKET_RECORD -> action = SERVER_ACTIONS_CHECKEMAIL;
	P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFailSelector = @selector(getCallBack:);
    
    
    DataProcess *myDataProcess = [[DataProcess alloc] init];
    //add user
    [myDataProcess SyncServer:SERVER_ACTIONS_CHECKEMAIL syncServerPackedRecord:P_SYNC_SERVER_PACKET_RECORD];
    
}


#pragma mark -
#pragma mark textfidld

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    myTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        textField.layer.borderWidth= 1.0f;

        textField.layer.borderColor = [[UIColor redColor] CGColor];
        
        return;
    }
    
    if (ei_userview_statue == EI_USERVIEW_STATUE_CRATE) {
        textField.layer.borderWidth= 1.0f;

        if (textField == createView_nameField)
        {
            [self checkusername:textField.text];
        }
        else if (textField == createView_emailField)
        {
            if  ([self validateEmail:createView_emailField.text]) {
                [self checkemail:textField.text];
            }
            else {
                textField.layer.borderColor = [[UIColor redColor] CGColor];    
            }
        }
        else if (textField == createView_passwordField)
        {
            if ([createView_passwordField.text length] >=6)
            {
                textField.layer.borderColor = [[UIColor greenColor] CGColor];
            }
            else {
                textField.layer.borderColor = [[UIColor redColor] CGColor];
            }
        }
    }
    
}

@end
