//
//  MapViewController.m
//  Public Art
//
//  Created by Евгений Кириллов on 30/09/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

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
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:mapFrame];
    [self.view addSubview:mapView];
}

- (void)getArtworks {
    APIManager *apiManager = [APIManager new];
    [apiManager getArtworksWithCompletion:^(NSArray<Artwork *> * _Nonnull artArray) {
        self.artArray = artArray;
        NSLog(@"");
    }];
}

@end
