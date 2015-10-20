//
//  Photo.h
//  photos
//
//  Created by Wil Ferrel on 10/19/15.
//  Copyright © 2015 speakeasy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>
#import "User.h"
#import "Images.h"

@interface Photo : MTLModel<MTLJSONSerializing>

@property(nonatomic) NSString *createdAt;
@property(nonatomic) NSString *guid;
@property(nonatomic) NSString *camera;
@property(nonatomic) NSString *shutterSpeed;
@property(nonatomic) NSString *url;
@property(nonatomic) NSNumber *favoritesCount;
@property(nonatomic) NSString *lens;
@property(nonatomic) NSString *imageUrl;
@property(nonatomic, assign) NSNumber *votesCount;
@property(nonatomic) NSString *photosDescription;
@property(nonatomic) User *user;
@property(nonatomic) NSString *name;
@property(nonatomic) NSString *takenAt;
@property(nonatomic) NSArray *images;
@end
