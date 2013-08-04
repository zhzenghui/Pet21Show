//
//  MessageTableViewCell.m
//  Exchange
//
//  Created by dong xin on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell
@synthesize userButton;
@synthesize titleLable;
@synthesize bodyLable;
@synthesize dateTimeLable;
@synthesize receiverButton;

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
    [userButton release];
    [titleLable release];
    [bodyLable release];
    [dateTimeLable release];
    [receiverButton release];
    [super dealloc];
}
@end
