//
//  FavoritesCollectionViewController.m
//  Public Art
//
//  Created by Евгений Кириллов on 15/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "FavoritesCollectionViewController.h"
#import "NSString+Localize.h"

@interface FavoritesCollectionViewController ()

@property (strong, nonatomic) NSString *reuseID;

@end

@implementation FavoritesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [@"favoritesTitle" localize];
    self.reuseID = @"ReuseIdentifier";
    
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.artArray = [[CoreDataHelper shared] getFavorites];
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return self.artArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.reuseID
                                                                         forIndexPath:indexPath];
    
    Artefact *favorite = self.artArray[indexPath.row];
    [cell configureCellWithArtefact:favorite];
    
    return cell;
}

@end
