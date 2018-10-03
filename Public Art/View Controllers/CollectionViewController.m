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
@property (strong, nonatomic) LabelSizeHelper *labelSizeHelper;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelSizeHelper = [LabelSizeHelper new];
    [self setCollection];
}

- (void)setCollection {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(100, 100);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.reuseID = @"ReuseIdentifier";
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:self.reuseID];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - Collection View data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.artArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.reuseID
                                                                           forIndexPath:indexPath];
    cell.backgroundColor = UIColor.lightGrayColor;
    [self addTitleOfArtwork:self.artArray[indexPath.row] toContentView:cell];
    
    return cell;
}

#pragma mark - добавление графических элементов

- (void)addTitleOfArtwork:(Artwork *)artwork toContentView:(UIView *)view {
    if (!artwork.title) { return; }

    UILabel *artTitle = [UILabel new];
    artTitle.text = artwork.title;
    artTitle.numberOfLines = 2;

    artTitle.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    artTitle.textColor = UIColor.blackColor;

    CGSize labelSize = [self.labelSizeHelper getLabelSizeForText:artTitle.text
                                                        withFont:artTitle.font
                                              addedToContentView:view];
    CGRect labelFrame = CGRectMake(18,
                                   30,
                                   labelSize.width,
                                   labelSize.height);
    artTitle.frame = labelFrame;

    [view addSubview:artTitle];
}

@end
