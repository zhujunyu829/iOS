//
//  User.h
//  runtimeDemo
//
//  Created by hy001 on 2022/2/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, assign) int age;
@property(nonatomic, strong) NSArray *users;
@property (nonatomic, strong) User *user;
 
+(User *)modelFromDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
