//
//  MessageViewController.h
//  Exchange
//
//  Created by dong xin on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
  NSMutableArray *messageArray;
  NSIndexPath *iPath;
  UITableView *_tableView;  
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
