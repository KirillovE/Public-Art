//
//  ArtAnnotation.m
//  Public Art
//
//  Created by Евгений Кириллов on 01/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "ArtAnnotation.h"

@implementation ArtAnnotation

- (void)setAnnotation:(id<MKAnnotation>)annotation {
    [super setAnnotation:annotation];
    
    self.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    self.canShowCallout = YES;
}

@end
