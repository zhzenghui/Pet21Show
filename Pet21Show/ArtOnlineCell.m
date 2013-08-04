//
//  TestCell.m
//  States
//
//  Created by dong xin on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ArtOnlineCell.h"

@implementation ArtOnlineCell
@synthesize titleLable;
@synthesize dateLable;
@synthesize userButton;
@synthesize numberLable;
@synthesize onlineImageView;

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
  [titleLable release];
  [dateLable release];
  [userButton release];
  [numberLable release];
  [onlineImageView release];
    [_OnlinetagButton release];
  [super dealloc];
}
@end
