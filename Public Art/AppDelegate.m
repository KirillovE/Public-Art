//
//  AppDelegate.m
//  Public Art
//
//  Created by Евгений Кириллов on 30/09/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    MapViewController *mapVC = [MapViewController new];
    mapVC.view.backgroundColor = UIColor.blueColor;
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:mapVC];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
