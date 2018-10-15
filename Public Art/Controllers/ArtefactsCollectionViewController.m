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
//    for (NSIndexPath *indexPath in self.highlightedCells) {
//        [[CoreDataHelper shared] addToFavoritesArtefact:self.artArray[indexPath.row]];
//    }
    [self showSuccess];
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
        cell.layer.borderWidth = 0;
        [self.highlightedCells removeObject:indexPath];
    } else {
        cell.layer.borderColor = UIColor.blueColor.CGColor;
        cell.layer.borderWidth = 5;
        [self.highlightedCells addObject:indexPath];
    }
    
    if (self.highlightedCells.count > 0) {
        self.favoritesBarButton.enabled = YES;
    } else {
        self.favoritesBarButton.enabled = NO;
    }
}

/**
 Убирает выделение ячеек
 */
- (void)clearSelection {
    for (NSIndexPath *indexPath in self.highlightedCells) {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        cell.layer.borderWidth = 0;
    }
    [self.highlightedCells removeAllObjects];
    self.navigationItem.leftBarButtonItem = nil;
}

#pragma mark - Информирование об успешном добавлении в избранное

/**
 Информирует об успешном добавлении в избранное. С анимацией
 */
- (void)showSuccess {
    UIView *blurView = [self createBlurView];
    [self.view addSubview: blurView];
    
    UIImageView *imageView = [self createTransparentImageView];
    [self.view addSubview:imageView];

    UILabel *label = [self createTransparentLabel];
    [self.view addSubview:label];
    
    [UIView animateWithDuration:0.5 animations:^{
        imageView.alpha = 1;
    }];
    
    [UIView animateWithDuration:0.5
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         label.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [self dismissSuccessView:imageView afterDelay:0.7];
                         [self dismissSuccessView:label afterDelay:0.8];
                         [self dismissSuccessView:blurView afterDelay:1.2];
                     }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(3 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [imageView removeFromSuperview];
                       [label removeFromSuperview];
                       [blurView removeFromSuperview];
                   });
}

/**
 Создаёт размытый вид размером с экран (с учётом NavigationBar)

 @return Размытое представление
 */
- (UIView *)createBlurView {
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    blurView.frame = self.view.bounds;
    return blurView;
}

/**
 Создаёт прозрачное представление изображения

 @return Прозрачный Image View
 */
- (UIImageView *)createTransparentImageView {
    UIImageView *imageView = [[UIImageView alloc]
                              initWithImage:[UIImage imageNamed:@"success"]];
    CGRect imageFrame = CGRectMake(self.view.bounds.size.width / 2 - 25,
                                   self.view.bounds.size.height / 2 - 75,
                                   50,
                                   50);
    imageView.frame = imageFrame;
    imageView.alpha = 0;
    return imageView;
}

/**
 Создаёт прозрачное представление текста

 @return Прозрачный Text Label
 */
- (UILabel *)createTransparentLabel {
    CGSize labelSize = CGSizeMake(self.view.bounds.size.width - 20, 50);
    UILabel *label = [[UILabel alloc]
                      initWithFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
    label.center = CGPointMake(self.view.center.x, self.view.center.y + 50);
    
    label.text = @"Added to favorites!";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:25 weight:UIFontWeightHeavy];
    
    label.alpha = 0;
    return label;
}

/**
 Плавно скрывает переданное предстваление с эффектом прозрачности после задержки

 @param view Представление для скрытыия
 @param delay Задержка до начала скрытия
 */
- (void)dismissSuccessView:(UIView *)view
                afterDelay:(NSTimeInterval)delay {
    
    [UIView animateWithDuration:0.3
                          delay:delay
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         view.alpha = 0;
                     }
                     completion:nil];
}

@end
