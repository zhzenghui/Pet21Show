//
//  P2GuideViewController.m
//  LifeLine
//
//  Created by zeng on 12-9-26.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "P2GuideViewController.h"

@interface P2GuideViewController ()

@end

@implementation P2GuideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)registerGuideView
{
    [self.view addSubview: _registerView];
    [self.view addSubview: _guide1View];
}

- (IBAction)register:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)bind:(id)sender
{
//    UIButton *registerButton = (UIButton *)sender;

    [UIView animateWithDuration:.5 animations:^{
        _registerView.frame = CGRectMake(0, 2*screenHeight, screenWidth, screenHeight);
    } completion:^(BOOL finished) {
        if (finished) {
            [_registerView removeFromSuperview];
        }
    }];
}

- (IBAction)roleSelect:(id)sender
{
    UIButton *roleButton = (UIButton *)sender;

    
    switch (roleButton.tag) {
        case 1:
        {            
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            break;
        }
        default:
            break;
    }
    
//    保存角色
    [userDict setValue:[NSNumber numberWithInt:roleButton.tag] forKey:@"role"];
    
//关闭角色选择
    
    [UIView animateWithDuration:.5 animations:^{
        _guide1View.frame = CGRectMake(0, 2*screenHeight, screenWidth, screenHeight);
    } completion:^(BOOL finished) {
        if (finished) {
            [_guide1View removeFromSuperview];
        }
    }];
    
    
//    1  女孩
//    2  看客
//    3  other
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view .backgroundColor = [UIColor whiteColor];
    
    [self registerGuideView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_registerView release];
    [_guide1View release];
    [_emailTextField release];
    [_pwdTextField release];

    [_userNameTextField release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setRegisterView:nil];
    [self setGuide1View:nil];
    [self setEmailTextField:nil];
    [self setPwdTextField:nil];

    [self setUserNameTextField:nil];
    [super viewDidUnload];
}

#pragma mark - textfield

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _emailTextField) {
        [userDict setValue:textField.text forKey:@"email"];
    }
    if (textField == _userNameTextField) {
        [userDict setValue:textField.text forKey:@"name"];
    }
    if (textField == _pwdTextField) {
        [userDict setValue:textField.text forKey:@"pwd"];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

@end
