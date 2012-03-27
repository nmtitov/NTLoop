Description
===========

The NTLoop class provides part of the standard view controller functionality, it implements loop using CADisplayLink (TODO: add NSTimer for compatibility with old devices). 
A NTLoop object usually works in conjunction with a view object to display frames of animation in the view or to update application logic using time interval since last update.

To use this class, allocate and initialize a new NTLoop subclass with frame intrerval (1 means 60 frames per second, 2 means 30 frames per secon and so on) using update block object or set its delegate. 
You can set a delegate or configure other properties on the view controller, such as whether the loop is automatically paused or resumed when the application moves into the background.

When active, loop automatically updates application data using time interval since last update.
The view controller calls its delegate’s ntLoopUpdate: method. If you use delegate then your delegate should update data that does not involve rendering the results to the screen.

Sample usage
============


    #import "NTLoop.h"
    @interface AppDelegate()

    @property (strong, nonatomic) NTLoop *gameLoop;

    @end


    @implementation AppDelegate

    @synthesize gameLoop;

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        self.gameLoop = [[NTLoop alloc] initWithFrameInterval:1.0 usingBlock:^(NSTimeInterval timeSinceLastUpdate) {
            NSLog(@"Wow this is so simple!");
        }];
        return YES;
    }

    @end
