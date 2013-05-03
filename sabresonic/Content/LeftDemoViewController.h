//
//  LeftDemoViewController.h
//  PKRevealController
//
//  Created by Philip Kluz on 1/18/13.
//  Copyright (c) 2013 zuui.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kal.h"
#import "ShoppingTableViewCell.h"
#import "ShoppingTableViewCell.h"

@interface LeftDemoViewController : UIViewController <UIPopoverControllerDelegate, UITableViewDelegate, ShoppingTableViewCellDelegate>
{
    NSArray *tableViewDataSourceArray;
    UITableView *leftDemoTableView;
    NSIndexPath *selectedRawIndexPath;
    BOOL isCellExpanded;
    UIPopoverController *calendarPopover;
    KalViewController *kalVC;
    BOOL isStartDateSelected;
    UIButton *selectStartDateBtn;
    UIButton *selectReturnDateBtn;
}
#pragma mark - Propertires
@property(nonatomic, strong)NSArray *tableViewDataSourceArray;
@property(nonatomic, strong)UITableView *leftDemoTableView;
@property(nonatomic, strong)NSIndexPath *selectedRawIndexPath;
@property(nonatomic, strong)UIButton *selectStartDateBtn;
@property(nonatomic, strong)UIButton *selectReturnDateBtn;
@property(nonatomic, assign)BOOL isCellExpanded;
@property(nonatomic, strong)UIPopoverController *calendarPopover;
@property(nonatomic, strong)KalViewController *kalVC;
@property(nonatomic, assign)BOOL isStartDateSelected;

#pragma mark - Methods
- (IBAction)showOppositeView:(id)sender;
- (IBAction)togglePresentationMode:(id)sender;
- (void)selectStartDateBtnTapped:(id)sender;
- (void)selectReturnDateBtnTapped:(id)sender;
- (void)showCalendarPopover:(UIButton*)selectedBtn;
-(void)setCellChidrenHeightToOriginal:(ShoppingTableViewCell*)cell;
-(void)setCellChidrenHeightToZero:(ShoppingTableViewCell*)cell;

@end