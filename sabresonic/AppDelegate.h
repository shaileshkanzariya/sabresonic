//
//  AppDelegate.h
//  sabresonic
//
//  Created by Ramon Resma on 4/9/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrontViewController.h"
#import "MapViewController.h"
#import "TravelInfo.h"

@class PKRevealController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *frontViewNavController;
    UINavigationController *mapViewNavController;
    UINavigationController *checkInWebViewNavController;
    TravelInfo *travelInfo;
}
@property (nonatomic, strong, readwrite) PKRevealController *revealController;
@property (nonatomic, strong) UINavigationController *frontViewNavController;
@property (nonatomic, strong) UINavigationController *mapViewNavController;
@property (nonatomic, strong) UINavigationController *checkInWebViewNavController;
@property (nonatomic, strong) TravelInfo *travelInfo;
@property (nonatomic, strong) UIWindow *window;

@end
