//
//  AnimationView.m
//  优酷动画
//
//  Created by 周都 on 2017/11/17.
//  Copyright © 2017年 周都. All rights reserved.
//

#import "AnimationView.h"

//动画时长
static CGFloat animationDuration = 0.8f;
//线条颜色
#define BLueColor [UIColor colorWithRed:62/255.0 green:157/255.0 blue:254/255.0 alpha:1]
#define LightBLueColor [UIColor colorWithRed:87/255.0 green:188/255.0 blue:253/255.0 alpha:1]
#define RedColor [UIColor colorWithRed:228/255.0 green:35/255.0 blue:6/255.0 alpha:0.8]

@interface AnimationView ()

/**
 左边
 */
@property (nonatomic, strong) CAShapeLayer *leftLayer;

/**
 左边圆弧
 */
@property (nonatomic, strong) CAShapeLayer *leftCircle;

/**
 右边
 */
@property (nonatomic, strong) CAShapeLayer *rightLayer;

/**
 右边圆弧
 */
@property (nonatomic, strong) CAShapeLayer *rightCircle;


@property (nonatomic, strong) CAShapeLayer *triangleCotainer;

@property (nonatomic, assign) BOOL judge;

@end

@implementation AnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self leftCircle];
        [self rightCircle];
        [self rightLayer];
         [self leftLayer];
    }
    return self;
}

- (CAShapeLayer *)leftLayer{
    if (!_leftLayer) {
        CGFloat witdh = self.frame.size.width;
        //路径
        UIBezierPath *bezierPatch = [UIBezierPath bezierPath];
        [bezierPatch moveToPoint:CGPointMake(witdh * 0.2, witdh * 0.9)];
        [bezierPatch addLineToPoint:CGPointMake(witdh * 0.2, witdh * 0.1)];
        
        _leftLayer = [CAShapeLayer layer];
        _leftLayer.path = bezierPatch.CGPath;
        _leftLayer.fillColor = [UIColor clearColor].CGColor;
        _leftLayer.strokeColor = BLueColor.CGColor;
        _leftLayer.lineWidth = 0.2 * witdh;
        _leftLayer.strokeEnd = 0;
        _leftLayer.lineCap = kCALineCapRound;
        _leftLayer.lineJoin = kCALineJoinRound;
        [self.layer addSublayer:_leftLayer];
    }
    
    return _leftLayer;
}

- (CAShapeLayer *)rightLayer{
    if (!_rightLayer) {
         CGFloat witdh = self.frame.size.width;
        UIBezierPath *bezierPatch = [UIBezierPath bezierPath];
        [bezierPatch moveToPoint:CGPointMake(0.8 * witdh, 0.1 * witdh)];
        [bezierPatch addLineToPoint:CGPointMake(0.8 * witdh, 0.9 * witdh)];
        
        _rightLayer = [CAShapeLayer layer];
        _rightLayer.path = bezierPatch.CGPath;
        _rightLayer.fillColor = [UIColor clearColor].CGColor;
        _rightLayer.strokeColor = BLueColor.CGColor;
        _rightLayer.lineWidth = 0.2 * witdh;
        _rightLayer.lineCap = kCALineCapRound;
        _rightLayer.lineJoin = kCALineJoinRound;
        _rightLayer.strokeEnd = 0;
        [self.layer addSublayer:_rightLayer];
    }
    
    return _rightLayer;
}

- (CAShapeLayer *)leftCircle{
    if (!_leftCircle) {
        CGFloat width = self.frame.size.width;
        UIBezierPath *bezierPatch = [UIBezierPath bezierPath];
        [bezierPatch moveToPoint:CGPointMake(width * 0.2, 0.9 * width)];
        CGFloat startAngle = acos(4.0/5.0) + M_PI_2;
        CGFloat endAngle = startAngle - M_PI;
        [bezierPatch addArcWithCenter:CGPointMake(0.5 * width, 0.5 * width) radius:0.5 * width startAngle:startAngle endAngle:endAngle clockwise:NO];
       
        _leftCircle = [CAShapeLayer layer];
        _leftCircle.path = bezierPatch.CGPath;
        _leftCircle.fillColor = [UIColor clearColor].CGColor;
        _leftCircle.strokeColor =  LightBLueColor.CGColor;
        _leftCircle.lineWidth = 0.20 * width;
        _leftCircle.lineCap = kCALineCapRound;
        _leftCircle.lineJoin = kCALineJoinRound;
        _leftCircle.strokeEnd = 1;
        [self.layer addSublayer:_leftCircle];
        
    }
    
    return _leftCircle;
}

- (CAShapeLayer *)rightCircle{
    if (!_rightCircle) {
        CGFloat width = self.frame.size.width;
        UIBezierPath *bezierPatch = [UIBezierPath bezierPath];
        CGFloat startAngle = -acos(3.0 / 5.0);
        CGFloat endAngle = startAngle - M_PI;
        [bezierPatch moveToPoint:CGPointMake(0.8 * width, 0.1 * width)];
        [bezierPatch addArcWithCenter:CGPointMake(0.5 * width, 0.5 * width) radius:0.5 * width startAngle:startAngle endAngle:endAngle clockwise:NO];
        _rightCircle = [CAShapeLayer layer];
        _rightCircle.path = bezierPatch.CGPath;
        _rightCircle.fillColor = [UIColor clearColor].CGColor;
        _rightCircle.strokeColor = LightBLueColor.CGColor;
        _rightCircle.lineWidth = 0.20 * width;
        _rightCircle.lineCap = kCALineCapRound;
        _rightCircle.lineJoin = kCALineJoinRound;
        _rightCircle.strokeEnd = 1;
        [self.layer addSublayer:_rightCircle];
    }
    
    return _rightCircle;
}


/**
播放器按钮

 @return <#return value description#>
 */
-(CAShapeLayer *)triangleCotainer{
    if (!_triangleCotainer) {
        
        
        
    }
    
    return _triangleCotainer;
}
- (CABasicAnimation *)strokeEndAnimationFrom:(CGFloat)fromValue to:(CGFloat)toValue  onLayer:(CALayer *)layer duration:(CGFloat)duration{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimation.duration = duration;
    basicAnimation.fromValue = @(fromValue);
    basicAnimation.toValue = @(toValue);
    //layer动画结束以后会还原， 需要设置下面的属性
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    [layer addAnimation:basicAnimation forKey:nil];
    

    return basicAnimation;
}

- (void)actionRotateAnimationClockwise:(BOOL)colockwise{
    CGFloat startAngle = 0.0;
    CGFloat endAngle = -M_PI_2;
    CGFloat duration = 0.75 * animationDuration;
    if (colockwise) {
        startAngle = -M_PI_2;
        endAngle = 0.0;
        duration = animationDuration;
        
    }
    
    CABasicAnimation *roateAnimtion = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    roateAnimtion.duration = duration;
    roateAnimtion.fromValue = [NSNumber numberWithFloat:startAngle];
    roateAnimtion.toValue = [NSNumber numberWithFloat:endAngle];
    roateAnimtion.fillMode = kCAFillModeForwards;
    roateAnimtion.removedOnCompletion = NO;
    [roateAnimtion setValue:@"roateAnimation" forKey:@"roateAnimation"];
    [self.layer addAnimation:roateAnimtion forKey:nil];
}
//开始动画
-(void)showStartAnimation{
    
    if (self.judge) {
        [self strokeEndAnimationFrom:1 to:0 onLayer:self.leftLayer duration:0.4];
        [self strokeEndAnimationFrom:1 to:0 onLayer:self.rightLayer duration:0.4];
        [self strokeEndAnimationFrom:0 to:1 onLayer:self.leftCircle duration:0.8];
        [self strokeEndAnimationFrom:0 to:1 onLayer:self.rightCircle duration:0.8];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, animationDuration / 4.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self actionRotateAnimationClockwise:NO];
        });
        self.judge = NO;
    }else{
  
 [self strokeEndAnimationFrom:1 to:0 onLayer:self.leftCircle duration:0.8];
[self strokeEndAnimationFrom:1 to:0 onLayer:self.rightCircle duration:0.8];
        self.judge = YES;
        [self actionRotateAnimationClockwise:true];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, animationDuration / 2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self strokeEndAnimationFrom:0 to:1 onLayer:self.leftLayer duration:0.4];
            [self strokeEndAnimationFrom:0 to:1 onLayer:self.rightLayer duration:0.4];
        });
    }
    
}

//暂停动画
- (void)showSuspendAnimation{
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
