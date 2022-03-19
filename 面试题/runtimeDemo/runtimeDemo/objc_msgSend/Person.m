//
//  Person.m
//  runtimeDemo
//
//  Created by hy001 on 2022/2/17.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person
//通过 clang -rewrite-objc Person.m 命令可以看到里面的方法会转化成objc_msgSend
+ (void)thisIsClassMethod{
    NSLog(@"%s",__func__);
    Person *p  = [[Person alloc] init];
    [p thisIsInstanceMethod];
}

- (void)thisIsInstanceMethod{
    NSLog(@"%s",__func__);
    void (^callBackBlock)(id data, NSError *error,int i) = ^(id data,NSError*error,int i){
        NSLog(@"%@ 这是回调",data);
    };
}

- (void)thisIsExchangeInstanceMethod{
    NSLog(@"%s",__func__);
    [self thisIsExchangeInstanceMethod];

}
- (void)personMessageTranspond{
    NSLog(@"%s",__func__);

}
- (void)personMessageTranspondInvocation{
    NSLog(@"%s",__func__);

}

//实现方法交换  最好是在load中  load在加载完就会执行。initalize只有在创建了实例对象才会执行
+(void)load{
    NSLog(@"%s",__func__);
    Method olderMethod = class_getInstanceMethod(self, @selector(thisIsInstanceMethod));
    Method newMethod = class_getInstanceMethod(self, @selector(thisIsExchangeInstanceMethod));
    method_exchangeImplementations(olderMethod, newMethod);
    
}
+ (void)initialize{
    
    NSLog(@"%s",__func__);
}
@end
