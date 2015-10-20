//
//  Images.m
//  photos
//
//  Created by Wil Ferrel on 10/19/15.
//  Copyright © 2015 speakeasy. All rights reserved.
//

#import "Images.h"

@implementation Images
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"url" : @"url",
        @"httpsUrl" : @"https_url",
        @"format" : @"format",
    };
}
@end
