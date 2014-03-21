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
    JSKEarthView *_earthView;
    JSKLunarOrbitView *_lunarOrbitView;
}

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
    
    _earthView = ({
        CGRect t_frame = CGRectMake(0.0, 0.0, 60, 60);
        JSKEarthView *t_view = [[JSKEarthView alloc] initWithFrame:t_frame];
        t_view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        t_view.center = CGPointMake(CGRectGetMidX(_contentView.bounds), CGRectGetMidY(_contentView.bounds));
        [_contentView addSubview:t_view];
        t_view;
    });
    
    _lunarOrbitView = ({
        CGRect t_frame = CGRectMake(0.0, 0.0, 200, 200);
        JSKLunarOrbitView *t_view = [[JSKLunarOrbitView alloc] initWithFrame:t_frame];
        t_view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        t_view.center = _earthView.center;
        [_contentView addSubview:t_view];
        t_view;
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
