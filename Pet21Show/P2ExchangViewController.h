//
//  P2ExchangViewController.h
//  LifeLine
//
//  Created by zeng on 12-10-30.
//  Copyright (c) 2012年 zeng. All rights reserved.
//



#define KTansaction_User @"KTansaction_User"
#define KTansaction_Type @"KTansaction_Type"
#define KTansaction_Sum @"KTansaction_Sum"
#define KTansaction_Currency @"KTansaction_Currency"
#define KTansaction_Desc @"KTansaction_Desc"
#define KTansaction_Status @"KTansaction_Status"

typedef enum {
    TansactionStatusCreate,
    TansactionStatusPurchaseRequest,
    TansactionStatusPurchase,
    TansactionStatusConfirmPurchaseA,
    TansactionStatusConfirmPurchaseB,
    TansactionStatusDone,
    
    TansactionStatusClose,
    TansactionStatusComplaints,
    TansactionStatusHandle,
    TansactionStatusProcessingComplete
} TansactionStatus;

#import <UIKit/UIKit.h>
#import "Common.h"

@interface P2ExchangViewController : ViewController<UIAlertViewDelegate>
{
    NSMutableArray *exchangMallArray;
    NSMutableDictionary *bankDateDict;
    
    

    NSMutableArray *exchangeArray;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) IBOutlet UIView *bankView;
@property (retain, nonatomic) IBOutlet UIView *remidView;
@property (retain, nonatomic) IBOutlet UIView *headerView;
@property (retain, nonatomic) IBOutlet UILabel *headerViewTitleLable;
@property (retain, nonatomic) IBOutlet UILabel *headerViewMessLable;

@property (retain, nonatomic) IBOutlet UIView *header2View;
@property (retain, nonatomic) IBOutlet UILabel *header2ViewTitleLable;
@property (retain, nonatomic) IBOutlet UILabel *header2ViewMessLable;
- (IBAction)closeView:(id)sender;
- (IBAction)ruleView:(id)sender;
@end
