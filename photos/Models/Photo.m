//
//  Photo.m
//  photos
//
//  Created by Wil Ferrel on 10/19/15.
//  Copyright © 2015 speakeasy. All rights reserved.
//

#import "Photo.h"

@implementation Photo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"createdAt" : @"created_at",
        @"camera" : @"camera",
        @"shutterSpeed" : @"shutter_speed",
        @"favoritesCount" : @"favorite_count",
        @"lens" : @"lens",
        @"imageUrl" : @"image_url",
        @"votesCount" : @"votes_count",
        @"photosDescription" : @"description",
        @"name" : @"name",
        @"takenAt" : @"taken_at",
        @"images" : @"images",
        @"guid" : @"id"

    };
}
+ (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss-Z";
    return dateFormatter;
}

+ (NSValueTransformer *)takenAtJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
      return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
      return [self.dateFormatter stringFromDate:date];
    }];
}
+ (NSValueTransformer *)createdAtJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
      return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
      return [self.dateFormatter stringFromDate:date];
    }];
}
+ (NSValueTransformer *)imagesTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Images class]];
}
@end
