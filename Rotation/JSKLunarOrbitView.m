//
//  JSKLunarOrbitView.m
//  Rotation
//
//  Created by Joshua Kaden on 3/21/14.
//  Copyright (c) 2014 Chadford Software. All rights reserved.
//

#import "JSKLunarOrbitView.h"

@interface JSKLunarOrbitView ()

- (void)addAnimation;

@end

@implementation JSKLunarOrbitView

@synthesize rotationDuration = _rotationDuration;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.rotationDuration = 1.0;
        [self addAnimation];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGFloat t_lineWidth = 1.0;
    CGFloat t_moonRadius = self.bounds.size.width / 15;
    
    // The orbit circle.
    CGRect t_frame = CGRectMake(t_lineWidth + t_moonRadius, t_lineWidth + t_moonRadius, self.bounds.size.width - (t_lineWidth * 2) - (t_moonRadius * 2), self.bounds.size.height - (t_lineWidth * 2) - (t_moonRadius * 2));
    UIBezierPath *t_path = [UIBezierPath bezierPathWithOvalInRect:t_frame];
    t_path.lineWidth = t_lineWidth;
    [[UIColor grayColor] setStroke];
    [t_path stroke];
    
    // The moon itself.
    CGRect t_moonFrame = CGRectMake(t_lineWidth, CGRectGetMidY(self.bounds) - t_moonRadius, t_moonRadius * 2, t_moonRadius * 2);
    t_path = [UIBezierPath bezierPathWithOvalInRect:t_moonFrame];
    [[UIColor blackColor] setStroke];
    [t_path stroke];
    [[UIColor lightGrayColor] setFill];
    [t_path fill];
    
    t_path = [UIBezierPath bezierPath];
    [t_path moveToPoint:CGPointMake(t_moonFrame.origin.x, CGRectGetMidY(t_moonFrame))];
    [t_path addLineToPoint:CGPointMake(CGRectGetMaxX(t_moonFrame), CGRectGetMidY(t_moonFrame))];
    [t_path stroke];
}

- (CGFloat)rotationDuration
{
    return _rotationDuration / 27.3;
}

- (void)setRotationDuration:(CGFloat)rotationDuration
{
    _rotationDuration = rotationDuration * 27.3;
}

- (void)addAnimation
{
    CABasicAnimation *t_animation;
    t_animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    t_animation.toValue = [NSNumber numberWithFloat: M_PI * -2.0];
    t_animation.duration = _rotationDuration;
    t_animation.cumulative = YES;
    t_animation.repeatCount = HUGE_VALF;
    
    [self.layer addAnimation:t_animation forKey:@"rotationAnimation"];
}

@end
