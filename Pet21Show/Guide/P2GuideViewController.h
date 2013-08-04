//
//  P2GuideViewController.h
//  LifeLine
//
//  Created by zeng on 12-9-26.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "P2PetShow_Utility.h"

@interface P2GuideViewController : ViewController <UITextFieldDelegate>
{
    
}
@property (retain, nonatomic) IBOutlet UITextField *emailTextField;
@property (retain, nonatomic) IBOutlet UITextField *pwdTextField;
@property (retain, nonatomic) IBOutlet UITextField *userNameTextField;

@property (retain, nonatomic) IBOutlet UIView *registerView;
@property (retain, nonatomic) IBOutlet UIView *guide1View;
@end
