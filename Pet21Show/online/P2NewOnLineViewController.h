//
//  P2NewOnLineViewController.h
//  LifeLine
//
//  Created by zeng on 12-9-29.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "EICameraImageController.h"

#import "AGSimpleImageEditorView.h"
#import "AGViewController.h"



@interface P2NewOnLineViewController : ViewController<UITextFieldDelegate, UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, AGViewControllerDelegate,
                        EICameraControllerDelegate
>
{
    NSMutableDictionary *onlineDict;
    NSDate *endDate;
    
    

}

- (IBAction)allTagEvent:(id)sender;

- (IBAction)chooseTag:(id)sender;
- (IBAction)endTime:(id)sender;

- (IBAction)takePic:(id)sender;
- (IBAction)camaryPic:(id)sender;
- (IBAction)canclePic:(id)sender;
- (IBAction)resignFirstResponderTT:(id)sender;





@property (retain, nonatomic) IBOutlet UIImageView *imgView;
@property (retain, nonatomic) IBOutlet UIButton *imageButton;
@property (retain, nonatomic) IBOutlet UIButton *rewardButton;
@property (retain, nonatomic) IBOutlet UIButton *tagButton;
@property (retain, nonatomic) IBOutlet UIButton *endTimeButton;

@property (retain, nonatomic) IBOutlet UIScrollView *tagScrollView;

@property (retain, nonatomic) IBOutlet UIView *camaryView;
@property (retain, nonatomic) IBOutlet UIView *tagView;
@property (retain, nonatomic) IBOutlet UIView *dateView;
@property (retain, nonatomic) IBOutlet UIView *rewardView;
@property (retain, nonatomic) IBOutlet UIView *newOnlineView;

@property (retain, nonatomic) IBOutlet UITextView *descTextView;
@property (retain, nonatomic) IBOutlet UITextField *titleTextField;

- (IBAction)rewardAmount:(id)sender;

@end
