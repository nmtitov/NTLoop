//
//  ZCAppDelegate.m
//  ZCLoop
//
//  Created by Nikita Titov on 2/9/12.
//  Copyright (c) 2012 nikita@zencode.ru. All rights reserved.
//

#import "ZCAppDelegate.h"
#import "ZCLoop.h"

@interface ZCAppDelegate()
@property (strong, nonatomic) ZCLoop *loop;
@end

@implementation ZCAppDelegate

@synthesize loop;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray *hello = [NSArray arrayWithObjects:@"Salaam aleihum", @"Tungjatjeta", @"Hello", @"Ahlen", @"Marhaba", @"Voghdzuyin", @"Shlama", @"Goeie dag", @"Kheyerle irte", @"Прывитанне", @"Nomoskaar", @"Zdraveite", @"Zdravo", @"Aloha", @"Hallo", @"Geia sou", @"Gamardjobat", @"God dag", @"Shalom", @"Iiti", @"Sawubona", @"Salam", @"Selamat", @"Godan daginn", @"Buenos dias", @"Buon giorno", @"Salam", @"Mendvt", @"Assalomu alaikum", @"Terveh", @"Salaam matszbe", @"Mauri", @"Haa", @"Annyoung hasimnikka", @"Mej", nil];
    
    // 1 means 60 iterations per second, 2 means 30, 3 - 20 and so on.
    self.loop = [[ZCLoop alloc] initWithFrameInterval:1 usingBlock:^(NSTimeInterval timeSinceLastUpdate) {
        NSUInteger index = arc4random() % hello.count;
        NSString *phrase = [hello objectAtIndex:index];
        NSLog(@"After %f: %@", timeSinceLastUpdate, phrase);
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
