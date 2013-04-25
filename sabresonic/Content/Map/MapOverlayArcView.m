//
//  MapOverlayArcView.m
//  SMaps
//
//  Created by SabreSonic Web on 4/16/13.
//  Copyright (c) 2013 SabreSonic Web. All rights reserved.
//

#import "MapOverlayArcView.h"

@implementation MapOverlayArcView
@synthesize myPolyline;

/*
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
*/
- (void)createPath
{
    if(self.myPolyline == nil || self.myPolyline.pointCount <= 0)
        return;
    [self invalidatePath];
    CGPoint orgPoint = [self pointForMapPoint:self.myPolyline.points[0]];
    CGPoint destPoint = [self pointForMapPoint:self.myPolyline.points[myPolyline.pointCount-1]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, nil, orgPoint.x, orgPoint.y);
    CGPathAddLineToPoint(path, nil, destPoint.x, destPoint.y);
    //CGPathAddArcToPoint(path, nil, orgPoint.x, orgPoint.y, destPoint.x, destPoint.y, 45);
	self.path = path;
	CGPathRelease(path);
    
}
- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context
{
    CGContextAddPath(context, self.path);
    [super drawMapRect:mapRect zoomScale:zoomScale inContext:context];
}

-(id)initWithPolyline:(MKPolyline*)polyline
{
    self = [super initWithOverlay:polyline];
    if(self)
    {
        self.myPolyline = polyline;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
