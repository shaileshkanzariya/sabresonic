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
#import "ShoppingTableViewCell.h"

#define DESTINATION_SHOPPING_CELL_INDEX 1

@implementation LeftDemoViewController
@synthesize tableViewDataSourceArray, leftDemoTableView, selectedRawIndexPath, isCellExpanded,  calendarPopover, kalVC;
@synthesize isStartDateSelected, selectStartDateBtn, selectReturnDateBtn;

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isCellExpanded = NO;
    self.tableViewDataSourceArray = [NSArray arrayWithObjects:@"Home",@"Destination Shopping",@"Check-in",@"Flight Status", nil];
    
    // Each view can dynamically specify the min/max width that can be revealed.
    [self.revealController setMinimumWidth:340.0f maximumWidth:324.0f forViewController:self];
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
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableViewDataSourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SHOPPING_CELL_IDENTIFIER = @"ShoppingCellIdentifier";
    static NSString *NORMAL_CELL_IDENTIFIER = @"NormalCellIdentifier";
    
    if(indexPath.row == DESTINATION_SHOPPING_CELL_INDEX) //shopping cell
    {
        ShoppingTableViewCell *shoppingCell = (ShoppingTableViewCell*) [tableView dequeueReusableCellWithIdentifier:SHOPPING_CELL_IDENTIFIER];
        if(shoppingCell == nil) //create new cell
        {
            NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ShoppingTableViewCell" owner:self options:nil];
            shoppingCell = (ShoppingTableViewCell*)[nibArray objectAtIndex:0];
            if(self.isCellExpanded == YES)
            {
                [self setCellChidrenHeightToOriginal:(ShoppingTableViewCell*)shoppingCell];
                shoppingCell.textLabel.text = nil;
            }
            else
            {
                [self setCellChidrenHeightToZero:(ShoppingTableViewCell*) shoppingCell];
                shoppingCell.textLabel.text = [self.tableViewDataSourceArray objectAtIndex:indexPath.row];
            }
            shoppingCell.selectionStyle = UITableViewCellSelectionStyleNone;
            shoppingCell.backgroundColor = [UIColor clearColor];
            shoppingCell.delegate = self;
            return  shoppingCell;
        }
        else //dequeued cell
        {
            if(self.isCellExpanded == YES)
            {
                [self setCellChidrenHeightToOriginal:shoppingCell];
            }
            else
            {
                [self setCellChidrenHeightToZero:shoppingCell];
            }
        }
    }
    else //normal cells
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NORMAL_CELL_IDENTIFIER];
        if(cell == nil) //create new cell
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NORMAL_CELL_IDENTIFIER];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.text = [self.tableViewDataSourceArray objectAtIndex:indexPath.row];
            return cell;
        }
        else //dequeued cell
        {
            return cell;
        }
    }
    // NSString *path = [[NSBundle  mainBundle] pathForResource:[item objectForKey:@"imageKey"] ofType:@"png"];
    //UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    //cell.imageView.image = theImage;
}

-(void)setCellChidrenHeightToZero:(ShoppingTableViewCell*)cell
{
    cell.fromLbl.hidden = YES;
    cell.fromValueLbl.hidden = YES;
    cell.startLbl.hidden = YES;
    cell.endLbl.hidden = YES;
    cell.selectStartDateBtn.hidden = YES;
    cell.selectReturndateBtn.hidden = YES;
    cell.searchBtn.hidden = YES;
}

-(void)setCellChidrenHeightToOriginal:(ShoppingTableViewCell*)cell
{
    cell.fromLbl.hidden = NO;
    cell.fromValueLbl.hidden = NO;
    cell.startLbl.hidden = NO;
    cell.endLbl.hidden = NO;
    cell.selectStartDateBtn.hidden = NO;
    cell.selectReturndateBtn.hidden = NO;
    cell.searchBtn.hidden = NO;    
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
    if(indexPath.row == DESTINATION_SHOPPING_CELL_INDEX && self.isCellExpanded == YES)
    {
        return 250;
    }
    return 100;
}
/*
-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        if(indexPath.row == DESTINATION_SHOPPING_CELL_INDEX)
        {
            if(self.isCellExpanded == YES)
            {
                self.isCellExpanded = NO;
            }
            else
            {
                self.isCellExpanded = YES;
            }
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        //save selected indexpath
        self.selectedRawIndexPath = indexPath;
        //take action
        switch (indexPath.row)
        {
            case 0: //Home
            {
                AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
                [self.revealController setFrontViewController:appDel.frontViewNavController];
                break;
            }
            case 1: //Shop/Book
            {
                AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
                [self.revealController setFrontViewController:appDel.mapViewNavController];
                break;
            }
            case 2: //Checkin
            {
                AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
                [self.revealController setFrontViewController:appDel.checkInWebViewNavController];
                break;
            }
            case 3: //Flight Status
            {
                AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
                [self.revealController setFrontViewController:appDel.checkInWebViewNavController];
                break;
            }
                
            default:
                break;
        }
}

- (void)selectStartDateBtnTapped:(id)sender
{
    UIButton *strtBtn = (UIButton*)sender;
    self.selectStartDateBtn = strtBtn;
    self.isStartDateSelected = YES;
    [self showCalendarPopover:strtBtn];
}

- (void)selectReturnDateBtnTapped:(id)sender
{
    UIButton *strtBtn = (UIButton*)sender;
    self.selectReturnDateBtn = strtBtn;
    self.isStartDateSelected = NO;
    [self showCalendarPopover:strtBtn];
}

- (void)showCalendarPopover:(UIButton*)selectedBtn
{
    self.kalVC = [[KalViewController alloc] initWithFrame:CGRectMake(5, 10, 330, 300)];
    
    self.calendarPopover = [[UIPopoverController alloc] initWithContentViewController:kalVC];
    self.calendarPopover.delegate = self;
    self.calendarPopover.popoverContentSize = CGSizeMake(330, 240);
    if(self.isStartDateSelected)
    {
        [self.calendarPopover presentPopoverFromRect:selectedBtn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    else
    {
        [self.calendarPopover presentPopoverFromRect:selectedBtn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

#pragma mark Popover Delegate Methods
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"]; //yyyy-MM-dd HH:mm:ss zzz
    NSLog(@"Date: %@", [formatter stringFromDate:self.kalVC.selectedFromDate]);
    if(self.isStartDateSelected)
    {
        if(self.selectStartDateBtn != nil)
            self.selectStartDateBtn.titleLabel.text = [formatter stringFromDate:self.kalVC.selectedFromDate];
    }
    else
    {
        if(self.selectReturnDateBtn != nil)
            self.selectReturnDateBtn.titleLabel.text = [formatter stringFromDate:self.kalVC.selectedFromDate];
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

#pragma mark ShoppingTableViewCellDelegate Methods

-(void)selectStartDateButtonTapped:(id)sender
{
    [self selectStartDateBtnTapped:sender];
}

-(void)selectReturnDateButtonTapped:(id)sender
{
    [self selectReturnDateBtnTapped:sender];
}

-(void)searchDateButtonTapped:(id)sender
{
    
}

@end