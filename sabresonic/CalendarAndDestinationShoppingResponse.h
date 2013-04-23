//
//  CalendarAndDestinationResponse.h
//  sabresonic
//
//  Created by SabreSonic Web on 4/22/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarAndDestinationShoppingResponse : NSObject
{
    NSString *origin;
    NSString *destination;
    NSMutableArray *leadPrices;
}
@property(nonatomic, strong)NSString *origin;
@property(nonatomic, strong)NSString *destination;
@property(nonatomic, strong)NSMutableArray *leadPrices;

@end
