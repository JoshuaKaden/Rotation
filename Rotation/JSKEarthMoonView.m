//
//  JSKEarthMoonView.m
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
