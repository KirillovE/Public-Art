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
    
    [self.mapView registerClass:[ArtAnnotation class] forAnnotationViewWithReuseIdentifier:MKMapViewDefaultAnnotationViewReuseIdentifier];
    
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
    NSMutableArray<ArtMarker *> *annotations = [NSMutableArray array];
    for (Artwork *artwork in self.artArray) {
        ArtMarker *annotation = [[ArtMarker alloc] initWithArtwork:artwork];
        [annotations addObject:annotation];
    }
    
    [self.mapView addAnnotations:annotations];
}

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control {
    
    DetailsViewController *detailsVC = [DetailsViewController new];
    
    // надо как-то передать объект Artwork
    NSLog(@"Из массива произведений: %@", self.artArray[4].title);
    NSLog(@"Из массива аннотаций: %@", mapView.annotations[4].title);
    // индексы не совпадают
    
    detailsVC.artwork = view.annotation;
    
    [self presentViewController:detailsVC animated:YES completion:nil];
}

@end
