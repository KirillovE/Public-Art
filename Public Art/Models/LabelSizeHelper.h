//
//  LabelSizeHelper.h
//  Public Art
//
//  Created by Евгений Кириллов on 03/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LabelSizeHelper : NSObject

- (CGSize)getLabelSizeForText:(NSString *)text
                     withFont:(UIFont *)font
           addedToContentView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
