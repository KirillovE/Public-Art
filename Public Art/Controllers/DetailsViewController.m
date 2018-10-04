//
//  DetailsViewController.m
//  Public Art
//
//  Created by Евгений Кириллов on 01/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@property (strong, nonatomic) UIButton *dismissButton;
@property (strong, nonatomic) UILabel *artTitle;
@property (strong, nonatomic) UILabel *artCredits;
@property (strong, nonatomic) UITextView *artDescription;

@property (strong, nonatomic) NSString *discipline;
@property (strong, nonatomic) NSString *creator;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *location;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self addDismissButton];
    [self addArtTitleLabel];
    [self addArtCreditsLabel];
    [self addArtDescriptionView];
}

#pragma mark - добавление графических элементов

- (void)addDismissButton {
    self.dismissButton = [UIButton new];
    [self.dismissButton setTitle:@"V" forState:UIControlStateNormal];
    self.dismissButton.frame = CGRectMake(CGRectGetMaxX(self.view.bounds) - 60,
                                          CGRectGetMaxY(self.view.bounds) - 60,
                                          50,
                                          50);
    self.dismissButton.backgroundColor = UIColor.blueColor;
    self.dismissButton.layer.cornerRadius = 25;
    [self.dismissButton addTarget:self
                           action:@selector(dismissVC)
                 forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.dismissButton];
}

- (void)addArtTitleLabel {
    if (!self.artefact.title) { return; }
    
    self.artTitle = [UILabel new];
    self.artTitle.text = self.artefact.title;
    self.artTitle.numberOfLines = 0;
    
    self.artTitle.font = [UIFont systemFontOfSize:25 weight:UIFontWeightBlack];
    self.artTitle.textColor = UIColor.blackColor;
    
    CGSize labelSize = [self getLabelSizeForText:self.artTitle.text
                                        withFont:self.artTitle.font];
    CGRect labelFrame = CGRectMake(18,
                                   30,
                                   labelSize.width,
                                   labelSize.height);
    self.artTitle.frame = labelFrame;
    
    [self.view addSubview:self.artTitle];
}

- (void)addArtCreditsLabel {
    [self setDiscipline];
    [self setCreator];
    [self setDate];
    [self setLocation];
    
    self.artCredits = [UILabel new];
    self.artCredits.text = [NSString stringWithFormat:@"%@ by %@, %@ year \nAt %@",
                            self.discipline,
                            self.creator,
                            self.date,
                            self.location];
    self.artCredits.numberOfLines = 0;
    
    self.artCredits.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    self.artCredits.textColor = UIColor.darkGrayColor;
    
    CGSize labelSize = [self getLabelSizeForText:self.self.artCredits.text
                                        withFont:self.self.artCredits.font];
    CGRect labelFrame = CGRectMake(18,
                                   CGRectGetMaxY(self.artTitle.frame) + 10,
                                   labelSize.width,
                                   labelSize.height);
    self.artCredits.frame = labelFrame;
    
    [self.view addSubview:self.artCredits];
}

- (void)addArtDescriptionView {
    if (!self.artefact.description) { return; }
    
    self.artDescription = [UITextView new];
    self.artDescription.text = self.artefact.artDescription;
    self.artDescription.editable = NO;
    
    self.artDescription.font = [UIFont systemFontOfSize:17 weight:UIFontWeightThin];
    self.artDescription.textColor = UIColor.darkGrayColor;
    
    CGFloat textViewHeight = self.dismissButton.frame.origin.y - CGRectGetMaxY(self.artCredits.frame) - 20;
    CGRect textViewRect = CGRectMake(18,
                                     CGRectGetMaxY(self.artCredits.frame) + 10,
                                     self.view.bounds.size.width - 36,
                                     textViewHeight);
    self.artDescription.frame = textViewRect;
    
    [self.view addSubview:self.artDescription];
}

#pragma mark - вспомогательное

/**
 Закрывает текущий View Controller
 */
- (void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 Рассчитывает размеры Label

 @param text Текст для отображения на Label
 @param font Шрифт текста
 @return Размер Label
 */
- (CGSize)getLabelSizeForText:(NSString *)text
                     withFont:(UIFont *)font {
    
    CGFloat maxWidth = self.view.bounds.size.width - 36;
    CGSize textBlock = CGSizeMake(maxWidth, CGFLOAT_MAX);
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    
    CGRect rect = [text boundingRectWithSize:textBlock
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributesDictionary
                                     context:nil];
    
    return CGSizeMake(rect.size.width, rect.size.height);
    
}

#pragma mark - проверка значений полей на nil и установка

- (void)setDiscipline {
    if (!self.artefact.discipline) {
        self.discipline = @"Unknown type artefact";
    } else {
        self.discipline = self.artefact.discipline;
    }
}

- (void)setCreator {
    if (!self.artefact.creator) {
        self.creator = @"Unknown creator";
    } else {
        self.creator = self.artefact.creator;
    }
}

- (void)setDate {
    if (!self.artefact.date) {
        self.date = @"Unknown year";
    } else {
        self.date = self.artefact.date.description;
    }
}

- (void)setLocation {
    if (!self.artefact.location) {
        self.location = @"Unknown place";
    } else {
        self.location = self.artefact.location;
    }
}

@end
