//
//  TabBarController.m
//  Public Art
//
//  Created by Евгений Кириллов on 02/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        MapViewController *mapVC = [MapViewController new];
        mapVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Карта"
                                                         image:[UIImage imageNamed:@"map"]
                                                           tag:0];
        self.viewControllers = @[mapVC];
        self.selectedIndex = 0;
    }
    return self;
}

@end
