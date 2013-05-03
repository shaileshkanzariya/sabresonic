//
//  CustomAnnotationView.h
//  sabresonic
//
//  Created by Shailesh Kanzariya on 5/3/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface CustomAnnotationView : MKPinAnnotationView
{
    IBOutlet UIImageView *imgView;
}
@property (strong, nonatomic) UIView *calloutView;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@end
