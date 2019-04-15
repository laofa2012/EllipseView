//
//  GCHComponent.h
//  Component
//
//  Created by Yuanhai on 15/4/19.
//  Copyright © 2019年 Yuanhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (PerformBlockAfterDelay)
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
@end

@interface UIColor (HexStringToColor)
+ (UIColor *)hexStringToColor:(NSString *)stringToConvert;
@end

@interface UIView (UIViewFrame)
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic, readonly) CGFloat right;
@property (nonatomic, readonly) CGFloat bottom;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@end

@interface NSObject (CreateView)
- (UIView *)createView:(UIView *)parentView;
- (UIButton *)createButton:(UIView *)parentView;
- (UILabel *)createLabel:(UIView *)parentView;
- (UIImageView *)createImageView:(UIView *)parentView;
- (UITextField *)createTextField:(UIView *)parentView;
- (UITableView *)createTable:(UIView *)parentView frame:(CGRect)frame target:(id)target;
- (UITextView *)createTextView:(UIView *)parentView;
- (UIScrollView *)createScrollView:(UIView *)parentView;
@end













