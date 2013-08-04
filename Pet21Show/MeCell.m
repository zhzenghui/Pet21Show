//
//  GroupCell.m
//  LifeLine
//
//  Created by zeng on 12-10-29.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "MeCell.h"

@implementation MeCell

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
    [_titleLable release];
    [_numberLabel release];
    [_souceTypeButton release];
    [super dealloc];
}
@end
