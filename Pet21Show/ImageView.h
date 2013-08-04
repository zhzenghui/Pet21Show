//
//  ImageView.h
//  LifeLine
//
//  Created by zeng on 12-9-2.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageViewDelegate <NSObject>

- (void)touchOpen:(id)target;

@end
@interface ImageView : UIImageView
{
    id<ImageViewDelegate> delegate;
}

@property(nonatomic, assign) id<ImageViewDelegate> delegate;
@end
