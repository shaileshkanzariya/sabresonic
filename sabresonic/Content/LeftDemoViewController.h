//
//  LeftDemoViewController.h
//  PKRevealController
//
//  Created by Philip Kluz on 1/18/13.
//  Copyright (c) 2013 zuui.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"

@interface LeftDemoViewController : UIViewController
{
    NSArray *tableViewDataSourceArray;
    UITableView *leftDemoTableView;
    NSIndexPath *selectedRawIndexPath;
    IBOutlet CustomTableViewCell *customCell;
    BOOL isCellExpanded;
}
#pragma mark - Propertires
@property(nonatomic, strong)NSArray *tableViewDataSourceArray;
@property(nonatomic, strong)UITableView *leftDemoTableView;
@property(nonatomic, strong)NSIndexPath *selectedRawIndexPath;
@property(nonatomic, strong)IBOutlet CustomTableViewCell *customCell;
@property(nonatomic, assign)BOOL isCellExpanded;

#pragma mark - Methods
- (IBAction)showOppositeView:(id)sender;
- (IBAction)togglePresentationMode:(id)sender;

@end