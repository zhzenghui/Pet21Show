//
//  P2UserHomeViewController.m
//  Artvotary
//
//  Created by zeng on 12-11-25.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#define KpicButtonTag 101
#define KLikeButtonTag 102
#define KFollowButtonTag 103
#define KBFollowButtonTag 104

#define KBlackButtonTag 105
#define KMedalButtonTag 106

typedef NS_ENUM(int, TableType) {

     TableTypePic = 0,
     TableTypeLike,
     TableTypeFollow,
     TableTypeBFollow,
     TableTypeBlack,
     TableTypeMedal
};

#import "P2UserHomeViewController.h"
#import "Common.h"

@interface P2UserHomeViewController ()
{
    TableType tableType;
}
@end

@implementation P2UserHomeViewController

#pragma mark button 

- (IBAction)followingUser:(id)sender
{
    
}

- (IBAction)editUserInfo:(id)sender
{
    
}


- (IBAction)buttonInside:(id)sender
{
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case KpicButtonTag:
        {
            tableType = TableTypePic;
            
            break;
        }
        case KLikeButtonTag:
        {
            tableType = TableTypeLike;
            break;
        }
        case KFollowButtonTag:
        {
            tableType = TableTypeFollow;
            break;
        }
        case KBFollowButtonTag:
        {

            tableType = TableTypeBFollow;
            break;
        }
        case KBlackButtonTag:
        {

            tableType = TableTypeBlack;
            break;
        }
        case KMedalButtonTag:
        {
            tableType = TableTypeMedal;
            break;
        }
            
        default:
            break;
    }
    
    [self.tableView reloadData];
}

#pragma mark view cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ( 2 ) {
        self.navigationItem.rightBarButtonItem  = BARBUTTON(@"编辑", @selector(editUserInfo:));
    }
    else {
        self.navigationItem.rightBarButtonItem  = BARBUTTON(@"F", @selector(followingUser:));
    }

    
    tableType = TableTypePic;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    

    switch (tableType) {
        case TableTypePic:
        {

            cell.textLabel.text = @"pic";
            break;
        }
        case TableTypeLike:
        {

            cell.textLabel.text = @"like";
            break;
        }
        case TableTypeFollow:
        {
            cell.textLabel.text = @"follow";            
            break;
        }
        case TableTypeBFollow:
        {
            cell.textLabel.text = @"bfollow";            
            break;
        }
        case TableTypeBlack:
        {
            break;
        }
        case TableTypeMedal:
        {
            break;
        }
        default:
            break;
    }


    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
