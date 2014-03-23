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

- (BOOL)isPad;

@end

@implementation JSKSunEarthMoonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _solarOrbitView = ({
            CGRect t_frame = CGRectMake(0.0, 0.0, 400.0, 400.0);
            if (![self isPad])
                t_frame = CGRectMake(0.0, 0.0, 220, 220);
            JSKSolarOrbitView *t_view = [[JSKSolarOrbitView alloc] initWithFrame:t_frame];
            t_view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
            t_view.center = self.center;
            [self addSubview:t_view];
            t_view;
        });
        
        _sunView = ({
            CGRect t_frame = CGRectMake(0.0, 0.0, 100, 100);
            if (![self isPad])
                t_frame = CGRectMake(0.0, 0.0, 70, 70);
            JSKSunView *t_view = [[JSKSunView alloc] initWithFrame:t_frame];
            t_view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
            t_view.center = self.center;
            [self addSubview:t_view];
            t_view;
        });
    }
    
    return self;
}

- (BOOL)isPad {
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}

@end
