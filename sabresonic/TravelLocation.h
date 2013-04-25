//
//  TravelLocation.h
//  sabresonic
//
//  Created by SabreSonic Web on 4/23/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKPointAnnotation.h>

@interface TravelLocation : NSObject
{
    //location
    CLLocation *location;
    //location code
    NSString *locationCode;
}
@property(nonatomic, strong)CLLocation *location;
@property(nonatomic, strong)NSString *locationCode;

@end
