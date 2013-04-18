//
//  MapOverlayArcView.h
//  SMaps
//
//  Created by SabreSonic Web on 4/16/13.
//  Copyright (c) 2013 SabreSonic Web. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MapOverlayArcView : MKOverlayPathView
{
    MKPolyline *myPolyline;
}
@property(nonatomic,retain)MKPolyline *myPolyline;

-(id)initWithPolyline:(MKPolyline*)polyline;
@end
