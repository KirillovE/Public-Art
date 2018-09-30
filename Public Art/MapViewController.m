//
//  MapViewController.m
//  Public Art
//
//  Created by Евгений Кириллов on 30/09/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) NSArray<Artwork *> *artArray;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMapView];
    [self getArtworks];
}

- (void)setMapView {
    CGRect mapFrame = CGRectMake(0,
                                 0,
                                 UIScreen.mainScreen.bounds.size.width,
                                 UIScreen.mainScreen.bounds.size.height);
    self.mapView = [[MKMapView alloc] initWithFrame:mapFrame];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
}

- (void)getArtworks {
    APIManager *apiManager = [APIManager new];
    [apiManager getArtworksWithCompletion:^(NSArray<Artwork *> * _Nonnull artArray) {
        self.artArray = artArray;
        [self showAnnotationsOnMap];
    }];
}

#pragma mark - используем методы делегата

- (void)showAnnotationsOnMap {
    NSMutableArray<MKPointAnnotation *> *annotations = [NSMutableArray array];
    for (Artwork *artwork in self.artArray) {
        MKPointAnnotation *annotation = [MKPointAnnotation new];
        annotation.title = artwork.title;
        annotation.subtitle = artwork.discipline;
        annotation.coordinate = CLLocationCoordinate2DMake(artwork.latitude.doubleValue, artwork.longitude.doubleValue);
        
        [annotations addObject:annotation];
    }
    
    [self.mapView addAnnotations:annotations];
}

@end
