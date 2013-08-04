//
//  MessageTableViewCell.h
//  Exchange
//
//  Created by dong xin on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIButton *userButton;
@property (retain, nonatomic) IBOutlet UILabel *titleLable;
@property (retain, nonatomic) IBOutlet UILabel *bodyLable;
@property (retain, nonatomic) IBOutlet UILabel *dateTimeLable;
@property (retain, nonatomic) IBOutlet UIButton *receiverButton;
@end
