//
//  Route.m
//  SMaps
//
//  Created by SabreSonic Web on 4/15/13.
//  Copyright (c) 2013 SabreSonic Web. All rights reserved.
//

#import "Route.h"
#import "MapOverlayArcView.h"
#import "TravelLocation.h"

@implementation Route

@synthesize points;

-(NSArray*)getAnnotationsForRoute
{
    if(points == nil || points.count <= 0)
        return [NSArray arrayWithObjects: nil]; //avoid crash and return array with zero objects
    
    //origin point will be always first object into points-array
    MKPointAnnotation *p1 = [[MKPointAnnotation alloc]init];
    CLLocation *startPoint = self.points[0];
    [p1 setCoordinate:startPoint.coordinate];
    
    //destination point will be always last object into points-array
    MKPointAnnotation *p2 = [[MKPointAnnotation alloc]init];
    CLLocation *endPoint = self.points[[self.points count]-1];
    [p2 setCoordinate:endPoint.coordinate];
    
    return [NSArray arrayWithObjects:p1,p2, nil];
}

-(NSArray*)getAnnotationsForRoute:(NSArray*)locationPoints ForTravelInfo:(TravelInfo*)travel
{
    if(locationPoints == nil || locationPoints.count <= 0)
        return [NSArray arrayWithObjects: nil]; //avoid crash and return array with zero objects
    
    [self setPoints:locationPoints];
    
    MKPointAnnotation *a1 = [[MKPointAnnotation alloc]init];
    if(travel != nil)
    {
        [a1 setTitle:[NSString stringWithFormat:@"$%f",travel.cost]];
        [a1 setSubtitle:@"origin"];
    }
    TravelLocation *startPoint = self.points[0];
    [a1 setCoordinate:startPoint.location.coordinate];
    
    MKPointAnnotation *a2 = [[MKPointAnnotation alloc]init];
    if(travel != nil)
    {
        [a2 setTitle:[NSString stringWithFormat:@"$%f",travel.cost]];
    }
    TravelLocation *endPoint = self.points[[self.points count]-1];
    [a2 setCoordinate:endPoint.location.coordinate];
    [a2 setSubtitle:endPoint.locationCode];
    
    //in case if we require custom annotation objects then uncomment below
    /*
    CLLocation *startPoint = self.points[0];
    CLLocation *endPoint = self.points[[self.points count]-1];
    
    TravelPointAnnotation *a1 = [[[TravelPointAnnotation alloc] initWithLocation:startPoint.coordinate] autorelease];
    TravelPointAnnotation *a2 = [[[TravelPointAnnotation alloc] initWithLocation:endPoint.coordinate] autorelease];
    */
    
    return [NSArray arrayWithObjects:a1,a2, nil];
}

-(MKOverlayView*)getOverlayForRoute
{
    if(points == nil)
        return nil;
    //add map overlay
    MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * 2);
    for(int i=0; i < self.points.count;i++)
    {
        CLLocation *location = self.points[i];
        pointArr[i] = MKMapPointForCoordinate(location.coordinate);
    }
    MKPolyline *line = [MKPolyline polylineWithPoints:pointArr count:self.points.count];

    return (MKOverlayView*)line;
}
/*
-(MKOverlayView*)getOverlayForRoute:(NSArray*)locationPoints
{
    if(locationPoints == nil)
        return nil;
    [self setPoints:locationPoints];
    //add map overlay
    MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * 2);
    for(int i=0; i < self.points.count;i++)
    {
        CLLocation *location = self.points[i];
        pointArr[i] = MKMapPointForCoordinate(location.coordinate);
    }
    MKPolyline *line = [MKPolyline polylineWithPoints:pointArr count:self.points.count];
    return (MKOverlayView*)line;
}
*/

-(MKOverlayView*)getOverlayForRoute:(NSArray*)locationPoints
{
    if(locationPoints == nil ||  locationPoints.count <= 0)
        return nil;
    for(int i=0; i < locationPoints.count; i++)
    {
        TravelLocation *tl = (TravelLocation*)locationPoints[i];
        NSLog(@"point = %f, %f", tl.location.coordinate.latitude, tl.location.coordinate.longitude);
    }
    [self setPoints:locationPoints];
    //add map overlay
    MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * 2);
    for(int i=0; i < self.points.count;i++)
    {
        TravelLocation *location = self.points[i];
        pointArr[i] = MKMapPointForCoordinate(location.location.coordinate);
    }
    MKPolyline *line = [MKPolyline polylineWithPoints:pointArr count:self.points.count];
    
    return (MKPolylineView*)line;
}
/*
-(void)setRoute:(NSArray*)locationPoints ForMapView:(MKMapView*)mapView
{
    if(locationPoints == nil ||  locationPoints.count <= 0 ||  mapView == nil)
        return;
    [mapView addAnnotations:[self getAnnotationsForRoute:locationPoints]];
    [mapView addOverlay:(MKPolyline*)[self getOverlayForRoute:locationPoints]];
}
*/

-(void)setRoute:(NSArray*)locationPoints ForTravelInfo:(TravelInfo*)travel ForMapView:(MKMapView*)mapView
{
    if(locationPoints == nil ||  locationPoints.count <= 0 ||  mapView == nil)
        return;
    [mapView addAnnotations:[self getAnnotationsForRoute:locationPoints ForTravelInfo:travel]];
    [mapView addOverlay:(MKPolyline*)[self getOverlayForRoute:locationPoints]];
}

@end
