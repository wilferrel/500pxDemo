//
//  PopularPhotosCall.h
//  photos
//
//  Created by Wil Ferrel on 10/19/15.
//  Copyright © 2015 speakeasy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEConstants.h"

@interface PopularPhotosCall : NSObject
@property(nonatomic, copy) void (^callCompleted)(BOOL success, NSString* errorString);

/**
 *  GET to retrieve
 *
 *  @param completionBlock <#completionBlock description#>
 */
- (void)getPopularPhotos:(void (^)(BOOL success, NSString* errorString))completionBlock;

@end
