//
//  CollectionViewController.h
//  Public Art
//
//  Created by Евгений Кириллов on 03/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Artefact.h"
#import "CollectionViewCell.h"
#import "DetailsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray<Artefact *> *artArray;

@end

NS_ASSUME_NONNULL_END
