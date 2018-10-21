//
//  NSString+Localize.m
//  Public Art
//
//  Created by Евгений Кириллов on 21/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "NSString+Localize.h"

@implementation NSString (Localize)

- (NSString *)localize {
    return NSLocalizedString(self, "");
}

@end
