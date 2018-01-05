//
//  NodelObj.h
//  LinkedListTest
//
//  Created by ZhuJunyu on 2018/1/5.
//  Copyright © 2018年 zhujunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NodelObj : NSObject <NSCopying>

@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) int index;
@property (nonatomic, retain) NodelObj *next;


/**
 创建单链表

 @param index 起始坐标
 @param count 总共节点数
 @return 返回链表
 */
- (instancetype)initNodeAtIndex:(int)index count:(int)count;

- (NodelObj *)lastNode;
- (NSInteger)length;
- (void)readAllnode;
- (void)delectedAtIndx:(int)index;
- (void)insettNodeAtIndx:(int)index;
- (NodelObj *)getNodeAtIndex:(int)index;

- (BOOL)hasHoop;

/**
 检查环的入口
 @return 返回环的入口节点
 */
- (NSInteger)cheakHoopIndex;

/**
 检查环的长度

 @return 返回环的长度
 */
- (NSInteger)cheakHoopLength;

/**
 判断两个链表是否相交

 @param obj 另一个链表
 @return 返回结果
 */
- (BOOL)intesectWithNode:(NodelObj *)obj;

@end
