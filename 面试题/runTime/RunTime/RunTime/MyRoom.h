//
//  MyRoom.h
//  RunTime
//
//  Created by zjy on 2018/3/8.
//  Copyright © 2018年 zhujunyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "MyModel.h"
@interface MyRoom : MyModel

@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSMutableArray *models;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int  ID;
@end
