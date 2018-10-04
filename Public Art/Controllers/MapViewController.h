//
//  MapViewController.h
//  Public Art
//
//  Created by Евгений Кириллов on 30/09/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Artefact.h"
#import "APIManager.h"
#import "DetailsViewController.h"
#import "ArtAnnotation.h"
#import "ArtMarker.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) NSArray<Artefact *> *artArray;

@end

