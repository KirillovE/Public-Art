//
//  SuccessAnimationView.m
//  Public Art
//
//  Created by Евгений Кириллов on 21/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "SuccessAnimationView.h"

@implementation SuccessAnimationView

/**
 Информирует об успешном добавлении в избранное. С анимацией
 */
- (void)show {
    UIView *blurView = [self createBlurView];
    [self addSubview: blurView];
    
    UIImageView *imageView = [self createTransparentImageView];
    [self addSubview:imageView];
    
    UILabel *label = [self createTransparentLabel];
    [self addSubview:label];
    
    [UIView animateWithDuration:0.5 animations:^{
        imageView.alpha = 1;
    }];
    
    [UIView animateWithDuration:0.5
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         label.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [self dismissSuccessView:imageView afterDelay:0.7];
                         [self dismissSuccessView:label afterDelay:0.8];
                         [self dismissSuccessView:blurView afterDelay:1.2];
                     }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(3 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [imageView removeFromSuperview];
                       [label removeFromSuperview];
                       [blurView removeFromSuperview];
                   });
}

/**
 Создаёт размытый вид размером с экран (с учётом NavigationBar)
 
 @return Размытое представление
 */
- (UIView *)createBlurView {
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    blurView.frame = self.bounds;
    return blurView;
}

/**
 Создаёт прозрачное представление изображения
 
 @return Прозрачный Image View
 */
- (UIImageView *)createTransparentImageView {
    UIImageView *imageView = [[UIImageView alloc]
                              initWithImage:[UIImage imageNamed:@"success"]];
    CGRect imageFrame = CGRectMake(self.bounds.size.width / 2 - 25,
                                   self.bounds.size.height / 2 - 75,
                                   50,
                                   50);
    imageView.frame = imageFrame;
    imageView.alpha = 0;
    return imageView;
}

/**
 Создаёт прозрачное представление текста
 
 @return Прозрачный Text Label
 */
- (UILabel *)createTransparentLabel {
    CGSize labelSize = CGSizeMake(self.bounds.size.width - 20, 50);
    UILabel *label = [[UILabel alloc]
                      initWithFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
    label.center = CGPointMake(self.center.x, self.center.y + 50);
    
    label.text = @"Added to favorites!";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:25 weight:UIFontWeightHeavy];
    
    label.alpha = 0;
    return label;
}

/**
 Плавно скрывает переданное предстваление с эффектом прозрачности после задержки
 
 @param view Представление для скрытыия
 @param delay Задержка до начала скрытия
 */
- (void)dismissSuccessView:(UIView *)view
                afterDelay:(NSTimeInterval)delay {
    
    [UIView animateWithDuration:0.3
                          delay:delay
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         view.alpha = 0;
                     }
                     completion:nil];
}

@end
