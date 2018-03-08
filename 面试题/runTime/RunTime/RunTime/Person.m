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
- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0 ; i <count; i ++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        NSString *propertyValue = [self valueForKey:propertyName];
        [aCoder encodeObject:propertyValue forKey:propertyName];
    }
    free(properties);
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super  init]) {
        unsigned int count;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for (int i = 0; i < count; i ++) {
            objc_property_t prorerty = properties[i];
            const char *name = property_getName(prorerty);
            NSString *propertyName = [NSString stringWithUTF8String:name];
            NSString *propertyValue = [aDecoder decodeObjectForKey:propertyName];
            [self setValue:propertyValue forKey:propertyName];
        }
        free(properties);
    }
    return self;
}
@end
