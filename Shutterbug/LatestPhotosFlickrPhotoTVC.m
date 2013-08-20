//
//  LatestPhotosFlickrPhotoTVC.m
//  Shutterbug
//
//  Created by Диана Корсак on 06.08.13.
//  Copyright (c) 2013 Диана Корсак. All rights reserved.
//

#import "LatestPhotosFlickrPhotoTVC.h"
#import "FlickrFetcher.h"

@interface LatestPhotosFlickrPhotoTVC ()

@end

@implementation LatestPhotosFlickrPhotoTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadRecentPhotosFromFlickr];
    [self.refreshControl addTarget:self action:@selector(loadRecentPhotosFromFlickr)
                  forControlEvents:UIControlEventValueChanged];
}

-(void)loadRecentPhotosFromFlickr
{
    [self.refreshControl beginRefreshing] ;
    dispatch_queue_t loaderQ = dispatch_queue_create("flickr recent loader", NULL);
    dispatch_async(loaderQ, ^{
          NSArray *recentPhotos = [FlickrFetcher recentGeoreferencedPhotos];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photos = recentPhotos;
            [self.refreshControl endRefreshing]; 
        }); 
    });
   
}

@end
     