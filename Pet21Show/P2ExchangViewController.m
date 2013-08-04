//
//  P2ExchangViewController.m
//  LifeLine
//
//  Created by zeng on 12-10-30.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "P2ExchangViewController.h"
//#import "ADViewController.h"

#import "ExchangeTableViewCell.h"


@interface P2ExchangViewController ()

@end

@implementation P2ExchangViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - _SYNC_SERVER_PACKET_RECORD

- (void)getDBList_CallBack:(ASIFormDataRequest *)request
{
    NSLog(@"%@", request.responseString);

    if (request.responseStatusCode == 200) {
        if ([request.responseString isEqualToString:@"t"]) {
            
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", @"")
                                                         message:@"很抱歉，优惠券已经领完，您如果愿意我们将以1积分兑换1块人民币给您兑换积分"
                                                        delegate:self
                                               cancelButtonTitle:@"不用了"
                                               otherButtonTitles:@"我愿意这样兑换",
                               nil];
            [av show];
            [av release];
        }
    }
}
- (IBAction)getDBListFail_CallBack:(id)sender
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"出错了", @"")
                                                 message:@"请您稍后再试试吧！"
                                                delegate:self
                                       cancelButtonTitle:@"好"
                                       otherButtonTitles:
                       nil];
    [av show];
    [av release];
}
- (void)netWork
{
    struct _SYNC_SERVER_PACKET_RECORD *P_SYNC_SERVER_PACKET_RECORD = (struct _SYNC_SERVER_PACKET_RECORD *)malloc(sizeof(struct _SYNC_SERVER_PACKET_RECORD));
    
    P_SYNC_SERVER_PACKET_RECORD -> delegate = self;
    P_SYNC_SERVER_PACKET_RECORD -> progressIndicator = nil;
    P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFinishSelector = @selector(getDBList_CallBack:);
    P_SYNC_SERVER_PACKET_RECORD -> action = SERVER_ACTIONS_ADDONLINE;
    P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFailSelector = @selector(getDBListFail_CallBack:);
    P_SYNC_SERVER_PACKET_RECORD -> dataDict = bankDateDict;
    
    DataProcess *myDataProcess = [[DataProcess alloc] init];
    
    [myDataProcess SyncServer:SERVER_ACTIONS_ADDONLINE syncServerPackedRecord:P_SYNC_SERVER_PACKET_RECORD];
    
}

- (IBAction)saveBankInfo:(id)sender
{
    
    self.navigationItem.rightBarButtonItem  = BARBUTTON(@"添加银行信息", @selector(addBankInfo:));
//    save data
    
    [self netWork];
    
    [self.bankView removeFromSuperview];
}

- (IBAction)addBankInfo:(id)sender
{

    self.navigationItem.rightBarButtonItem  = BARBUTTON(@"保存", @selector(saveBankInfo:));
    [self.view addSubview:self.bankView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    self.navigationItem.rightBarButtonItem  = BARBUTTON(@"添加银行信息", @selector(addBankInfo:));
    
    
    
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"12"]) {
//        int state = [[[NSUserDefaults standardUserDefaults] objectForKey:@"12"] intValue];
    
//        if (1) {
//        }
//    }
    
#define KexchangName @"exchangName"
#define KexchangAmount @"exchangAmount"
    
    exchangMallArray = [[NSMutableArray alloc] init];
    bankDateDict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    
    [dict1 setValue:@"京东优惠券" forKey:@"exchangName"];
    [dict1 setValue:@"100" forKey:@"exchangAmount"];
    
    [exchangMallArray addObject:dict1];
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    exchangeArray = array;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setValue:@"li" forKey:KTansaction_User];
    [dict setValue:@"balabalabala" forKey:KTansaction_Desc];
    [dict setValue:@"10" forKey:KTansaction_Sum];
    
    [dict setValue:@"卖" forKey:KTansaction_Type];
    [dict setValue:@"金" forKey:KTansaction_Currency];
    [dict setValue:@"可购买" forKey:KTansaction_Status];
    
    [array addObject:dict];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {

    [_remidView release];
    [_bankView release];
    [_headerView release];
    [_headerViewTitleLable release];
    [_headerViewMessLable release];
    [_header2View release];
    [super dealloc];
}
- (void)viewDidUnload {

    [self setRemidView:nil];
    [self setBankView:nil];
    [self setHeaderView:nil];
    [self setHeaderViewTitleLable:nil];
    [self setHeaderViewMessLable:nil];
    [self setHeader2View:nil];
    [super viewDidUnload];
}

- (IBAction)closeView:(id)sender
{
    [self.remidView removeFromSuperview];
}

- (IBAction)ruleView:(id)sender {
     [self.view addSubview:self.remidView];
}



//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *title = @"公告：在";
//    
//    return title;
//}

- (IBAction)buy:(id)sender
{
//    UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", @"")
//                                                 message:@"很抱歉，优惠券已经领完，您如果愿意我们将以1积分兑换1块人民币给您兑换积分"
//                                                delegate:self
//                                       cancelButtonTitle:@"不用了"
//                                       otherButtonTitles:@"我愿意这样兑换",
//                       nil];
//    [av show];
//    [av release];
//     ADViewController *viewController = [[[ADViewController alloc] initWithNibName:@"ADViewController_iPhone" bundle:nil] autorelease];
//    [self.navigationController pushViewController:viewController animated:YES];
}
#pragma mark - uialert

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
        {
            [self addBankInfo:nil];
            break;
        }
        default:
            break;
    }
}
#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.section) {
        case 0:
        {

            return 44;
            break;
        }
        case 1:
        {
            
            return 70;
            break;
        }
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {

            return [exchangMallArray count];
            break;
        }
        case 1:
        {
            
            return [exchangeArray count];
            break;
        }
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            static NSString *CellIdentifier = @"Cell";
            UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.frame = CGRectMake(240, 2, 60, 40);
                [button setTitle:NSLocalizedString(@"兑换", @"") forState:UIControlStateNormal];
                [button addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell.contentView addSubview:button];
            }
            
            NSDictionary *dict = [exchangMallArray objectAtIndex:indexPath.row];
            
            cell.textLabel.text = [dict objectForKey:KexchangName];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@积分", [dict objectForKey:KexchangAmount]];
            cell.imageView.image = [UIImage imageNamed:@"sina_16x16"];
            return cell;

            break;
        }
        case 1:
        {
            static NSString *CellIdentifier = @"Cell";
            
            ExchangeTableViewCell *cell = (ExchangeTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ExchangeTableViewCell" owner:self options:nil];
                
                for (id currentObject in topLevelObjects){
                    if ([currentObject isKindOfClass:[UITableViewCell class]]){
                        cell =  (ExchangeTableViewCell *) currentObject;
                        break;
                    }
                }
            }
            
            
            NSDictionary *dict = [exchangeArray objectAtIndex:indexPath.row];
            [cell.userButton setTitle: [dict objectForKey:KTansaction_User] forState:UIControlStateNormal];
            
            cell.tansactionTypeLable.text = [dict objectForKey:KTansaction_Type];
            cell.descLable.text = [dict objectForKey:KTansaction_Desc];
            cell.currencyLable.text = [dict objectForKey:KTansaction_Currency];
            
            [cell.statusButton setTitle: [dict objectForKey:KTansaction_Status] forState:UIControlStateNormal];
            cell.sumLable.text = [dict objectForKey:KTansaction_Sum];  
            
            return cell;
            break;
        }
        default:
            break;
    }
    return nil;
}


#pragma mark - Table view delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    
    switch (section) {
        case 0:
        {
            self.headerViewTitleLable.text = @"官方交易：";
            self.headerViewMessLable.text = @"";
            
            return  self.headerView;
            break;
        }
        case 1:
        {
            self.header2ViewTitleLable.text = @"用户交易：";
            self.header2ViewMessLable.text = @"建议用户进行支付宝交易";
            return  self.header2View;
            break;
        }
        default:
            break;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//
//    UIView *footView = [[[UIView alloc] init] autorelease];
//    return footView;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self payGold:nil];
    
}
@end
