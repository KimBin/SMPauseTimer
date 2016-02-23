//
//  SMViewController.m
//  SMPauseTimer
//
//  Created by Sean McNeil on 02/15/2016.
//  Copyright (c) 2016 Sean McNeil. All rights reserved.
//

#import "SMViewController.h"

@import SMPauseTimer;

static const CGFloat SMTimeIntervalA = 15.0f;
static const CGFloat SMTimeIntervalB = 18.0f;
static const CGFloat SMTimeIntervalDelay = 5.0f;

@interface SMViewController ()

@property (nonatomic) NSDate *startDateA;
@property (nonatomic) NSDate *startDateB;

@end

@implementation SMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self testClassTimerA];
    self.startDateA = [NSDate date];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.startDateB = [NSDate date];
        [self testClassTimerB];
    });
}

- (void)testClassTimerA {
    NSLog(@"Timer A has started");
    SMPauseTimer *pauseTimer = [SMPauseTimer scheduledTimerWithTimeInterval:SMTimeIntervalA
                                                                     target:self
                                                                   selector:@selector(testA)
                                                                   userInfo:nil
                                                                    repeats:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, SMTimeIntervalDelay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"Pause timer A");
        [pauseTimer pauseTimer];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, SMTimeIntervalDelay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            NSLog(@"Resume timer A");
            [pauseTimer resumeTimer];
        });
    });
}

- (void)testClassTimerB {
    NSLog(@"Timer B has started");
    SMPauseTimer *pauseTimer = [SMPauseTimer scheduledTimerWithTimeInterval:SMTimeIntervalB
                                                                     target:self
                                                                   selector:@selector(testB)
                                                                   userInfo:nil
                                                                    repeats:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, SMTimeIntervalDelay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"Pause timer B");
        [pauseTimer pauseTimer];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, SMTimeIntervalDelay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            NSLog(@"Resume timer B");
            [pauseTimer resumeTimer];
        });
    });
}

- (void)testA {
    CGFloat interval = [self.startDateA timeIntervalSinceNow];
    NSLog(@"Timer A has completed in %.2f seconds. It should complete just over %.2f seconds.",(interval * -1), SMTimeIntervalA + SMTimeIntervalDelay);
    
}

- (void)testB {
    CGFloat interval = [self.startDateB timeIntervalSinceNow];
    NSLog(@"Timer B has completed in %.2f seconds. It should complete just over %.2f seconds.",(interval * -1), SMTimeIntervalB + SMTimeIntervalDelay);}

@end
