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
@property (strong, nonatomic) NSArray<FavoriteArtefactMO *> *favoritesArray;

@end

@implementation FavoritesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Favorites";
    self.reuseID = @"ReuseIdentifier";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.favoritesArray = [[CoreDataHelper shared] getFavorites];
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return self.favoritesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.reuseID
                                                                         forIndexPath:indexPath];
    
    //FIXME: По идеи нужен метод для конвертации NSManagedObject объекта в обычный и наоборот
    FavoriteArtefactMO *favorite = self.favoritesArray[indexPath.row];
    Artefact *art = [[Artefact alloc] init];
    art.title = favorite.title;
    art.discipline = favorite.discpline;
    art.creator = favorite.creator;
    art.date = [NSNumber numberWithInt:1];
    art.location = favorite.location;
    art.artDescription = favorite.artDescription;
    
    [cell configureCellWithArtefact:art];
    
    return cell;
}

@end
