//
//  TravelInfo.m
//  SMaps
//
//  Created by SabreSonic Web on 4/17/13.
//  Copyright (c) 2013 SabreSonic Web. All rights reserved.
//

#import "TravelInfo.h"

@implementation TravelInfo
@synthesize originLocation, destinationLocation, stops, cost, travelAttractions, travelRoutes;

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

@end
