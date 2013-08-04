//
//  DetailOnLineCell.h
//  Artvotary
//
//  Created by zeng on 12-11-18.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailOnLineCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIButton *userButton;
@property (retain, nonatomic) IBOutlet UIButton *userNameButton;
@property (retain, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *descLabel;
@property (retain, nonatomic) IBOutlet UIImageView *onlineImageView;
@end
