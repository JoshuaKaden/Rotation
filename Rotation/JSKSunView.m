//
//  JSKSunView.m
//  Rotation
//
//  Created by Joshua Kaden on 3/22/14.
//  Copyright (c) 2014 Chadford Software. All rights reserved.
//

#import "JSKSunView.h"

@implementation JSKSunView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGFloat t_lineWidth = 1.0;
    
    CGRect t_frame = CGRectMake(self.bounds.origin.x + t_lineWidth, self.bounds.origin.y + t_lineWidth, self.bounds.size.width - (t_lineWidth * 2), self.bounds.size.height - (t_lineWidth * 2));
    UIBezierPath *t_path = [UIBezierPath bezierPathWithOvalInRect:t_frame];
    t_path.lineWidth = t_lineWidth;
    [[UIColor blackColor] setStroke];
    [t_path stroke];
    [[UIColor lightGrayColor] setFill];
    [t_path fill];
}

@end
