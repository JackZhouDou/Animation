//
//  ViewController.m
//  优酷动画
//
//  Created by 周都 on 2017/11/17.
//  Copyright © 2017年 周都. All rights reserved.
//

#import "ViewController.h"
#import "AnimationView.h"
#import "AiQIYi.h"
#import "CircularStaisticsView.h"
#import "CircularStatistics.h"
@interface ViewController ()

/**
 动画view用来装载
 */
@property (nonatomic, strong) AnimationView * animationView;

@property (nonatomic, strong) AiQIYi *animationAiQiYi;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animationView = [[AnimationView alloc]initWithFrame:CGRectMake(100, 100, 150, 150)];
    self.animationView.backgroundColor = [UIColor colorWithRed:250.0 / 255 green:250.0 / 255 blue:250.0 / 255 alpha:1];
    [self.view addSubview:self.animationView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(animationAction)];
    [self.animationView addGestureRecognizer:tap];
    
    
    
    self.animationAiQiYi = [[AiQIYi alloc]initWithFrame:CGRectMake(100, 300, 150, 150)];
    self.animationAiQiYi.backgroundColor = [UIColor colorWithRed:250.0 / 255 green:250.0 / 255 blue:250.0 / 255 alpha:1];
    [self.view addSubview:self.animationAiQiYi];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(animationActionOf)];
    [self.animationAiQiYi addGestureRecognizer:tap1];
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"🐯" forState:0];
    NSLog(@"🐯%@", [button currentTitleColor]);
  
    
    
    CircularStaisticsView *circularView = [[CircularStaisticsView alloc]initWithFrame:CGRectMake(10, 300, 300, 300)];
    circularView.backgroundColor = [UIColor colorWithRed:200.0 / 255 green:200.0 / 255 blue:200.0 / 255 alpha:1];
    [self.view addSubview:circularView];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 5 ; i++) {
        CircularStatistics *model = [CircularStatistics new];
        model.saleNUmber = 0.2;
        model.titleString = @"壶🐯🐯🐯";
        model.subString = @"133";
        CGFloat red = (arc4random() % 255) / 255.0 ;
         CGFloat green = (arc4random() % 255) / 255.0 ;
         CGFloat blue = (arc4random() % 255) / 255.0 ;
        model.color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
        [array addObject:model];
    }
    
    circularView.CircularArray = array;
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)animationAction{
    
    [self.animationView showStartAnimation];
}

- (void)animationActionOf{
    
    [self.animationAiQiYi showAnimation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
