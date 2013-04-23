//
//  LeadPrice.h
//  sabresonic
//
//  Created by SabreSonic Web on 4/22/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeadPrice : NSObject
{
    NSString *departureDate;
    NSString *returnDate;
    NSString *minfare;
    NSString *minNonStopFare;
}
@property(nonatomic, strong)NSString *departureDate;
@property(nonatomic, strong)NSString *returnDate;
@property(nonatomic, strong)NSString *minfare;
@property(nonatomic, strong)NSString *minNonStopFare;

@end
