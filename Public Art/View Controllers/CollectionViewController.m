//
//  CollectionViewController.m
//  Public Art
//
//  Created by Евгений Кириллов on 03/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSString *reuseID;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCollection];
}

/**
 Настройка коллекции для дальнейшей работы
 */
- (void)setCollection {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(150, 150);
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = UIColor.cyanColor;
    self.collectionView.dataSource = self;
    
    self.reuseID = @"ReuseIdentifier";
    [self.collectionView registerClass:[CollectionViewCell class]
            forCellWithReuseIdentifier:self.reuseID];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - Collection View data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.artArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.reuseID
                                                                         forIndexPath:indexPath];
    [cell configureCellWithArtwork:self.artArray[indexPath.row]];

    return cell;
}


@end
