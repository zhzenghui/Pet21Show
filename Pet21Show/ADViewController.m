//
//  ADViewController.m
//  Exchange
//
//  Created by dong xin on 12-11-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ADViewController.h"
#import "ExchangeTableViewCell.h"

@implementation ADViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
      return YES;
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//  static NSString *CellIdentifier = @"Cell";
//  
//  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//  if (cell == nil) {
//    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
//  }
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
  
}

@end
