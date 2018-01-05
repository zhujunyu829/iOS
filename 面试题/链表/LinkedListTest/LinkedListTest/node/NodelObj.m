//
//  NodelObj.m
//  LinkedListTest
//
//  Created by ZhuJunyu on 2018/1/5.
//  Copyright © 2018年 zhujunyu. All rights reserved.
//

#import "NodelObj.h"

@implementation NodelObj

- (instancetype)initNodeAtIndex:(int)index  count:(int)count{
    if (self = [super init]) {
        _index = index;
        _value = [NSString stringWithFormat:@"value_%d",index];
        if (index <= count) {
            _next = [[[self class] alloc] initNodeAtIndex:index+1 count:count];
        }else{
            _next = nil;
        }
    }
    return self;
}


- (NodelObj *)lastNode{
    NodelObj *node = self;
    while (node.next) {
        node = node.next;
    }
    return node;
}
- (NSInteger)length{
    NSInteger length = 0;
    NodelObj *node = self;

    while (node.next) {
        node = node.next;
        length++;
    }
    return length;
}
- (void)readAllnode{
    NodelObj *node = self;
    while (node) {
        NSLog(@"index = %d, value = %@",node.index,node.value);
        node = node.next;
    }
}
- (void)delectedAtIndx:(int)index{
    
}
- (void)insettNodeAtIndx:(int)index{
    if (self.length+1 <index) {//超出长度
        return;
    }
    NodelObj *newNode = [[NodelObj alloc] initNodeAtIndex:index count:0];
    NodelObj *indexNode = [self getNodeAtIndex:index];
    NodelObj *beforNode = [self getNodeAtIndex:index-1];

    if (!indexNode) {//在最后一个节点
        beforNode.next = newNode;
        return;
    }
    newNode.next = indexNode;
    beforNode.next = newNode;
}
- (NodelObj *)getNodeAtIndex:(int)index{
    NodelObj *node = self;
    while (node.next) {
        if (node.index == index) {
            break;
        }
        node = node.next;
    }
    return node;
}
- (BOOL)hasHoop{
    NodelObj *lowNode = self;
    NodelObj *fastNode = self;
    BOOL has = NO;
    while (fastNode.next) {
        lowNode = lowNode.next;
        fastNode = fastNode.next.next;
        if (fastNode == lowNode) {
            has = YES;
            break;
        }
       
    }
    return has;
}
- (NSInteger)cheakHoopIndex{
    NodelObj *lowNode = self;
    NodelObj *fastNode = self;
    while (fastNode.next) {
        lowNode = lowNode.next;
        fastNode = fastNode.next.next;
        if (fastNode == lowNode) {
            break;
        }
    }
    lowNode = self;
    
    while (fastNode.next) {
        if (fastNode == lowNode) {
            NSLog(@"环入口 %d",fastNode.index);
            return fastNode.index;
            break;
        }
        lowNode = lowNode.next;
        fastNode = fastNode.next;
    }
    return -1;
}
- (NSInteger)cheakHoopLength{
    NodelObj *lowNode = self;
    NodelObj *fastNode = self;
    while (fastNode.next) {
        lowNode = lowNode.next;
        fastNode = fastNode.next.next;
        if (fastNode == lowNode) {
            break;
        }
    }
    lowNode = self;
    NSInteger length = 0;
    while (fastNode.next) {
        length ++;
        lowNode = lowNode.next;
        fastNode = fastNode.next.next;
        if (fastNode == lowNode) {
            break;
        }
    }
    NSLog(@"hooplength %ld",(long)length);
    return length;
}
- (BOOL)intesectWithNode:(NodelObj *)obj{
    BOOL selfHasHoop = [self hasHoop];
    BOOL objHasHoop = [obj hasHoop];
    if (selfHasHoop != objHasHoop) {//如果两个链表一个有环一个没有环则必定不相交
        return NO;
    }
    if (selfHasHoop && objHasHoop) {//两个都有环
        BOOL hasIntesect = NO;
        NSInteger  hoopIndex = [self cheakHoopIndex];
        NodelObj *hoopNode = [self getNodeAtIndex:(int)hoopIndex];
        NodelObj *headNodel = obj;
        NodelObj *objHoopNode = [obj getNodeAtIndex:(int)[obj cheakHoopIndex]];
        int i = 0;
        while (i != 2) {//如果另一个链表环绕环两圈都没找到 环入口这个节点说明两个链表没有交叉
            if (headNodel == objHoopNode) {
                i ++;
            }
            if (headNodel == hoopNode) {
                hasIntesect = YES;
                break;
            }
            headNodel = headNodel.next;
        }
        return hasIntesect;
    }
    //剩下的就是两个都是单链表讲两个链表的头尾相连 如果存在环必交叉
    NodelObj *selfHead = self;
    NodelObj *objLast = [obj lastNode];
    objLast.next = self;
    if ([obj hasHoop]) {
        return YES;
    }
    
    
    return NO;
}

#pragma mark - NSCopying
- (id)copyWithZone:(nullable NSZone *)zone
{
    NodelObj *newObj = [NodelObj allocWithZone:zone];
    newObj.index = self.index;
    newObj.value = self.value;
    newObj.next = self.next;
    return newObj;
}

@end
