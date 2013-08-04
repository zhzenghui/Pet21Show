//
//  MessageViewController.m
//  Exchange
//
//  Created by dong xin on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageDetailTableViewCell.h"

@implementation MessageViewController
@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}




#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

  NSMutableArray *array = [[NSMutableArray alloc] init];
  messageArray = array;
  
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  
  [dict setValue:@"1" forKey:KMessage_ID];
  [dict setValue:@"z" forKey:KMessage_SendUser];
  [dict setValue:@"10" forKey:KMessage_ReceiverUser];
  
  [dict setValue:@"卖" forKey:KMessage_DateTime];
  [dict setValue:@"金" forKey:KMessage_Title];
  [dict setValue:@"参加" forKey:KMessage_Body];
  [dict setValue:@"参加" forKey:KMessage_Receiver_ID];
  
  [array addObject:dict];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [messageArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ([iPath isEqual:indexPath]) {
    return 160;
  }
  return 83;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  static NSString *CellIdentifier = @"Cell";
  //  
  //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  //  if (cell == nil) {
  //    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
  //  }
  if ([indexPath isEqual:iPath]) {
    
    static NSString *CellIdentifier = @"Cell";
    
    MessageDetailTableViewCell *cell = (MessageDetailTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
      
      NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MessageDetailTableViewCell" owner:self options:nil];
      
      for (id currentObject in topLevelObjects){
        if ([currentObject isKindOfClass:[UITableViewCell class]]){
          cell =  (MessageDetailTableViewCell *) currentObject;
          break;
        }
      }
    }
    
    
    //    NSDictionary *dict = [messageArray objectAtIndex:indexPath.row];
    //    [cell setTitle: [dict objectForKey:KTansaction_User] forState:UIControlStateNormal];
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
    
    MessageTableViewCell *cell = (MessageTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
      
      NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:self options:nil];
      
      for (id currentObject in topLevelObjects){
        if ([currentObject isKindOfClass:[UITableViewCell class]]){
          cell =  (MessageTableViewCell *) currentObject;
          break;
        }
      }
    }
    
    
    NSDictionary *dict = [messageArray objectAtIndex:indexPath.row];
    [cell.userButton setTitle: [dict objectForKey:KMessage_ReceiverUser] forState:UIControlStateNormal];
    
    cell.titleLable.text = [dict objectForKey:KMessage_Title];
    cell.bodyLable.text = [dict objectForKey:KMessage_Body];
    cell.dateTimeLable.text = [dict objectForKey:KMessage_DateTime];  
    
    
    return cell;
  }
  return nil;
}

- (IBAction)exchange:(id)sender
{
  if (iPath == NULL) {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
//    [dict setValue:@"zh" forKey:KTansaction_User];
//    [dict setValue:@"balabalabala" forKey:KTansaction_Desc];
//    [dict setValue:@"10" forKey:KTansaction_Sum];
//    
//    [dict setValue:@"买" forKey:KTansaction_Type];
//    [dict setValue:@"金" forKey:KTansaction_Currency];
//    [dict setValue:@"参加" forKey:KTansaction_Status];
    
    [messageArray addObject:dict];
    
    
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
    
  }
  else 
  {
    [messageArray removeObjectAtIndex:iPath.row-1];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:iPath.row inSection:iPath.section];
    
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    iPath = nil;
  }
  
}






@end
