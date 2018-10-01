//
//  APIManager.h
//  Public Art
//
//  Created by Евгений Кириллов on 30/09/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

- (void)getArtworksWithCompletion:(void (^)(NSArray<Artwork *> *artArray))completion;

@end

NS_ASSUME_NONNULL_END
