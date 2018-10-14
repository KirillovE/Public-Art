//
//  ContentViewController.h
//  Public Art
//
//  Created by Евгений Кириллов on 14/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentViewController : UIViewController

@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) NSString *contentText;
@property (strong, nonatomic) UIImage *image;
@property (nonatomic) NSInteger index;;

@end

NS_ASSUME_NONNULL_END
