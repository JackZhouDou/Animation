//
//  CircularStaisticsView.h
//  优酷动画
//
//  Created by 周都 on 2017/11/24.
//  Copyright © 2017年 周都. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CircularStatistics;
@interface CircularStaisticsView : UIView

/**
 画圆形图的数据
 */
@property (nonatomic, strong) NSArray <CircularStatistics *> *CircularArray;

/**
 显示圆形图， 要提前设置好显示的数据
 */
-(void)showCircularArray;

@end
