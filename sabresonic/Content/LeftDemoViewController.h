//
//  LeftDemoViewController.h
//  PKRevealController
//
//  Created by Philip Kluz on 1/18/13.
//  Copyright (c) 2013 zuui.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "Kal.h"

@interface LeftDemoViewController : UIViewController <UIPopoverControllerDelegate, UITableViewDelegate>
{
    NSArray *tableViewDataSourceArray;
    UITableView *leftDemoTableView;
    NSIndexPath *selectedRawIndexPath;
    BOOL isCellExpanded;
    IBOutlet CustomTableViewCell *customCell;
    IBOutlet UIButton *selectStartDateBtn;
    IBOutlet UIButton *selectReturnDateBtn;
    UIPopoverController *calendarPopover;
    KalViewController *kalVC;
    BOOL isStartDateSelected;
}
#pragma mark - Propertires
@property(nonatomic, strong)NSArray *tableViewDataSourceArray;
@property(nonatomic, strong)UITableView *leftDemoTableView;
@property(nonatomic, strong)NSIndexPath *selectedRawIndexPath;
@property(nonatomic, assign)BOOL isCellExpanded;
@property(nonatomic, strong)IBOutlet CustomTableViewCell *customCell;
@property(nonatomic, strong)IBOutlet UIButton *selectStartDateBtn;
@property(nonatomic, strong)IBOutlet UIButton *selectReturnDateBtn;
@property(nonatomic, strong)UIPopoverController *calendarPopover;
@property(nonatomic, strong)KalViewController *kalVC;
@property(nonatomic, assign)BOOL isStartDateSelected;

#pragma mark - Methods
- (IBAction)showOppositeView:(id)sender;
- (IBAction)togglePresentationMode:(id)sender;
- (IBAction)selectStartDateBtnTapped;
- (IBAction)selectReturnDateBtnTapped;
- (void)showCalendarPopover;

@end