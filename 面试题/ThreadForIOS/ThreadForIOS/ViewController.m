//
//  ViewController.m
//  ThreadForIOS
//
//  Created by zjy on 2022/3/19.
//

#import "ViewController.h"
#import <pthread.h>
@interface ViewController ()
{
    int _ticket;
    int _btnCount;
}
@property (nonatomic, strong) NSLock *lock;//锁
@property (nonatomic, strong) NSOperationQueue *queue;//队列

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lock = [NSLock new];
    _ticket = 50;
    _btnCount = 0;
    UIButton *pthreadBtn = [self getBtn:@"pthread" ];
    [pthreadBtn addTarget:self action:@selector(pthreadAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nsthreadBtn = [self getBtn:@"NSthread" ];
    [nsthreadBtn addTarget:self action:@selector(NSThreadAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *saleBtn = [self getBtn:@"卖票非安全" ];
    [saleBtn addTarget:self action:@selector(saleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *saleSafeBtn = [self getBtn:@"卖票安全" ];
    [saleSafeBtn addTarget:self action:@selector(saleSafeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *GCDsynBtn = [self getBtn:@"GCD同步" ];
    [GCDsynBtn addTarget:self action:@selector(GCDsynBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *GCDAsynBtnBtn = [self getBtn:@"GCD异步" ];
    [GCDAsynBtnBtn addTarget:self action:@selector(GCDAsynBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *GCDAsynBtnBtn1 = [self getBtn:@"异步+并发" ];
    [GCDAsynBtnBtn1 addTarget:self action:@selector(GCDAsynBtnBtn1Action:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *GCDAsynBtnBtn2 = [self getBtn:@"同步+并发" ];
    [GCDAsynBtnBtn2 addTarget:self action:@selector(GCDSynBingfaAction) forControlEvents:UIControlEventTouchUpInside];
    UIButton *GCDAsynBtnBtn3 = [self getBtn:@"异步+串行" ];
    [GCDAsynBtnBtn3 addTarget:self action:@selector(GCDAsynSERIAL) forControlEvents:UIControlEventTouchUpInside];
    UIButton *GCDAsynBtnBtn4 = [self getBtn:@"同步+并发" ];
    [GCDAsynBtnBtn4 addTarget:self action:@selector(GCDsynSERIAL) forControlEvents:UIControlEventTouchUpInside];
    UIButton *GCDAsynBtnBtn5 = [self getBtn:@"异步+主队列" ];
    [GCDAsynBtnBtn5 addTarget:self action:@selector(GCDAsynMain) forControlEvents:UIControlEventTouchUpInside];
    UIButton *GCDAsynBtnBtn6 = [self getBtn:@"同步+主队列" ];
    [GCDAsynBtnBtn6 addTarget:self action:@selector(GCDSynMain) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *GCDAsynBtnBtn7 = [self getBtn:@"GCD栅栏" ];
    [GCDAsynBtnBtn7 addTarget:self action:@selector(GCDbarrier) forControlEvents:UIControlEventTouchUpInside];
    UIButton *GCDAsynBtnBtn8 = [self getBtn:@"GCD延迟" ];
    [GCDAsynBtnBtn8 addTarget:self action:@selector(GCDAfter) forControlEvents:UIControlEventTouchUpInside];
    UIButton *GCDAsynBtnBtn9 = [self getBtn:@"GCD快速迭代" ];
    [GCDAsynBtnBtn9 addTarget:self action:@selector(GCDapply) forControlEvents:UIControlEventTouchUpInside];
    UIButton *GCDAsynBtnBtn10 = [self getBtn:@"GCDGroup" ];
    [GCDAsynBtnBtn10 addTarget:self action:@selector(GCDGroup) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *GCDAsynBtnBtn11 = [self getBtn:@"GCD信号量" ];
    [GCDAsynBtnBtn11 addTarget:self action:@selector(GCDSignal) forControlEvents:UIControlEventTouchUpInside];
    
    [self getBtn:@"invocation" sel:@selector(invocationOperation)];
    [self getBtn:@"NSBlock" sel:@selector(NSBlockOperation)];
    [self getBtn:@"NSQueue" sel:@selector(NSOperationQueue)];
    [self getBtn:@"创建队列" sel:@selector(createOperationQueueSuspended:)];
    [self getBtn:@"暂停开始" sel:@selector(operationSetSuspended:)];
    [self getBtn:@"取消所有" sel:@selector(operationSetCancel:)];
    [self getBtn:@"设置依赖" sel:@selector(addDependency)];
    [self getBtn:@"合成图片" sel:@selector(combineImage)];

    // Do any additional setup after loading the view.
}
- (UIButton *)getBtn:(NSString *)title {
    float x = 100*(_btnCount%4);
    float y = 80*(_btnCount /4 ) + 80;
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(x, y, 80, 40);
    bt.backgroundColor = [UIColor grayColor];
    [bt setTitle:title forState:UIControlStateNormal];
    bt.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:bt];
    _btnCount ++;
    return bt;
}
- (UIButton *)getBtn:(NSString *)title sel:(SEL)sel{
    UIButton *bt = [self getBtn:title];
    [bt addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return bt;
}
#pragma mark - action

#pragma mark NSOperation
- (void)combineImage{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    __block UIImage *image1;
    NSBlockOperation *downloadw1 = [NSBlockOperation blockOperationWithBlock:^{
        
        //下载图片1
        NSURL *url = [NSURL URLWithString:@"https://lmg.jj20.com/up/allimg/tp09/210Q6123120B42-0-lp.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        image1 =[UIImage imageWithData:data];
    }];
    
    __block UIImage *image2;
    NSBlockOperation *downloadw2 = [NSBlockOperation blockOperationWithBlock:^{
        
        //下载图片2
        NSURL *url = [NSURL URLWithString:@"https://lmg.jj20.com/up/allimg/tp09/210611094Q512b-0-lp.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        image2 =[UIImage imageWithData:data];
        
    }];
    
    
    NSBlockOperation *combine = [NSBlockOperation blockOperationWithBlock:^{
        
        //合成新图片
        UIGraphicsBeginImageContext(CGSizeMake(100, 100));
        [image1 drawInRect:CGRectMake(0, 0, 50, 100)];
        [image2 drawInRect:CGRectMake(50, 0, 50, 100)];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            UIImageView *iamgeV = [[UIImageView alloc] initWithImage:image];
            [self.view addSubview:iamgeV];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [iamgeV removeFromSuperview];
            });        }];
    }];
    
    [combine addDependency:downloadw1];
    [combine addDependency:downloadw2];
    
    [queue addOperation:downloadw1];
    [queue addOperation:downloadw2];
    [queue addOperation:combine];


}


- (void)addDependency{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"down1---%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"down2---%@",[NSThread currentThread]);
        
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"down3---%@",[NSThread currentThread]);
        
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"down4---%@",[NSThread currentThread]);
    }];
    
    
    //设置依赖（op1和op3执行完之后才执行2）
    [op3 addDependency:op1];
    [op3 addDependency:op4];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    
    
    //监听一个操作的执行完成
    [op3 setCompletionBlock:^{
        NSLog(@"执行完成");
    }];
    
    
}
- (void)createOperationQueueSuspended:(id)sender {
    
    //创建队列
    self.queue = [[NSOperationQueue alloc]init];
    self.queue.maxConcurrentOperationCount = 1;
    [self.queue addOperationWithBlock:^{
        NSLog(@"-1--%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];
    [self.queue addOperationWithBlock:^{
        NSLog(@"-2--%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];
    [self.queue addOperationWithBlock:^{
        NSLog(@"-3--%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];
    [self.queue addOperationWithBlock:^{
        NSLog(@"-4--%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];
    //设置队列挂起或者取消的话都必须是在block方法执行完之后才有效
    [self.queue addOperationWithBlock:^{
        for(NSInteger i = 0;i<5;i++){
            NSLog(@"-5--%zd---%@",(long)i,[NSThread currentThread]);
        }
    }];
}
- (void)operationSetSuspended:(id)sender {
    if(self.queue.suspended){
        //恢复队列，继续执行
        self.queue.suspended  = NO;
    }else{
        //挂起（暂停队列）
        /*
         队列里的执行方法立即停止，但是有一点需要注意的是，当block操作中，队列挂起是不起作用的，它是无法停止的，必须操作执行结束后才会生效。
         */
        self.queue.suspended  = YES;
    }
}
- (void)operationSetCancel:(id)sender {
    /*
     当队列调用取消（ [self.queue cancelAllOperations]）就意味着后续队列不再执行，再次启动需要重新加入队列
     */
    [self.queue cancelAllOperations];
}


- (void)NSOperationQueue{
    //创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    //NSOperationQueue *queue = [NSOperationQueue mainQueue];
    //设置最大并发操作数
    queue.maxConcurrentOperationCount = 2;
    //创建操作（任务）
    //创建--NSInvocationOperation
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(NSqueueRun) object:nil];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(NSqueueRun1) object:nil];
    //创建--NSBlockOperation
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"-1--%@",[NSThread currentThread]);
        sleep(1);
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"-2--%@",[NSThread currentThread]);
        sleep(1);
    }];
    
    //添加任务队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    //也可以直接创建任务到队列中去
    [queue addOperationWithBlock:^{
        NSLog(@"-3--%@",[NSThread currentThread]);
    }];
    
}
- (void)NSqueueRun{
    NSLog(@"-NSqueueRunb--%@",[NSThread currentThread]);
    
    sleep(1);
    for (int i = 0 ; i <10; i ++) {
        NSLog(@"-NSqueueRun--%@",[NSThread currentThread]);
    }
}
- (void)NSqueueRun1{
    NSLog(@"-NSqueueRun1--%@",[NSThread currentThread]);
    sleep(1);
}
//操作数大于1，就会异步执行
- (void)NSBlockOperation{
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1--%@",[NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"2--%@",[NSThread currentThread]);
        
    }];
    [op start];
}
/*
 默认情况下，调用了start方法后并不会开一条新线程去执行操作，而是在当前线程同步执行操作
 只有NSOperation放到一个NSOperationQueue中，才会异步执行
 */
- (void)invocationOperation{
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(saleTicketSafe) object:nil];
    [op start];
}

#pragma mark - GCD
- (void)GCDSignal {
    //创建信号量，参数：信号量的初值，如果小于0则会返回NULL
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        //等待降低信号量
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 1");
        sleep(1);
        NSLog(@"complete task 1");
        //提高信号量
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_async(queue, ^{
        //等待降低信号量
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 2");
        sleep(1);
        NSLog(@"complete task 2");
        //提高信号量
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_async(queue, ^{
        //等待降低信号量
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 3");
        sleep(1);
        NSLog(@"complete task 3");
        //提高信号量
        dispatch_semaphore_signal(semaphore);
    });
    
    NSLog(@"complete");
}
- (void)GCDGroup{
    //创建一个队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建一个队列组
    dispatch_group_t group = dispatch_group_create();
    __block UIImage *image ;
    __block UIImage *image1;
    dispatch_group_async(group, queue, ^{
        NSLog(@"download image1 start");
        //下载图片1
        NSURL *url = [NSURL URLWithString:@"https://lmg.jj20.com/up/allimg/tp09/210Q6123120B42-0-lp.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        image = [UIImage imageWithData:data];
        NSLog(@"download image1 end");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"download image2 start");
        //下载图片2
        NSURL *url = [NSURL URLWithString:@"https://lmg.jj20.com/up/allimg/tp09/210611094Q512b-0-lp.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        image1 = [UIImage imageWithData:data];
        
        NSLog(@"download image2 end");
    });
    
    //当这个队列组的所有队列全部完成，就会收到这个消息
    dispatch_group_notify(group, queue, ^{
        NSLog(@"download all images");
        //合成新图片
        UIGraphicsBeginImageContext(CGSizeMake(100, 100));
        [image1 drawInRect:CGRectMake(0, 0, 50, 100)];
        [image drawInRect:CGRectMake(50, 0, 50, 100)];
        UIImage *lImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //在主线程显示
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *iamgeV = [[UIImageView alloc] initWithImage:lImage];
            [self.view addSubview:iamgeV];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [iamgeV removeFromSuperview];
            });
        });
    });
    
    
}
- (void)GCDapply{
    //参数1： 指定重复次数
    //参数2：对象的DispatchQueue
    //参数3：带有参数的Block, index的作用是为了按执行的顺序区分各个Block
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"%@--%zu",[NSThread currentThread],index);
    });
    NSLog(@"done");
    
    
}
- (void)GCDAfter{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"after");
    });
    /*
     还可以用
     performSelector
     NSTimer
     */
}
- (void)GCDbarrier{
    
    //queue不能是全局的队列，最好自己创建
    dispatch_queue_t queue = dispatch_queue_create("com.xiaoyi.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<5; i++) {
            NSLog(@"1线程-%ld-%@",(long)i,[NSThread currentThread]);
        }
    });
    //在barrier函数前面执行的任务执行结束后它后面的任务才会执行
    dispatch_barrier_async(queue, ^{
        for (NSInteger i = 0; i<5; i++) {
            NSLog(@"barrier-%ld-%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<5; i++) {
            NSLog(@"2线程-%ld-%@",(long)i,[NSThread currentThread]);
        }
    });
}

//异步函数 + 主队列 :只在主线程中执行任务
- (void)GCDAsynMain{
    [self dispatchAsyncInQueue:dispatch_get_main_queue()];
}
//同步函数 + 主队列 :会卡死，线程间相互制约
- (void)GCDSynMain{
    [self dispatchSyncInQueue:dispatch_get_main_queue()];
}
/*
 队列的初始化有
 第一种：自定义（队列的名字，队列的类型）
 队列的类型(并发：DISPATCH_QUEUE_CONCURRENT,串行：DISPATCH_QUEUE_SERIAL)
 dispatch_queue_t queue = dispatch_queue_create("com.xiaoyi.queue", DISPATCH_QUEUE_CONCURRENT);
 
 第二种：获得全局的并发队列(参数1：优先级(官方建议用default),参数2：目前没有意义，官方文档提示传0)
 dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 */

//异步函数 + 串行队列 :会开新线程，但是任务是串行的，执行完一个再执行下一个
- (void)GCDAsynSERIAL{
    dispatch_queue_t queue = dispatch_queue_create("com.xiaoyi.queue", DISPATCH_QUEUE_SERIAL);
    //2、将任务加入队列
    [self dispatchAsyncInQueue:queue];
}

//同步函数 + 串行队列 :不会开新线程，在当前线程执行任务
- (void)GCDsynSERIAL{
    dispatch_queue_t queue = dispatch_queue_create("com.xiaoyi.queue", DISPATCH_QUEUE_SERIAL);
    [self dispatchSyncInQueue:queue];
}
//同步函数 + 并发队列 :不会开新线程
- (void)GCDSynBingfaAction{
    //1、创建一个并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //2、将任务加入队列
    [self dispatchSyncInQueue:queue];
}
//异步函数 + 并发队列：会开新线程
- (void)GCDAsynBtnBtn1Action:(id)sender{
    //1、创建一个并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //2、将任务加入队列
    [self dispatchAsyncInQueue:queue];
    
}

- (void)dispatchAsyncInQueue:(dispatch_queue_t)queue{
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<5; i++) {
            NSLog(@"1线程-%ld-%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_barrier_sync(queue, ^{
        NSLog(@"barrier---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<5; i++) {
            NSLog(@"2线程-%ld-%@",(long)i,[NSThread currentThread]);
        }
    });
}
- (void)dispatchSyncInQueue:(dispatch_queue_t)queue{
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i<5; i++) {
            NSLog(@"1线程-%ld-%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i<5; i++) {
            NSLog(@"2线程-%ld-%@",(long)i,[NSThread currentThread]);
        }
    });
}

- (void)GCDsynBtnAction:(id)sender{
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"sync---%@",[NSThread currentThread]);
    });
    
    NSLog(@"外层---%@",[NSThread currentThread]);
    
}
- (void)GCDAsynBtnAction:(id)sender{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"sync---%@",[NSThread currentThread]);
        
    });
    NSLog(@"外层---%@",[NSThread currentThread]);
    
}
#pragma mark -  NSThread
- (void)saleBtnAction:(id)sender{
    _ticket = 50;
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicketNotSafe) object:nil];
    thread.name = @"长沙站";
    [thread start];
    NSThread *threadCZ = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicketNotSafe) object:nil];
    threadCZ.name = @"郴州站";
    [threadCZ start];
}
/**
 * 售卖火车票(非线程安全)
 */
- (void)saleTicketNotSafe {
    while (1) {
        //如果还有票，继续售卖
        if (_ticket > 0) {
            _ticket --;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", _ticket, [NSThread currentThread].name]);
            [NSThread sleepForTimeInterval:0.2];
        }
        //如果已卖完，关闭售票窗口
        else {
            NSLog(@"所有火车票均已售完");
            break;
        }
    }
}


- (void)saleSafeBtnAction:(id)sender{
    _ticket = 50;
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicketSafe) object:nil];
    thread.name = @"长沙站";
    [thread start];
    NSThread *threadCZ = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicketSafe) object:nil];
    threadCZ.name = @"郴州站";
    [threadCZ start];
}
/**
 * 售卖火车票(程安全)
 */
- (void)saleTicketSafe {
    
    /*
     iOS 实现线程加锁有很多种方式。@synchronized、 NSLock、NSRecursiveLock、NSCondition、NSConditionLock、pthread_mutex、dispatch_semaphore、OSSpinLock、atomic(property) set/ge等等各种方式
     */
    int i = 0;
    switch (i) {
        case 0:
        {
            [self useSynchronized];
        }break;
        case 1:
        {
            [self useNSlock];
        }break;
        case 2:
        {
            
        }break;
        default:{//非安全
            while (1) {
                if (_ticket > 0) {
                    _ticket --;
                    NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", _ticket, [NSThread currentThread].name]);
                    [NSThread sleepForTimeInterval:0.2];
                }
                //如果已卖完，关闭售票窗口
                else {
                    NSLog(@"所有火车票均已售完");
                    break;
                }
            }
        }
            break;
    }
}
- (void)useSynchronized{
    while (1) {
        @synchronized (self) {
            if (_ticket > 0) {
                _ticket --;
                NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", _ticket, [NSThread currentThread].name]);
                [NSThread sleepForTimeInterval:0.2];
            }
            //如果已卖完，关闭售票窗口
            else {
                NSLog(@"所有火车票均已售完");
                break;
            }
        }
        
    }
}
- (void)useNSlock{
    while (1) {
        
        [self.lock lock];
        if (_ticket > 0) {
            _ticket --;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", _ticket, [NSThread currentThread].name]);
            [NSThread sleepForTimeInterval:0.2];
        }
        //如果已卖完，关闭售票窗口
        else {
            NSLog(@"所有火车票均已售完");
            break;
        }
        
        [self.lock unlock];
    }
}


#pragma mark - NSThread
- (void)NSThreadAction:(id)sender{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadAction:) object:nil];
    [thread start];
    
    //自动开启
    // [NSThread detachNewThreadSelector:@selector(threadAction:) toTarget:self withObject:nil];
    /*
     
     */
}

- (void)threadAction:(id)sender{
    NSLog(@"%@", [NSThread currentThread]);
}

#pragma mark - pthread_t
-(void)pthreadAction:(id)sender{
    //pthread_t用于表示Thread ID，具体内容根据实现的不同而不同，有可能是一个Structure，因此不能将其看作为整数.
    pthread_t thread;
    /*
     第一个参数&thread是线程对象，指向线程标识符的指针
     第二个是线程属性，可赋值NULL
     第三个指向函数的指针(需要在新线程中执行的任务)
     第四个是运行函数的参数，可赋值NULL
     */
    pthread_create(&thread, NULL, pthreadRun, NULL);
    //等待 线程结束后才会执行后面
    pthread_join(thread, NULL);
    pthread_t thread1;
    pthread_create(&thread1, NULL, pthreadRun, NULL);
    //设置子线程的状态设置为 detached，该线程运行结束后会自动释放所有资源
    
    pthread_detach(thread);
    pthread_detach(thread1);
    
    
}
void *pthreadRun(void *p){
    NSLog(@"pthreadRun---当前线程%@",[NSThread currentThread]);
    for (int i =0 ; i < 50; i ++) {
        NSLog(@"%d-----线程--%@",i,[NSThread currentThread]);
    }
    return NULL;
}
@end
