//
//  CollectionViewController.h
//  Public Art
//
//  Created by Евгений Кириллов on 03/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"
#import "DetailsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray<Artefact *> *artArray;
@property (strong, nonatomic) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
