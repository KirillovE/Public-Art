//
//  LabelSizeHelper.m
//  Public Art
//
//  Created by Евгений Кириллов on 03/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "LabelSizeHelper.h"

@implementation LabelSizeHelper

/**
 Рассчитывает размеры Label
 
 @param text Текст для отображения на Label
 @param font Шрифт текста
 @return Размер Label
 */
- (CGSize)getLabelSizeForText:(NSString *)text
                     withFont:(UIFont *)font
           addedToContentView:(UIView *)view {
    
    CGFloat maxWidth = view.bounds.size.width - 36;
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
