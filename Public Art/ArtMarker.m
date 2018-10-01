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

- (NSString *)title {
    return self.artwork.title;
}

- (NSString *)subtitle {
    return self.artwork.discipline;
}

- (instancetype)initWithArtwork:(Artwork *)artwork {
    self = [super init];
    if (self) {
        self.coordinate = CLLocationCoordinate2DMake(artwork.latitude.doubleValue, artwork.longitude.doubleValue);
        self.artwork = artwork;
    }
    
    return self;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    coordinate = newCoordinate;
}

@end
