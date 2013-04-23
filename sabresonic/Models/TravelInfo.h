//
//  TravelInfo.h
//  SMaps
//
//  Created by SabreSonic Web on 4/17/13.
//  Copyright (c) 2013 SabreSonic Web. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Route.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKPointAnnotation.h>
#import "CalendarAndDestinationShoppingResponse.h"

@interface TravelInfo : NSObject
{
    //travel starting point
    CLLocation *originLocation;
    //travel destination point
    CLLocation *destinationLocation;
    //number of stops in between
    int stops;
    //cost of travel
    double cost;
    //travel attractions e.g beach, adventure, tracking
    NSString *travelAttractions;
    //possible available routes between origin and destination
    NSArray *travelRoutes;
    
    NSMutableArray *singledateShopping; //array of Itineraries (Itinrary)
    CalendarAndDestinationShoppingResponse *calendarOrDestinationShopping; //array of LeadPrices
}
@property(nonatomic,strong)CLLocation *originLocation;
@property(nonatomic,strong)CLLocation *destinationLocation;
@property(nonatomic,assign)int stops;
@property(nonatomic,assign)double cost;
@property(nonatomic,strong)NSString *travelAttractions;
@property(nonatomic,strong)NSArray *travelRoutes;
@property(nonatomic,strong)NSMutableArray *singledateShopping;
@property(nonatomic,strong)CalendarAndDestinationShoppingResponse *calendarOrDestinationShopping;

//functions
+(id)createDummyInstance;
-(void)setAnnotaionsAndOverlayOnMapview:(MKMapView*)mapView;
-(void)parseJSONResponseAndFillObjects:(NSString*)jsonResponse ForShoppingType:(NSString*)shoppingType;
-(void)parseSingleDateShoppingJSONResponse:(NSString*)jsonResponse;
-(void)parseCalendarOrDestinationShoppingJSONResponse:(NSString*)jsonResponse;

@end
