//
//  DetailOnLineCell.m
//  Artvotary
//
//  Created by zeng on 12-11-18.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "DetailOnLineCell.h"

@implementation DetailOnLineCell

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
    [_onlineImageView release];
    [_userButton release];
    [_userNameButton release];
    [_dateTimeLabel release];
    [_descLabel release];
    [super dealloc];
}
@end
