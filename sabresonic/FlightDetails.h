//
//  FlightDetails.h
//  sabresonic
//
//  Created by SabreSonic Web on 4/24/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayLoadKeys.h"
#import "Itinerary.h"
#import "JSON.h"
#import "FlightSegment.h"

@interface FlightDetails : NSObject
{
    NSString *origin;
    NSString *destination;
    NSString *departureDate;
    NSString *returnDate;
    NSString *minFare;
    NSString *minNonstopFare;
    Itinerary *itinerary; //array ob "Itinerary" objects
}
@property(nonatomic, strong)NSString *origin;
@property(nonatomic, strong)NSString *destination;
@property(nonatomic, strong)NSString *departureDate;
@property(nonatomic, strong)NSString *returnDate;
@property(nonatomic, strong)NSString *minFare;
@property(nonatomic, strong)NSString *minNonstopFare;
@property(nonatomic, strong)Itinerary *itinerary;

@end
