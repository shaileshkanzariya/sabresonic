//
//  RightDemoViewController.m
//  PKRevealController
//
//  Created by Philip Kluz on 1/18/13.
//  Copyright (c) 2013 zuui.org. All rights reserved.
//

#import "RightDemoViewController.h"
#import "PKRevealController.h"
#import "FlightFilterHelper.h"
#import "AppDelegate.h"

@implementation RightDemoViewController
@synthesize fareFilterSlider;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set fare slider values
    [self.fareFilterSlider setMinimumValue:0.0];
    [self.fareFilterSlider setMaximumValue:1000.0];
    
    // Each view can dynamically specify the min/max width that can be revealed.
    [self.revealController setMinimumWidth:250.0f maximumWidth:270.0f forViewController:self];
}

#pragma mark - API

- (IBAction)showOppositeView:(id)sender
{
    [self.revealController showViewController:self.revealController.leftViewController];
}

- (IBAction)togglePresentationMode:(id)sender
{
    if (![self.revealController isPresentationModeActive])
    {
        [self.revealController enterPresentationModeAnimated:YES
                                                  completion:NULL];
    }
    else
    {
        [self.revealController resignPresentationModeEntirely:NO
                                                     animated:YES
                                                   completion:NULL];
    }
}
- (IBAction)filterByFare:(id)sender
{
    float sliderValue = self.fareFilterSlider.value;
    enum FilterTypes currentFilter = FilterByFare;
    AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
    
    NSArray *filteredArray  = [FlightFilterHelper filterArray:appDel.flightsArray withFilterType:currentFilter minValue:0.0 maxValue:sliderValue];
    NSDictionary *userInfoDict = [NSDictionary dictionaryWithObject:filteredArray forKey:FILTER_FLIGHT_LIST_NOTIFICATION];
    [[NSNotificationCenter defaultCenter] postNotificationName:FILTER_FLIGHT_LIST_NOTIFICATION object:nil userInfo:userInfoDict];
}

#pragma mark - Autorotation

/*
 * Please get familiar with iOS 6 new rotation handling as if you were to nest this controller within a UINavigationController,
 * the UINavigationController would _NOT_ relay rotation requests to his children on its own!
 */

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end