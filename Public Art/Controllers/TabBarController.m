//
//  TabBarController.m
//  Public Art
//
//  Created by Евгений Кириллов on 02/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@property (strong, nonatomic) MapViewController *mapVC;
@property (strong, nonatomic) CollectionViewController *collectionVC;

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setArtefactsToControllers];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self presentWelcomeViewControllerIfNeeded];
}

/**
 Передаёт загруженный из интернета массив артефактов
 в контроллеры карты и коллекции
 */
- (void)setArtefactsToControllers {
    APIManager *apiManager = [APIManager new];
    __weak __typeof(self)weakSelf = self;
    [apiManager getArtefactsWithCompletion:^(NSArray<Artefact *> * _Nonnull artArray) {
        weakSelf.mapVC.artArray = artArray;
        weakSelf.collectionVC.artArray = artArray;
    }];
}

- (void)presentWelcomeViewControllerIfNeeded {
    BOOL welcomeShown = [[NSUserDefaults standardUserDefaults] boolForKey:@"welcomeShown"];
    if (!welcomeShown) {
        WelcomeViewController *welcomeVC = [WelcomeViewController alloc];
        welcomeVC = [welcomeVC initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                 navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                               options:nil];
        [self presentViewController:welcomeVC animated:YES completion:nil];
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mapVC = [MapViewController new];
        self.mapVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Map"
                                                              image:[UIImage imageNamed:@"map"]
                                                                tag:0];
        
        self.collectionVC = [CollectionViewController new];
        UINavigationController *navigationVC = [[UINavigationController alloc]
                                                initWithRootViewController:self.collectionVC];
        navigationVC.navigationBar.prefersLargeTitles = YES;
        self.collectionVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Collection"
                                                                     image:[UIImage imageNamed:@"gallery"]
                                                                       tag:1];
        
        self.viewControllers = @[self.mapVC, navigationVC];
        self.selectedIndex = 0;
    }
    return self;
}

@end
