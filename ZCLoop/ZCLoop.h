//
//  ZCLoop.h
//  ZCLoop
//
//  Created by Nikita Titov on 11/24/11.
//  Copyright (c) 2011 nikita@zencode.ru. All rights reserved.
//


@class ZCLoop;

@protocol ZCLoopDelegate <NSObject>
@required
- (void)zcLoopUpdate:(ZCLoop *)loop;
@optional
- (void)zcLoop:(ZCLoop *)loop willPause:(BOOL)pause;
@end

typedef void (^UpdateBlock)(NSTimeInterval timeSinceLastUpdate);

// The ZCLoop class provides part of the standard view controller functionality, it implements loop using CADisplayLink (TODO: add NSTimer for compatibility with old devices). 
// A ZCLoop object usually works in conjunction with a view object to display frames of animation in the view or to update application logic using time interval since last update.

// To use this class, allocate and initialize a new ZCLoop subclass with frame intrerval (1 means 60 frames per second, 2 means 30 frames per secon and so on) using update block object or set its delegate. 
// You can set a delegate or configure other properties on the view controller, such as whether the loop is automatically paused or resumed when the application moves into the background.

// When active, loop automatically updates application data using time interval since last update.
// The view controller calls its delegate’s zcLoopUpdate: method. If you use delegate then your delegate should update data that does not involve rendering the results to the screen.

@interface ZCLoop : NSObject

// Convinience constructor. See |initWithFrameInterval:usingBlock:| for more information
+ (id)loopWithFrameInterval:(NSUInteger)frameInterval usingBlock:(UpdateBlock)block;
// Designated initializer. Block variable |block| will be copied and assigned to private variable
- (id)initWithFrameInterval:(NSUInteger)frameInterval usingBlock:(UpdateBlock)block;
// Initialize loop without block. User should use delegate adopting |ZCLoopDelegate| protocol
- (id)initWithFrameInterval:(NSUInteger)frameInterval;

// The view controller’s delegate.
@property (unsafe_unretained, nonatomic) id<ZCLoopDelegate> delegate;
// The number of frame updates that have been sent by the view controller since it was created. (read-only)
@property(nonatomic, readonly) NSInteger framesDisplayed;
// The actual rate that the view controller attempts to call the view to update its contents. (read-only)
@property(nonatomic, readonly) NSInteger framesPerSecond;
// A Boolean value that indicates whether the rendering loop is paused.
@property(nonatomic, getter=isPaused) BOOL paused;
// A Boolean value that indicates whether the view controller automatically pauses the rendering loop when the application resigns the active state.
// Default YES.
@property(nonatomic) BOOL pauseOnWillResignActive;
// A Boolean value that indicates whether the view controller automatically resumes the rendering loop when the application becomes active.
// Defaule YES.
@property(nonatomic) BOOL resumeOnDidBecomeActive;
// The amount of time that has passed since first time the view controller resumed sending update events. (read-only)
@property(nonatomic, readonly) NSTimeInterval timeSinceFirstResume;
// The amount of time that has passed since the last time the view controller resumed sending update events. (read-only)
@property(nonatomic, readonly) NSTimeInterval timeSinceLastResume;
// The amount of time that has passed since the last time the view controller called the delegate’s glkViewControllerUpdate: method. (read-only)
@property(nonatomic, readonly) NSTimeInterval timeSinceLastUpdate;

@end
