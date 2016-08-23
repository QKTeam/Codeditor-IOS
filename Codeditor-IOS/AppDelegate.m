//
//  AppDelegate.m
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import "AppDelegate.h"
#import "FileViewController.h"
#import "FileModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString* opened = [[NSUserDefaults standardUserDefaults] objectForKey:@"opened"];
    if(!opened || ![opened isEqualToString:@"yes"]) {
        FileModel* file = [[FileModel alloc] initWithFilename:@"example.cpp" content:@"/*\n Highlight and auto indent will be recognized with the suffix of your filename.\n The following is an example code\n*/\n#include <cstdio>\nint main() {\n\tprintf(\"hello world!\");\n\treturn 0;\n}"];
        [file saveFile];
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"opened"];
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[FileViewController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    // codeditor://new/filename/code (filename&code base64 encoded)
    if([[url host] isEqualToString:@"new"] && [url pathComponents].count >= 2) {
        NSData* filenameData = [[NSData alloc] initWithBase64EncodedString:[url pathComponents][1] options:0];
        NSString* filename = [[NSString alloc] initWithData:filenameData encoding:NSUTF8StringEncoding];
        NSString* code = @"";
        if([url pathComponents].count >= 3) {
            NSData* codeData = [[NSData alloc] initWithBase64EncodedString:[url pathComponents][2] options:0];
            code = [[NSString alloc] initWithData:codeData encoding:NSUTF8StringEncoding];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"newCodeWithData" object:nil userInfo:@{@"filename":filename, @"code":code}];
    }
    return YES;
}

@end
