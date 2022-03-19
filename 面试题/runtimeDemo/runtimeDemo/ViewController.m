//
//  ViewController.m
//  runtimeDemo
//
//  Created by hy001 on 2022/2/17.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <UIKit/UIKit.h>
#import "Person+man.h"
#import "User.h"
#import <WebKit/WebKit.h>
#import "MessageOrg.h"

#import "RuntimeMethod.h"

@interface ViewController ()

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testClassMethod];
//    [self testInstanceMethod];
    [self testRuntimeMethod];
    return;
    [self showDoc];
//    [self  testMsgSend];
    [self testMessageTranspond];
    NSDictionary *dict = @{@"name":@"123",
                           @"sex":@"man",
                           @"age":@"12",
                           @"user":@{@"name":@"223",
                                     @"age":@"122",},
                           @"users":@[@{@"name":@"323",
                                        @"age":@"322",},
                                      @{@"name":@"423",
                                                @"age":@"422",}]};
    User *uuser = [User modelFromDict:dict];
    NSLog(@"%@",uuser.user.name);
    // Do any additional setup after loading the view.
}

///  通过IMP调用方法
- (void)testClassMethod {
    Class cls = NSClassFromString(@"RuntimeMethod");
    SEL sel = NSSelectorFromString(@"runtimeClassMethod:");
    Method method = class_getClassMethod(cls, sel);
    IMP imp = method_getImplementation(method);
//   IMP ip=  class_getMethodImplementation(cls, sel);
//    ((id (*)(id,SEL,id))ip)(cls,sel,@"2121");

    if ([cls respondsToSelector:sel]) {
     
        ((id (*)(id,SEL,id))imp)(cls,sel,@"2121");
    } else {
        NSLog(@"无法响应类方法");
    }
}

///  通过IMP调用实例方法
- (void)testInstanceMethod {
    Class cls = NSClassFromString(@"RuntimeMethod");
    SEL sel = NSSelectorFromString(@"runtimeMethodAd:");
    id obj = [cls new];
//    if ([obj respondsToSelector:sel]) {
        Method method = class_getInstanceMethod([cls class], sel);
        IMP imp = method_getImplementation(method);
    if (imp) {
        ((id (*)(id,SEL,id))imp)(obj,sel,@"2121");
    }
       
//    } else {
//        NSLog(@"无法响应实例方法");
//    }
}


//通过 NSInvocation 实现方法的动态调用支持多参数调用
- (void)testRuntimeMethod{
    
    NSDictionary *dataDic = @{@"class":@"RuntimeMethod",@"methodName":@"runtimeMethodInt:",@"varArr":@[@(12)],@"callBackName":@"callBackBlock"};
    NSArray * objects = dataDic[@"varArr"];
    Class class = NSClassFromString(dataDic[@"class"]);
    if (!class) {
        return;
    }
    
    id obj = [class new];
    void (^callBackBlock)(id data, NSError *error) = ^(id data,NSError*error){
        NSLog(@"%@ 这是回调",data);
    };
    unsigned count = 0;
    ///获取所有变量值判断 所要赋值的对象是否存在
    Ivar *ivarList = class_copyIvarList(class, &count);
    for (int i = 0 ; i< count;i ++) {
        Ivar ivar = ivarList[i];
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *key = [name substringFromIndex:1];
        if ([key isEqualToString:dataDic[@"callBackName"]]) {//变量名称相同则赋值
            [obj setValue:callBackBlock forKey:dataDic[@"callBackName"]];
            break;
        }
    }
    NSMutableArray *varArr = [NSMutableArray arrayWithArray:objects];
    [varArr addObject:callBackBlock];
    
    
    SEL selector = NSSelectorFromString(dataDic[@"methodName"]);
    if (!selector) {
        //可以抛出异常也可以不操作。
        return;
    }
  
    BOOL isClassMethod = NO;
    NSMethodSignature *signature = [class instanceMethodSignatureForSelector:selector];
    if (signature == nil) {
        //未找到实例方法 通过看是否为类方法
        signature =  [class methodSignatureForSelector:selector];
        if (signature == nil) {
            return;
        }
        isClassMethod = YES;
    }
    // NSInvocation : 利用一个NSInvocation对象包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = isClassMethod?class: obj;
    invocation.selector = selector;
    // 设置参数
    NSInteger paramsCount = signature.numberOfArguments - 2; // 除self、_cmd以外的参数个数
    paramsCount = MIN(paramsCount, varArr.count);
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = varArr[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        const char *type = [signature getArgumentTypeAtIndex:2 + i];
        if (strcmp(type, "@") == 0) {
            [invocation setArgument:&object atIndex:i + 2];
        }else{
            int value = [object intValue];
            [invocation setArgument:&value atIndex:i + 2];
        }
        
    }
    // 调用方法
    [invocation invoke];
    // 获取返回值
    id returnValue = nil;
    if (signature.methodReturnLength) { // 有返回值类型，才去获得返回值
        [invocation getReturnValue:&returnValue];
    }
}

- (void)testMessageTranspond{
    MessageOrg *objc = [[MessageOrg alloc] init];
    //测试 第一步动态解析方法
   // [objc performSelector:@selector(messageNoMethod:)];
    //测试 第二步防错 接受者转发
   // [objc performSelector:@selector(personMessageTranspond)];
    //测试第三步消息转发
    [objc performSelector:@selector(personMessageTranspondInvocation)];
    //奔溃方法
//    [objc performSelector:@selector(carshMothod)];

}

- (void)testMsgSend{
    //由于系统不提倡使用msgsend 需要配置 buildsetting objc_msgSendCalls 设置为NO
//    Person *p = objc_msgSend(objc_getClass("Person"),sel_registerName("alloc"));
//        p = objc_msgSend(p,sel_registerName("init"));
    
//    objc_msgSend(p, sel_registerName("thisIsInstanceMethod"));
//    objc_msgSend(objc_getClass("Person"), sel_registerName("thisIsClassMethod"));
//    Person *p  = [[Person alloc] init];
//    [p thisIsInstanceMethod];
    
    
    Person *p = ((Person *(*)(id, SEL))(void *)objc_msgSend)((id)((Person *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("Person"), sel_registerName("alloc")), sel_registerName("init"));
    ((void (*)(id, SEL))(void *)objc_msgSend)((id)p, sel_registerName("thisIsInstanceMethod"));
    p.wife = @"hhahah";
    NSLog(@"%@",p.wife);
}

- (void)showDoc{
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Runtime" ofType:@"docx"]]]];
}
@end
