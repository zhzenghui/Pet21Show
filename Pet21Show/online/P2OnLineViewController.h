//
//  P2OnLineViewController.h
//  LifeLine
//
//  Created by zeng on 12-8-26.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

#import "HorizontalTableView.h"

@interface P2OnLineViewController : ViewController 
{
    NSMutableArray *onlineInfoArray;
    

    
    NSMutableArray *ionlineInfoArray;
    NSMutableArray *_objects;
}
//setting

//
@property (retain, nonatomic) IBOutlet UIView *iListView;
@property (retain, nonatomic) IBOutlet UIView *groupListView;
@property (retain, nonatomic) IBOutlet UIView *roomListView;

@property (retain, nonatomic) IBOutlet UITableView *allDataTableView;


@property (retain, nonatomic) IBOutlet UIView *iView;
@property (retain, nonatomic) IBOutlet UIScrollView *iScrollView;

@property (retain, nonatomic) IBOutlet UITableView *newArtTableView;
@property (retain, nonatomic) IBOutlet UITableView *popularTableView;
@property (retain, nonatomic) IBOutlet HorizontalTableView *MessageTableView;


@property (retain, nonatomic) IBOutlet HorizontalTableView *iTableView;
@property (retain, nonatomic) IBOutlet HorizontalTableView *groupTableView;
@property (retain, nonatomic) IBOutlet HorizontalTableView *roomTableView;

@property (retain, nonatomic) IBOutlet UILabel *ICmtLable;
@property (retain, nonatomic) IBOutlet UIScrollView *IScrollView;

@property (retain, nonatomic) IBOutlet UIView *mainView;
@property (retain, nonatomic) IBOutlet UITableView *onLineTableView;

@property (retain, nonatomic) IBOutlet UITableViewCell *myCell;



@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIScrollView *contentScrollView;


- (IBAction)openOnlineType:(id)sender;

@end
