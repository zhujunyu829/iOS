//
//  User.h
//  RunTime
//
//  Created by zjy on 2018/3/8.
//  Copyright © 2018年 zhujunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int ID;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
