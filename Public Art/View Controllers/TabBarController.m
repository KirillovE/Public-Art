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
    [self getArtworks];
}

- (void)getArtworks {
    APIManager *apiManager = [APIManager new];
    __weak __typeof(self)weakSelf = self;
    [apiManager getArtworksWithCompletion:^(NSArray<Artwork *> * _Nonnull artArray) {
        weakSelf.mapVC.artArray = artArray;
        weakSelf.collectionVC.artArray = artArray;
    }];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mapVC = [MapViewController new];
        self.mapVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Карта"
                                                              image:[UIImage imageNamed:@"map"]
                                                                tag:0];
        
        self.collectionVC = [CollectionViewController new];
        self.collectionVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Коллекция"
                                                                     image:[UIImage imageNamed:@"gallery"]
                                                                       tag:1];
        
        self.viewControllers = @[self.mapVC, self.collectionVC];
        self.selectedIndex = 0;
    }
    return self;
}

@end
