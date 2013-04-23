//
//  TravelInfo.m
//  SMaps
//
//  Created by SabreSonic Web on 4/17/13.
//  Copyright (c) 2013 SabreSonic Web. All rights reserved.
//

#import "TravelInfo.h"
#import "JSON.h"
#import "PayLoadKeys.h"
#import "SingleDateShoppingResponse.h"
#import "FlightSegment.h"
#import "LeadPrice.h"

@implementation TravelInfo
@synthesize originLocation, destinationLocation, stops, cost, travelAttractions, travelRoutes, singledateShopping, calendarOrDestinationShopping;

//test data
+(id)createDummyInstance
{
    //NYC to Dallas
    TravelInfo *ti1 = [[TravelInfo alloc] init];
    ti1.originLocation = [[CLLocation alloc] initWithLatitude:40.7142 longitude:-74.0064];  //nyc
    ti1.destinationLocation = [[CLLocation alloc] initWithLatitude:32.7828 longitude:-96.80396]; //dallas
    ti1.stops = 1;
    ti1.cost = 100;
    ti1.travelAttractions = @"Beach";
    
    Route *r1 = [[Route alloc] init];
    [r1 setPoints:[NSArray arrayWithObjects:ti1.originLocation, ti1.destinationLocation, nil]];
     
     ti1.travelRoutes = [NSArray arrayWithObjects:r1,nil];
    
    //Chicago to Huston
    TravelInfo *ti2 = [[TravelInfo alloc] init];
    ti2.originLocation = [[CLLocation alloc] initWithLatitude:41.8500 longitude:-87.6500];  //chicago
    ti2.destinationLocation = [[CLLocation alloc] initWithLatitude:29.7631 longitude:-95.3631]; //huston
    ti2.stops = 3;
    ti2.cost = 200;
    ti2.travelAttractions = @"Adventures";
    
    Route *r2 = [[Route alloc] init];
    [r2 setPoints:[NSArray arrayWithObjects:ti2.originLocation, ti2.destinationLocation, nil]];
    
    ti2.travelRoutes = [NSArray arrayWithObjects:r2,nil];

    //NYC to Colorado
    TravelInfo *ti3 = [[TravelInfo alloc] init];
    ti3.originLocation = [[CLLocation alloc] initWithLatitude:40.7142 longitude:-74.0064];  //nyc
    ti3.destinationLocation = [[CLLocation alloc]initWithLatitude:39.0473 longitude:-105.4654]; //colorado
    ti3.stops = 5;
    ti3.cost = 300;
    ti3.travelAttractions = @"Beach, Adventures";
    
    Route *r3 = [[Route alloc] init];
    [r3 setPoints:[NSArray arrayWithObjects:ti3.originLocation, ti3.destinationLocation, nil]];
    ti3.travelRoutes = [NSArray arrayWithObjects:r3,nil];
    
    return [NSArray arrayWithObjects:ti1, ti2, ti3, nil];
}

//set point annotations and map-overlay on mapview
-(void)setAnnotaionsAndOverlayOnMapview:(MKMapView*)mapView
{
    NSArray *routes = [self travelRoutes];
    for(int i=0; i < routes.count; i++)
    {
        Route *r1 = (Route*)[routes objectAtIndex:i];
        //[r1 setRoute:r1.points ForMapView:mapView]; //sets annotaions and overlay
        [r1 setRoute:r1.points ForTravelInfo:self ForMapView:mapView];
    }
}
-(void)parseJSONResponseAndFillObjects:(NSString*)jsonResponse ForShoppingType:(NSString*)shoppingType
{
    if(jsonResponse == nil || jsonResponse.length <= 0)
        return;
    
    if([shoppingType isEqualToString:SINGLE_DATE_SHOPPING])
    {
        [self parseSingleDateShoppingJSONResponse:jsonResponse];
        NSLog(@"singledateShopping count = %d", self.singledateShopping.count);
    }
    else if([shoppingType isEqualToString:CALENDARE_SHOPPING] || [shoppingType isEqualToString:DESTINATION_SHOPPING])
    {
        [self parseCalendarOrDestinationShoppingJSONResponse:jsonResponse];
        NSLog(@"self.calendarOrDestinationShopping.leadPrices.count = %d", self.calendarOrDestinationShopping.leadPrices.count);
    }
    else
    {
        NSLog(@"Error- Shopping type does not match");
        return;
    }

}

-(void)parseSingleDateShoppingJSONResponse:(NSString*)jsonResponse
{
    singledateShopping = nil; //alwasy make this nil first to fill it with new data
    self.singledateShopping = [[NSMutableArray alloc] init];
    
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
    
    for(int i=0; i < iteniraries.count; i++)
    {
        SingleDateShoppingResponse *iten = [[SingleDateShoppingResponse alloc] init];
        
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
        [self.singledateShopping addObject:iten];
    }
}

-(void)parseCalendarOrDestinationShoppingJSONResponse:(NSString*)jsonResponse
{
    calendarOrDestinationShopping = nil; //alwasy make this nil first to fill it with new data
    self.calendarOrDestinationShopping = [[CalendarAndDestinationShoppingResponse alloc] init];
    
    NSError *err; //capture parse errro
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *dict = [parser objectWithString:jsonResponse error:&err];
    if(dict == nil)
    {
        NSLog(@"JSON Parse error = %@", err.description);
        return;
    }
    self.calendarOrDestinationShopping.origin = [dict objectForKey:ORIGIN_KEY];
    self.calendarOrDestinationShopping.destination = [dict objectForKey:DESTINATION_KEY];
    NSArray *leadPricesArray = [dict objectForKey:LEAD_PRICES_KEY];
    
    if(leadPricesArray != nil && leadPricesArray.count > 0)
        self.calendarOrDestinationShopping.leadPrices = [[NSMutableArray alloc] init];
    
    for(int i=0; i < leadPricesArray.count; i++)
    {
        LeadPrice *lp = [[LeadPrice alloc] init];
        lp.departureDate = [leadPricesArray[i] objectForKey:DEPARTURE_DATE_KEY];
        lp.returnDate = [leadPricesArray[i] objectForKey:RETURN_DATE_KEY];
        lp.minfare = [leadPricesArray[i] objectForKey:MIN_FARE_KEY];
        lp.minNonStopFare = [leadPricesArray[i] objectForKey:MIN_NONSTOP_FARE_KEY];
        
        [self.calendarOrDestinationShopping.leadPrices addObject:lp];
        
    }

}

@end
