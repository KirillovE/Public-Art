//
//  FavoriteArtefactMO+CoreDataProperties.m
//  Public Art
//
//  Created by Евгений Кириллов on 11/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//
//

#import "FavoriteArtefactMO+CoreDataProperties.h"

@implementation FavoriteArtefactMO (CoreDataProperties)

+ (NSFetchRequest<FavoriteArtefactMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"FavoriteArtefact"];
}

@dynamic artDescription;
@dynamic creator;
@dynamic date;
@dynamic discpline;
@dynamic location;
@dynamic title;

@end
