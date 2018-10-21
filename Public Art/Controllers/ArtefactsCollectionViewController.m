//
//  ArtefactsCollectionViewController.m
//  Public Art
//
//  Created by Евгений Кириллов on 03/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "ArtefactsCollectionViewController.h"
#import "ResultsCollectionViewController.h"

@interface ArtefactsCollectionViewController () <UISearchResultsUpdating>

@property (strong, nonatomic) NSString *reuseID;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) ResultsCollectionViewController *resultsController;
@property (strong, nonatomic) UIBarButtonItem *selectCancelBarButton;
@property (strong, nonatomic) UIBarButtonItem *favoritesBarButton;
@property (nonatomic) BOOL selectionModeActive;
@property (strong, nonatomic) NSMutableArray<NSIndexPath *> *highlightedCells;

@end

@implementation ArtefactsCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setInitialValues];
    [self setSelectCancelButton];
    [self setSearchController];
    [self setCollectionView];
}

#pragma mark - Настройка отображения экрана

/**
 Первоначальная настройка значений переменных
 */
- (void)setInitialValues {
    self.view.backgroundColor = UIColor.cyanColor;
    self.title = @"Collection";
    self.selectionModeActive = NO;
    self.highlightedCells = [NSMutableArray array];
}

/**
 Настройка кнопки выделения ячеек
 */
- (void)setSelectCancelButton {
    self.selectCancelBarButton = [[UIBarButtonItem alloc]
                                  initWithImage:[UIImage imageNamed:@"select"]
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(selectCancelBarButtonPressed)];
    
    self.navigationItem.rightBarButtonItem = self.selectCancelBarButton;
}

/**
 Настройка кнопки сохранения артефакта в избранное
 */
- (void)setFavoritesButton {
    self.favoritesBarButton = [[UIBarButtonItem alloc]
                               initWithImage:[UIImage imageNamed:@"add favorites"]
                               style:UIBarButtonItemStylePlain
                               target:self
                               action:@selector(addToFavorites)];
    self.navigationItem.leftBarButtonItem = self.favoritesBarButton;
    self.navigationItem.leftBarButtonItem.enabled = NO;
}

/**
 Настройка поисковой строки
 */
- (void)setSearchController {
    self.resultsController = [ResultsCollectionViewController new];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsController];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.placeholder = @"Title or discipline...";
    self.navigationItem.searchController = self.searchController;
}

/**
 Настройка коллекции для дальнейшей работы
 */
- (void)setCollectionView {
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
    if ([self.highlightedCells containsObject:indexPath]) {
        [self highlightCell:cell];
    } else {
        [self unhighlightCell:cell];
    }

    return cell;
}

#pragma mark - Collection View delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectionModeActive) {
        [self highlightCellIfNeededForIndexPath:indexPath];
    } else {
        [self showDetailsViewControllerForIndexPath:indexPath];
    }
    
}

#pragma mark - Search Results Updating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text) {
        NSPredicate *titlePredicate = [NSPredicate
                                       predicateWithFormat:@"SELF.title CONTAINS[cd] %@", searchController.searchBar.text];
        NSPredicate *disciplinePredicate = [NSPredicate
                                            predicateWithFormat:@"SELF.discipline CONTAINS[cd] %@", searchController.searchBar.text];
        
        NSCompoundPredicate *compoundPredicate =  [NSCompoundPredicate
                                                   orPredicateWithSubpredicates:@[titlePredicate,
                                                                                  disciplinePredicate]];
        self.resultsController.artArray = [self.artArray
                                           filteredArrayUsingPredicate:compoundPredicate];
        
        [self.resultsController updateCollection];
    }
}

#pragma mark - Прочие методы

/**
 Переключает режимы работы с коллекцией (выделение/просмотр)
 */
- (void)selectCancelBarButtonPressed {
    if (self.selectionModeActive) {
        self.selectCancelBarButton.image = [UIImage imageNamed:@"select"];
        self.selectionModeActive = NO;
        [self clearSelection];
    } else {
        self.selectCancelBarButton.image = [UIImage imageNamed:@"cancel"];
        self.selectionModeActive = YES;
        [self setFavoritesButton];
    }
}

/**
 Добавляет выделенные ячейки в избранное
 */
- (void)addToFavorites {
    for (NSIndexPath *indexPath in self.highlightedCells) {
        [[CoreDataHelper shared] addToFavoritesArtefact:self.artArray[indexPath.row]];
    }
    [self animateSuccess];
    [self selectCancelBarButtonPressed];
}

/**
 Показывает модально экран с подробной информацией об артефакте

 @param indexPath Индекс артефакта для отображения
 */
- (void)showDetailsViewControllerForIndexPath:(NSIndexPath * _Nonnull)indexPath {
    DetailsViewController *detailsVC = [DetailsViewController new];
    detailsVC.artefact = self.artArray[indexPath.row];
    
    [self presentViewController:detailsVC animated:YES completion:nil];
}

/**
 Выделяет ячейку

 @param indexPath Индекс ячейки, которую нужно выделить
 */
- (void)highlightCellIfNeededForIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    if ([self.highlightedCells containsObject:indexPath]) {
        [self unhighlightCell:cell];
        [self.highlightedCells removeObject:indexPath];
    } else {
        [self highlightCell:cell];
        [self.highlightedCells addObject:indexPath];
    }
    
    if (self.highlightedCells.count > 0) {
        self.favoritesBarButton.enabled = YES;
    } else {
        self.favoritesBarButton.enabled = NO;
    }
}

/**
 Выделяет переданную ячейку

 @param cell Ячейка для выделения
 */
- (void)highlightCell:(UICollectionViewCell *)cell {
    cell.layer.borderColor = UIColor.blueColor.CGColor;
    cell.layer.borderWidth = 5;
}

/**
 Снимает выделение с ячейки

 @param cell Ячейка для снятия выделения
 */
- (void)unhighlightCell:(UICollectionViewCell *)cell {
    cell.layer.borderWidth = 0;
}

/**
 Убирает выделение ячеек
 */
- (void)clearSelection {
    for (NSIndexPath *indexPath in self.highlightedCells) {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        [self unhighlightCell:cell];
    }
    [self.highlightedCells removeAllObjects];
    self.navigationItem.leftBarButtonItem = nil;
}

#pragma mark - Информирование об успешном добавлении в избранное

/**
 Информирует об успешном добавлении в избранное. С анимацией
 */
- (void)animateSuccess {
    SuccessAnimationView *successView = [[SuccessAnimationView alloc]
                                         initWithFrame:self.view.frame];
    [self.view addSubview:successView];
    [successView show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [successView removeFromSuperview];
    });
}

@end
