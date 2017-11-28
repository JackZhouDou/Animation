//
//  CircularStatistics.h
//  优酷动画
//
//  Created by 周都 on 2017/11/24.
//  Copyright © 2017年 周都. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CircularStatistics : NSObject

/**
 标题
 */
@property (nonatomic, strong) NSString *titleString;

/**
 子标题
 */
@property (nonatomic, strong) NSString *subString;

/**
 占的比例， 范围0～1；
 */
@property (nonatomic, assign)  float saleNUmber;

/**
 颜色
 */
@property (nonatomic, strong) UIColor *color;

/**
 装载的layer
 */
@property (nonatomic, strong) CALayer *layer;
@end
