//
//  AiQIYi.m
//  优酷动画
//
//  Created by 周都 on 2017/11/21.
//  Copyright © 2017年 周都. All rights reserved.
//

#import "AiQIYi.h"

@implementation AiQIYi
- (void)showAnimation{
    
    if (!self.layerShape) {
        CGFloat width = self.frame.size.width;
        
        UIBezierPath *pathBezier = [UIBezierPath bezierPath];
        
        [pathBezier moveToPoint:CGPointMake(width / 2.0, width / 2.0)];
        [pathBezier addArcWithCenter:CGPointMake(width / 2.0, width / 2.0) radius:width / 2.0 startAngle:0 endAngle:M_PI * 1.5 clockwise:YES];
        
       self.layerShape = [CAShapeLayer layer];
        //    layer.backgroundColor = [UIColor clearColor].CGColor;
        self.layerShape.fillColor = [UIColor clearColor].CGColor;
        self.layerShape.strokeColor = [UIColor redColor].CGColor;
        self.layerShape.lineWidth = 0.1 * width;
        self.layerShape.lineCap = kCALineCapRound;
        self.layerShape.lineJoin = kCALineJoinRound;
        //    layer.fillMode
       
        self.layerShape.path = pathBezier.CGPath;
        [self.layer addSublayer:self.layerShape];
    }
    
    if (self.judgeLayer) {
         [self animationFrome:1 withTo:0 layerOf:self.layerShape];
        self.judgeLayer = NO;
    }else{
        [self animationFrome:0 withTo:1 layerOf:self.layerShape];
        self.judgeLayer = YES;
    }

     
    
}


- (void)animationFrome:(CGFloat)frome withTo:(CGFloat)to layerOf:(CALayer *)layer {
    
    CABasicAnimation *basicAnimtion = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimtion.fillMode = kCAFillModeForwards;
    basicAnimtion.removedOnCompletion = NO;
    basicAnimtion.fromValue = @(frome);
    basicAnimtion.toValue = @(to);
    basicAnimtion.duration = 0.8;
    CAMediaTimingFunction *timingFuncation = [CAMediaTimingFunction functionWithControlPoints:0.22 :0.57 :0.32 :1.13];
    
    basicAnimtion.timingFunction =  timingFuncation;
    [layer addAnimation:basicAnimtion forKey:@"strokeEnd"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
