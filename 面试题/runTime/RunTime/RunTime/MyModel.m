//
//  MyModel.m
//  RunTime
//
//  Created by zjy on 2018/3/8.
//  Copyright © 2018年 zhujunyu. All rights reserved.
//

#import "MyModel.h"
#import <objc/runtime.h>

@implementation MyModel

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    id  objc = [[self alloc] init];
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        NSString *key = [ivarName substringFromIndex:1];
        
        if ([self respondsToSelector:@selector(propertyKeyDic)]) {
            id idSelf = self;
            key  = [idSelf propertyKeyDic][key]?:key;
        }
        id value = dict[key];
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            Class modelClass = NSClassFromString(ivarType);
            if (modelClass) {
                value = [modelClass modelWithDict:value];
            }
        }
        if ([value isKindOfClass:[NSArray class]]) {
            if ([self respondsToSelector:@selector(arrayContainModelClass)]) {
                id idSelf = self;
                NSString *type = [idSelf arrayContainModelClass][key];
                Class classModel = NSClassFromString(type);
                if (classModel) {
                    NSMutableArray *arrM = [NSMutableArray new];
                    for (NSDictionary *dict in value) {
                        id model = [classModel modelWithDict:dict];
                        [arrM addObject:model];
                    }
                    value = arrM;
                }
            }
        }
        if (value) {
            [objc setValue:value forKey:[ivarName substringFromIndex:1]];
        }
    }
    return objc;
}
/**
 数组中保存的 对象字典
 
 @return  @{对象属性值：对应的model类名字}字典
 */
+ (NSDictionary *)arrayContainModelClass{
    return @{};
}

/**
 字典和对象值不一致时 设置
 
 @return @{对象属性值：字典中存的值}
 */
+  (NSDictionary *)propertyKeyDic{
    return @{};
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    encodeRuntime(MyModel);
}

- (id)initWithCoder:(NSCoder *)decoder{
     initCoderRuntime(MyModel);
}
@end
