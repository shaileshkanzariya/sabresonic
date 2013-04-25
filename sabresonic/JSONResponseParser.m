//
//  JSONResponseParser.m
//  sabresonic
//
//  Created by SabreSonic Web on 4/24/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import "JSONResponseParser.h"

@implementation JSONResponseParser

+(NSMutableArray*)parseJSONResponseAndFillObjects:(NSString*)jsonResponse ForShoppingType:(int)shoppingType
{
    if(jsonResponse == nil || jsonResponse.length <= 0)
        return [NSMutableArray arrayWithObjects:nil];
    
    NSMutableArray *flights = nil;
    switch (shoppingType) {
        case SINGLE_DATE_SHOPPING:
        {
            flights = [self parseSingleDateShoppingJSONResponse:jsonResponse];
            NSLog(@"flight details count = %d", flights.count);
            
            break;
        }
        case (CALENDARE_SHOPPING | DESTINATION_SHOPPING):
        {
            flights = [self parseCalendarOrDestinationShoppingJSONResponse:jsonResponse];
            NSLog(@"flight details count = %d", flights.count);
            
            break;
        }
        default:
        {
            NSLog(@"Error- Shopping type does not match");
        }
            break;
    }
    return flights;
}

+(NSMutableArray*)parseSingleDateShoppingJSONResponse:(NSString*)jsonResponse
{
    
    NSError *err; //capture parse errro
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *dict = [parser objectWithString:jsonResponse error:&err];
    if(dict == nil)
    {
        NSLog(@"JSON Parse error = %@", err.description);
        return [NSMutableArray arrayWithObjects:nil];
    }
    NSDictionary*flightSearchRSValue =  [dict objectForKey:FLIGHT_SEARCH_RS_KEY];
    if(flightSearchRSValue == nil || flightSearchRSValue.count <= 0)
    {
        return [NSMutableArray arrayWithObjects:nil];
    }
    NSArray *iteniraries = [flightSearchRSValue objectForKey:ITINIRARIES_KEY];
    if(iteniraries == nil || iteniraries.count <= 0)
        return [NSMutableArray arrayWithObjects:nil];
    
    NSMutableArray *flights = [[NSMutableArray alloc] init];
    
    for(int i=0; i < iteniraries.count; i++)
    {
        FlightDetails *fd = [[FlightDetails alloc]init];
        fd.itinerary = [[Itinerary alloc] init];
        
        fd.itinerary.currencyCode = [iteniraries[i] objectForKey:CURRENCY_CODE_KEY];
        fd.itinerary.totalPrice = [iteniraries[i] objectForKey:TOTAL_PRICE_KEY];
        fd.itinerary.baseFare = [iteniraries[i] objectForKey:BASE_FARE_KEY];
        fd.itinerary.totalTaxes = [iteniraries[i] objectForKey:TOTAL_TAXES_KEY];
        
        NSArray *itenrary = [iteniraries[i] objectForKey:ITINERARY_KEY];
        
        if(itenrary != nil || itenrary.count > 0)
            fd.itinerary.flightSegments = [[NSMutableArray alloc] init];
        
        for(int j=0; j < itenrary.count; j++)
        {
            FlightSegment *fs = [[FlightSegment alloc] init];
            fs.marketCarrierCode = [itenrary[j] objectForKey:MARKET_CARRIER_CODE_KEY];
            fs.flightNumber = [itenrary[j] objectForKey:FLIGHT_NUMBER_KEY];
            fs.originAirport = [itenrary[j] objectForKey:ORIGIN_AIRPORT_KEY];
            fs.destinationAirport = [itenrary[j] objectForKey:DESTINATION_AIRPORT_KEY];
            fs.departTime = [itenrary[j] objectForKey:DEPART_TIME_KEY];
            fs.arrivalTime = [itenrary[j] objectForKey:ARRIVAL_TIME_KEY];
            
            [fd.itinerary.flightSegments addObject:fs];
        }

        [flights addObject:fd];
    }

    return flights;
}

+(NSMutableArray*)parseCalendarOrDestinationShoppingJSONResponse:(NSString*)jsonResponse
{
    NSError *err; //capture parse errro
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *dict = [parser objectWithString:jsonResponse error:&err];
    if(dict == nil)
    {
        NSLog(@"JSON Parse error = %@", err.description);
        return [NSMutableArray arrayWithObjects:nil];
    }
    NSMutableArray *flights = [[NSMutableArray alloc] init];
    NSArray *leadPricesArray = [dict objectForKey:LEAD_PRICES_KEY];
    
    for(int i=0; i < leadPricesArray.count; i++)
    {
        FlightDetails *fd = [[FlightDetails alloc] init];
        fd.origin = [dict objectForKey:ORIGIN_KEY];
        fd.destination = [leadPricesArray[i] objectForKey:DESTINATION_KEY];


        fd.departureDate = [dict objectForKey:DEPARTURE_DATE_KEY];
        fd.returnDate = [dict objectForKey:RETURN_DATE_KEY];
        fd.minFare = [leadPricesArray[i] objectForKey:MIN_FARE_KEY];
        fd.minNonstopFare = [leadPricesArray[i] objectForKey:MIN_NONSTOP_FARE_KEY];
        
        [flights addObject:fd];
    }
    return flights;
}

@end
