//
//  P2DetailOLViewController.h
//  Artvotary
//
//  Created by zeng on 12-11-18.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

typedef enum {
    NotNodel = 0,
    DetailOnLineCellModel,
    DetailOnlineCollectionCellModel
} TableViewModel;


#import <UIKit/UIKit.h>

@interface P2DetailOLViewController : UIViewController
{
    TableViewModel tableViewModel ;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSMutableArray *detailDataArray;
@property (retain, nonatomic) NSIndexPath *indexPath;
@end
