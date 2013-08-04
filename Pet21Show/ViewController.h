//
//  ViewController.h
//  LifeLine
//
//  Created by zeng on 12-9-27.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSMutableDictionary *userDict;
}
@property(nonatomic, retain) NSMutableDictionary *userDict;
@property(nonatomic, retain) UILabel *titleLable;

- (IBAction)payGold:(id)sender;


@end
