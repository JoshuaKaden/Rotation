//
//  JSKViewController.m
//  Rotation
//
//  Created by Joshua Kaden on 3/21/14.
//  Copyright (c) 2014 Chadford Software. All rights reserved.
//

#import "JSKViewController.h"

#import "JSKEarthView.h"
#import "JSKLunarOrbitView.h"

@interface JSKViewController () {
    UIView *_contentView;
    UIView *_earthMoonView;
    UIView *_sunEarthMoonView;
}

- (void)constructEarthMoonView;
- (void)constructSunEarthMoonView;
- (void)doubleTap:(id)sender;

@end

@implementation JSKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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
    
    [self constructEarthMoonView];
    [self constructSunEarthMoonView];
    
    UITapGestureRecognizer *t_gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    t_gesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:t_gesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)constructEarthMoonView
{
    _earthMoonView = ({
        UIView *t_view = [[UIView alloc] initWithFrame:_contentView.bounds];
        t_view.backgroundColor = [UIColor clearColor];
        t_view.alpha = 0.0;
        [_contentView addSubview:t_view];
        t_view;
    });
    
    JSKEarthView *t_earthView = ({
        CGRect t_frame = CGRectMake(0.0, 0.0, 60, 60);
        JSKEarthView *t_view = [[JSKEarthView alloc] initWithFrame:t_frame];
        t_view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        t_view.center = CGPointMake(CGRectGetMidX(_earthMoonView.bounds), CGRectGetMidY(_earthMoonView.bounds));
        t_view;
    });
    [_earthMoonView addSubview:t_earthView];
    
    JSKLunarOrbitView *t_lunarOrbitView = ({
        CGRect t_frame = CGRectMake(0.0, 0.0, 200, 200);
        JSKLunarOrbitView *t_view = [[JSKLunarOrbitView alloc] initWithFrame:t_frame];
        t_view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        t_view.center = t_earthView.center;
        t_view;
    });
    [_earthMoonView addSubview:t_lunarOrbitView];
}

- (void)constructSunEarthMoonView
{
    
}

- (void)doubleTap:(UIGestureRecognizer *)sender
{
    UIView *t_hideView = _earthMoonView;
    UIView *t_showView = _sunEarthMoonView;
    if (_earthMoonView.alpha == 0.0) {
        t_hideView = _sunEarthMoonView;
        t_showView = _earthMoonView;
    }
    
    [UIView animateWithDuration:1.0 animations:^{
        t_hideView.alpha = 0.0;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:1.0 animations:^{
            t_showView.alpha = 1.0;
        } completion:^(BOOL finished){
            [self.view setNeedsDisplay];
        }];
    }];
}

@end
