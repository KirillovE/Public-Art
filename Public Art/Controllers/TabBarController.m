//
//  TabBarController.m
//  Public Art
//
//  Created by Евгений Кириллов on 02/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "TabBarController.h"
#import "NSString+Localize.h"

@interface TabBarController ()

@property (strong, nonatomic) MapViewController *mapVC;
@property (strong, nonatomic) ArtefactsCollectionViewController *collectionVC;

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

/**
 Отображает экран приветствия при необходимости
 */
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
        self.mapVC.tabBarItem = [[UITabBarItem alloc]
                                 initWithTitle:NSLocalizedString(@"mapTab", "")
//                                 initWithTitle:[@"mapTab" localize]
                                 image:[UIImage imageNamed:@"map"]
                                 tag:0];
        
        self.collectionVC = [ArtefactsCollectionViewController new];
        UINavigationController *artefactsNavigationVC = [[UINavigationController alloc]
                                                         initWithRootViewController:self.collectionVC];
        artefactsNavigationVC.navigationBar.prefersLargeTitles = YES;
        self.collectionVC.tabBarItem = [[UITabBarItem alloc]
                                        initWithTitle:[@"collectionTab" localize]
                                        image:[UIImage imageNamed:@"gallery"]
                                        tag:1];
        
        FavoritesCollectionViewController *favoritesVC = [FavoritesCollectionViewController new];
        UINavigationController *favoritesNavigationVC = [[UINavigationController alloc]
                                                         initWithRootViewController:favoritesVC];
        favoritesNavigationVC.navigationBar.prefersLargeTitles = YES;
        favoritesVC.tabBarItem = [[UITabBarItem alloc]
                                  initWithTitle:[@"favoritesTab" localize]
                                  image:[UIImage imageNamed:@"favorites"]
                                  tag:2];
        
        self.viewControllers = @[self.mapVC, artefactsNavigationVC, favoritesNavigationVC];
        self.selectedIndex = 0;
    }
    return self;
}

@end
