//
//  ExchangeTableViewCell.h
//  Exchange
//
//  Created by dong xin on 12-11-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeTableViewCell : UITableViewCell


@property (retain, nonatomic) IBOutlet UIButton *userButton;
@property (retain, nonatomic) IBOutlet UILabel *tansactionTypeLable;
@property (retain, nonatomic) IBOutlet UILabel *sumLable;
@property (retain, nonatomic) IBOutlet UILabel *currencyLable;
@property (retain, nonatomic) IBOutlet UILabel *descLable;

@property (retain, nonatomic) IBOutlet UIButton *statusButton;

@end
