//
//  GCHComponent.m
//  Component
//
//  Created by Yuanhai on 15/4/19.
//  Copyright © 2019年 Yuanhai. All rights reserved.
//

#import "GCHComponent.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

#pragma mark - NSObject (PerformBlockAfterDelay)

@implementation NSObject (PerformBlockAfterDelay)

- (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:block
               afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block
{
    block();
}

@end

#pragma mark - UIColor (HexStringToColor)

@implementation UIColor (HexStringToColor)

+(UIColor *)hexStringToColor:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
}

@end

#pragma mark - UIView (UIViewFrame)

@implementation UIView (UIViewFrame)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

@end

#pragma mark - NSObject (CreateView)

@implementation NSObject (CreateView)

- (UIView *)createView:(UIView *)parentView
{
    UIView *view = [[UIView alloc] init];
    [parentView addSubview:view];
    return view;
}

- (UIButton *)createButton:(UIView *)parentView
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor]  forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.titleLabel.minimumScaleFactor = 0.5;
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setImageEdgeInsets:UIEdgeInsetsMake(15.0f, 0.0f, 15.0f, 0.0f)];
    [parentView addSubview:button];
    return button;
}

- (UILabel *)createLabel:(UIView *)parentView
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor darkGrayColor];
    label.numberOfLines = 0;
    label.userInteractionEnabled = NO;
    [parentView addSubview:label];
    return label;
}

- (UIImageView *)createImageView:(UIView *)parentView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [parentView addSubview:imageView];
    imageView.userInteractionEnabled = NO;
    return imageView;
}

- (UITextField *)createTextField:(UIView *)parentView
{
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:16];
    textField.textColor = [UIColor blackColor];
    [parentView addSubview:textField];
    return textField;
}

- (UITableView *)createTable:(UIView *)parentView frame:(CGRect)frame target:(id)target
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.rowHeight = 50.0f;
    tableView.dataSource = target;
    tableView.delegate = target;
    tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    tableView.backgroundView = nil;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [parentView addSubview:tableView];
    return tableView;
}

- (UITextView *)createTextView:(UIView *)parentView
{
    UITextView *textView = [[UITextView alloc] init];
    textView.backgroundColor = [UIColor clearColor];
    textView.font = [UIFont systemFontOfSize:16];
    textView.textColor = [UIColor blackColor];
    [parentView addSubview:textView];
    return textView;
}

- (UIScrollView *)createScrollView:(UIView *)parentView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [parentView addSubview:scrollView];
    return scrollView;
}

@end

