//
//  APIManager.m
//  Public Art
//
//  Created by Евгений Кириллов on 30/09/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import "APIManager.h"

@interface APIManager ()

@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSURLSession *urlSession;

@end

@implementation APIManager

/**
 Загружает из сети объекты класса `Artefact`

 @param completion массив артефактов – объектов класса `Artefact`
 */
- (void)getArtefactsWithCompletion:(void (^)(NSArray<Artefact *> *artArray))completion
{
    [self load:self.urlString withComletion:^(id result) {
        NSArray *jsonArray = result;
        
        if (jsonArray) {
            NSMutableArray<Artefact *> *artArray = [NSMutableArray array];
            
            for (NSDictionary *jsonDictionary in jsonArray) {
                Artefact *artefact = [[Artefact alloc] initWithDictionary:jsonDictionary];
                [artArray addObject:artefact];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(artArray);
            });
        }
    }];
}

- (void)load:(NSString *)urlString withComletion:(void (^)(id result))completion
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[self.urlSession dataTaskWithURL:url
                 completionHandler:^(NSData * _Nullable data,
                                     NSURLResponse * _Nullable response,
                                     NSError * _Nullable error) {
                     NSObject *json = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:nil];
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                     });
                     completion(json);
                 }] resume];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlSession = [NSURLSession sharedSession];
        self.urlString = @"https://data.honolulu.gov/resource/csir-pcj2.json";
    }
    return self;
}

@end
