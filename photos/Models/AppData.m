//
//  AppData.m
//  photos
//
//  Created by Wil Ferrel on 10/19/15.
//  Copyright © 2015 speakeasy. All rights reserved.
//

#import "AppData.h"

@implementation AppData
+ (AppData *)sharedInstance
{
    static AppData *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (id)init
{
    if (self = [super init]) {
        self.currentPhotosArray = [NSMutableArray array];
        NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
        self.appImageCache = [[SDImageCache alloc] initWithNamespace:bundleIdentifier];
    }
    return self;
}
@end
