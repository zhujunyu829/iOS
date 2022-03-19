//
//  User.m
//  runtimeDemo
//
//  Created by hy001 on 2022/2/17.
//

#import "User.h"
#import <objc/runtime.h>

@implementation User
+(User *)modelFromDict:(NSDictionary *)dict{
    User *objc = [[self alloc] init];
    id idSelf = self;
    unsigned int count;
    //获取所有key的值
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivarList[i];
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        NSString *key = [name substringFromIndex:1];
        id idkey = [idSelf modelCustomPropertyMapper][key];
        if (idkey == nil) {
            idkey = key;
        }
        id value = dict[idkey];
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            Class methodClass = NSClassFromString(ivarType);
            if (methodClass) {
                value = [methodClass modelFromDict:value];
            }
        }
        if ([value isKindOfClass:[NSArray class]]) {
            NSString *type = [idSelf containModelClass][key];
            Class methodClass = NSClassFromString(type);
            NSMutableArray *mulary = [NSMutableArray array];
            for (NSDictionary *dic in value) {
                id model = [methodClass modelFromDict:dic];
                [mulary addObject:model];
            }
            value = mulary;
        }
        
        
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    
    
    return objc;
    
}
+(NSDictionary *)modelCustomPropertyMapper{
    return @{};
}
+ (NSDictionary *)containModelClass{
    return @{@"users":@"User"};
}
@end
