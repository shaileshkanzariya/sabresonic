//
//  CustomAnnotationView.m
//  sabresonic
//
//  Created by Shailesh Kanzariya on 5/3/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import "CustomAnnotationView.h"

@implementation CustomAnnotationView
@synthesize imgView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if (selected)
    {
        if (!_calloutView)
        {
            _calloutView = [[[NSBundle mainBundle] loadNibNamed:@"CustomAnnotationView" owner:self options:0] objectAtIndex:0];
            NSLog(@"%@",NSStringFromCGPoint(self.calloutOffset));
            [_calloutView sizeToFit];
            [self addSubview:_calloutView];
        }
    }
    else
    {
        //Remove your custom view...
        [_calloutView removeFromSuperview];
    }
}
/*
- (void)layoutSubviews
{
    [super layoutSubviews];
}
*/
/*
- (void)didAddSubview:(UIView *)subview{
    //  CustomMapItem *ann = self.annotation;
    //if (!self.selected)
    //{
        if ([[[subview class] description] isEqualToString:@"CustomAnnotationView"]) {
            for (UIView *subsubView in subview.subviews) {
                if ([subsubView class] == [UIImageView class]) {
                    UIImageView *imageView = ((UIImageView *)subsubView);
                    [imageView removeFromSuperview];
                }else if ([subsubView class] == [UILabel class]) {
                    UILabel *labelView = ((UILabel *)subsubView);
                    [labelView removeFromSuperview];
                }
            }
        }
    //}
}
*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
