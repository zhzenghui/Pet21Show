//
//  P2AddStatusesViewController.m
//  LifeLine
//
//  Created by zeng on 12-8-21.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "P2AddStatusesViewController.h"
#import "P2PetShow_Utility.h"
#import "P2UploadImage.h"

@interface P2AddStatusesViewController ()

@end

@implementation P2AddStatusesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - _SYNC_SERVER_PACKET_RECORD

- (void)getDBList_CallBack:(ASIFormDataRequest *)request
{
    if (request.responseStatusCode == 200) {
        
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"titl" message:@"secuss" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil , nil];
        [av show];
        [av release];
    }
    else {
        NSLog(@"%@", request.responseString);
        UIWebView *webV = [[UIWebView alloc]initWithFrame:screenSize];
        
        [webV loadHTMLString:request.responseString baseURL:nil];
        [self.view addSubview:webV];
        [webV release];
    }
}
- (IBAction)getDBListFail_CallBack:(id)sender
{
    
}

#pragma mark - customer method

- (void)addStatuse
{
    NSString *text  = @"text";
    NSString *mid  = [Session getSession:@"id"];
    
    NSString *geo  = @"0,0";
    NSString *pic  = @"pic";
    NSString *in_reply_to_user_id = @"2";
    
    NSMutableDictionary *statuesDict = [NSMutableDictionary dictionary];

    [statuesDict setObject:text forKey:@"text"];
    [statuesDict setObject:mid forKey:@"mid"];

    [statuesDict setObject:geo forKey:@"geo"];
    [statuesDict setObject:pic forKey:@"pic"];
    [statuesDict setObject:in_reply_to_user_id forKey:@"ruser"];

    [Session setSession:@"statuses" value:statuesDict];

    struct _SYNC_SERVER_PACKET_RECORD *P_SYNC_SERVER_PACKET_RECORD = (struct _SYNC_SERVER_PACKET_RECORD *)malloc(sizeof(struct _SYNC_SERVER_PACKET_RECORD));

	P_SYNC_SERVER_PACKET_RECORD -> delegate = self;
	P_SYNC_SERVER_PACKET_RECORD -> progressIndicator = nil;
	P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFinishSelector = @selector(getDBList_CallBack:);
	P_SYNC_SERVER_PACKET_RECORD -> action = SERVER_ACTIONS_ADDSTATUES;
	P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFailSelector = @selector(getDBListFail_CallBack:);


    DataProcess *myDataProcess = [[DataProcess alloc] init];

    [myDataProcess SyncServer:SERVER_ACTIONS_ADDSTATUES syncServerPackedRecord:P_SYNC_SERVER_PACKET_RECORD];


}
- (IBAction)addStatuses:(id)sender
{

//    1update  image

    P2UploadImage *uImage = [[P2UploadImage alloc] init];
    uImage .delegate = self;
    [uImage uploadImage:nil];
    
//    s
//    2addstatue
//    s
//    all s
        
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@", [P2CommonMethod randFileName]);
    NSLog(@"%@", [P2CommonMethod md5TimeIDToRandFileName]);

//    [self addStatuses:nil];
}

#pragma - upload image 

- (void)uploadImageSecuss:(id)sender
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)sender;
    if (request.responseStatusCode == 200) {
    
        if ([request.responseString isEqualToString:@"t"]) {
            [self addStatuse];
        }
    }
    else {
        NSLog(@"%@", request.responseString);
        UIWebView *webV = [[UIWebView alloc]initWithFrame:screenSize];
        
        [webV loadHTMLString:request.responseString baseURL:nil];
        [self.view addSubview:webV];
        [webV release];
    }
    
}
- (void)uploadImageFail:(id)sender
{
}

@end
