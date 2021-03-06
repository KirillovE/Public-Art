//
//  AppDelegate.m
//  Public Art
//
//  Created by Евгений Кириллов on 30/09/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *urlString = @"https://data.honolulu.gov/resource/csir-pcj2.json";
    NSURL *url = [NSURL URLWithString:urlString];
    [NSUserDefaults.standardUserDefaults setURL:url forKey:@"apiURL"];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [TabBarController new];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
