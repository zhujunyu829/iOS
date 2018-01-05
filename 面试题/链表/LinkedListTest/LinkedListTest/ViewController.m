//
//  ViewController.m
//  LinkedListTest
//
//  Created by ZhuJunyu on 2018/1/5.
//  Copyright © 2018年 zhujunyu. All rights reserved.
//

#import "ViewController.h"
#import "NodelObj.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatYNode];
    [self creatHoop];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)creatHoop{
    NodelObj *node = [[NodelObj alloc] initNodeAtIndex:0 count:20];
   
    if ([node hasHoop]) {
        NSLog(@"没设置前存在环");
    }else{
        NSLog(@"没设置前不存在环");
    }
    NodelObj *nodeCenter = [node getNodeAtIndex:10];
    [node lastNode].next = nodeCenter;
    
    if ([node hasHoop]) {
        NSLog(@"存在环");
        [node cheakHoopIndex];
        [node cheakHoopLength];
    }else{
        NSLog(@"不存在环");
    }
    
}

- (void)creatYNode{
    NodelObj *node = [[NodelObj alloc] initNodeAtIndex:0 count:20];
    NodelObj *node1 = [[NodelObj alloc] initNodeAtIndex:40 count:50];
    if ([node1 intesectWithNode:node]) {
        NSLog(@"前链表相交");
    }else{
        NSLog(@"前链表不相交");
    }
    NodelObj *nodeSame = [[NodelObj alloc] initNodeAtIndex:23 count:31];
    NodelObj *nLast = [node lastNode];
    nLast.next = nodeSame;
    [node1 lastNode].next = nodeSame;
    
    if ([node1 intesectWithNode:node]) {
        NSLog(@"后链表相交");
    }else{
        NSLog(@"后链表不相交");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
