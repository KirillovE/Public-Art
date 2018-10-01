//
//  Artwork.h
//  Public Art
//
//  Created by Евгений Кириллов on 30/09/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Artwork : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *discipline;
@property (strong, nonatomic) NSString *creator;
@property (strong, nonatomic) NSNumber *date;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *artDescription;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
