//
//  FlightDetailsTableViewCell.m
//  sabresonic
//
//  Created by Shailesh Kanzariya on 5/1/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import "FlightDetailsTableViewCell.h"

@implementation FlightDetailsTableViewCell
@synthesize originLbl, destinationLbl, departureDateLbl, returndateLbl, minFareLbl, shareBtn, delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSString *) reuseIdentifier {
    return @"MyFlightCellIdentifier";
}
-(void)shareBtnTapped:(id)sender
{
    if(delegate != nil && [delegate conformsToProtocol:@protocol(FlightTableViewCellDelegate)] )
    {
        [delegate shareBtnTapped:sender];
    }
}

@end
