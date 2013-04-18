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
}
@property(nonatomic,retain)CLLocation *originLocation;
@property(nonatomic,retain)CLLocation *destinationLocation;
@property(nonatomic,assign)int stops;
@property(nonatomic,assign)double cost;
@property(nonatomic,retain)NSString *travelAttractions;
@property(nonatomic,retain)NSArray *travelRoutes;

//functions
+(id)createDummyInstance;
-(void)setAnnotaionsAndOverlayOnMapview:(MKMapView*)mapView;

@end
