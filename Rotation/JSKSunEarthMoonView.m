//
//  JSKSunEarthMoonView.m
//  Rotation
//
//  Created by Joshua Kaden on 3/23/14.
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
