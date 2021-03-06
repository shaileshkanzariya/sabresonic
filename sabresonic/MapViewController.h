//
//  MapViewController.h
//  sabresonic
//
//  Created by SabreSonic Web on 4/17/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKPointAnnotation.h>
#import "Route.h"
#import "TravelInfo.h"
#import "TravelPointAnnotation.h"
#import  <Social/Social.h>
#import "FlightDetailsTableViewCell.h"

@interface MapViewController : UIViewController <FlightTableViewCellDelegate>
{
    Route *r1,*r2,*r3;
    IBOutlet MKMapView *airMapView;
    IBOutlet UITableView *flightInfoTableView;
    NSArray *filteredArray;
    SLComposeViewController *slController;
}
@property (nonatomic, strong) IBOutlet MKMapView *airMapView;
@property (nonatomic, strong) IBOutlet UITableView *flightInfoTableView;
@property (nonatomic, strong) NSArray *filteredArray;
@property (nonatomic, strong) SLComposeViewController *slController;

-(void)PostOnTwitter;
-(void)PostOnFacebook;

@end
