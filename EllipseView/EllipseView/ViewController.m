//
//  ViewController.m
//  EllipseView
//
//  Created by Yuanhai on 15/4/19.
//  Copyright © 2019年 Yuanhai. All rights reserved.
//

#import "ViewController.h"
#import "GCHComponent.h"
#import "CVEllipseView.h"

#define backIconHeight 15.0f

@interface ViewController ()

@property (strong, nonatomic) CVEllipseView *backView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 背景
    [self layoutBackView];
    
    // 小图标
    [self layoutIcons];
}

// 背景
- (void)layoutBackView
{
    // Frame
    float widthSpacing = 30.0f;
    float backWidth = self.view.width - widthSpacing * 2;
    float backHeight = backWidth * 0.65;
    
    // Back
    self.backView = [[CVEllipseView alloc] init];
    self.backView.frame = CGRectMake(widthSpacing, (self.view.height - backHeight) / 2, backWidth, backHeight);
    [self.view addSubview:self.backView];
}

// 小图标
- (void)layoutIcons
{
    /*
     * angle：弧度
     * left：从左开始布局，顺时针
     * move：向外偏移距离
     */
    NSArray *icons =
    @[
      @{@"title": @"1", @"angle": @(60), @"left": @(YES)},
      @{@"title": @"2", @"angle": @(110), @"left": @(YES)},
      @{@"title": @"3", @"angle": @(155), @"left": @(YES), @"move": @(30.0f)},
      @{@"title": @"4", @"angle": @(35), @"left": @(NO)},
      @{@"title": @"5", @"angle": @(70), @"left": @(NO)},
      @{@"title": @"6", @"angle": @(120), @"left": @(NO)},
      ];
    
    for (int f = 0; f < icons.count; f++)
    {
        NSDictionary *itemDic = icons[f];
        
        // 角度转弧度
        float angle = [itemDic[@"angle"] floatValue] / 180.0f * M_PI;
        
        // 椭圆x、y轴半径
        float a = self.backView.width / 2;
        float b = self.backView.height / 2;
        
        // 中心到点的距离
        float r = a * b / sqrt(a * a * cos(angle) * cos(angle) + b * b * sin(angle) * sin(angle));
        
        // 顺时针/逆时针
        int xDirection = [itemDic[@"left"] boolValue] ? -1 : 1;
        
        // 根据夹角与距离，计算中心的x、y
        float centerX = self.backView.center.x + r * sin(angle) * xDirection;
        float centerY = self.backView.center.y + r * cos(angle);
        
        // y轴偏移量
        float move = [itemDic[@"move"] floatValue];
        
        // Layout
        UILabel *label = [self createLabel:self.view];
        label.frame = CGRectMake(centerX - backIconHeight / 2, centerY - backIconHeight / 2 - move, backIconHeight, backIconHeight);
        label.text = itemDic[@"title"];
        label.backgroundColor = [UIColor darkGrayColor];
        label.textColor = [UIColor whiteColor];
        label.layer.cornerRadius = backIconHeight / 2;
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:9];
    }
}

@end
