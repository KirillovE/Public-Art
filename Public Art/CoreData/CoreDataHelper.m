//
//  CoreDataHelper.m
//  Public Art
//
//  Created by Евгений Кириллов on 11/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "CoreDataHelper.h"

@interface CoreDataHelper ()

@property (strong, nonatomic) NSPersistentContainer *persistentContainer;

@end

@implementation CoreDataHelper

#pragma mark - Методы для взаимодействия с базой данных из вне

/**
 Добавляет артефакт в избранное
 
 @param artefact Артефакт для добавления в избранное
 */
- (void)addToFavoritesArtefact:(Artefact *)artefact {
    FavoriteArtefactMO *favoriteArtefact = [NSEntityDescription
                                            insertNewObjectForEntityForName:@"FavoriteArtefactMO"
                                            inManagedObjectContext:self.context];
    favoriteArtefact.title = artefact.title;
    favoriteArtefact.discpline = artefact.discipline;
    favoriteArtefact.creator = artefact.creator;
    favoriteArtefact.date = artefact.date.doubleValue;
    favoriteArtefact.location = artefact.location;
    favoriteArtefact.artDescription = artefact.artDescription;
    
    [self save];
}

/**
 Получает массив избранных управляемых моделей
 
 @return Массив избранных управляемых моделей
 */
- (NSArray<FavoriteArtefactMO *> *)getFavoritesMO {
    NSFetchRequest *request = [FavoriteArtefactMO fetchRequest];
    return [self.context executeFetchRequest:request error:nil];
}

/**
 Получает массив избраных артефактов

 @return Массив избранных артефактов
 */
- (NSArray<Artefact *> *)getFavorites {
    NSArray<FavoriteArtefactMO *> *favoritesMO = [self getFavoritesMO];
    NSMutableArray<Artefact *> *favorites = [NSMutableArray array];
    
    for (FavoriteArtefactMO *artefactMO in favoritesMO) {
        Artefact *art = [[Artefact alloc] init];
        art.title = artefactMO.title;
        art.discipline = artefactMO.discpline;
        art.creator = artefactMO.creator;
        art.date = [NSNumber numberWithInt:1];
        art.location = artefactMO.location;
        art.artDescription = artefactMO.artDescription;
        
        [favorites addObject:art];
    }
    
    return favorites;
}

/**
 Удаляет переданный артефакт из избранных
 
 @param artefact Артефакт для удаления из избранных
 */
- (void)deleteFromFavoritesArtefact:(Artefact *)artefact {
    FavoriteArtefactMO *favoriteArtefact = [self favoriteArtefactFromArtefact:artefact];
    if (favoriteArtefact) {
        [self.context deleteObject:favoriteArtefact];
        [self save];
    }
}

/**
 Проверяет наличие артефакта среди избранных
 
 @param artefact Артефакт для проверки
 @return Результат проверки на наличие среди избранных
 */
- (BOOL)isFavoriteArtefact:(Artefact *)artefact {
    return [self favoriteArtefactFromArtefact:artefact] != nil;
}

+ (instancetype)shared {
    static CoreDataHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [CoreDataHelper new];
        [helper setup];
    });
    
    return helper;
}

#pragma mark - Вспомогательные методы

/**
 Настраивает работу с CoreData
 */
- (void)setup {
    self.persistentContainer = [[NSPersistentContainer alloc] initWithName:@"FavoriteArtefact"];
    [self.persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *description, NSError * error) {
        if (error != nil) {
            NSLog(@"Failed to load Core Data stack: %@", error);
            abort();
        }
    }];
}

/**
 Получает контекст из постоянного хранилища
 
 @return Контекст работы с CoreData
 */
- (NSManagedObjectContext *)context {
    return self.persistentContainer.viewContext;
}

/**
 Сохраняет текущий контекст в базу данных CoreData
 */
- (void)save {
    NSError *error;
    if ([self.context hasChanges] && ![self.context save:&error]) {
        NSLog(@"Failed to save Core Data context with error: %@", error.localizedDescription);
        abort();
    }
}

/**
 Ищет среди избранных соответствие переданному артефакту
 
 @param artefact Артефакт для поиска соответствия
 @return Соответствующий артефакт из базы данных
 */
- (FavoriteArtefactMO *)favoriteArtefactFromArtefact:(Artefact *)artefact {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteArtefactMO"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"title == %@ AND discipline == %@ AND creator == %@ AND date == %f AND location == %@ AND artDescription == %@",
                         artefact.title,
                         artefact.discipline,
                         artefact.creator,
                         artefact.date.doubleValue,
                         artefact.location,
                         artefact.artDescription];
    
    return [[self.context executeFetchRequest:request error:nil] firstObject];
}


@end
