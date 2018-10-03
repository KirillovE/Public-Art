//
//  ArtMarker.m
//  Public Art
//
//  Created by Евгений Кириллов on 01/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "ArtMarker.h"

@implementation ArtMarker

@synthesize coordinate;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    coordinate = newCoordinate;
}

- (NSString *)title {
    return self.artefact.title;
}

- (NSString *)subtitle {
    return self.artefact.discipline;
}

- (instancetype)initWithArtefact:(Artefact *)artefact {
    self = [super init];
    if (self) {
        self.coordinate = CLLocationCoordinate2DMake(artefact.latitude.doubleValue, artefact.longitude.doubleValue);
        self.artefact = artefact;
    }
    
    return self;
}

@end
