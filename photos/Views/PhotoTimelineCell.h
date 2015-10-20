//
//  PhotoTimelineCell.h
//  photos
//
//  Created by Wil Ferrel on 10/19/15.
//  Copyright © 2015 speakeasy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotoTimelineCell : UITableViewCell<UIAlertViewDelegate>
- (void)loadDataFromPhoto:(Photo*)photoData;
@end
