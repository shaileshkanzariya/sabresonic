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

@interface LeftDemoViewController : UIViewController <UITableViewDelegate>
{
    NSArray *tableViewDataSourceArray;
    UITableView *leftDemoTableView;
    NSIndexPath *selectedRawIndexPath;
    BOOL isCellExpanded;
    KalViewController *kalVC;
}
#pragma mark - Propertires
@property(nonatomic, strong)NSArray *tableViewDataSourceArray;
@property(nonatomic, strong)UITableView *leftDemoTableView;
@property(nonatomic, strong)NSIndexPath *selectedRawIndexPath;
@property(nonatomic, assign)BOOL isCellExpanded;
@property(nonatomic, strong)KalViewController *kalVC;
#pragma mark - Methods
- (IBAction)showOppositeView:(id)sender;
- (IBAction)togglePresentationMode:(id)sender;

@end