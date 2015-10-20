//
//  PopularPhotosCall.m
//  photos
//
//  Created by Wil Ferrel on 10/19/15.
//  Copyright © 2015 speakeasy. All rights reserved.
//

#import "PopularPhotosCall.h"
#import <AFNetworking/AFNetworking.h>
#import "Photo.h"
#import "AppData.h"

@implementation PopularPhotosCall
- (void)getPopularPhotos:(void (^)(BOOL success, NSString *errorString))completionBlock
{
    NSDictionary *getParams = @{ @"feature" : @"popular", @"image_size" : @"4", @"consumer_key" : SETestAPIConsumerKey };
    self.callCompleted = completionBlock;
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:SETestAPIEndpoint]];
    [manager GET:SETestAPIPath
        parameters:getParams
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          NSDictionary *jsonResponse = [NSDictionary dictionaryWithDictionary:responseObject];
          if ([jsonResponse objectForKey:@"photos"]) {
              NSArray *photsArrayResponse = [NSArray arrayWithArray:[jsonResponse objectForKey:@"photos"]];
              [self parsePopularPhotosToAppData:photsArrayResponse];
          }
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"Error: %@", error);
          if (completionBlock) {
              completionBlock(NO, error.localizedDescription);
          }
        }];
}
- (void)parsePopularPhotosToAppData:(NSArray *)photosJsonArray
{
    for (NSDictionary *photoJsonDict in photosJsonArray) {
        if (photoJsonDict) {
            NSError *parseError;
            Photo *tempPhoto = [MTLJSONAdapter modelOfClass:Photo.class fromJSONDictionary:photoJsonDict error:&parseError];
            if (!parseError) {
                if (tempPhoto) {
                    [[AppData sharedInstance].currentPhotosArray addObject:tempPhoto];
                }
            }
        }
    }
    if (self.callCompleted) {
        self.callCompleted(YES, @"");
    }
}
@end
