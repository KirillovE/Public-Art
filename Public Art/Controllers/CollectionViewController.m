//
//  CollectionViewController.m
//  Public Art
//
//  Created by Евгений Кириллов on 03/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "CollectionViewController.h"
#import "ResultsCollectionViewController.h"

@interface CollectionViewController () <UISearchResultsUpdating>

@property (strong, nonatomic) NSString *reuseID;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) ResultsCollectionViewController *resultsController;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.cyanColor;
    self.title = @"Collection";
    [self searchControllerSetup];
    [self setCollection];
}

/**
 Настройка поисковой строки
 */
- (void)searchControllerSetup {
    self.resultsController = [ResultsCollectionViewController new];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsController];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.placeholder = @"Title or discipline...";
    self.navigationItem.searchController = self.searchController;
}

/**
 Настройка коллекции для дальнейшей работы
 */
- (void)setCollection {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGFloat itemSide = self.view.bounds.size.width / 2 - 4;
    layout.itemSize = CGSizeMake(itemSide, itemSide);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    
    CGRect collectionFrame = self.view.bounds;
    collectionFrame.origin.y = CGRectGetMaxY(self.searchController.searchBar.frame);
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionFrame
                                             collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = UIColor.cyanColor;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
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
    [cell configureCellWithArtefact:self.artArray[indexPath.row]];

    return cell;
}

#pragma mark - Collection View delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailsViewController *detailsVC = [DetailsViewController new];
    detailsVC.artefact = self.artArray[indexPath.row];
    
    [self presentViewController:detailsVC animated:YES completion:nil];
}

#pragma mark - Search Results Updating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text) {
        NSPredicate *titlePredicate = [NSPredicate
                                       predicateWithFormat:@"SELF.title CONTAINS[cd] %@", searchController.searchBar.text];
        NSPredicate *disciplinePredicate = [NSPredicate
                                            predicateWithFormat:@"SELF.discipline CONTAINS[cd] %@", searchController.searchBar.text];
        
        NSArray<Artefact *> *matchedTitles = [self.artArray filteredArrayUsingPredicate:titlePredicate];
        NSArray<Artefact *> *matchedDisciplines = [self.artArray filteredArrayUsingPredicate:disciplinePredicate];
        
        self.resultsController.artArray = matchedTitles ?
        [matchedTitles arrayByAddingObjectsFromArray:matchedDisciplines] :
        matchedDisciplines;
        
        [self.resultsController updateCollection];
    }
}


@end
