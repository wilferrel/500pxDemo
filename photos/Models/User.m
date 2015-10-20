//
//  User.m
//  photos
//
//  Created by Wil Ferrel on 10/19/15.
//  Copyright © 2015 speakeasy. All rights reserved.
//

#import "User.h"

@implementation User

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"guid" : @"id",
        @"coverUrl" : @"cover_url",
        @"lastname" : @"lastname",
        @"userpicUrl" : @"userpic_url",
        @"firstname" : @"firstname",
        @"city" : @"city",
        @"username" : @"username",
        @"fullname" : @"fullname",
        @"userpicHttpsUrl" : @"userpic_https_url",
        @"country" : @"country"
    };
}
@end
