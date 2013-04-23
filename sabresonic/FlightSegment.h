//
//  FlightSegment.h
//  sabresonic
//
//  Created by SabreSonic Web on 4/22/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightSegment : NSObject
{
    //Marketing Carrier Code
    NSString *marketCarrierCode;
    //FlightNumber
    NSString *flightNumber;
    //Origin Airport
    NSString *originAirport;
    //Destination Airport
    NSString *destinationAirport;
    //DepartTime
    NSString *departTime;
    //ArrivalTime
    NSString *arrivalTime;
}
@property(nonatomic, strong)NSString *marketCarrierCode;
@property(nonatomic, strong)NSString *flightNumber;
@property(nonatomic, strong)NSString *originAirport;
@property(nonatomic, strong)NSString *destinationAirport;
@property(nonatomic, strong)NSString *departTime;
@property(nonatomic, strong)NSString *arrivalTime;

@end
