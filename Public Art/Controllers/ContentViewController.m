//
//  ContentViewController.m
//  Public Art
//
//  Created by Евгений Кириллов on 14/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;

@end

@implementation ContentViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addImageView];
        [self addTitleLabel];
        [self addContentLabel];
    }
    return self;
}

#pragma mark - Добавление визуальных элементов

- (void)addImageView {
    CGRect imageFrame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100,
                                   [UIScreen mainScreen].bounds.size.height / 2 - 100,
                                   200,
                                   200);
    self.imageView = [[UIImageView alloc] initWithFrame:imageFrame];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.cornerRadius = 8.0;
    self.imageView.clipsToBounds = YES;
    
    [self.view addSubview:self.imageView];
}

- (void)addTitleLabel {
    CGRect titleFrame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100,
                                   CGRectGetMinY(self.imageView.frame) - 61,
                                   200,
                                   21);
    self.titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    self.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightHeavy];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.titleLabel];
}

- (void)addContentLabel {
    CGRect contentFrame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100,
                                     CGRectGetMaxY(self.imageView.frame) + 20,
                                     200,
                                     21);
    self.contentLabel = [[UILabel alloc] initWithFrame:contentFrame];
    self.contentLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.contentLabel];
}

#pragma mark - Пользовательские сеттеры для визуальных элементов

- (void)setTitleText:(NSString *)titleText {
    self.titleLabel.text = titleText;
    CGFloat height = [self heightForText:titleText
                                withFont:self.titleLabel.font
                                andWidth:200];
    self.titleLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100,
                                       CGRectGetMinY(self.imageView.frame) - 40 - height,
                                       200,
                                       height);
}

- (void)setContentText:(NSString *)contentText {
    self.contentLabel.text = contentText;
    CGFloat height = [self heightForText:contentText
                                withFont:self.contentLabel.font
                                andWidth:200];
    self.contentLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100,
                                         CGRectGetMaxY(self.imageView.frame) + 20,
                                         200,
                                         height);
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

#pragma mark - Вспомогательное

- (CGFloat) heightForText:(NSString *)text
                 withFont:(UIFont *)font
                 andWidth:(CGFloat) width {
    
    CGSize size = CGSizeMake(width, FLT_MAX);
    CGRect needLabel = [text boundingRectWithSize:size
                                          options:(NSStringDrawingUsesLineFragmentOrigin |
                                                   NSStringDrawingUsesFontLeading)
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil];
    
    return ceilf(needLabel.size.height);
}


@end
