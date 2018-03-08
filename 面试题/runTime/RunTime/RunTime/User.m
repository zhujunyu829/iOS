//
//  User.m
//  RunTime
//
//  Created by zjy on 2018/3/8.
//  Copyright © 2018年 zhujunyu. All rights reserved.
//

#import "User.h"
#import "MyModel.h"
#import <objc/runtime.h>
@implementation User
+ (instancetype)modelWithDict:(NSDictionary *)dict{
    id  objc = [[self alloc] init];
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *key = [ivarName substringFromIndex:1];
        if ([key isEqualToString:@"ID"]) {
            key = @"id";
        }
        id value = dict[key];
        if (value) {
            [objc setValue:value forKey:[ivarName substringFromIndex:1]];
        }
    }
    return objc;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    encodeRuntime(User);
}

- (id)initWithCoder:(NSCoder *)decoder{
    initCoderRuntime(User);
}
@end
