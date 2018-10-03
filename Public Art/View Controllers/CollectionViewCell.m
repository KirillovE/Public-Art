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

@end

@implementation CollectionViewCell

- (void)configureCellWithArtwork:(Artwork *)artwork {
    [self initialSetup];
    
    self.titleLabel.text = artwork.title;
    self.disciplineLabel.text = artwork.discipline;
}

- (void)layoutSubviews {
    [self setTitleLayout];
    [self setDisciplineLayout];
}

- (void)initialSetup {
    self.backgroundColor = UIColor.whiteColor;
    self.labelSizeHelper = [LabelSizeHelper new];
    [self addTitle];
    [self addDiscipline];
}

#pragma mark - добавление визуальных элементов

- (void)addTitle {
    self.titleLabel = [UILabel new];
    self.titleLabel.numberOfLines = 2;
    
    self.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    self.titleLabel.textColor = UIColor.blackColor;
    
    [self.contentView addSubview:self.titleLabel];
}

- (void)addDiscipline {
    self.disciplineLabel = [UILabel new];
    self.disciplineLabel.numberOfLines = 1;
    
    self.disciplineLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightThin];
    self.disciplineLabel.textColor = UIColor.darkGrayColor;
    
    [self.contentView addSubview:self.disciplineLabel];
}

#pragma mark - настройка расположения визуальных элементов

- (void)setTitleLayout {
    CGSize labelSize = [self.labelSizeHelper getLabelSizeForText:self.titleLabel.text
                                                        withFont:self.titleLabel.font
                                              addedToContentView:self.contentView];
    CGRect labelFrame = CGRectMake(5,
                                   5,
                                   labelSize.width,
                                   labelSize.height);
    self.titleLabel.frame = labelFrame;
}

- (void)setDisciplineLayout {
    CGSize labelSize = [self.labelSizeHelper getLabelSizeForText:self.disciplineLabel.text
                                                        withFont:self.disciplineLabel.font
                                              addedToContentView:self.contentView];
    CGRect labelFrame = CGRectMake(5,
                                   CGRectGetMaxY(self.contentView.bounds) - labelSize.height - 5,
                                   labelSize.width,
                                   labelSize.height);
    self.disciplineLabel.frame = labelFrame;
}


@end
