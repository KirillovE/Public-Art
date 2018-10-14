//
//  WelcomeViewController.m
//  Public Art
//
//  Created by Евгений Кириллов on 15/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

struct Content {
    NSString *titleText;
    NSString *contentText;
    NSString *imageName;
} content[3];

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.cyanColor;
    self.dataSource = self;
//    self.delegate = self;
    
    [self createContentArray];
}

- (void)createContentArray {
    NSArray *titles = @[@"Гавайи",
                        @"Достопримечательности",
                        @"Избранное"];
    NSArray *contents = @[@"Добро пожаловать",
                          @"Почти 200 артефактов",
                          @"Сохраняйте артефакты в избранное"];
    
    for (int i = 0; i < 3; ++i) {
        content[i].titleText = titles[i];
        content[i].contentText = contents[i];
        content[i].imageName = [NSString stringWithFormat:@"welcome %d", i + 1];
    }
}
    
- (ContentViewController *)viewControllerAtIndex:(NSInteger)index {
    if (index < 0 || index >= 3) {
        return nil;
    }
    
    ContentViewController *contentViewController = [ContentViewController new];
    contentViewController.title = content[index].titleText;
    contentViewController.contentText = content[index].contentText;
    contentViewController.image =  [UIImage imageNamed: content[index].imageName];
    contentViewController.index = index;
    
    return contentViewController;
}

#pragma mark - Page view controller data source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger index = ((ContentViewController *)viewController).index;
    index -= 1;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger index = ((ContentViewController *)viewController).index;
    index += 1;
    return [self viewControllerAtIndex:index];
}


@end
