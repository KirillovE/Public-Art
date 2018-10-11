//
//  FavoriteArtefactMO+CoreDataProperties.h
//  Public Art
//
//  Created by Евгений Кириллов on 11/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//
//

#import "FavoriteArtefactMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavoriteArtefactMO (CoreDataProperties)

+ (NSFetchRequest<FavoriteArtefactMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *artDescription;
@property (nullable, nonatomic, copy) NSString *creator;
@property (nonatomic) double date;
@property (nullable, nonatomic, copy) NSString *discpline;
@property (nullable, nonatomic, copy) NSString *location;
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
