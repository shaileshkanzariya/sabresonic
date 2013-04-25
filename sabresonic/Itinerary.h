//
//  Itinerary.h
//  sabresonic
//
//  Created by SabreSonic Web on 4/24/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Itinerary : NSObject
{
    //CurrencyCode
    NSString *currencyCode;
    //Total Price
    NSString *totalPrice;
    //Base fare
    NSString *baseFare;
    //Total Taxes
    NSString *totalTaxes;
    //Array of FlightSegments
    NSMutableArray *flightSegments;
}
@property(nonatomic, strong)NSString *currencyCode;
@property(nonatomic, strong)NSString *totalPrice;
@property(nonatomic, strong)NSString *baseFare;
@property(nonatomic, strong)NSString *totalTaxes;
@property(nonatomic, strong)NSMutableArray *flightSegments;

@end
