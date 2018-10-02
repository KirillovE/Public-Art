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
    __weak __typeof(self)weakSelf = self;
    [apiManager getArtworksWithCompletion:^(NSArray<Artwork *> * _Nonnull artArray) {
        [weakSelf pinAnnotationsFromArray:artArray];
    }];
}

#pragma mark - используем методы делегата

- (void)pinAnnotationsFromArray:(NSArray<Artwork *> *)artArray {
    NSMutableArray<ArtMarker *> *annotations = [NSMutableArray array];
    for (Artwork *artwork in artArray) {
        ArtMarker *annotation = [[ArtMarker alloc] initWithArtwork:artwork];
        [annotations addObject:annotation];
    }
    
    [self.mapView addAnnotations:annotations];
}

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control {
    
    DetailsViewController *detailsVC = [DetailsViewController new];
    ArtAnnotation *myAnnotation = (ArtAnnotation *)view.annotation;
    detailsVC.artwork = myAnnotation.artwork;
    
    [self presentViewController:detailsVC animated:YES completion:nil];
}

@end
