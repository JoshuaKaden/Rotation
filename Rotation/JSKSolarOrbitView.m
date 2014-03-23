//
//  JSKSolarOrbitView.m
//  Rotation
//
//  Created by Joshua Kaden on 3/22/14.
//  Copyright (c) 2014 Chadford Software. All rights reserved.
//

#import "JSKSolarOrbitView.h"

#import "JSKEarthMoonView.h"

@interface JSKSolarOrbitView () {
    JSKEarthMoonView *_earthMoonView;
    CGFloat _lineWidth;
    CGRect _orbitFrame;
}

- (void)addAnimation;

@end

@implementation JSKSolarOrbitView

@synthesize rotationDuration = _rotationDuration;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.rotationDuration = 1.0;
        
        _lineWidth = 1.0;
        CGFloat t_earthRadius = self.bounds.size.width / 15;
        CGFloat t_diameter = self.bounds.size.width - (_lineWidth * 2) - (t_earthRadius * 2);
        _orbitFrame = CGRectMake(_lineWidth + t_earthRadius, _lineWidth + t_earthRadius, t_diameter, t_diameter);
        
        // The earth and moon.
        _earthMoonView = ({
            CGRect t_frame = CGRectMake(_lineWidth, CGRectGetMidY(self.bounds) - t_earthRadius * 2, t_earthRadius * 4, t_earthRadius * 4);
            JSKEarthMoonView *t_view = [[JSKEarthMoonView alloc] initWithFrame:t_frame];
            t_view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
            t_view.backgroundColor = [UIColor clearColor];
            [self addSubview:t_view];
            t_view;
        });
        
        [self addAnimation];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    // The orbit circle.
    UIBezierPath *t_path = [UIBezierPath bezierPathWithOvalInRect:_orbitFrame];
    t_path.lineWidth = _lineWidth;
    [[UIColor grayColor] setStroke];
    [t_path stroke];
}

- (CGFloat)rotationDuration
{
    return _rotationDuration / 365.0;
}

- (void)setRotationDuration:(CGFloat)rotationDuration
{
    _rotationDuration = rotationDuration * 365.0;
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
