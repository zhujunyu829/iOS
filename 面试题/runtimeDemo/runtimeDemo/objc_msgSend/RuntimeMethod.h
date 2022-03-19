//
//  RuntimeMethod.h
//  runtimeDemo
//
//  Created by hy001 on 2022/2/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeMethod : NSObject

@property (nonatomic, copy) void (^callBackBlock)(id data, NSError *error);
@property (nonatomic, copy) NSString *name;

+ (void)runtimeClassMethod:(NSString *)name;
- (void)runtimeMethodA:(NSString *)name;
- (void)runtimeMethodB:(NSString *)name;
- (void)runtimeMethodInt:(int)age;

- (void)runtimeMethodA:(NSString *)name block:(void (^)(id data, NSError *error))block;
- (void)runtimeMethodB:(NSString *)name block:(void (^)(id data, NSError *error))block;
@end

NS_ASSUME_NONNULL_END
