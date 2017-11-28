//
//  AnimationView.h
//  优酷动画
//
//  Created by 周都 on 2017/11/17.
//  Copyright © 2017年 周都. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 用来装载动画的layer容器
 */
@interface AnimationView : UIView

/**
 显示开始动画
 */
-(void)showStartAnimation;


/**
 暂停动画
 */
- (void)showSuspendAnimation;


@end
