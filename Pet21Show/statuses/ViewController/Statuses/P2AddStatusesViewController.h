//
//  P2AddStatusesViewController.h
//  LifeLine
//
//  Created by zeng on 12-8-21.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P2UploadImage.h"

@interface P2AddStatusesViewController : UIViewController <UploadImageDelegate>

@property(nonatomic, retain) IBOutlet UITextView *statusesTextView;
@property(nonatomic, retain) IBOutlet UIButton *statusesButton;
@property(nonatomic, retain) IBOutlet UIImageView *statusesImageView;

- (IBAction)addStatuses:(id)sender;
@end
