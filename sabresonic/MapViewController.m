//
//  MapViewController.m
//  sabresonic
//
//  Created by SabreSonic Web on 4/17/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import "MapViewController.h"
#import "MapOverlayArcView.h"
#import "PKRevealController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize airMapView,travelArray, flightInfoTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [airMapView.delegate self];
	
    UIImage *revealImagePortrait = [UIImage imageNamed:@"reveal_menu_icon_portrait"];
    UIImage *revealImageLandscape = [UIImage imageNamed:@"reveal_menu_icon_landscape"];
    
    if (self.navigationController.revealController.type & PKRevealControllerTypeLeft)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:revealImagePortrait landscapeImagePhone:revealImageLandscape style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView:)];
    }
    
    if (self.navigationController.revealController.type & PKRevealControllerTypeRight)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:revealImagePortrait landscapeImagePhone:revealImageLandscape style:UIBarButtonItemStylePlain target:self action:@selector(showRightView:)];
    }
    
    //get test travel-data which is hard-coded
    self.travelArray = [TravelInfo createDummyInstance];
    for(int i=0; i < self.travelArray.count; i++)
    {
        TravelInfo *ti = (TravelInfo*) [self.travelArray objectAtIndex:i];
        [ti setAnnotaionsAndOverlayOnMapview:airMapView];
    }
    self.view.backgroundColor = [UIColor greenColor];
    
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MapOverlayArcView *aView = [[MapOverlayArcView alloc] initWithPolyline:overlay];
        [aView setStrokeColor:[UIColor redColor]];
        return aView;
    }
    return nil;
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // Try to dequeue an existing pin view first.
    MKPinAnnotationView*    pinView = (MKPinAnnotationView*)[airMapView
                                                             dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
    if (!pinView)
    {
        // If an existing pin view was not available, create one.
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                   reuseIdentifier:@"CustomPinAnnotationView"];
        if([[annotation subtitle] isEqualToString:@"origin"])
        {
            pinView.pinColor = MKPinAnnotationColorRed;
        }
        else
        {
            pinView.pinColor = MKPinAnnotationColorGreen;
        }
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        
        // Add a detail disclosure button to the callout.
        UIButton* rightButton = [UIButton buttonWithType:
                                 UIButtonTypeDetailDisclosure];
        [rightButton addTarget:self action:@selector(myShowDetailsMethod:)
              forControlEvents:UIControlEventTouchUpInside];
        pinView.rightCalloutAccessoryView = rightButton;
    }
    else
    {
        pinView.annotation = annotation;
    }
    
    return pinView;
}

//pin detail disclouser button tapped
-(void)myShowDetailsMethod:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Map App" message:@"I am tapped" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    CLLocationCoordinate2D centerOfMap;
    centerOfMap.latitude =  40.7142;
    centerOfMap.longitude = -74.0064;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMake(centerOfMap, MKCoordinateSpanMake(40, 40));
    //MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(locationToShow, 0, 0);
    
    [airMapView setRegion:viewRegion];
}

- (void)showLeftView:(id)sender
{
    if (self.navigationController.revealController.focusedController == self.navigationController.revealController.leftViewController)
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
    }
    else
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
    }
}

- (void)showRightView:(id)sender
{
    if (self.navigationController.revealController.focusedController == self.navigationController.revealController.rightViewController)
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
    }
    else
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.rightViewController];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyFlightCellIdentifier"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyFlightCellIdentifier"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = @"Test Label";
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate
/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
 
    UIButton *sectionHdr = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sectionHdr setEnabled:NO];
    [sectionHdr setFrame:CGRectMake(10, 10, 200, 80)];
    sectionHdr.titleLabel.text = @"Section Header";
 
    return  sectionHdr;
}
*/
/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}
*/
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return @"Section Header";
}



@end
