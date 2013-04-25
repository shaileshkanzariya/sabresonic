//
//  Route.h
//  SMaps
//
//  Created by SabreSonic Web on 4/15/13.
//  Copyright (c) 2013 SabreSonic Web. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import  <MapKit/MKAnnotation.h>
#import <MapKit/MKPointAnnotation.h>
#import  <MapKit/MKAnnotation.h>
#import <MapKit/MKPointAnnotation.h>
#import "TravelPointAnnotation.h"

@class TravelInfo; //forward declaration
//This class contains information/data to  show pin and route on the map
@interface Route : NSObject
{
    //points to draw line on. As of now starting & end point for drawing a line in between
    NSArray* points;
}
#pragma mark Properties
@property(nonatomic,strong)NSArray *points;

#pragma mark Functions
-(NSArray*)getAnnotationsForRoute;
-(MKOverlayView*)getOverlayForRoute;
-(void)setRoute:(NSArray*)locationPoints ForTravelInfo:(TravelInfo*)travel ForMapView:(MKMapView*)mapView;

@end
