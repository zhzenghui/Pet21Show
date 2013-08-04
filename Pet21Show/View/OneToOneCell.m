//
//  OneToOneCell.m
//  LifeLine
//
//  Created by zeng on 12-10-29.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "OneToOneCell.h"

@implementation OneToOneCell

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
    [_InviteesUserButton release];
    [_toBeInviteesUserButton release];
    [_payAmountLable release];
    [super dealloc];
}
@end
