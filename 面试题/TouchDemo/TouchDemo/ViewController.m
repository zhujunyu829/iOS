//
//  ViewController.m
//  TouchDemo
//
//  Created by zjy on 2022/3/22.
//

#import "ViewController.h"
#import "TopView.h"
#import "MidView.h"
#import "LastView.h"

@interface ViewController ()
{
    TopView *_topView;
    MidView *_midView;
    LastView *_lastView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _topView = [[TopView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    _topView.backgroundColor = [UIColor redColor];
    _midView = [[MidView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    _midView.backgroundColor = [UIColor blueColor];
    _lastView = [[LastView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    _lastView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_topView];
    [_topView addSubview:_midView];
    [_midView addSubview:_lastView];
    
    
    // Do any additional setup after loading the view.
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
   return [self.view hitTest:point withEvent:event];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}
// 一根或者多根手指在view上移动，系统会自动调用view的下面方法（随着手指的移动，会持续调用该方法）
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
}
// 一根或者多根手指离开view，系统会自动调用view的下面方法
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}
// 触摸结束前，某个系统事件(例如电话呼入)会打断触摸过程，系统会自动调用view的下面方法
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}
@end
