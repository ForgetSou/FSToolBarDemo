//
//  FSMoreVC.m
//  FSToolBarDemo
//
//  Created by forget on 2020/11/3.
//

#import "FSMoreVC.h"
#import <libkern/OSAtomic.h>
#import <os/lock.h>

@interface FSMoreVC ()

@property (assign, nonatomic) int ticketsCount;
//@property (assign, nonatomic) OSSpinLock ticketLock;
@property (strong, nonatomic) NSLock *lock;
@property (strong, nonatomic) NSRecursiveLock *rLock;
@property (strong, nonatomic) NSCondition *condition;

@end

@implementation FSMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = NSColor.whiteColor.CGColor;
    [self.view addGestureRecognizer:[[NSClickGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)]];
    
//    self.ticketLock = OS_SPINLOCK_INIT;
    [self ticketTestAction];
}

- (NSRecursiveLock *)rLock {
    if (!_rLock) {
        _rLock = [[NSRecursiveLock alloc] init];
    }
    return _rLock;
}

- (NSLock *)lock {
    if (!_lock) {
        _lock = [[NSLock alloc] init];
    }
    return _lock;
}

- (NSCondition *)condition {
    if (!_condition) {
        _condition = [[NSCondition alloc] init];
    }
    return _condition;
}

- (void)viewClick {
    [self performSegueWithIdentifier:@"split" sender:nil];
}

- (void)ticketTestAction {
    self.ticketsCount = 15;
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        dispatch_async(queue, ^{
            for (int i = 0; i < 5; i++) {
                 [self saleSingleTicket];
            }
        });
        dispatch_async(queue, ^{
            for (int i = 0; i < 5; i++) {
                [self saleSingleTicket];
            }
        });
        dispatch_async(queue, ^{
            for (int i = 0; i < 5; i++) {
                [self saleSingleTicket];
            }
        });
}

- (void)saleSingleTicket {
    // 加锁
//    [self.lock lock];
//    [self.rLock lock];
//    [self.condition lock];
    int oldTicketsCount = self.ticketsCount;
    sleep(.2);
    oldTicketsCount--;
    self.ticketsCount = oldTicketsCount;
    NSLog(@"还剩%d张票 - %@", oldTicketsCount, [NSThread currentThread]);
    // 解锁
//    [self.lock unlock];
//    [self.rLock unlock];
//    [self.condition unlock];
}


@end
