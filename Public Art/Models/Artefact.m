//
//  Artefact.m
//  Public Art
//
//  Created by Евгений Кириллов on 30/09/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "Artefact.h"

@implementation Artefact

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.title = [dict valueForKey:@"title"];
        self.discipline = [dict valueForKey:@"discipline"];
        self.creator = [dict valueForKey:@"creator"];
        self.date = [dict valueForKey:@"date"];
        self.location = [dict valueForKey:@"location"];
        self.artDescription = [dict valueForKey:@"description"];
        self.latitude = [dict valueForKey:@"latitude"];
        self.longitude = [dict valueForKey:@"longitude"];
    }
    return self;
}

@end
