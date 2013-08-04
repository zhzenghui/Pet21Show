//
//  FeedbackViewController.h
//  Artvotary
//
//  Created by zeng on 12-11-27.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface FeedbackViewController : ViewController<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextView *feedBackTextView;
@end
