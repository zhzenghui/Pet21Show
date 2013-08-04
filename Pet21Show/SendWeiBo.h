//
//  SendWeiBo.h
//  LifeLine
//
//  Created by zeng on 12-8-21.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WBSendView.h"

@interface SendWeiBo : NSObject <WBSendViewDelegate>

- (void)sendSinaWeiBo:(NSDictionary *)weibo;


@end
