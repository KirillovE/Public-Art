//
//  DetailsViewController.m
//  Public Art
//
//  Created by Евгений Кириллов on 01/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@property (strong, nonatomic) UILabel *artTitle;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self addArtTitleLabel];
    [self addDismissButton];
}

- (void)addArtTitleLabel {
    if ([self.artwork.title isEqual:[NSNull null]]) {
        return;
    }
    
    self.artTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    self.artTitle.text = self.artwork.title;
    self.artTitle.numberOfLines = 0;
    self.artTitle.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    CGSize labelSize = [self getLabelSizeForText:self.artTitle.text
                                        withFont:self.artTitle.font];
    CGRect labelFrame = CGRectMake(18,
                                   30,
                                   labelSize.width,
                                   labelSize.height);
    self.artTitle.frame = labelFrame;
    self.artTitle.textColor = UIColor.blackColor;
    
    [self.view addSubview:self.artTitle];
}

- (void)addDismissButton {
    UIButton *dismissButton = [UIButton new];
    [dismissButton setTitle:@"<" forState:UIControlStateNormal];
    dismissButton.frame = CGRectMake(0, 0, 100, 100);
    dismissButton.center = self.view.center;
    dismissButton.backgroundColor = UIColor.cyanColor;
    [dismissButton addTarget:self
                      action:@selector(dismissVC)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
}

- (void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

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

@end
