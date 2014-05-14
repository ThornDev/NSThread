//
//  MjViewController.m
//  ThreadSample
//
//  Created by qingyun on 14-5-12.
//  Copyright (c) 2014年 hnqingyun. All rights reserved.
//

#import "MjViewController.h"

@interface MjViewController ()
@property (weak, nonatomic) IBOutlet UIButton *threadBtn;

@end

@implementation MjViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.threadBtn setTitle:@"Doing" forState:UIControlStateHighlighted];
    [self.threadBtn setBackgroundImage:[UIImage imageNamed:@"6-12AM"] forState:UIControlStateNormal];
    [self.threadBtn setBackgroundImage:[UIImage imageNamed:@"6-12PM"] forState:UIControlStateHighlighted];
    
	
}
- (IBAction)doThing:(id)sender {
//    [self doSomeThing];
    NSLog(@"Button Action");
//    第一种方法，直接开启一个线程来运行
//    [self performSelectorInBackground:@selector(doSomeThing) withObject:nil];
//    
//    第二种方法，直接创建一个线程，SEL参数是指这个线程需要执行的任务，使用这个方法的话，线程直接启动，但是不能控制线程什么时候关闭
//    [NSThread detachNewThreadSelector:@selector(doSomeThing) toTarget:self withObject:nil];
//    
//    第三种方法，初始化一个线程并将线程启动，否则线程不会执行的。这种创建线程的方式是可以控制线程开始和关闭的，线程本身有对应的方法cancel。
//    NSThread *thread = [[NSThread alloc ]initWithTarget:self selector:@selector(doSomeThing) object:nil];
////    启动线程
//    [thread start];
//    
//    第四种方法，创建一个线程队列，并在线程队列中添加操作对象
//不过在这里需要注意的是：不能直接用NSOperation来定义一个操作对象,因为NSOperation只是一个抽象的类。我们若要使用必须继承他.而好在苹果公司提供了继承NSOperation的两个子类即NSInvocationOperation和NSBlockOperation.可见官方解释。
//    The NSOperation class is an abstract class you use to encapsulate the code and data associated with a single task. Because it is abstract, you do not use this class directly but instead subclass or use one of the system-defined subclasses (NSInvocationOperation or NSBlockOperation) to perform the actual task.
//    我们可以直接使用这两个类来定义我们的操作对象，前者是管理一个单一的封装的任务的执行，后者则是管理一个或多个块中的并行执行。当然我们也可以自定义操作对象。
////    创建一个线程队列
//    NSOperationQueue *operationQuene = [[NSOperationQueue alloc]init];
////    创建一个操作对象，这个操作对象定义了线程需要做的任务。
////  1、NSInvocationOperation
//    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(doSomeThing) object:nil];
////    将创建好的操作对象放进线程队列中，这样线程就可以直接启动了。
//    [operationQuene addOperation:operation];
//    
////  2、NSBlockOperation
//    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
//        [NSThread sleepForTimeInterval:5];
//        NSThread *thread = [NSThread currentThread];
//        if ([thread isMainThread]) {
//            NSLog(@"Main Thread");
//        }else{
//            NSLog(@"Peer Thread");
//        }
//        NSLog(@"DONE");
//    }];
//    [operationQuene addOperation:blockOperation];
    


    
//    第五种方法，使用dispatch的分发方法，直接将需要操作的任务放进dispatch的Block块中
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    同步分发
    dispatch_sync(quene, ^{
        NSLog(@"do thing");
        [NSThread sleepForTimeInterval:5];
        NSThread *thread = [NSThread currentThread];
        if ([thread isMainThread]) {
            NSLog(@"Main Thread");
        }else{
            NSLog(@"Peer1 Thread");
        }
        NSLog(@"DONE");

    });
//    异步分发
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"do anotherthing");
        [NSThread sleepForTimeInterval:5];
        NSThread *thread = [NSThread currentThread];
        if ([thread isMainThread]) {
            NSLog(@"Main Thread");
        }else{
            NSLog(@"Peer2 Thread");
        }
        NSLog(@"DONE");
    });
}

- (void)doSomeThing
{

    NSLog(@"do thing");
    [NSThread sleepForTimeInterval:5];
     NSLog(@"Done");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
