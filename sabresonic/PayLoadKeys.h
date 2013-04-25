//
//  PayLoadKeys.h
//  sabresonic
//
//  Created by SabreSonic Web on 4/22/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayLoadKeys : NSObject

//Shopping Types
#define SINGLE_DATE_SHOPPING 0
#define CALENDARE_SHOPPING 1
#define DESTINATION_SHOPPING 3


//Single date shopping Keys
#define FLIGHT_SEARCH_RS_KEY @"FlightSearchRS"
#define ITINIRARIES_KEY @"Itineraries"

#define CURRENCY_CODE_KEY @"CurrencyCode"
#define TOTAL_PRICE_KEY @"TotalPrice"
#define BASE_FARE_KEY @"BaseFare"
#define TOTAL_TAXES_KEY @"TotalTaxes"
#define ITINERARY_KEY @"Itinerary"

#define MARKET_CARRIER_CODE_KEY @"MarketingCarrierCode"
#define FLIGHT_NUMBER_KEY @"FlightNumber"
#define ORIGIN_AIRPORT_KEY @"OriginAirport"
#define DESTINATION_AIRPORT_KEY @"DestinationAirport"
#define DEPART_TIME_KEY @"DepartTime"
#define ARRIVAL_TIME_KEY @"ArrivalTime"

//Calendar or Destination Shopping Keys
#define ORIGIN_KEY @"Origin"
#define DESTINATION_KEY @"Destination"
#define LEAD_PRICES_KEY @"LeadPrices"
#define DEPARTURE_DATE_KEY @"DepartureDate"
#define RETURN_DATE_KEY @"ReturnDate"
#define MIN_FARE_KEY @"MinFare"
#define MIN_NONSTOP_FARE_KEY @"MinNonstopFare"

//NSNotifications
#define FILTER_FLIGHT_LIST_NOTIFICATION @"FilterFlightList"
#define FILTER_BY_DESTINATION @"FilterByDestination"
#define FILTER_BY_MINFARE @"FilterByMInFare"

@end
