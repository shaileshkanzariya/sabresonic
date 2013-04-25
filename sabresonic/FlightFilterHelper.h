//
//  FlightFilterHelper.h
//  sabresonic
//
//  Created by SabreSonic Web on 4/24/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightDetails.h"

enum FilterTypes
{
    FilterByDestination = 0,
    FilterByFare
};

@interface FlightFilterHelper : NSObject
{
}
+(NSArray*)filterArray:(NSArray*)arrayToFilter withFilterType:(enum FilterTypes)f1 byParameter:(NSObject*)para;
+(NSArray*)filterArray:(NSArray*)arrayToFilter withFilterType:(enum FilterTypes)f1 minValue:(float)mValue maxValue:(float)mxValue;
+(NSArray*)filterArray:(NSArray*)arrayToFilter;

@end
