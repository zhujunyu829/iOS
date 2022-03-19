//
//  Person.h
//  runtimeDemo
//
//  Created by hy001 on 2022/2/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

+ (void)thisIsClassMethod;

- (void)thisIsInstanceMethod;

- (void)personMessageTranspond;
- (void)personMessageTranspondInvocation;
@property(nonatomic, copy) NSString * name;
@end

NS_ASSUME_NONNULL_END
