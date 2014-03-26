//
//  JSKSolarOrbitView.m
//  Rotation
//
//  Created by Joshua Kaden on 3/22/14.
//  Copyright (c) 2014 Chadford Software. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
//  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "JSKSolarOrbitView.h"

#import "JSKEarthMoonView.h"

@interface JSKSolarOrbitView () {
    JSKEarthMoonView *_earthMoonView;
    CGFloat _lineWidth;
    CGRect _orbitFrame;
    id _backgroundObserver;
    id _foregroundObserver;
}

@property (nonatomic, strong) CAAnimation *animation;

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
            CGRect t_frame = CGRectMake(_orbitFrame.origin.x - (t_earthRadius * 2), CGRectGetMidY(self.bounds) - (t_earthRadius * 2), t_earthRadius * 4, t_earthRadius * 4);
            JSKEarthMoonView *t_view = [[JSKEarthMoonView alloc] initWithFrame:t_frame];
            t_view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
            t_view.backgroundColor = [UIColor clearColor];
            [self addSubview:t_view];
            t_view;
        });
        
        NSNotificationCenter *t_center = [NSNotificationCenter defaultCenter];
        _backgroundObserver = [t_center addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note){
            // Many thanks to cclogg's answer to http://stackoverflow.com/questions/7568567/restoring-animation-where-it-left-off-when-app-resumes-from-background?rq=1
            self.animation = [self.layer animationForKey:@"rotationAnimation"];
            [self pauseLayer:self.layer];
        }];
        
        _foregroundObserver = [t_center addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note){
            if (self.animation) {
                [self.layer addAnimation:self.animation forKey:@"rotationAnimation"];
                self.animation = nil;
            }
            [self resumeLayer:self.layer];
        }];
        
        [self addAnimation];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:_backgroundObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:_foregroundObserver];
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

#pragma mark - Animation Pause and Resume
// These methods are from https://developer.apple.com/library/ios/qa/qa1673/_index.html

-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

@end
