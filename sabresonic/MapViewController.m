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
#import "AppDelegate.h"
#import "FlightFilterHelper.h"
#import "TravelInfo.h"
#import "PayLoadKeys.h"
#import "FlightDetailsWebViewController.h"

#define FLIGHT_CELL_LABEL_TAG 3000
#define FLIGHT_CELL_LABEL_ADDITION 100

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize airMapView, flightInfoTableView, filteredArray, slController;

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
    //add notification obserber
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filterFlightListNotificationReceived:) name:FILTER_FLIGHT_LIST_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareOnFBNotificationReceived:) name:SHARE_ON_FACEBOOK_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareOnFBNotificationReceived:) name:SHARE_ON_TWITTER_NOTIFICATION object:nil];
    
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
    //AppDelegate *del = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSArray *tmpTraveArray = [TravelInfo createDummyInstance];
    for(int i=0; i < tmpTraveArray.count; i++)
    {
        TravelInfo *ti = (TravelInfo*) [tmpTraveArray objectAtIndex:i];
        [ti setAnnotaionsAndOverlayOnMapview:airMapView];
    }
    
    
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
                                 UIButtonTypeRoundedRect];
        [rightButton setFrame:CGRectMake(2, 2, 60, 30)];
        [rightButton setTitle:[annotation subtitle] forState:UIControlStateNormal];
        rightButton.titleLabel.text = [annotation subtitle];
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
    UIButton *btn = (UIButton*)sender;
    //filter array by destination location code
    AppDelegate *del = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    enum FilterTypes currentFilter = FilterByDestination;
    self.filteredArray = [FlightFilterHelper filterArray:del.flightsArray withFilterType:currentFilter byParameter:btn.titleLabel.text];

    [self.flightInfoTableView reloadData];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.filteredArray != nil && self.filteredArray.count > 0)
    {
        return [self.filteredArray count];
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyFlightCellIdentifier"];
    FlightDetails *fd = [self.filteredArray objectAtIndex:indexPath.row];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyFlightCellIdentifier"];
        [cell setBackgroundColor:[UIColor clearColor]];
        //origin
        UILabel *orgLbl = [[UILabel alloc] init];
        [orgLbl setTag:FLIGHT_CELL_LABEL_TAG];
        [orgLbl setFrame:CGRectMake(5, 5, 100, 30)];
        [orgLbl setText:@"Origin: "];
        
        UILabel *orgValueLbl = [[UILabel alloc] init];
        [orgValueLbl setTag:FLIGHT_CELL_LABEL_TAG + (2*FLIGHT_CELL_LABEL_ADDITION)];
        [orgValueLbl setFrame:CGRectMake(60, 5, 100, 30)];
        orgValueLbl.text = fd.origin;
        
        //destination
        UILabel *desLbl = [[UILabel alloc] init];
        [desLbl setTag:FLIGHT_CELL_LABEL_TAG + (4*FLIGHT_CELL_LABEL_ADDITION)];
        [desLbl setFrame:CGRectMake(100, 5, 100, 30)];
        [desLbl setText:@"Destination: "];
        
        UILabel *desValueLbl = [[UILabel alloc] init];
        [desValueLbl setTag:FLIGHT_CELL_LABEL_TAG + (6*FLIGHT_CELL_LABEL_ADDITION)];
        [desValueLbl setFrame:CGRectMake(195, 5, 100, 30)];
        desValueLbl.text = fd.destination;
        
        //departure date
        UILabel *depDateLbl = [[UILabel alloc] init];
        [depDateLbl setTag:FLIGHT_CELL_LABEL_TAG + (8*FLIGHT_CELL_LABEL_ADDITION)];
        [depDateLbl setFrame:CGRectMake(5, 40, 130, 30)];
        [depDateLbl setText:@"Departure Date: "];
        
        UILabel *depDateValueLbl = [[UILabel alloc] init];
        [depDateValueLbl setTag:FLIGHT_CELL_LABEL_TAG + (10*FLIGHT_CELL_LABEL_ADDITION)];
        [depDateValueLbl setFrame:CGRectMake(150, 40, 100, 30)];
        
        depDateValueLbl.text = fd.departureDate;
        
        //retuen date
        UILabel *retDateLbl = [[UILabel alloc] init];
        [retDateLbl setTag:FLIGHT_CELL_LABEL_TAG + (12*FLIGHT_CELL_LABEL_ADDITION)];
        [retDateLbl setFrame:CGRectMake(5, 75, 130, 30)];
        [retDateLbl setText:@"Retuen Date: "];
        
        UILabel *retDateValueLbl = [[UILabel alloc] init];
        [retDateValueLbl setTag:FLIGHT_CELL_LABEL_TAG + (14*FLIGHT_CELL_LABEL_ADDITION)];
        [retDateValueLbl setFrame:CGRectMake(150, 75, 100, 30)];
        
        retDateValueLbl.text = fd.returnDate;
        
        //min fare
        UILabel *minFareLbl = [[UILabel alloc] init];
        [minFareLbl setTag:FLIGHT_CELL_LABEL_TAG + (16*FLIGHT_CELL_LABEL_ADDITION)];
        [minFareLbl setFrame:CGRectMake(5, 110, 130, 30)];
        [minFareLbl setText:@"Min Fare: "];
        
        UILabel *minFareValueLbl = [[UILabel alloc] init];
        [minFareValueLbl setTag:FLIGHT_CELL_LABEL_TAG + (18*FLIGHT_CELL_LABEL_ADDITION)];
        [minFareValueLbl setFrame:CGRectMake(150, 110, 100, 30)];
        
        [minFareValueLbl setText:[NSString stringWithFormat:@"%@",fd.minFare]];
        
        //share
        UIButton *shareFB = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [shareFB addTarget:self action:@selector(shareBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        shareFB.tag = FLIGHT_CELL_LABEL_TAG + (20*FLIGHT_CELL_LABEL_ADDITION);
        [shareFB setFrame:CGRectMake(150, 140, 100, 30)];
        if(fd.shouldShare)
        {
            [shareFB setTitle:@"Undo Share" forState:UIControlStateNormal];
        }
        else
        {
            [shareFB setTitle:@"Share" forState:UIControlStateNormal];
        }
        //add to cell
        [cell addSubview:orgLbl];
        [cell addSubview:orgValueLbl];
        [cell addSubview:desLbl];
        [cell addSubview:desValueLbl];
        [cell addSubview:depDateLbl];
        [cell addSubview:depDateValueLbl];
        [cell addSubview:retDateLbl];
        [cell addSubview:retDateValueLbl];
        [cell addSubview:minFareLbl];
        [cell addSubview:minFareValueLbl];
        [cell addSubview:shareFB];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    UILabel *orgValueLbl = (UILabel*) [cell viewWithTag:FLIGHT_CELL_LABEL_TAG + (2*FLIGHT_CELL_LABEL_ADDITION)];
    orgValueLbl.text = fd.origin;

    UILabel *desValueLbl = (UILabel*) [cell viewWithTag:FLIGHT_CELL_LABEL_TAG + (6*FLIGHT_CELL_LABEL_ADDITION)];
    desValueLbl.text = fd.destination;
    
    UILabel *depDateValueLbl = (UILabel*) [cell viewWithTag:FLIGHT_CELL_LABEL_TAG + (10*FLIGHT_CELL_LABEL_ADDITION)];
    depDateValueLbl.text = fd.departureDate;

    UILabel *retDateValueLbl = (UILabel*) [cell viewWithTag:FLIGHT_CELL_LABEL_TAG + (14*FLIGHT_CELL_LABEL_ADDITION)];
    retDateValueLbl.text = fd.returnDate;
    
    UILabel *minFareValueLbl = (UILabel*) [cell viewWithTag:FLIGHT_CELL_LABEL_TAG + (18*FLIGHT_CELL_LABEL_ADDITION)];
    [minFareValueLbl setText:[NSString stringWithFormat:@"%@",fd.minFare]];
    
    UIButton *shareFB =  (UIButton*)[cell viewWithTag:FLIGHT_CELL_LABEL_TAG + (20*FLIGHT_CELL_LABEL_ADDITION)];
    if(fd.shouldShare)
    {
        [shareFB setTitle:@"Undo Share" forState:UIControlStateNormal];
    }
    else
    {
        [shareFB setTitle:@"Share" forState:UIControlStateNormal];
    }

        return cell;
}

-(void)shareBtnTapped:(id)sender
{
    UIButton *shareBtn = (UIButton*)sender;
    UITableViewCell *cell = (UITableViewCell*) [shareBtn superview];
    int selectedRow = [self.flightInfoTableView indexPathForCell:cell].row;
    NSLog(@"Row = %d", selectedRow);
    FlightDetails *selectedFlight = [self.filteredArray objectAtIndex:selectedRow];
    if(selectedFlight.shouldShare == NO)
    {
        selectedFlight.shouldShare = YES;
        [shareBtn setTitle:@"Undo Share" forState:UIControlStateNormal];
    }
    else
    {
        selectedFlight.shouldShare = NO;
        [shareBtn setTitle:@"Share" forState:UIControlStateNormal];
    }
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
    FlightDetailsWebViewController *flightVC = [[FlightDetailsWebViewController alloc] initWithNibName:@"FlightDetailsWebViewController" bundle:[NSBundle mainBundle]];
    [appDel.mapViewNavController pushViewController:flightVC animated:YES];
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
  return @"Flight Details";
}

//notification received
-(void)filterFlightListNotificationReceived:(NSNotification*)notification
{
    if([notification.name isEqualToString:FILTER_FLIGHT_LIST_NOTIFICATION])
    {
        self.filteredArray = [[notification userInfo] valueForKey:FILTER_FLIGHT_LIST_NOTIFICATION];
        [self.flightInfoTableView reloadData];
    }
}
-(void)PostOnFacebook
{
    if(NSClassFromString(@"SLComposeViewController") != nil)
    {
        self.slController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        BOOL resFB = [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook];
        if(resFB)
        {
            [self.navigationController presentViewController:self.slController animated:YES completion:nil];
        }
        
    }
}

-(void)PostOnTwitter
{
    if(NSClassFromString(@"SLComposeViewController") != nil)
    {
        self.slController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        BOOL resTwtr = [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
        if(resTwtr)
        {
            [self.navigationController presentViewController:self.slController animated:YES completion:nil];
        }
        
    }
}

-(void)shareOnFBNotificationReceived:(NSNotification*)notification
{

    if([notification.name isEqualToString:SHARE_ON_FACEBOOK_NOTIFICATION] || [notification.name isEqualToString:SHARE_ON_TWITTER_NOTIFICATION])
    {
        NSPredicate *predic = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"shouldShare == YES"]];
        NSArray *shareFBCollection = [self.filteredArray filteredArrayUsingPredicate:predic];
        NSString *textToShare = [NSString stringWithFormat:@"I like following flights.!...what you think ?\n"];
        for(int i=0; i < shareFBCollection.count; i++)
        {
            FlightDetails *fd = shareFBCollection[i];
            textToShare = [textToShare stringByAppendingFormat:@" Origin: %@    Destination: %@\n Departure: %@   Return: %@\n Fare: USD %@", fd.origin, fd.destination, fd.departureDate, fd.returnDate, fd.minFare];
        }
        if(shareFBCollection != nil && shareFBCollection.count > 0)
        {
            if([notification.name isEqualToString:SHARE_ON_FACEBOOK_NOTIFICATION])
               {
                   [self PostOnFacebook];
               }
            else if([notification.name isEqualToString:SHARE_ON_TWITTER_NOTIFICATION])
                {
                    if(textToShare.length > 140) //twtr lenght limit
                    {
                        textToShare = [[textToShare substringToIndex:136] stringByAppendingString:@"..."];
                    }
                    [self PostOnTwitter];
                }
               
            [self.slController setInitialText:textToShare];
        }

    }
}
                    

@end
