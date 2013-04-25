//
//  JSONResponseParser.h
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
#import "FlightDetails.h"

@interface JSONResponseParser : NSObject

+(NSMutableArray*)parseCalendarOrDestinationShoppingJSONResponse:(NSString*)jsonResponse;
+(NSMutableArray*)parseSingleDateShoppingJSONResponse:(NSString*)jsonResponse;
+(NSMutableArray*)parseJSONResponseAndFillObjects:(NSString*)jsonResponse ForShoppingType:(int)shoppingType;

@end
