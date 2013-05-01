//
//  RightDemoViewController.h
//  PKRevealController
//
//  Created by Philip Kluz on 1/18/13.
//  Copyright (c) 2013 zuui.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightDemoViewController : UIViewController
{
    IBOutlet UISlider *fareFilterSlider;
}
@property(nonatomic, strong) IBOutlet UISlider *fareFilterSlider;

#pragma mark - Methods
- (IBAction)showOppositeView:(id)sender;
- (IBAction)togglePresentationMode:(id)sender;
- (IBAction)filterByFare:(id)sender;
- (IBAction)shareOnFacebook:(id)sender;
- (IBAction)shareOnTwitter:(id)sender;

@end