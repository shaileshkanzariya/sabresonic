//
//  FlightDetailsTableViewCell.h
//  sabresonic
//
//  Created by Shailesh Kanzariya on 5/1/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlightTableViewCellDelegate <NSObject>

@required
-(void)shareBtnTapped:(id)sender;
@end

@interface FlightDetailsTableViewCell : UITableViewCell
{
    IBOutlet UILabel *originLbl;
    IBOutlet UILabel *destinationLbl;
    IBOutlet UILabel *departureDateLbl;
    IBOutlet UILabel *returndateLbl;
    IBOutlet UILabel *minFareLbl;
    IBOutlet UIButton *shareBtn;
    id<FlightTableViewCellDelegate> __weak delegate;
}
@property(nonatomic, strong)UILabel *originLbl;
@property(nonatomic, strong)UILabel *destinationLbl;
@property(nonatomic, strong)UILabel *departureDateLbl;
@property(nonatomic, strong)UILabel *returndateLbl;
@property(nonatomic, strong)UILabel *minFareLbl;
@property(nonatomic, strong)IBOutlet UIButton *shareBtn;
@property(nonatomic, weak)id<FlightTableViewCellDelegate> delegate;

- (IBAction)shareBtnTapped:(id)sender;

@end
