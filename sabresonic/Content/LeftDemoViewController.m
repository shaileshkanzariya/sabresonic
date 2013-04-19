//
//  LeftDemoViewController.m
//  PKRevealController
//
//  Created by Philip Kluz on 1/18/13.
//  Copyright (c) 2013 zuui.org. All rights reserved.
//

#import "LeftDemoViewController.h"
#import "PKRevealController.h"
#import "MapViewController.h"
#import "AppDelegate.h"
#import "CustomTableViewCell.h"

@implementation LeftDemoViewController
@synthesize tableViewDataSourceArray, leftDemoTableView, selectedRawIndexPath, isCellExpanded, customCell;

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set data for left=table view
 
    self.isCellExpanded = NO;
    self.tableViewDataSourceArray = [NSArray arrayWithObjects:@"Shop/Book",@"Check-in", nil];
    
    // Each view can dynamically specify the min/max width that can be revealed.
    [self.revealController setMinimumWidth:280.0f maximumWidth:324.0f forViewController:self];
}

#pragma mark - API

- (IBAction)showOppositeView:(id)sender
{
    [self.revealController showViewController:self.revealController.rightViewController];
}

- (IBAction)togglePresentationMode:(id)sender
{
    if (![self.revealController isPresentationModeActive])
    {
        [self.revealController enterPresentationModeAnimated:YES
                                                  completion:NULL];
    }
    else
    {
        [self.revealController resignPresentationModeEntirely:NO
                                                     animated:YES
                                                   completion:NULL];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [self.tableViewDataSourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
            if(indexPath.row == 0 && self.isCellExpanded == YES)
            {
                return self.customCell;
            }
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.text = [self.tableViewDataSourceArray objectAtIndex:indexPath.row];
            return cell;
    // NSString *path = [[NSBundle  mainBundle] pathForResource:[item objectForKey:@"imageKey"] ofType:@"png"];
    //UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    //cell.imageView.image = theImage;

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if(indexPath.row == 0)
        {
            if(self.selectedRawIndexPath && indexPath.row == selectedRawIndexPath.row && self.isCellExpanded == YES)
            {
            
                return 350;
            }
            else
            {
                return 100;
            }
        }
        else
        {
            return 100;
        }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        //save selected indexpath
        self.selectedRawIndexPath = indexPath;

        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]; //get custom cell
        NSLog(@"height = %f",cell.frame.size.height);
        if(indexPath.row == 0)
        {
            if(cell.frame.size.height > 100)
            {
                self.isCellExpanded = NO;
            }
            else
            {
                self.isCellExpanded = YES;
            }
        }
        else
        {
            self.isCellExpanded = NO;
        }
        [tableView reloadData];
        /*
        if(indexPath.row == 0)
        {
            if(self.isCellExpanded == YES)
            {
                self.isCellExpanded = NO;
            }
            else
            {
                self.isCellExpanded = YES;
            }
        }
        */
    
        [tableView beginUpdates];
        [tableView endUpdates];
    
        switch (indexPath.row)
        {
            case 0: //Shop/Book
            {
                AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
                [self.revealController setFrontViewController:appDel.mapViewNavController];
                break;
            }
            case 1: //Checkin
            {
                AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
                [self.revealController setFrontViewController:appDel.checkInWebViewNavController];
                break;
            }
            
            default:
                break;
        }
}

#pragma mark - Autorotation

/*
* Please get familiar with iOS 6 new rotation handling as if you were to nest this controller within a UINavigationController,
* the UINavigationController would _NOT_ relay rotation requests to his children on its own!
*/

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end