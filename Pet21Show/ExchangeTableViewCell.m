//
//  ExchangeTableViewCell.m
//  Exchange
//
//  Created by dong xin on 12-11-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "ExchangeTableViewCell.h"

@implementation ExchangeTableViewCell
@synthesize statusButton;
@synthesize currencyLable;
@synthesize sumLable;
@synthesize tansactionTypeLable;
@synthesize descLable;
@synthesize userButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
  [statusButton release];
  [currencyLable release];
  [sumLable release];
  [tansactionTypeLable release];
  [descLable release];
  [userButton release];
  [super dealloc];
}

@end
