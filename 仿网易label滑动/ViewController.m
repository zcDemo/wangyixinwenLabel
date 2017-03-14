//
//  ViewController.m
//  仿网易label滑动
//
//  Created by zc on 16/4/1.
//  Copyright © 2016年 zcDong. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, PanGestureDirection){
    PanGestureDirectionUp,
    PanGestureDirectionDown,
};

@interface ViewController (){
    UILabel *label;
    UIView *view;
    CGFloat y;//文字view每次滑动的距离
    CGFloat y1;
    CGFloat lableHeight;//文字的高度
    PanGestureDirection direction; //手势响应时的方向
    PanGestureDirection lastDirection;//手势方向发生变化时记录上一次的手势方向

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    y = 10;
    y1 = 3;
    
    self.view.backgroundColor = [UIColor whiteColor];
    view = [[UIView alloc] init];
    view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 100, [UIScreen mainScreen].bounds.size.width, 150);
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self.view addSubview:view];
    
    label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150);
    label.text = @"dfadsfkaenabvuhsdfjkaskdfhjkas第三方尽快哈送客户的反馈为股比我爸的开发v，都是佛家。。。。。。水电费甲肝。dfadsfkaenabvuhsdfjkaskdfhjkas第三方尽快哈送客户的反馈为股比我爸的开发v，都是佛家。。。。。。水电费甲肝。dfadsfkaenabvuhsdfjkaskdfhjkas第三方尽快哈送客户的反馈为股比我爸的开发v，都是佛家。。。。。。水电费甲肝。daskdfhjkas第三方尽快哈送客户的反馈为股比我爸的开发v，都是佛家。。。。。。水电费甲肝第三方见了就第三方改革还122dsfedfadsfkaenabvuhsdfjkaskdfhjkas第三方尽快哈送客户的反馈为股比我爸的开发v，都是佛家。电视剧发了就爱上。。。。。";
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    CGSize labelSize = [label.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    lableHeight = labelSize.height;
    
    if (lableHeight > 100) {
       view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 100, [UIScreen mainScreen].bounds.size.width, lableHeight);
    }
    
    label.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, lableHeight);
    
    NSLog(@"labelHeight:%f", lableHeight);
    if (lableHeight > 120) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        [view addGestureRecognizer:panGesture];
    }
   
//    UITextField
}

- (void)panGestureAction:(UIPanGestureRecognizer *)pan{
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
           //判断滑动方向
            CGPoint point = [pan velocityInView:view];
            if (point.y > 0) {
                direction = PanGestureDirectionDown;
            }else{
                direction = PanGestureDirectionUp;
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{
            
            CGPoint point1 = [pan translationInView:view];
            
            y = fabs(point1.y)/5;
            
            if (view.frame.origin.y > [UIScreen mainScreen].bounds.size.height - lableHeight && view.frame.origin.y < [UIScreen mainScreen].bounds.size.height - 100){
                y = fabs(point1.y);
            }
            
            [pan setTranslation:CGPointZero inView:view];
            
            CGPoint point = [pan velocityInView:view];
            if (point.y > 0) {
                lastDirection = PanGestureDirectionDown;
            }else{
                lastDirection = PanGestureDirectionUp;
            }
            
            if (lastDirection != direction) {
                direction = lastDirection;
            }
    
            if (direction == PanGestureDirectionUp) {
                if (view.frame.origin.y >= 300) {
                    NSLog(@"move to up view.y:%f", y);
                    view.frame = CGRectMake(0, view.frame.origin.y - y, [UIScreen mainScreen].bounds.size.width, view.bounds.size.height + y);
                }
            }else if (direction == PanGestureDirectionDown){
                if (view.frame.origin.y <= [UIScreen mainScreen].bounds.size.height - 40) {
                    view.frame = CGRectMake(0, view.frame.origin.y + y, [UIScreen mainScreen].bounds.size.width, view.bounds.size.height - y);
                    NSLog(@"move to down view.y:%f", y);
                   
                }
            }
            break;
        }
        case UIGestureRecognizerStateEnded:{
          
            if (view.frame.origin.y != [UIScreen mainScreen].bounds.size.height - 150) {
                if(direction == PanGestureDirectionUp){
                    [UIView animateWithDuration:0.3 animations:^{
                        view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - lableHeight, [UIScreen mainScreen].bounds.size.width, lableHeight);
                        
                    } completion:^(BOOL finished) {

                    }];
                }else if (direction == PanGestureDirectionDown){
                    
                    if (view.frame.origin.y > [UIScreen mainScreen].bounds.size.height - lableHeight) {
                        [UIView animateWithDuration:0.3 animations:^{
                            view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 100, [UIScreen mainScreen].bounds.size.width, 150);
                            
                        } completion:^(BOOL finished) {
                            
                        }];
                    }else{
                        [UIView animateWithDuration:0.3 animations:^{
                            view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - lableHeight, [UIScreen mainScreen].bounds.size.width, lableHeight);
                            
                        } completion:^(BOOL finished) {
                           
                        }];
                        
                    }
                }
            }
            break;
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
