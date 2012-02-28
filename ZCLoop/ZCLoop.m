//
//  ZCLoop.m
//  ZCLoop
//
//  Created by Nikita Titov on 11/24/11.
//  Copyright (c) 2011 nikita@zencode.ru. All rights reserved.
//

#import "ZCLoop.h"
#import <QuartzCore/QuartzCore.h>

@interface ZCLoop()

@property (readwrite, nonatomic) BOOL framesDisplayed;
@property (readwrite, copy, nonatomic) UpdateBlock updateBlock;

@property (strong, nonatomic) CADisplayLink *displayLink;

- (void)update;

@property (nonatomic) NSTimeInterval maxElapsedTime;
@property (nonatomic) NSTimeInterval lastTimestamp;
@property (nonatomic) NSTimeInterval currentTimestamp;

@property(nonatomic, readwrite) NSTimeInterval timeSinceFirstResume;
@property(nonatomic, readwrite) NSTimeInterval timeSinceLastResume;
@property(nonatomic, readwrite) NSTimeInterval timeSinceLastUpdate;

- (void)handleWillResignActive;
- (void)handleDidBecomeActive;

@end


@implementation ZCLoop

@synthesize 
    delegate,
    framesDisplayed,
    paused = paused_,
    updateBlock,
    framesPerSecond,
    pauseOnWillResignActive,
    resumeOnDidBecomeActive;

@synthesize 
    displayLink, 
    maxElapsedTime, 
    lastTimestamp,
    currentTimestamp,
    timeSinceFirstResume,
    timeSinceLastResume,
    timeSinceLastUpdate;

- (void)setPaused:(BOOL)paused {
    if (paused == NO) {
        self.timeSinceLastResume = 0;
    }
    if ([self.delegate respondsToSelector:@selector(zcLoop:willPause:)]) {
        [self.delegate zcLoop:self willPause:paused];
    }
    paused_ = paused;
}

+ (id)loopWithFrameInterval:(NSUInteger)frameInterval usingBlock:(UpdateBlock)block {
    return [[self alloc] initWithFrameInterval:frameInterval usingBlock:block];
}

- (id)init {
    self = [self initWithFrameInterval:1 usingBlock:nil];
    return self;
}

- (id)initWithFrameInterval:(NSUInteger)frameInterval {
    self = [self initWithFrameInterval:frameInterval usingBlock:nil];
    return self;
}

- (id)initWithFrameInterval:(NSUInteger)frameInterval usingBlock:(UpdateBlock)block {
    self = [super init];
    if (self) {
        self.updateBlock = block;
        self.lastTimestamp = 0;

        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        
        self.displayLink.frameInterval = frameInterval;
        NSTimeInterval fps = self.framesPerSecond;
        self.maxElapsedTime = 1 / fps;
        self.framesDisplayed = 0;
        
        self.timeSinceFirstResume = 0;
        self.timeSinceLastResume = 0;
        self.timeSinceLastUpdate = 0;
        
        self.paused = NO;
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        
        self.pauseOnWillResignActive = YES;
        self.resumeOnDidBecomeActive =YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector: @selector(handleWillResignActive) 
                                                     name: UIApplicationWillResignActiveNotification
                                                   object: nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector: @selector(handleDidBecomeActive) 
                                                     name: UIApplicationDidBecomeActiveNotification
                                                   object: nil];
    }
    return self;
}

- (void)dealloc {
    self.updateBlock = nil;
    [self.displayLink invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)framesPerSecond {
    NSInteger frameInterval = self.displayLink.frameInterval;
    NSInteger fpsValue = (NSInteger)floor(60 / frameInterval);
    return fpsValue;
}

- (NSTimeInterval)timeSinceLastUpdate {
    self.currentTimestamp = CACurrentMediaTime();
    NSTimeInterval dt = self.currentTimestamp - self.lastTimestamp;
    self.lastTimestamp = self.currentTimestamp;
    
    if (dt > self.maxElapsedTime) {
        dt = self.maxElapsedTime;
    }
    return dt;
}

- (void)update {
    if (!self.isPaused) {
        self.framesDisplayed++;
        NSTimeInterval dt = [self timeSinceLastUpdate];
        self.timeSinceFirstResume += dt;
        self.timeSinceLastResume += dt;
        if ([self.delegate respondsToSelector:@selector(zcLoopUpdate:)]) {
            [self.delegate zcLoopUpdate:self];
        }
        else {
            self.updateBlock(dt);
        }
    }
}

- (void)handleWillResignActive {
    if (self.pauseOnWillResignActive) {
        self.paused = YES;
    }
}

- (void)handleDidBecomeActive {
    if (self.resumeOnDidBecomeActive) {
        self.paused =NO;
    }
}

@end
