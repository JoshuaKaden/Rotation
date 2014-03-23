//
//  JSKSunEarthMoonView.m
//  Rotation
//
//  Created by Joshua Kaden on 3/23/14.
//  Copyright (c) 2014 Chadford Software. All rights reserved.
//

#import "JSKSunEarthMoonView.h"

#import "JSKEarthMoonView.h"
#import "JSKSolarOrbitView.h"
#import "JSKSunView.h"

@interface JSKSunEarthMoonView () {
    JSKSunView *_sunView;
    JSKSolarOrbitView *_solarOrbitView;
    JSKEarthMoonView *_earthMoonView;
}

@end

@implementation JSKSunEarthMoonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _sunView = ({
            CGRect t_frame = CGRectMake(0.0, 0.0, 100, 100);
            JSKSunView *t_view = [[JSKSunView alloc] initWithFrame:t_frame];
            t_view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
            t_view.center = self.center;
            [self addSubview:t_view];
            t_view;
        });

        _solarOrbitView = ({
            JSKSolarOrbitView *t_view = [[JSKSolarOrbitView alloc] initWithFrame:CGRectMake(0.0, 0.0, 400, 400)];
            t_view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
            t_view.center = self.center;
            [self addSubview:t_view];
            t_view;
        });
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
