//
//  ArtMarker.h
//  Public Art
//
//  Created by Евгений Кириллов on 01/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Artwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArtMarker : NSObject <MKAnnotation>

@property (strong, nonatomic) Artwork *artwork;

- (instancetype)initWithArtwork:(Artwork *)artwork;

@end

NS_ASSUME_NONNULL_END
