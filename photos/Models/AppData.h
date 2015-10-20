//
//  AppData.h
//  photos
//
//  Created by Wil Ferrel on 10/19/15.
//  Copyright © 2015 speakeasy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface AppData : NSObject
@property(nonatomic) NSMutableArray *currentPhotosArray;
@property(nonatomic) SDImageCache *appImageCache;

+ (AppData *)sharedInstance;

@end
