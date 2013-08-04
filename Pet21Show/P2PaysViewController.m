//
//  P2PaysViewController.m
//  Artvotary
//
//  Created by zeng on 12-10-31.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "P2PaysViewController.h"
#import "RageIAPHelper.h"
#import <StoreKit/StoreKit.h>

#import "ExchangeTableViewCell.h"
#import "ExchageDetailTableViewCell.h"


@interface P2PaysViewController ()
{
    NSArray *_products;
    NSArray *p;
    NSNumberFormatter * _priceFormatter;
}
@end

@implementation P2PaysViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"商城";
    
    sMessage = @"正在获取商品列表！";

    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
      [self reload];
    [self.refreshControl beginRefreshing];
    
    _priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布交易信息" style:UIBarButtonItemStyleBordered target:self action:@selector(restoreTapped:)];
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    exchangeArray = array;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setValue:@"li" forKey:KTansaction_User];
    [dict setValue:@"5块钱 贱卖啦！ 快来买吧" forKey:KTansaction_Desc];
    [dict setValue:@"10" forKey:KTansaction_Sum];
    
    [dict setValue:@"卖" forKey:KTansaction_Type];
    [dict setValue:@"金" forKey:KTansaction_Currency];
    [dict setValue:@"可交易" forKey:KTansaction_Status];
    
    [array addObject:dict];
    [dict release];
}

- (void)restoreTapped:(id)sender {
    [[RageIAPHelper sharedInstance] restoreCompletedTransactions];
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            *stop = YES;
        }
    }];
    
}

- (void)reload {
    _products = nil;
    
    [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _products = [products copy];
            if (_products.count == 0) {
                sMessage = @"获取商品列表失败，请稍后再试！";            }
            else {
                sMessage = @"已经获取商品列表！";
                
                self.headerViewMessLable.text = [NSString stringWithFormat:@"%d种产品销售中", products.count];

            }
            NSLog(@"%@", sMessage);
            [self.tableView reloadData];
            
        }
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - Table View

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
            
            if ([iPath isEqual:indexPath]) {
                return 300;
            }
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
        {
            if (_products.count == 0) {
                return 1;
            }
            else {
                return _products.count;
            }
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
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            }
            
            if (_products.count == 0) {
                cell.textLabel.text = sMessage;
            }
            else {
                
                SKProduct * product = (SKProduct *) _products[indexPath.row];
                
                cell.textLabel.text = product.localizedTitle;
                [_priceFormatter setLocale:product.priceLocale];
                cell.detailTextLabel.text = [_priceFormatter stringFromNumber:product.price];
                
                if ([[RageIAPHelper sharedInstance] productPurchased:product.productIdentifier]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    cell.accessoryView = nil;
                } else {
                    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    buyButton.frame = CGRectMake(0, 0, 72, 37);
                    [buyButton setTitle:@"购买" forState:UIControlStateNormal];
                    buyButton.tag = indexPath.row;
                    [buyButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.accessoryView = buyButton;
                }
                
            }
            return cell;

            break;
        }
        case 1:
        {
            if ([indexPath isEqual:iPath]) {
                static NSString *CellIdentifier = @"CellIdentifier";
                
                ExchageDetailTableViewCell *cell = (ExchageDetailTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    
                    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ExchageDetailTableViewCell" owner:self options:nil];
                    
                    for (id currentObject in topLevelObjects){
                        if ([currentObject isKindOfClass:[UITableViewCell class]]){
                            cell =  (ExchageDetailTableViewCell *) currentObject;
                            break;
                        }
                    }
                }
                
                
                //    NSDictionary *dict = [exchangeArray objectAtIndex:indexPath.row];
                //    [cell.userButton setTitle: [dict objectForKey:KTansaction_User] forState:UIControlStateNormal];
                //
                //    cell.tansactionTypeLable.text = [dict objectForKey:KTansaction_Type];
                //    cell.descLable.text = [dict objectForKey:KTansaction_Desc];
                //    cell.currencyLable.text = [dict objectForKey:KTansaction_Currency];
                //
                //    [cell.statusButton setTitle: [dict objectForKey:KTansaction_Status] forState:UIControlStateNormal];
                //    cell.sumLable.text = [dict objectForKey:KTansaction_Sum];
                
                return cell;
            }
            else {
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
                [cell.statusButton addTarget:self action:@selector(exchange:) forControlEvents:UIControlEventTouchUpInside];
                cell.sumLable.text = [dict objectForKey:KTansaction_Sum];
                
                return cell;
            }

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
//            self.headerViewMessLable.text = @"";
            
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

- (void)buyButtonTapped:(id)sender {
    
    UIButton *buyButton = (UIButton *)sender;
    SKProduct *product = _products[buyButton.tag];
    
    NSLog(@"Buying %@...", product.productIdentifier);
    [[RageIAPHelper sharedInstance] buyProduct:product];
    
}

- (IBAction)exchange:(id)sender
{
    if (iPath == NULL) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        [dict setValue:@"zh" forKey:KTansaction_User];
        [dict setValue:@"balabalabala" forKey:KTansaction_Desc];
        [dict setValue:@"10" forKey:KTansaction_Sum];
        
        [dict setValue:@"买" forKey:KTansaction_Type];
        [dict setValue:@"金" forKey:KTansaction_Currency];
        [dict setValue:@"参加" forKey:KTansaction_Status];
        
        [exchangeArray addObject:dict];
        
        
        //  [self.tableView reloadData];
        
        UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
        NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
        indexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        
        iPath = indexPath;
        [iPath retain];
        
        NSMutableArray* paths = [[NSMutableArray alloc] init];
        [paths addObject:indexPath];
        [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationTop];
        [paths release];
        
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES ];
        
    }
    else
    {
        [exchangeArray removeObjectAtIndex:iPath.row-1];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:iPath.row inSection:iPath.section];
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        iPath = nil;
    }
    
}

- (IBAction)openUser:(id)sender
{
    
}

- (void)viewDidUnload {
    

    [[RageIAPHelper sharedInstance] cancelRequest];

    [self setHeaderView:nil];
    [self setHeaderViewTitleLable:nil];
    [self setHeaderViewMessLable:nil];
    [self setHeader2View:nil];
    [self setHeader2ViewTitleLable:nil];
    [self setHeader2ViewMessLable:nil];

    [super viewDidUnload];
}

- (void)dealloc
{
    [_headerView release];
    [_headerViewTitleLable release];
    [_headerViewMessLable release];
    [_header2View release];
    [_header2ViewTitleLable release];
    [_header2ViewMessLable release];
    
    [_products release];
    [exchangeArray release];
    [super dealloc];
}
@end
