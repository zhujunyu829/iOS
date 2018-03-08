 //
//  ViewController.m
//  RunTime
//
//  Created by ZhuJunyu on 2018/1/15.
//  Copyright © 2018年 zhujunyu. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+MYImage.h"
#import "User.h"
#import "MyRoom.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *imge = [UIImage imageNamed:@"pppp.jpg"];
    NSLog(@"%@",imge.name);
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"list" ofType:@"plist"]];
    User *user = [User modelWithDict:dic];
    NSLog(@"%@ -- %d",user.name,user.ID);
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"myList" ofType:@"plist"]];
    MyRoom *room = [MyRoom modelWithDict:dict];
    
    NSLog(@"roo %@",room.name);
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:room];
    
    MyRoom *othr = [NSKeyedUnarchiver unarchiveObjectWithData:data ];
    
    NSLog(@"ddd%@",othr.name);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

