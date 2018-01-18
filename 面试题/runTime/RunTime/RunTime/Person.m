//
//  Person.m
//  RunTime
//
//  Created by ZhuJunyu on 2018/1/15.
//  Copyright © 2018年 zhujunyu. All rights reserved.
//
#import <objc/objc.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "Person.h"

@implementation Person

- (id)init{
    self = [super init];
    if(self){
        [self showName];
    }
    return self;
}

- (void)showName{

}
@end
