NTLoop
======

Simple implementation of abstract game loop using CADisplayLink technique.

Description
===========

The NTLoop class provides part of the standard view controller functionality, it implements loop using CADisplayLink (TODO: add NSTimer for compatibility with old devices). 
A NTLoop object usually works in conjunction with a view object to display frames of animation in the view or to update application logic using time interval since last update.

To use this class, allocate and initialize a new NTLoop subclass with frame intrerval (1 means 60 frames per second, 2 means 30 frames per secon and so on) using update block object or set its delegate. 
You can set a delegate or configure other properties on the view controller, such as whether the loop is automatically paused or resumed when the application moves into the background.

When active, loop automatically updates application data using time interval since last update.
The view controller calls its delegate’s ntLoopUpdate: method. If you use delegate then your delegate should update data that does not involve rendering the results to the screen.

Simple installation
===================

1. Clone repository
2. Drag files to your project and choose option "Copy items into destination group's folder (if needed)"
3. Link against QuartzCore framework (Click on your project at navigator panel, choose your build target, go to "Build Phases" tab, then "Link binary with libraries" and add "QuartzCore.framework")
4. Import `NTLoop.h` header to your project and build!

Sample usage
============

Add to your `AppDelegate.m`

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


License
=======

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
