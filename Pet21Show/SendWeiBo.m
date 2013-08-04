//
//  SendWeiBo.m
//  LifeLine
//
//  Created by zeng on 12-8-21.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "SendWeiBo.h"
#import "untitl/P2PetShow_Utility.h"

@implementation SendWeiBo 


#pragma mark - WBSDKTimelineViewController User Actions

- (void)sendSinaWeiBo:(NSDictionary *)weibo
{
    NSString *text = [weibo objectForKey:@"text"];
    UIImage *image = [weibo objectForKey:@"image"];
    
    WBSendView *sendView = [[WBSendView alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret text:text image:image];
    [sendView setDelegate:self];
    
    [sendView show:YES];
    [sendView release];
}
@end
