//
//  FlightFilterHelper.m
//  sabresonic
//
//  Created by SabreSonic Web on 4/24/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import "FlightFilterHelper.h"
#import "AppDelegate.h"
#import "PayLoadKeys.h"

@implementation FlightFilterHelper


+(NSArray*)filterArray:(NSArray*)arrayToFilter withFilterType:(enum FilterTypes)f1 byParameter:(NSObject*)para
{
    AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
    
    NSString *dest = (NSString*)para;
    
    if(appDel.filterParaDict == nil)
        appDel.filterParaDict = [NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"destination == '%@'",dest] forKey:FILTER_BY_DESTINATION];
    else
        [appDel.filterParaDict setObject:[NSString stringWithFormat:@"destination == '%@'",dest] forKey:FILTER_BY_DESTINATION];
    
    NSArray *fliterdArray = [self filterArray:arrayToFilter];
    return  fliterdArray;
}

+(NSArray*)filterArray:(NSArray*)arrayToFilter
{
    AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
    NSPredicate *predic = nil;
    NSString *predicateString = nil;
    
    NSString *destinationFilter = [appDel.filterParaDict objectForKey:FILTER_BY_DESTINATION];
    NSString *minfareFilter = [appDel.filterParaDict objectForKey:FILTER_BY_MINFARE];
    
    if(destinationFilter != nil)
        predicateString = [NSString stringWithString:destinationFilter];
    if(minfareFilter != nil)
        predicateString = [predicateString stringByAppendingString:minfareFilter];
    
    predic = [NSPredicate predicateWithFormat:predicateString];
    NSArray *fliterdArray = [arrayToFilter filteredArrayUsingPredicate:predic];
    return  fliterdArray;
}

+(NSArray*)filterArray:(NSArray*)arrayToFilter withFilterType:(enum FilterTypes)f1 minValue:(float)mValue maxValue:(float)mxValue
{
    AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
    
    if(appDel.filterParaDict == nil)
        return [NSArray arrayWithObjects:nil];
  
    [appDel.filterParaDict setObject:[NSString stringWithFormat:@" && minFare <= %f",mxValue] forKey:FILTER_BY_MINFARE];
    
    NSArray *fliterdArray = [self filterArray:arrayToFilter];
    return  fliterdArray;
}

@end
