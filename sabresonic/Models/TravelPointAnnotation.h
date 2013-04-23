//
//  TravelPointAnnotation.h
//  SMaps
//
//  Created by SabreSonic Web on 4/17/13.
//  Copyright (c) 2013 SabreSonic Web. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelInfo.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKPointAnnotation.h>

enum PinType
{
    Origin=0,
    Destination,
    Stop
};

@interface TravelPointAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    enum PinType pinType;
    double cost;
    NSString *title;
    NSString *subtitle;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) enum PinType pinType;
@property (nonatomic, assign) double cost;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;

- (id)initWithLocation:(CLLocationCoordinate2D)coord ForTitleString:(NSString*)titleString;
@end
