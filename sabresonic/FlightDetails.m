//
//  FlightDetails.m
//  sabresonic
//
//  Created by SabreSonic Web on 4/24/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import "FlightDetails.h"


@implementation FlightDetails
@synthesize origin, destination, departureDate, returnDate, minFare, minNonstopFare, itinerary, isSharedOnFB;

/*
-(void)parseJSONResponseAndFillObjects:(NSString*)jsonResponse ForShoppingType:(int)shoppingType
{
    if(jsonResponse == nil || jsonResponse.length <= 0)
        return;
    switch (shoppingType) {
        case SINGLE_DATE_SHOPPING:
        {
            [self parseSingleDateShoppingJSONResponse:jsonResponse];
            NSLog(@"singledateShopping count = %d", self.singleDateShoppingResponseObject.itineraries.count);
            
            break;
        }
        case (CALENDARE_SHOPPING | DESTINATION_SHOPPING):
        {
            [self parseCalendarOrDestinationShoppingJSONResponse:jsonResponse];
            NSLog(@"self.calendarOrDestinationShopping.leadPrices.count = %d", self.calendarOrDestinationShoppingObject.leadPrices.count);
            
            break;
        }
        default:
        {
            NSLog(@"Error- Shopping type does not match");
        }
            break;
    }
}

-(void)parseSingleDateShoppingJSONResponse:(NSString*)jsonResponse
{
    
    NSError *err; //capture parse errro
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *dict = [parser objectWithString:jsonResponse error:&err];
    if(dict == nil)
    {
        NSLog(@"JSON Parse error = %@", err.description);
        return;
    }
    NSDictionary*flightSearchRSValue =  [dict objectForKey:FLIGHT_SEARCH_RS_KEY];
    if(flightSearchRSValue == nil || flightSearchRSValue.count <= 0)
    {
        return;
    }
    NSArray *iteniraries = [flightSearchRSValue objectForKey:ITINIRARIES_KEY];
    if(iteniraries == nil || iteniraries.count <= 0)
        return;
    self.itineraries = [NSMutableArray arrayWithObjects:nil]; //return with zerp objs to avoid crash
    
    for(int i=0; i < iteniraries.count; i++)
    {
        Itinerary *iten = [[Itinerary alloc] init];
        
        iten.currencyCode = [iteniraries[i] objectForKey:CURRENCY_CODE_KEY];
        iten.totalPrice = [iteniraries[i] objectForKey:TOTAL_PRICE_KEY];
        iten.baseFare = [iteniraries[i] objectForKey:BASE_FARE_KEY];
        iten.totalTaxes = [iteniraries[i] objectForKey:TOTAL_TAXES_KEY];
        
        NSArray *itenrary = [iteniraries[i] objectForKey:ITINERARY_KEY];
        
        if(itenrary != nil || itenrary.count > 0)
            iten.flightSegments = [[NSMutableArray alloc] init];
        
        for(int j=0; j < itenrary.count; j++)
        {
            FlightSegment *fs = [[FlightSegment alloc] init];
            fs.marketCarrierCode = [itenrary[j] objectForKey:MARKET_CARRIER_CODE_KEY];
            fs.flightNumber = [itenrary[j] objectForKey:FLIGHT_NUMBER_KEY];
            fs.originAirport = [itenrary[j] objectForKey:ORIGIN_AIRPORT_KEY];
            fs.destinationAirport = [itenrary[j] objectForKey:DESTINATION_AIRPORT_KEY];
            fs.departTime = [itenrary[j] objectForKey:DEPART_TIME_KEY];
            fs.arrivalTime = [itenrary[j] objectForKey:ARRIVAL_TIME_KEY];
            
            [iten.flightSegments addObject:fs];
        }
        [self.itineraries addObject:iten];
    }
}

-(void)parseCalendarOrDestinationShoppingJSONResponse:(NSString*)jsonResponse
{
    calendarOrDestinationShoppingObject = nil; //alwasy make this nil first to fill it with new data
    self.calendarOrDestinationShoppingObject = [[CalendarAndDestinationShoppingResponse alloc] init];
    
    NSError *err; //capture parse errro
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *dict = [parser objectWithString:jsonResponse error:&err];
    if(dict == nil)
    {
        NSLog(@"JSON Parse error = %@", err.description);
        return;
    }
    self.calendarOrDestinationShoppingObject.origin = [dict objectForKey:ORIGIN_KEY];
    self.calendarOrDestinationShoppingObject.destination = [dict objectForKey:DESTINATION_KEY];
    NSArray *leadPricesArray = [dict objectForKey:LEAD_PRICES_KEY];
    
    if(leadPricesArray != nil && leadPricesArray.count > 0)
        self.calendarOrDestinationShoppingObject.leadPrices = [[NSMutableArray alloc] init];
    
    for(int i=0; i < leadPricesArray.count; i++)
    {
        LeadPrice *lp = [[LeadPrice alloc] init];
        lp.departureDate = [leadPricesArray[i] objectForKey:DEPARTURE_DATE_KEY];
        lp.returnDate = [leadPricesArray[i] objectForKey:RETURN_DATE_KEY];
        lp.minfare = [leadPricesArray[i] objectForKey:MIN_FARE_KEY];
        lp.minNonStopFare = [leadPricesArray[i] objectForKey:MIN_NONSTOP_FARE_KEY];
        
        [self.calendarOrDestinationShoppingObject.leadPrices addObject:lp];
}
    
}
*/
@end
