//
//  WelcomeViewController.m
//  Public Art
//
//  Created by Евгений Кириллов on 15/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@property (strong, nonatomic) UIButton *nextButton;

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
    self.delegate = self;
    
    ContentViewController *startViewController = [self viewControllerAtIndex:0];
    [self setViewControllers:@[startViewController]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
    
    [self createContentArray];
    [self addNextButton];
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

- (void)addNextButton {
    self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.nextButton.frame = CGRectMake(self.view.bounds.size.width - 100,
                                       self.view.bounds.size.height - 50,
                                       100,
                                       50);
    [self.nextButton addTarget:self
                        action:@selector(nextButtonDidTap:)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
    [self.nextButton setTintColor:[UIColor blackColor]];
    self.nextButton.hidden = YES;
    
    [self updateButtonWithIndex:0];
    [self.view addSubview:self.nextButton];
}

- (void)nextButtonDidTap:(UIButton *)sender {
    NSInteger index = ((ContentViewController *)[self.viewControllers firstObject]).index;
    if (sender.tag) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        __weak typeof(self) weakSelf = self;
        [self setViewControllers:@[[self viewControllerAtIndex:index + 1]]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:YES
                      completion:^(BOOL finished) {
                          [weakSelf updateButtonWithIndex:index + 1];
                      }
         ];
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

- (void)updateButtonWithIndex:(NSInteger)index {
    if (index < 2) {
        self.nextButton.hidden = YES;
        self.nextButton.tag = 0;
    } else {
        self.nextButton.hidden = NO;
        self.nextButton.tag = 1;
    }
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

#pragma mark - Page view controller delegate

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    
    if (completed) {
        NSInteger index = ((ContentViewController *)
                           [pageViewController.viewControllers firstObject]).index;
        [self updateButtonWithIndex:index];
    }
}


@end
