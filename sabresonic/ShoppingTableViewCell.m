//
//  ShoppingTableViewCell.m
//  sabresonic
//
//  Created by Shailesh Kanzariya on 5/2/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import "ShoppingTableViewCell.h"

@implementation ShoppingTableViewCell
@synthesize fromLbl, fromValueLbl, startLbl, endLbl, selectStartDateBtn, selectReturndateBtn, searchBtn, delegate;	

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

-(IBAction)selectStartDateButton:(id)sender
{
    if(delegate != nil && [delegate conformsToProtocol:@protocol(ShoppingTableViewCellDelegate)] )
    {
        [delegate selectStartDateButtonTapped:sender];
    }
}

-(IBAction)selectReturnDateButton:(id)sender
{
    if(delegate != nil && [delegate conformsToProtocol:@protocol(ShoppingTableViewCellDelegate)] )
    {
        [delegate selectReturnDateButtonTapped:sender];
    }
}

-(IBAction)searchButton:(id)sender
{
    if(delegate != nil && [delegate conformsToProtocol:@protocol(ShoppingTableViewCellDelegate)] )
    {
        [delegate searchDateButtonTapped:sender];
    }
}

@end
