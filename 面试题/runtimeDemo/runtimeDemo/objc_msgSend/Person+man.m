//
//  Person+man.m
//  runtimeDemo
//
//  Created by hy001 on 2022/2/17.
//
#import <objc/runtime.h>

#import "Person+man.h"

@implementation Person (man)

//由于分类中新增属性时不会自动生成属性方法 需要通过运行时添加
- (NSString *)wife{
    return  objc_getAssociatedObject(self, @"wife");
}
- (void)setWife:(NSString *)wife{
    objc_setAssociatedObject(self, @"wife", wife, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
