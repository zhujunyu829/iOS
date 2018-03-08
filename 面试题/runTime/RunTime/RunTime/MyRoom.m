//
//  MyRoom.m
//  RunTime
//
//  Created by zjy on 2018/3/8.
//  Copyright © 2018年 zhujunyu. All rights reserved.
//

#import "MyRoom.h"
#import <objc/runtime.h>

@implementation MyRoom

/**
 数组中保存的 对象字典

 @return  @{对象属性值：对应的model类名字}字典
 */
+ (NSDictionary *)arrayContainModelClass{
    return @{@"models":@"User"};
}

/**
 字典和对象值不一致时 设置

 @return @{对象属性值：字典中存的值}
 */
+  (NSDictionary *)propertyKeyDic{
    return @{@"ID":@"id"};
}
- (void)encodeWithCoder:(NSCoder *)encoder{
    encodeRuntime(MyRoom);
}

- (id)initWithCoder:(NSCoder *)decoder{
    initCoderRuntime(MyRoom);
}
@end
