//
//  DetailOnlineCollectionCell.m
//  Artvotary
//
//  Created by zeng on 12-11-18.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "DetailOnlineCollectionCell.h"

@implementation DetailOnlineCollectionCell

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

    [_leftImageView release];
    [_centerImageView release];
    [_rightImageView release];
    [super dealloc];
}
@end
