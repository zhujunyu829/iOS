//
//  MessageOrg.m
//  runtimeDemo
//
//  Created by hy001 on 2022/2/17.
//

#import "MessageOrg.h"
#import <objc/runtime.h>
#import "Person.h"
@implementation MessageOrg
/*
 消息转发的第一步 动态解析方法
 */
void dynamicIMP(id self, SEL _cmd) {
    NSLog(@"do something");
}


+ (BOOL)resolveClassMethod:(SEL)sel{
    NSLog(@"%s",__func__);

    return [super resolveClassMethod:sel];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"%s",__func__);

    NSString *selName = [NSString stringWithUTF8String:sel_getName(sel)];
    if ([selName hasPrefix:@"message"]) {
        
        /*
         "v@:"中v代表函数返回值类型为void，@代表self的类型为id，:代表_cmd的类型为SEL。当调用到MissMethod的时候，就会执行dynamicIMP方法
         */
        class_addMethod([self class], sel, (IMP)dynamicIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

/*
 第二步 消息接受者重定向
 */
-(id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"%s",__func__);
    NSString *selName = [NSString stringWithUTF8String:sel_getName(aSelector)];
    if ([selName isEqualToString:@"personMessageTranspond"]) {
        //返回消息的接受者对象
        return [Person new];
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

/*
 消息重定向
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    NSLog(@"%s",__func__);
    NSString *selName = [NSString stringWithUTF8String:sel_getName(aSelector)];
    if ([selName isEqualToString:@"personMessageTranspondInvocation"]) {
        //获取方法签名
        return[NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    //https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100  数据类型
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"%s",__func__);
    SEL sel = anInvocation.selector;
    Person *person = [Person new];
    if ([person respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:person];
    }else{
        [super forwardInvocation:anInvocation];
    }
}
//+ (void)personMessageTranspondInvocation{
//    NSLog(@"%s",__func__);
//}

@end
