//
//  JSKEarthView.m
//  Rotation
//
//  Created by Joshua Kaden on 3/21/14.
//  Copyright (c) 2014 Chadford Software. All rights reserved.
//

#import "JSKEarthView.h"

@interface JSKEarthView () {
    id _backgroundObserver;
    id _foregroundObserver;
}

@property (nonatomic, strong) CAAnimation *animation;

- (void)startAnimating;

@end

@implementation JSKEarthView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.rotationDuration = 1;
        
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
        
        [self startAnimating];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGFloat t_lineWidth = 1.0;
    CGFloat t_diameter = self.bounds.size.width - (t_lineWidth * 2);
    
    CGRect t_frame = CGRectMake(t_lineWidth, t_lineWidth, t_diameter, t_diameter);
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:_backgroundObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:_foregroundObserver];
}

- (void)startAnimating
{
    if (!self.animation) {
        self.animation = ({
            CABasicAnimation *t_animation;
            t_animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            t_animation.toValue = [NSNumber numberWithFloat: M_PI * -2.0];
            t_animation.duration = self.rotationDuration;
            t_animation.cumulative = YES;
            t_animation.repeatCount = HUGE_VALF;
            t_animation;
        });
    }
    
    [self.layer addAnimation:self.animation forKey:@"rotationAnimation"];
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
