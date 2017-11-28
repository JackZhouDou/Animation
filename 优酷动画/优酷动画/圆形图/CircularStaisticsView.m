//
//  CircularStaisticsView.m
//  优酷动画
//
//  Created by 周都 on 2017/11/24.
//  Copyright © 2017年 周都. All rights reserved.
//

#import "CircularStaisticsView.h"
#import "CircularStatistics.h"
#import <objc/runtime.h>
static CGFloat linewidthBit = 2.0;
static CGFloat  animationTimer = 0.8;

@interface CircularStaisticsView ()<CAAnimationDelegate>
//@property (nonatomic, strong) NSMutableArray *arrayLayer;
@property (nonatomic, strong) CAShapeLayer *animationLayer;

@end
@implementation CircularStaisticsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestUreAction:)];
        
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}


-(void)setCircularArray:(NSArray *)CircularArray{
    if (CircularArray != _CircularArray) {
        
        _CircularArray = CircularArray;
    }
    
}


-(void)showCircularArray{
    if (_CircularArray && _CircularArray.count > 0) {
        
        //清理显示
        while (self.layer.sublayers.count) {
            
            [[self.layer.sublayers lastObject]removeFromSuperlayer];
            
        }
        
        [self creatLayerViewOf];
    }
    
    [self showAnimation];
}

/**
 显示动画
 */
- (void)showAnimation{
    if (self.CircularArray && self.CircularArray.count) {
       
        [self creatBasicAnimtion:self.animationLayer startAngel:1.0 endAngel:0.0 duration:0.8];
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.8), dispatch_get_main_queue(), ^{
            for (CircularStatistics *model in weakSelf.CircularArray) {
                CALayer *layer = objc_getAssociatedObject(model, @"lineLayer");
                [weakSelf creatBasicAnimtion:layer startAngel:0 endAngel:1.0 duration:0.4];
            }
        });
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (CircularStatistics *model in weakSelf.CircularArray) {
                CALayer *layerBit = objc_getAssociatedObject(model, @"bitLayer");
                layerBit.hidden = NO;
                CALayer *layerTitle = objc_getAssociatedObject(model, @"titleLayer");
                layerTitle.hidden = NO;
            }
            
        });
    }
    
}

//结束点动画
- (void)creatBasicAnimtion:(CALayer *)layer startAngel:(CGFloat)startAngel endAngel:(CGFloat)endAngel duration:(CGFloat)duration{

    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimation.fromValue = @(startAngel);
    basicAnimation.toValue = @(endAngel);
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion =  NO;
    basicAnimation.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    basicAnimation.duration = duration;
    [layer addAnimation:basicAnimation forKey:nil];
  
}
/**
 创建所有的layer
 */
- (void)creatLayerViewOf{
    //开始的角度
    CGFloat startAngel = 0.0f;
    NSInteger number = self.CircularArray.count;
    
    for (int i = 0; i < number; i++) {
        CircularStatistics *circularStatistics = [self.CircularArray objectAtIndex:i];
        CALayer *layer = [self creatNowCircularLayerModel:circularStatistics startAngel:startAngel];
        [self.layer addSublayer:layer];
        circularStatistics.layer = layer;
        startAngel = startAngel + circularStatistics.saleNUmber * M_PI * 2.0;
    }
    [self.layer addSublayer: self.animationLayer];
    [self.layer addSublayer:[self centerRadiusCreatLayer]];
    
}

- (CAShapeLayer *)animationLayer{
    if (!_animationLayer) {
        _animationLayer = [CAShapeLayer layer];
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        //圆的半径
        CGFloat layerWidth = height / 3.0;
        _animationLayer.strokeColor = [UIColor whiteColor].CGColor;
        _animationLayer.lineWidth = layerWidth / 2.0;
        _animationLayer.fillColor = [UIColor clearColor].CGColor;
        _animationLayer.lineJoin = kCALineJoinRound;
        _animationLayer.lineCap = kCALineCapButt;
        _animationLayer.strokeEnd = 0.0;
        
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath addArcWithCenter:CGPointMake(width / 2.0, height / 2.0) radius:layerWidth / 4.0 startAngle:0 endAngle:M_PI * 2.0 clockwise:NO];
        [bezierPath closePath];
        _animationLayer.path = bezierPath.CGPath;
        
    }
 
    return _animationLayer;
}
//中心白圆圈
- (CALayer *)centerRadiusCreatLayer{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor whiteColor].CGColor;
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    CGFloat widthLayer = (height / 3.0) / 6.0;
    UIBezierPath *bezierPatch = [UIBezierPath  bezierPathWithArcCenter:CGPointMake(width / 2.0, height /2.0) radius:widthLayer startAngle:0 endAngle:M_PI * 2.0 clockwise:YES];
    [bezierPatch closePath];
    layer.path = bezierPatch.CGPath;
 
    
    return layer;
}

/**
 创建图形

 @param layerModel 数据载体
 @param startAngle 幅度位置
 @return 返回结果
 */
- (CALayer *)creatNowCircularLayerModel:(CircularStatistics *)layerModel startAngel:(CGFloat)startAngle{
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = layerModel.color.CGColor;
    layer.strokeColor = layerModel.color.CGColor;
    layer.lineWidth = 0.1;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat layerWidth = height / 3.0;
    CGFloat endAngel = startAngle + layerModel.saleNUmber * M_PI * 2.0;
    if (endAngel > M_PI * 2.0) {
        
        endAngel = M_PI * 2.0;
    }
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(width / 2.0, height / 2.0)];
    [bezierPath addArcWithCenter:CGPointMake(width / 2.0, height / 2.0) radius:layerWidth / 2.0 startAngle:startAngle endAngle:endAngel clockwise:YES];
    [bezierPath closePath];
    layer.path = bezierPath.CGPath;

    [self creatLineStartAngel:startAngle endAngel:endAngel CircularLayerModel:layerModel radius:layerWidth / 2.0 + 20 centerPoint:CGPointMake(width / 2.0, height / 2.0)];
    
    
    return layer;
}

/**
 画线条

 @param startAngle 开始角度
 @param endAngel 结束角度
 @param circularModel 内容model
 */
- (void)creatLineStartAngel:(CGFloat)startAngle endAngel:(CGFloat)endAngel CircularLayerModel:(CircularStatistics *)circularModel radius:(CGFloat)radius centerPoint:(CGPoint)point{
    
    CGFloat centerAngel = (startAngle + endAngel) / 2.0;
    
    CGFloat x = point.x + (radius * cosf(centerAngel));
    CGFloat y = point.y + (radius * sinf(centerAngel));
    CGFloat leight;
    if (centerAngel > M_PI_2 && centerAngel < M_PI_2 * 3) {
        
        leight = -radius;
    }else {
        
        leight = radius;
    }
    CGPoint center = CGPointMake(x, y);
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = circularModel.color.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.strokeEnd = 0.0;
    UIBezierPath *bezierLine = [UIBezierPath bezierPath];
    [bezierLine moveToPoint:point];
    [bezierLine addLineToPoint:center];
     [bezierLine addLineToPoint:CGPointMake(center.x + leight, center.y)];
    bezierLine.lineWidth = linewidthBit;
    layer.path = bezierLine.CGPath;
    [self.layer addSublayer:layer];
    objc_setAssociatedObject(circularModel, @"lineLayer", layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    CAShapeLayer *layerBit = [CAShapeLayer layer];
    layerBit.fillColor = circularModel.color.CGColor;
    UIBezierPath *bezierBit = [UIBezierPath bezierPathWithArcCenter:center radius:linewidthBit / 2.0 + 1.5 startAngle:0 endAngle:M_PI * 2.0 clockwise:YES];
    [bezierBit closePath];
    layerBit.path = bezierBit.CGPath;
    layerBit.hidden = YES;
    [self.layer addSublayer:layerBit];
    objc_setAssociatedObject(circularModel, @"bitLayer", layerBit, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    CATextLayer *titleLayer = [CATextLayer layer];
    if (centerAngel > M_PI_2 && centerAngel < M_PI_2 * 3) {
        titleLayer.frame = CGRectMake(center.x + leight, center.y - 18, radius, 18);
        titleLayer.alignmentMode = kCAAlignmentLeft;
    }else{
        titleLayer.frame = CGRectMake(center.x, center.y - 18, radius, 18);
        titleLayer.alignmentMode = kCAAlignmentRight;
        
    }
    titleLayer.string = circularModel.titleString;
    titleLayer.foregroundColor = circularModel.color.CGColor;
    UIFont *font =  [UIFont systemFontOfSize:10.0];
    
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    titleLayer.font = fontRef;
    titleLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    titleLayer.contentsScale = [UIScreen mainScreen].scale;
    titleLayer.hidden = YES;
    [self.layer addSublayer:titleLayer];
    
    objc_setAssociatedObject(circularModel, @"titleLayer", titleLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (void)tapGestUreAction:(UIGestureRecognizer *)recognizer{
//处理点击事件第一种方法
    
//    NSLog(@"🐯🐯🐯🐯🐯🐯🐯");

    [self showCircularArray];
}

//处理点击事件的第二种方法
//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    
//    
//    return self;
//}

@end
