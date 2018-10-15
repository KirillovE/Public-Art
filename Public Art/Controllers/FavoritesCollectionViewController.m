//
//  FavoritesCollectionViewController.m
//  Public Art
//
//  Created by Евгений Кириллов on 15/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "FavoritesCollectionViewController.h"

@interface FavoritesCollectionViewController ()

@property (strong, nonatomic) NSString *reuseID;
@property (strong, nonatomic) NSArray<Artefact *> *favoritesArray;

@end

@implementation FavoritesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Favorites";
    self.favoritesArray = [[CoreDataHelper shared] getFavorites];
    self.reuseID = @"ReuseIdentifier";
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return self.favoritesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.reuseID
                                                                         forIndexPath:indexPath];
    [cell configureCellWithArtefact:self.favoritesArray[indexPath.row]];
    
    return cell;
}

@end
