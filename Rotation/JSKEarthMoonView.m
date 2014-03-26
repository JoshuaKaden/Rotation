//
//  JSKEarthMoonView.m
//  Rotation
//
//  Created by Joshua Kaden on 3/23/14.
//  Copyright (c) 2014 Chadford Software. All rights reserved.
//

#import "JSKEarthMoonView.h"

#import "JSKEarthView.h"
#import "JSKLunarOrbitView.h"

@interface JSKEarthMoonView () {
    JSKEarthView *_earthView;
    JSKLunarOrbitView *_lunarOrbitView;
}

@end

@implementation JSKEarthMoonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _earthView = ({
            CGFloat t_diameter = self.bounds.size.width / 3.3;
            JSKEarthView *t_view = [[JSKEarthView alloc] initWithFrame:CGRectMake(0.0, 0.0, t_diameter, t_diameter)];
            t_view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
            t_view.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
            [self addSubview:t_view];
            t_view;
        });
        
        _lunarOrbitView = ({
            CGFloat t_diameter = self.bounds.size.width;
            if (t_diameter > self.bounds.size.height)
                t_diameter = self.bounds.size.height;
            JSKLunarOrbitView *t_view = [[JSKLunarOrbitView alloc] initWithFrame:CGRectMake(0.0, 0.0, t_diameter, t_diameter)];
            t_view.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
            [self addSubview:t_view];
            t_view;
        });
    }
    
    return self;
}

@end
