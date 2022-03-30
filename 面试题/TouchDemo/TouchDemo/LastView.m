//
//  LastView.m
//  TouchDemo
//
//  Created by zjy on 2022/3/22.
//

#import "LastView.h"

@implementation LastView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    [self.superview touchesBegan:touches withEvent:event];
}
// 一根或者多根手指在view上移动，系统会自动调用view的下面方法（随着手指的移动，会持续调用该方法）
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"%s",__func__);
}
// 一根或者多根手指离开view，系统会自动调用view的下面方法
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.superview touchesBegan:touches withEvent:event];
    NSLog(@"%s",__func__);
}
// 触摸结束前，某个系统事件(例如电话呼入)会打断触摸过程，系统会自动调用view的下面方法
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
   return [super hitTest:point withEvent:event];
}
@end
