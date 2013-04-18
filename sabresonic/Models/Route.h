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

@class TravelInfo;
@interface Route : NSObject
{
    NSArray* points;
}
@property(nonatomic,retain)NSArray *points;

-(NSArray*)getAnnotationsForRoute;
-(MKOverlayView*)getOverlayForRoute;
//-(void)setRoute:(NSArray*)locationPoints ForMapView:(MKMapView*)mapView;
-(void)setRoute:(NSArray*)locationPoints ForTravelInfo:(TravelInfo*)travel ForMapView:(MKMapView*)mapView;

@end
