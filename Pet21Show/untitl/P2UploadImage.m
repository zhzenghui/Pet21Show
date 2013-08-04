//
//  P2UploadImage.m
//  LifeLine
//
//  Created by zeng on 12-8-23.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "P2UploadImage.h"
#import "P2PetShow_Utility.h"
#import "P2CommonMethod.h"

@implementation P2UploadImage
@synthesize delegate;


#pragma mark - _SYNC_SERVER_PACKET_RECORD

- (void)getDBList_CallBack:(ASIFormDataRequest *)request
{
    
    [delegate uploadImageSecuss:request];
    if (request.responseStatusCode == 200) {
        
//        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"titl" message:@"secuss" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil , nil];
//        [av show];
//        [av release];
    }
    else {
        NSLog(@"%@", request.responseString);
//        UIWebView *webV = [[UIWebView alloc]initWithFrame:screenSize];
        
//        [webV loadHTMLString:request.responseString baseURL:nil];
//        [self.view addSubview:webV];
        
//        [webV release];
    }
}
- (void)getDBListFail_CallBack:(id)sender
{
    
}

- (void)uploadImage:(NSDictionary *)imageInfo
{
    NSMutableDictionary *imageDict = [NSMutableDictionary dictionary];
    [imageDict setObject:[UIImage imageNamed:@"webhp"] forKey:@"image"];
    [imageDict setObject:[NSString stringWithFormat:@"%@.jpeg", [P2CommonMethod md5TimeIDToRandFileName]] forKey:@"filename"];
    [imageDict setObject:@"zeng" forKey:@"cookname"];
    
    

    
    struct _SYNC_SERVER_PACKET_RECORD *P_SYNC_SERVER_PACKET_RECORD = (struct _SYNC_SERVER_PACKET_RECORD *)malloc(sizeof(struct _SYNC_SERVER_PACKET_RECORD));
	
	P_SYNC_SERVER_PACKET_RECORD -> delegate = self;
	P_SYNC_SERVER_PACKET_RECORD -> progressIndicator = nil;
	P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFinishSelector = @selector(getDBList_CallBack:);
	P_SYNC_SERVER_PACKET_RECORD -> action = SERVER_ACTIONS_UPLOADIMAGE;
	P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFailSelector = @selector(getDBListFail_CallBack:);
    P_SYNC_SERVER_PACKET_RECORD -> dataDict = imageDict;
    
    DataProcess *myDataProcess = [[DataProcess alloc] init];
    
    [myDataProcess SyncServer:SERVER_ACTIONS_UPLOADIMAGE syncServerPackedRecord:P_SYNC_SERVER_PACKET_RECORD];
}

@end
