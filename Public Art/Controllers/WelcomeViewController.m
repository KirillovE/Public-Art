//
//  WelcomeViewController.m
//  Public Art
//
//  Created by Евгений Кириллов on 15/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "WelcomeViewController.h"
#import "NSString+Localize.h"

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
    [self createContentArray];
    [self addNextButton];
    
    self.dataSource = self;
    self.delegate = self;
    ContentViewController *startViewController = [self viewControllerAtIndex:0];
    [self setViewControllers:@[startViewController]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
}

/**
 Создание массива информации для экрана привествия
 */
- (void)createContentArray {
    NSArray *titles = @[[@"welcomeTitlesFirst" localize],
                        [@"welcomeTitlesSecond" localize],
                        [@"welcomeTitlesThird" localize]];
    NSArray *contents = @[[@"welcomeContentsFirst" localize],
                          [@"welcomeContentsSecond" localize],
                          [@"welcomeContentsThird" localize]];
    
    for (int i = 0; i < 3; ++i) {
        content[i].titleText = titles[i];
        content[i].contentText = contents[i];
        content[i].imageName = [NSString stringWithFormat:@"welcome %d", i + 1];
    }
}

/**
 Добавление кнопки перехода на главный экран
 */
- (void)addNextButton {
    self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.nextButton.frame = CGRectMake(self.view.bounds.size.width - 100,
                                       self.view.bounds.size.height - 50,
                                       100,
                                       50);
    [self.nextButton addTarget:self
                        action:@selector(nextButtonDidTap)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.nextButton setTitle:[@"welcomeNextButton" localize]
                     forState:UIControlStateNormal];
    [self.nextButton setTintColor:[UIColor blackColor]];
    self.nextButton.hidden = YES;
    
    [self updateButtonWithIndex:0];
    [self.view addSubview:self.nextButton];
}

/**
 Переход на главный экран приложения
 */
- (void)nextButtonDidTap {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"welcomeShown"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 Обновления состояния кнопки

 @param index Индекс текущего экрана
 */
- (void)updateButtonWithIndex:(NSInteger)index {
    if (index < 2) {
        self.nextButton.hidden = YES;
        self.nextButton.tag = 0;
    } else {
        self.nextButton.hidden = NO;
        self.nextButton.tag = 1;
    }
}
    
/**
 Создаёт контроллер по указанному индексу

 @param index Порядковй номер контроллера
 @return Контроллер содержимого для экрана приветствия
 */
- (ContentViewController *)viewControllerAtIndex:(NSInteger)index {
    if (index < 0 || index >= 3) {
        return nil;
    }
    
    ContentViewController *contentViewController = [ContentViewController new];
    contentViewController.titleText = content[index].titleText;
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
