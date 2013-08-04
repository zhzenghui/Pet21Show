//
//  DataProcess.m
//  LifeLine
//
//  Created by zeng on 12-8-18.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "DataProcess.h"
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Common.h"

@implementation DataProcess

- (id)init
{
    if (self = [super init]) {
        uid = [Session getSession:@"id"];
    }

    return  self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)ProcessAction:(EI_IP_ACTIONS)action obj:(id)obj
{
    struct _SYNC_SERVER_PACKET_RECORD *tmpSyncServerPacketRecordPosint;
    
    NSValue *nValue = obj;
    
    [nValue getValue:&tmpSyncServerPacketRecordPosint];
    
    
    [self SyncServer:tmpSyncServerPacketRecordPosint->action
        syncServerPackedRecord:tmpSyncServerPacketRecordPosint];
}

- (void)getInfo:(EI_SERVER_ACTIONS)action
         neturl:(NSString*)url
        timeout:(int)timeOut
       ASIQueue:(ASINetworkQueue *)networkQueue
{
    
    
    ASIHTTPRequest *request;

    switch (action) {
        case SERVER_ACTIONS_LOGINUSER:
        {
            NSDictionary *userDict = [Session getSession:@"vuser"];
            NSString *userName = [userDict objectForKey:@"username"];
            
            url =[NSString stringWithFormat:@"%@%@", url, userName];
            
            break;
        }
        case SERVER_ACTIONS_CHECKUSERNAME:
        {
            NSDictionary *userDict = [Session getSession:@"vuser"];
            NSString *userName = [userDict objectForKey:@"username"];
            
            url =[NSString stringWithFormat:@"%@user/checkuserinfo/?quname=%@", url, userName];
            break;
        }
        case SERVER_ACTIONS_CHECKEMAIL:
        {
            NSDictionary *userDict = [Session getSession:@"vuser"];
            NSString *email = [userDict objectForKey:@"email"];
            
            url =[NSString stringWithFormat:@"%@user/checkuserinfo/?qemail=%@", url, email];
            break;
        }
        case SERVER_ACTIONS_STATUES:
        {
            url = [NSString stringWithFormat:@"%@getstatusesuid/%@/2/", Server_Url, uid];
            break;
        }

        default:
            break;
    }
    
    NSLog(@"%@", url);
    request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]] autorelease];
    
    [request setTimeOutSeconds:timeOut];
    
    [ASIHTTPRequest clearSession];
    [request addRequestHeader:@"User-Agent" value:[NSString stringWithFormat: @"EI %@", EiPhone_Ver]];
    request.requestMethod = @"GET";
    
    //add Queue
    [networkQueue addOperation:request];
}

- (void)postInfo:(struct _SYNC_SERVER_PACKET_RECORD *)syncServerPackedRecord
          neturl:(NSString*)url
         timeout:(int)timeOut
        ASIQueue:(ASINetworkQueue *)networkQueue
{
    
    ASIFormDataRequest *request;
    request = [[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]] autorelease];
    
    EI_SERVER_ACTIONS  actions = syncServerPackedRecord->action;
    
    switch (actions) {
        case SERVER_ACTIONS_ADDUSER:
        {
            NSDictionary *userDict = [Session getSession:@"user"];
            
            [request setPostValue:[userDict objectForKey:@"screen_name"] forKey:@"screen_name"];
            [request setPostValue:[userDict objectForKey:@"gender"] forKey:@"gender"];
            [request setPostValue:[userDict objectForKey:@"description"] forKey:@"description"];
            [request setPostValue:[userDict objectForKey:@"birth"] forKey:@"birth"];
            [request setPostValue:[userDict objectForKey:@"phone"] forKey:@"phone"];
            [request setPostValue:[userDict objectForKey:@"profile_image_url"] forKey:@"profile_image_url"];
            
            [request setPostValue:[userDict objectForKey:@"name"] forKey:@"name"];
            [request setPostValue:[userDict objectForKey:@"email"] forKey:@"email"];
            [request setPostValue:[userDict objectForKey:@"pwd"] forKey:@"pwd"];
            [Session setSession:@"user" value:nil];
            break;
        }
        case SERVER_ACTIONS_UPDATEUSER:
        {
            NSDictionary *userDict = [Session getSession:@"user"];
            
            [request setPostValue:[userDict objectForKey:@"screen_name"] forKey:@"screen_name"];
            [request setPostValue:[userDict objectForKey:@"gender"] forKey:@"gender"];
            [request setPostValue:[userDict objectForKey:@"description"] forKey:@"description"];
            [request setPostValue:[userDict objectForKey:@"birth"] forKey:@"birth"];
            [request setPostValue:[userDict objectForKey:@"phone"] forKey:@"phone"];
            [request setPostValue:[userDict objectForKey:@"profile_image_url"] forKey:@"profile_image_url"];
            
            [request setPostValue:[userDict objectForKey:@"name"] forKey:@"name"];
            [request setPostValue:[userDict objectForKey:@"email"] forKey:@"email"];
            [request setPostValue:[userDict objectForKey:@"pwd"] forKey:@"pwd"];
            break;
        }
        case SERVER_ACTIONS_ADDSTATUES:
        {
            
            NSDictionary *statusesDict = [Session getSession:@"statuses"];

            [request setPostValue:[statusesDict objectForKey:@"text"] forKey:@"text"];
            [request setPostValue:[statusesDict objectForKey:@"mid"] forKey:@"mid"];
            [request setPostValue:[statusesDict objectForKey:@"geo"] forKey:@"geo"];
            
            [request setPostValue:[statusesDict objectForKey:@"pic"] forKey:@"bmiddle_pic"];
            [request setPostValue:[statusesDict objectForKey:@"ruser"] forKey:@"in_reply_to_user_id"];
            
            
        
            break;
        }
        case SERVER_ACTIONS_UPLOADIMAGE:
        {
            NSDictionary *imageDict =  syncServerPackedRecord ->dataDict;
            UIImage *image = (UIImage *)[imageDict objectForKey:@"image"];
            NSString *filename = [imageDict objectForKey:@"filename"];
            NSString *cookname = [imageDict objectForKey:@"cookname"];
            

            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            [request setData:imageData withFileName:filename andContentType:@"image/jpeg" forKey:@"file"];
            [request setPostValue:cookname forKey:@"cookname"];
        }
        case SERVER_ACTIONS_ADDONLINE:
        {

            NSDictionary *onlineDict = syncServerPackedRecord ->dataDict;
            
            [request setPostValue:[onlineDict objectForKey:KonlineTitle] forKey:KonlineTitle];
            [request setPostValue:[onlineDict objectForKey:KonlineImage] forKey:KonlineImage];
            [request setPostValue:[onlineDict objectForKey:KonlineUser] forKey:KonlineUser];
            [request setPostValue:[onlineDict objectForKey:KonlineDesc] forKey:KonlineDesc];
            [request setPostValue:[onlineDict objectForKey:KonlineEndDate] forKey:KonlineEndDate];
            [request setPostValue:[onlineDict objectForKey:KonlineTag] forKey:KonlineTag];
            [request setPostValue:[onlineDict objectForKey:KonlineRewardAmount] forKey:KonlineRewardAmount];
            [request setPostValue:[onlineDict objectForKey:KonlineHotNum] forKey:KonlineHotNum];
            [request setPostValue:[onlineDict objectForKey:KonlineJoinNum] forKey:KonlineJoinNum];

            break;
        }
        default:
            break;
    }
    
    
    
    NSLog(@"%@", url);
    [ASIFormDataRequest clearSession];
    [request addRequestHeader:@"User-Agent" value:[NSString stringWithFormat: @"EI %@", EiPhone_Ver]];
    request.requestMethod = @"POST";
    
    
    //add Queue
    [networkQueue addOperation:request];
}
- (void)SyncServer:(EI_SERVER_ACTIONS)serverAction
    syncServerPackedRecord:(struct _SYNC_SERVER_PACKET_RECORD *)syncServerPackedRecord
{
    /*
    NSString *config = [NSString string];
        NSString *password =(NSString *)CFURLCreateStringByAddingPercentEscapes(NULL
                                                                                ,(CFStringRef)@""
                                                                                ,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]"
                                                                                ,kCFStringEncodingUTF8 );
            [password release];
     */
    serverAction = syncServerPackedRecord->action;
    if (uid != nil) {
        
        
        int timeout = 30;
        
        NSString *url = Server_Url;

        NSString *DeviceSerialNum = @"";
        DeviceSerialNum = [[[UIDevice currentDevice] uniqueIdentifier]
                           stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
		
        
        switch (serverAction) {
//          ------------------------
//                POST
            case SERVER_ACTIONS_ADDUSER:
            {
                url = [NSString stringWithFormat:@"%@user/create/1/", Server_Url];
                
                timeout = 100;
                break;
            }
            case SERVER_ACTIONS_UPDATEUSER:
            {
                url = [NSString stringWithFormat:@"%@", Server_Url];
                
                timeout = 100;
                break;
                            
            }
            case SERVER_ACTIONS_ADDSTATUES:
            {
                url = [NSString stringWithFormat:@"%@addStatuses/", Server_Url];
                
                timeout = 100;
                break;
                
            }
            case SERVER_ACTIONS_UPLOADIMAGE: {
                url = [NSString stringWithFormat:@"%@upload/", Server_Url];
                
                timeout = 300;
                break;
                
            }
//          ------------------------
//                ADD ONLINE
            case SERVER_ACTIONS_ADDONLINE:
            {
                url = [NSString stringWithFormat:@"%@artonline/addartonline/", Server_Url];
                
                timeout = 100;
                break;
            }
            case SERVER_ACTIONS_GETONLINE:
            {
                url = [NSString stringWithFormat:@"%@artonline/addartonline/", Server_Url];
                
                timeout = 100;
                break;
            }
//          ------------------------
//                GET
            case SERVER_ACTIONS_LOGINUSER:
            {
                timeout = 30;
                
//                http://127.0.0.1:8000/user/info/5/2/
                break;
            }
            case SERVER_ACTIONS_CHECKUSERNAME:
            {

            }
            case SERVER_ACTIONS_CHECKEMAIL:{

            }
            case SERVER_ACTIONS_STATUES:{
                
//                http://127.0.0.1:8000/getstatusesuid/1/2/
//                url = [NSString stringWithFormat:@"%@getstatusesuid/%@/2/", Server_Url, uid];
                timeout = 10;
                break;
            }
            default:
                break;
        }
        

    
        ASINetworkQueue *networkQueue = [[ASINetworkQueue queue] retain];
        if ( ! [url isEqualToString:@""]) {

            
            [networkQueue cancelAllOperations];
            [networkQueue setDownloadProgressDelegate:syncServerPackedRecord -> progressIndicator];
            [networkQueue setRequestDidFailSelector:syncServerPackedRecord->setRequestDidFailSelector];
            [networkQueue setRequestDidFinishSelector:syncServerPackedRecord->setRequestDidFinishSelector];
            [networkQueue setDelegate:syncServerPackedRecord -> delegate];
            
            switch (serverAction) {
                case SERVER_ACTIONS_ADDUSER:
                case SERVER_ACTIONS_ADDONLINE:
                case SERVER_ACTIONS_UPDATEUSER:
                case SERVER_ACTIONS_ADDSTATUES:
                case SERVER_ACTIONS_UPLOADIMAGE:
                {

                    [self postInfo:syncServerPackedRecord neturl:url timeout:timeout ASIQueue:networkQueue];
                    break;
                }
                case SERVER_ACTIONS_LOGINUSER:
                case SERVER_ACTIONS_CHECKEMAIL:
                case SERVER_ACTIONS_CHECKUSERNAME:
                case SERVER_ACTIONS_STATUES:
                {
                
                    [self getInfo:serverAction neturl:url timeout:timeout ASIQueue:networkQueue];
                    break;
                }
                    
                default:
                    break;
            }
            
            [networkQueue go];
            
        }
        
        [networkQueue release];
    }
    
    free(syncServerPackedRecord);
}
@end

