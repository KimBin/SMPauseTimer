//
//  SMPauseTimerTests.m
//  SMPauseTimerTests
//
//  Created by Sean McNeil on 02/15/2016.
//  Copyright (c) 2016 Sean McNeil. All rights reserved.
//

@import XCTest;
@import SMPauseTimer;

static const CGFloat SMMinimumTimerDelay = 1.0f;
static const CGFloat SMMaximumTimerDelay = 5.0f;

@interface Tests : XCTestCase

@end

@implementation Tests

#pragma mark - Initialization tests
- (void)testScheduledTimerWithTimeIntervalForInvocation {
    NSMethodSignature *signature = [self methodSignatureForSelector:@selector(invocationTarget:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:@selector(invocationTarget:)];
    
    SMPauseTimer *pauseTimer = [SMPauseTimer scheduledTimerWithTimeInterval:SMMinimumTimerDelay
                                                                 invocation:invocation
                                                                    repeats:NO];
    XCTAssertNotNil(pauseTimer);
}

- (void)testScheduledTimerWithTimeIntervalAndNilInvocation {
    XCTAssertThrows([SMPauseTimer scheduledTimerWithTimeInterval:SMMinimumTimerDelay
                                                      invocation:nil
                                                         repeats:NO]);
}

- (void)testScheduledTimerWithTimeIntervalForSelector {
    SMPauseTimer *pauseTimer = [SMPauseTimer scheduledTimerWithTimeInterval:SMMinimumTimerDelay
                                                                     target:self
                                                                   selector:@selector(selectorTarget)
                                                                   userInfo:nil
                                                                    repeats:NO];
    XCTAssertNotNil(pauseTimer);
}

- (void)testScheduledTimerWithTimeIntervalAndNilTarget {
    XCTAssertThrows([SMPauseTimer scheduledTimerWithTimeInterval:SMMinimumTimerDelay
                                                          target:nil
                                                        selector:@selector(selectorTarget)
                                                        userInfo:nil
                                                         repeats:NO]);
}

- (void)testScheduledTimerWithTimeIntervalAndNilSelector {
    XCTAssertThrows([SMPauseTimer scheduledTimerWithTimeInterval:SMMinimumTimerDelay
                                                          target:self
                                                        selector:nil
                                                        userInfo:nil
                                                         repeats:NO]);
}

- (void)testTimerWithTimeIntervalWithInterval {
    NSMethodSignature *signature = [self methodSignatureForSelector:@selector(invocationTarget:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:@selector(invocationTarget:)];
    
    SMPauseTimer *pauseTimer = [SMPauseTimer timerWithTimeInterval:SMMinimumTimerDelay
                                                        invocation:invocation
                                                           repeats:NO];
    XCTAssertNotNil(pauseTimer);
}

- (void)testTimerWithTimeIntervalWithIntervalAndNilInvocation {
    XCTAssertThrows([SMPauseTimer timerWithTimeInterval:SMMinimumTimerDelay
                                             invocation:nil
                                                repeats:NO]);
}

- (void)testTimerWithTimeIntervalWithSelector {
    SMPauseTimer *pauseTimer = [SMPauseTimer timerWithTimeInterval:SMMinimumTimerDelay
                                                            target:self
                                                          selector:@selector(selectorTarget)
                                                          userInfo:nil
                                                           repeats:NO];
    XCTAssertNotNil(pauseTimer);
}

- (void)testTimerWithTimeIntervalWithSelectorAndNilTarget {
    XCTAssertThrows([SMPauseTimer timerWithTimeInterval:SMMinimumTimerDelay
                                                 target:nil
                                               selector:@selector(selectorTarget)
                                               userInfo:nil
                                                repeats:NO]);
}

- (void)testTimerWithTimeIntervalWithSelectorAndNilSelector {
    XCTAssertThrows([SMPauseTimer timerWithTimeInterval:SMMinimumTimerDelay
                                                 target:self
                                               selector:nil
                                               userInfo:nil
                                                repeats:NO]);
}

#pragma mark - Pause & Resume tests
- (void)testPauseTimer {
    SMPauseTimer *pauseTimer = [SMPauseTimer scheduledTimerWithTimeInterval:SMMaximumTimerDelay
                                                                     target:self
                                                                   selector:@selector(selectorTarget)
                                                                   userInfo:nil
                                                                    repeats:NO];
    [pauseTimer pauseTimer];
    XCTAssertTrue(pauseTimer.isPaused);
}

- (void)testResumeTimer {
    SMPauseTimer *pauseTimer = [SMPauseTimer scheduledTimerWithTimeInterval:SMMaximumTimerDelay
                                                                     target:self
                                                                   selector:@selector(selectorTarget)
                                                                   userInfo:nil
                                                                    repeats:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [pauseTimer pauseTimer];
        XCTAssertTrue(pauseTimer.isPaused);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [pauseTimer resumeTimer];
            XCTAssertFalse(pauseTimer.isPaused);
        });
    });
}

#pragma mark - Target methods
- (void)invocationTarget:(NSString *)string {

}

- (void)selectorTarget {
    
}

@end

