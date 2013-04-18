//
//  TravelPointAnnotation.m
//  SMaps
//
//  Created by SabreSonic Web on 4/17/13.
//  Copyright (c) 2013 SabreSonic Web. All rights reserved.
//

#import "TravelPointAnnotation.h"

@implementation TravelPointAnnotation
@synthesize coordinate, pinType, cost, title, subtitle;

//init
- (id)initWithLocation:(CLLocationCoordinate2D)coord ForTitleString:(NSString*)titleString
{
    self = [super init];
    if (self) {
        coordinate = coord;
    }
    return self;
}
@end
