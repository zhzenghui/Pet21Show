//
//  GroupCell.m
//  LifeLine
//
//  Created by zeng on 12-10-29.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "GroupCell.h"

@implementation GroupCell

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
    [_titleLabel release];
    [_dateLabel release];
    [_payAmount release];
    [_descLabel release];
    [_userButton release];
    [_imgView release];
    [super dealloc];
}
@end
