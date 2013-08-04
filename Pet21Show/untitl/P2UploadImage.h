//
//  P2UploadImage.h
//  LifeLine
//
//  Created by zeng on 12-8-23.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UploadImageDelegate 

- (void)uploadImageSecuss:(id)sender;
- (void)uploadImageFail:(id)sender;

@end
@interface P2UploadImage : NSObject
{
    id<UploadImageDelegate> delegate;
}
@property(nonatomic, retain)id<UploadImageDelegate> delegate;
- (void)uploadImage:(NSDictionary *)imageInfo;
@end
