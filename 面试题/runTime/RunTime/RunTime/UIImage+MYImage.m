//
//  UIImage+MYImage.m
//  RunTime
//
//  Created by zjy on 2018/3/8.
//  Copyright © 2018年 zhujunyu. All rights reserved.
//
#import <objc/message.h>
#import "UIImage+MYImage.h"

@implementation UIImage (MYImage)

+ (void)load{
    Method imageNameMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method lMyImageNameMethod = class_getClassMethod(self, @selector(my_imageName:));
    //3.交换方法地址，相当于交换实现方式;「method_exchangeImplementations 交换两个方法的实现」
    method_exchangeImplementations(imageNameMethod, lMyImageNameMethod);
}
+ (UIImage *)my_imageName:(NSString *)name{
    
    UIImage *imge = [UIImage my_imageName:name];//由于 方法交换了 所以这个其实调用的是imageNamed 方法
    imge.name = name;
    if (imge) {
        NSLog(@"runtime添加额外功能--加载成功");
    }else{
         NSLog(@"runtime添加额外功能--加载失败");
    }
    return imge;
}
- (void)setName:(NSString *)name{
    // objc_setAssociatedObject（将某个值跟某个对象关联起来，将某个值存储到某个对象中）
    // object:给哪个对象添加属性
    // key:属性名称
    // value:属性值
    // policy:保存策略
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)name{
    return objc_getAssociatedObject(self, @"name");
}
@end
