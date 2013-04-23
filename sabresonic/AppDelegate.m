//
//  AppDelegate.m
//  sabresonic
//
//  Created by Ramon Resma on 4/9/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import "AppDelegate.h"
#import "PKRevealController.h"
#import "FrontViewController.h"
#import "LeftDemoViewController.h"
#import "RightDemoViewController.h"
#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "CheckInWebViewController.h"
#import "PayLoadKeys.h"

@implementation AppDelegate
@synthesize  frontViewNavController,mapViewNavController,checkInWebViewNavController, travelInfo;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Step 1: Create your controllers.
    self.frontViewNavController = [[UINavigationController alloc] initWithRootViewController:[[FrontViewController alloc] init]];
    self.mapViewNavController = [[UINavigationController alloc] initWithRootViewController:[[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil]];
    self.checkInWebViewNavController = [[UINavigationController alloc] initWithRootViewController:[[CheckInWebViewController alloc] initWithNibName:@"CheckInWebViewController" bundle:nil]];

    UIViewController *rightViewController = [[RightDemoViewController alloc] init];
    UIViewController *leftViewController = [[LeftDemoViewController alloc] init];
    
    // Step 2: Configure an options dictionary for the PKRevealController if necessary - in most cases the default behaviour should suffice. See PKRevealController.h for more option keys.
    /*
     NSDictionary *options = @{
     PKRevealControllerAllowsOverdrawKey : [NSNumber numberWithBool:YES],
     PKRevealControllerDisablesFrontViewInteractionKey : [NSNumber numberWithBool:YES]
     };
     */
    
    // Step 3: Instantiate your PKRevealController.
    self.revealController = [PKRevealController revealControllerWithFrontViewController:self.frontViewNavController
                                                                     leftViewController:leftViewController
                                                                    rightViewController:rightViewController
                                                                                options:nil];
    
    // Step 4: Set it as your root view controller.
    self.window.rootViewController = self.revealController;
    
    //Load & parse JSON. Fill up it into objects
    self.travelInfo = [[TravelInfo alloc] init];
    NSError *err;
    NSStringEncoding *strEncoding = NULL;
    
    NSString *fullPathSD = [[NSBundle mainBundle] pathForResource:@"singledatejson" ofType:@"txt"];
    NSString *responseSD = [NSString stringWithContentsOfFile:fullPathSD usedEncoding:strEncoding error:&err];
    [self.travelInfo parseJSONResponseAndFillObjects:responseSD ForShoppingType:SINGLE_DATE_SHOPPING];
    
    
    //Parse Calendar Or Destination Shopping
    NSString *fullPathCD = [[NSBundle mainBundle] pathForResource:@"calendaranddestinationjson" ofType:@"txt"];
    NSString *responseCD = [NSString stringWithContentsOfFile:fullPathCD usedEncoding:strEncoding error:&err];
    [self.travelInfo parseJSONResponseAndFillObjects:responseCD ForShoppingType:CALENDARE_SHOPPING];
    
    [self.window makeKeyAndVisible];
    return YES;
    
    // Step 5: Take a look at the Left/RightDemoViewController files. They're self-sufficient as to the configuration of their reveal widths for instance.
}

@end