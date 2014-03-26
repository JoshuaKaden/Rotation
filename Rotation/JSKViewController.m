//
//  JSKViewController.m
//  Rotation
//
//  Created by Joshua Kaden on 3/21/14.
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

#import "JSKViewController.h"

#import "JSKEarthMoonView.h"
#import "JSKSunEarthMoonView.h"

@interface JSKViewController () {
    UIView *_contentView;
    JSKEarthMoonView *_earthMoonView;
    JSKSunEarthMoonView *_sunEarthMoonView;
    UILabel *_captionLabel;
}

- (void)tap:(id)sender;
- (void)doubleTap:(id)sender;

- (void)toggleCaption;

- (NSString *)buildCaptionString;

@end

@implementation JSKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _contentView = ({
        CGRect t_frame = CGRectMake(0, 0, self.view.bounds.size.width - 60, self.view.bounds.size.height - 60);
        UIView *t_view = [[UIView alloc] initWithFrame:t_frame];
        t_view.layer.cornerRadius = 15;
        t_view.backgroundColor = [UIColor whiteColor];
        t_view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        t_view.center = self.view.center;
        [self.view addSubview:t_view];
        t_view;
    });
    
    _earthMoonView = ({
        JSKEarthMoonView *t_view = [[JSKEarthMoonView alloc] initWithFrame:CGRectMake(0.0, 0.0, 230, 230)];
        t_view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        t_view.backgroundColor = [UIColor clearColor];
        t_view.center = CGPointMake(CGRectGetMidX(_contentView.bounds), CGRectGetMidY(_contentView.bounds));
        [_contentView addSubview:t_view];
        t_view;
    });

    _sunEarthMoonView = ({
        JSKSunEarthMoonView *t_view = [[JSKSunEarthMoonView alloc] initWithFrame:_contentView.bounds];
        t_view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        t_view.backgroundColor = [UIColor clearColor];
        t_view.alpha = 0.0;
        [_contentView addSubview:t_view];
        t_view;
    });
    
    _captionLabel = ({
        UILabel *t_label = [[UILabel alloc] init];
        t_label.font = [UIFont fontWithName:@"GillSans" size:14];
        t_label.textColor = [UIColor blackColor];
        t_label.text = [self buildCaptionString];
        CGSize t_size = [t_label sizeThatFits:CGSizeMake(_contentView.bounds.size.width, _contentView.bounds.size.width)];
        t_label.frame = CGRectMake(15, CGRectGetMaxY(_contentView.bounds) - t_size.height - 10, _contentView.bounds.size.width, t_size.height);
        t_label.alpha = 0.0;
        t_label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        t_label.numberOfLines = 0;
        [_contentView addSubview:t_label];
        t_label;
    });
    
    UITapGestureRecognizer *t_doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    t_doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:t_doubleTap];
    
    UITapGestureRecognizer *t_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [t_tap requireGestureRecognizerToFail:t_doubleTap];
    [self.view addGestureRecognizer:t_tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tap:(UIGestureRecognizer *)sender
{
        [self toggleCaption];
}

- (void)doubleTap:(__unused id)sender
{
    UIView *t_hideView = _earthMoonView;
    UIView *t_showView = _sunEarthMoonView;
    if (_earthMoonView.alpha == 0.0) {
        t_hideView = _sunEarthMoonView;
        t_showView = _earthMoonView;
    }
    
    BOOL t_captionIsVisible = NO;
    if (_captionLabel.alpha == 1.0)
        t_captionIsVisible = YES;
    
    [UIView animateWithDuration:0.4 animations:^{
        t_hideView.alpha = 0.0;
        if (t_captionIsVisible)
            _captionLabel.alpha = 0.0;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.4 animations:^{
            t_showView.alpha = 1.0;
            
            _captionLabel.text = [self buildCaptionString];
            CGSize t_size = [_captionLabel sizeThatFits:CGSizeMake(_contentView.bounds.size.width, _contentView.bounds.size.width)];
            _captionLabel.frame = CGRectMake(15, CGRectGetMaxY(_contentView.bounds) - t_size.height - 10, _contentView.bounds.size.width, t_size.height);
            
            if (t_captionIsVisible)
                _captionLabel.alpha = 1.0;
        } completion:^(BOOL finished){
            [self.view setNeedsDisplay];
        }];
    }];
}

- (void)toggleCaption
{
    [UIView animateWithDuration:0.5 animations:^{
        if (_captionLabel.alpha == 0.0)
            _captionLabel.alpha = 1.0;
        else
            _captionLabel.alpha = 0.0;
    }];
}

- (NSString *)buildCaptionString
{
    if (_earthMoonView.alpha == 0.0)
        return NSLocalizedString(@"The Moon orbits the Earth.\nThe Earth orbits the Sun.", @"caption");
    else
        return NSLocalizedString(@"The Moon orbits the Earth.", @"caption");
}

@end
