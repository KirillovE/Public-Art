//
//  ArtefactsCollectionViewController.h
//  Public Art
//
//  Created by Евгений Кириллов on 03/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"
#import "DetailsViewController.h"
#import "CoreDataHelper.h"
#import "SuccessAnimationView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArtefactsCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray<Artefact *> *artArray;
@property (strong, nonatomic) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
