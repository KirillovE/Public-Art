//
//  CollectionViewCell.m
//  Public Art
//
//  Created by Евгений on 03/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@property (strong, nonatomic) LabelSizeHelper *labelSizeHelper;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *disciplineLabel;
@property (strong, nonatomic) UIImageView *disciplineImage;

@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.labelSizeHelper = [LabelSizeHelper new];
        self.layer.cornerRadius = 3;
        self.clipsToBounds = YES;
        [self addTitleLabel];
        [self addDisciplineLabel];
        [self addDisciplineImageView];
    }
    return self;
}

/**
 Конфигурирует ячейку для показа необходимой информации

 @param artwork Произведение искусства для отображения на ячейке
 */
- (void)configureCellWithArtwork:(Artwork *)artwork {
    self.titleLabel.text = artwork.title;
    self.disciplineLabel.text = artwork.discipline;
    self.disciplineImage.image = [UIImage imageNamed:
                                  [self chooseImageNameForDisciplineDescription:artwork.discipline.description]];
}

- (void)layoutSubviews {
    [self setTitleLabelLayout];
    [self setDisciplineLabelLayout];
    [self setDisciplineImageLayout];
}

#pragma mark - добавление визуальных элементов

- (void)addTitleLabel {
    self.titleLabel = [UILabel new];
    self.titleLabel.numberOfLines = 2;
    
    self.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    self.titleLabel.textColor = UIColor.blackColor;
    
    [self.contentView addSubview:self.titleLabel];
}

- (void)addDisciplineLabel {
    self.disciplineLabel = [UILabel new];
    self.disciplineLabel.numberOfLines = 1;
    
    self.disciplineLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightThin];
    self.disciplineLabel.textColor = UIColor.darkGrayColor;
    
    [self.contentView addSubview:self.disciplineLabel];
}

- (void)addDisciplineImageView {
    self.disciplineImage = [UIImageView new];
    self.disciplineImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:self.disciplineImage];
}

#pragma mark - настройка расположения визуальных элементов

- (void)setTitleLabelLayout {
    CGSize labelSize = [self.labelSizeHelper getLabelSizeForText:self.titleLabel.text
                                                        withFont:self.titleLabel.font
                                              addedToContentView:self.contentView];
    CGRect labelFrame = CGRectMake(5,
                                   5,
                                   labelSize.width,
                                   labelSize.height);
    self.titleLabel.frame = labelFrame;
}

- (void)setDisciplineLabelLayout {
    CGSize labelSize = [self.labelSizeHelper getLabelSizeForText:self.disciplineLabel.text
                                                        withFont:self.disciplineLabel.font
                                              addedToContentView:self.contentView];
    CGRect labelFrame = CGRectMake(5,
                                   CGRectGetMaxY(self.contentView.bounds) - labelSize.height - 5,
                                   labelSize.width,
                                   labelSize.height);
    self.disciplineLabel.frame = labelFrame;
}

- (void)setDisciplineImageLayout {
    CGSize imageSize = CGSizeMake(self.contentView.bounds.size.width,
                                  self.contentView.bounds.size.height - self.titleLabel.frame.size.height - self.disciplineLabel.frame.size.height - 10);
    self.disciplineImage.frame = CGRectMake(0,
                                            CGRectGetMaxY(self.titleLabel.frame),
                                            imageSize.width,
                                            imageSize.height);
}

#pragma mark - подбор картинки для показа

/**
 Подбирает имя картинки для приведённого описания дисциплины

 @param disciplineString Цисциплина в виде строки (description)
 @return Имя картинки из каталога
 */
- (NSString *)chooseImageNameForDisciplineDescription:(NSString *)disciplineString {
    if ([disciplineString containsString:@"Bell"]) {
        return @"Bell";
    } else if ([disciplineString containsString:@"Bust"]) {
        return @"Bust";
    } else if ([disciplineString containsString:@"Door"]) {
        return @"Door";
    } else if ([disciplineString containsString:@"Fountain"]) {
        return @"Fountain";
    } else if ([disciplineString containsString:@"Lantern"]) {
        return @"Lantern";
    } else if ([disciplineString containsString:@"Monument"]) {
        return @"Monument";
    } else if ([disciplineString containsString:@"Mural"]) {
        return @"Mural";
    } else if ([disciplineString containsString:@"Plaque"]) {
        return @"Plaque";
    } else if ([disciplineString containsString:@"Sculpture"]) {
        return @"Sculpture";
    } else if ([disciplineString containsString:@"Sign"]) {
        return @"Sign";
    } else if ([disciplineString containsString:@"Urn"]) {
        return @"Urn";
    } else {
        return @"Other";
    }
}


@end
