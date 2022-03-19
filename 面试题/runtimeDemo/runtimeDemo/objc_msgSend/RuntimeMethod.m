//
//  RuntimeMethod.m
//  runtimeDemo
//
//  Created by hy001 on 2022/2/23.
//

#import "RuntimeMethod.h"

@implementation RuntimeMethod

- (void)runtimeMethodA:(NSString *)name{
    NSLog(@"%s--%@",__func__,name);
    if (self.callBackBlock) {
        self.callBackBlock(@"A", nil);
    }
}
- (void)runtimeMethodB:(NSString *)name{
    NSLog(@"%s--%@",__func__,name);
    if (self.callBackBlock) {
        self.callBackBlock(@"B", nil);
    }
}
- (void)runtimeMethodInt:(int)age{
    NSLog(@"%s--%d",__func__,age);
    if (self.callBackBlock) {
        self.callBackBlock(@"Int", nil);
    }
}
+ (void)runtimeClassMethod:(NSString *)name{
    NSLog(@"%s--%@",__func__,name);

}

- (void)runtimeMethodA:(NSString *)name block:(void (^)(id data, NSError *error))block{
    NSLog(@"%s--%@",__func__,name);
    if (block) {
        block(@"A",nil);

    }

}
- (void)runtimeMethodB:(NSString *)name block:(void (^)(id data, NSError *error))block{
    NSLog(@"%s--%@",__func__,name);
    if (block) {
        block(@"B",nil);

    }
}
@end
