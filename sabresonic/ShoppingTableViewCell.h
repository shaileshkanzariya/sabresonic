//
//  ShoppingTableViewCell.h
//  sabresonic
//
//  Created by Shailesh Kanzariya on 5/2/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShoppingTableViewCellDelegate <NSObject>

@required
-(void)selectStartDateButtonTapped:(id)sender;
-(void)selectReturnDateButtonTapped:(id)sender;
-(void)searchDateButtonTapped:(id)sender;
@end

@interface ShoppingTableViewCell : UITableViewCell
{
    IBOutlet UILabel *fromLbl;
    IBOutlet UILabel *fromValueLbl;
    IBOutlet UILabel *startLbl;
    IBOutlet UILabel *endLbl;
    IBOutlet UIButton *selectStartDateBtn;
    IBOutlet UIButton *selectReturndateBtn;
    IBOutlet UIButton *searchBtn;
    id<ShoppingTableViewCellDelegate> __weak delegate;
}
@property(nonatomic, strong)IBOutlet UILabel *fromLbl;
@property(nonatomic, strong)IBOutlet UILabel *fromValueLbl;
@property(nonatomic, strong)IBOutlet UILabel *startLbl;
@property(nonatomic, strong)IBOutlet UILabel *endLbl;
@property(nonatomic, strong)IBOutlet UIButton *selectStartDateBtn;
@property(nonatomic, strong)IBOutlet UIButton *selectReturndateBtn;
@property(nonatomic, strong)IBOutlet UIButton *searchBtn;
@property(nonatomic, weak)id<ShoppingTableViewCellDelegate> delegate;

-(IBAction)selectStartDateButton:(id)sender;
-(IBAction)selectReturnDateButton:(id)sender;
-(IBAction)searchButton:(id)sender;

@end
