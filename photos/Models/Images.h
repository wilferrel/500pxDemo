//
//  Images.h
//  photos
//
//  Created by Wil Ferrel on 10/19/15.
//  Copyright © 2015 speakeasy. All rights reserved.
//

#import "MTLModel.h"

@interface Images : MTLModel
@property(nonatomic) NSString *url;
@property(nonatomic) NSString *httpsUrl;
@property(nonatomic) NSString *format;
@end
