//
//  JSKEarthView.m
//  Rotation
//
//  Created by Joshua Kaden on 3/21/14.
//  Copyright (c) 2014 Chadford Software. All rights reserved.
//

#import "JSKEarthView.h"

@interface JSKEarthView ()

- (void)addAnimation;

@end

@implementation JSKEarthView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.rotationDuration = 1;
        [self addAnimation];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGFloat t_lineWidth = 1.0;
    
    CGRect t_frame = CGRectMake(self.bounds.origin.x + t_lineWidth, self.bounds.origin.y + t_lineWidth, self.bounds.size.width - (t_lineWidth * 2), self.bounds.size.height - (t_lineWidth * 2));
    UIBezierPath *t_path = [UIBezierPath bezierPathWithOvalInRect:t_frame];
    t_path.lineWidth = t_lineWidth;
    [[UIColor blackColor] setStroke];
    [t_path stroke];
    [[UIColor lightGrayColor] setFill];
    [t_path fill];
    
    t_path = [UIBezierPath bezierPath];
    [t_path moveToPoint:CGPointMake(t_lineWidth, CGRectGetMidY(t_frame))];
    [t_path addLineToPoint:CGPointMake(CGRectGetMaxX(t_frame), CGRectGetMidY(t_frame))];
    [t_path stroke];
}

- (void)addAnimation
{
    CABasicAnimation *t_animation;
    t_animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    t_animation.toValue = [NSNumber numberWithFloat: M_PI * -2.0];
    t_animation.duration = self.rotationDuration;
    t_animation.cumulative = YES;
    t_animation.repeatCount = HUGE_VALF;
    
    [self.layer addAnimation:t_animation forKey:@"rotationAnimation"];
}

@end
