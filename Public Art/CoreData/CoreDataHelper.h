//
//  CoreDataHelper.h
//  Public Art
//
//  Created by Евгений Кириллов on 11/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FavoriteArtefactMO+CoreDataClass.h"
#import "Artefact.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataHelper : NSObject

+ (instancetype)shared;

- (void)addToFavoritesArtefact:(Artefact *)artefact;
- (NSArray<Artefact *> *)getFavorites;
- (void)deleteFromFavoritesArtefact:(Artefact *)artefact;
- (BOOL)isFavoriteArtefact:(Artefact *)artefact;

@end

NS_ASSUME_NONNULL_END
