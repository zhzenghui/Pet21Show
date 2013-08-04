//
//  P2UserHomeViewController.h
//  Artvotary
//
//  Created by zeng on 12-11-25.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"


@interface P2UserHomeViewController : ViewController<UITableViewDataSource, UITableViewDelegate>
{

}

@property (assign, nonatomic)     NSInteger *userid;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)buttonInside:(id)sender;

@end
