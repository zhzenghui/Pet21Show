//
//  P2PayViewController.h
//  LifeLine
//
//  Created by zeng on 12-10-31.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "ViewController.h"

#import "MBProgressHUD.h"
@interface P2PayViewController : UITableViewController {
    
    MBProgressHUD *_hud;
}

@property (retain) MBProgressHUD *hud;

@end
