//
//  CVEllipseView.m
//  EllipseView
//
//  Created by Yuanhai on 15/4/19.
//  Copyright © 2019年 Yuanhai. All rights reserved.
//  虚线

#import "CVEllipseView.h"

@implementation CVEllipseView

- (id)init
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    float lineWidth = 1.0f;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat lengths[] = {5.0f, 8.0f, 5.0f, 8.0f};
    CGRect aRect= CGRectMake(lineWidth / 2, lineWidth / 2, self.bounds.size.width - lineWidth, self.bounds.size.height - lineWidth);
    CGContextSetRGBStrokeColor(context, 255 / 255.0f, 0 / 255.0f, 0 / 255.0f, 1.0);
    CGContextSetLineDash(context, 0, lengths, 4);
    CGContextSetLineWidth(context, lineWidth);
    CGContextAddEllipseInRect(context, aRect); // 椭圆
    CGContextDrawPath(context, kCGPathStroke);
}

@end
