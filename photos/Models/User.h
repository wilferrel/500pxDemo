//
//  User.h
//  photos
//
//  Created by Wil Ferrel on 10/19/15.
//  Copyright © 2015 speakeasy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>

@interface User : MTLModel<MTLJSONSerializing>
@property(nonatomic) NSString *guid;
@property(nonatomic) NSString *coverUrl;
@property(nonatomic) NSString *lastname;
@property(nonatomic) NSString *userpicUrl;
@property(nonatomic) NSString *firstname;
@property(nonatomic) NSString *city;
@property(nonatomic) NSString *username;
@property(nonatomic) NSString *fullname;
@property(nonatomic) NSString *userpicHttpsUrl;
@property(nonatomic) NSString *country;
@end
