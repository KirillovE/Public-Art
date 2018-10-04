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
    [self setMap];
}

/**
 Переопредлённый сеттер, используемый для показа аннотации
 после окончания загрузки информации из интернета

 @param artArray Массив артефактов
 */
- (void)setArtArray:(NSArray<Artefact *> *)artArray {
    [self pinAnnotationsFromArray:artArray];
}

/**
 Настройка карты для дальнейшей работы
 */
- (void)setMap {
    CGRect mapFrame = CGRectMake(0,
                                 0,
                                 UIScreen.mainScreen.bounds.size.width,
                                 UIScreen.mainScreen.bounds.size.height);
    self.mapView = [[MKMapView alloc] initWithFrame:mapFrame];
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(21.45, -157.95);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coords, 70000, 70000);
    [self.mapView setRegion:region animated:YES];
    
    [self.mapView registerClass:[ArtAnnotation class] forAnnotationViewWithReuseIdentifier:MKMapViewDefaultAnnotationViewReuseIdentifier];
    
    [self.view addSubview:self.mapView];
}

#pragma mark - используем методы делегата

/**
 Создаёт аннотации из массива для отображения на карте

 @param artArray Массив артефактов
 */
- (void)pinAnnotationsFromArray:(NSArray<Artefact *> *)artArray {
    NSMutableArray<ArtMarker *> *annotations = [NSMutableArray array];
    for (Artefact *artefact in artArray) {
        ArtMarker *annotation = [[ArtMarker alloc] initWithArtefact:artefact];
        [annotations addObject:annotation];
    }
    
    [self.mapView addAnnotations:annotations];
}

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control {
    
    DetailsViewController *detailsVC = [DetailsViewController new];
    ArtAnnotation *myAnnotation = (ArtAnnotation *)view.annotation;
    detailsVC.artefact = myAnnotation.artefact;
    
    [self presentViewController:detailsVC animated:YES completion:nil];
}

@end
