//
//  PhotoTimelineCell.m
//  photos
//
//  Created by Wil Ferrel on 10/19/15.
//  Copyright © 2015 speakeasy. All rights reserved.
//

#import "PhotoTimelineCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppData.h"
#import <Mantle/Mantle.h>

@interface PhotoTimelineCell ()
@property(weak, nonatomic) IBOutlet UIImageView *userAvatarImageView;
@property(weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property(weak, nonatomic) IBOutlet UIImageView *photoContentImageView;
@property(weak, nonatomic) IBOutlet UILabel *photoDescription;
@property(weak, nonatomic) IBOutlet UILabel *votesLabel;

@end
@implementation PhotoTimelineCell

- (void)awakeFromNib
{
    [self roundAvatarImage];
    [self setupGesture];
}
- (void)roundAvatarImage
{
    self.userAvatarImageView.layer.cornerRadius = self.userAvatarImageView.bounds.size.width / 2;
    self.userAvatarImageView.layer.masksToBounds = YES;
}
- (void)loadDataFromPhoto:(Photo *)photoData
{
    User *tempUser = [MTLJSONAdapter modelOfClass:User.class fromJSONDictionary:(NSDictionary *)photoData.user error:NULL];

    [self getAvatarImageFromPhoto:tempUser];
    [self getMainImageFromPhoto:photoData];
    self.photoDescription.text = [NSString stringWithFormat:@"%@", photoData.photosDescription];
    self.votesLabel.text = [NSString stringWithFormat:@"%@", photoData.votesCount.stringValue];

    self.usernameLabel.text = [NSString stringWithFormat:@"%@", tempUser.username];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)getAvatarImageFromPhoto:(User *)userInfo
{
    __weak typeof(self) weakSelf = self;
    [[AppData sharedInstance]
            .appImageCache queryDiskCacheForKey:userInfo.userpicUrl
                                           done:^(UIImage *image, SDImageCacheType cacheType) {
                                             if (image) {
                                                 weakSelf.userAvatarImageView.image = image;
                                             } else {
                                                 [weakSelf.userAvatarImageView
                                                     sd_setImageWithURL:[NSURL URLWithString:userInfo.userpicUrl]
                                                       placeholderImage:nil
                                                                options:SDWebImageHighPriority
                                                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                                if (image) {
                                                                    [[SDImageCache sharedImageCache] storeImage:image forKey:imageURL.absoluteString];
                                                                }
                                                              }];
                                             }
                                           }];
}
- (void)getMainImageFromPhoto:(Photo *)photoInfo
{
    __weak typeof(self) weakSelf = self;
    [[AppData sharedInstance]
            .appImageCache queryDiskCacheForKey:photoInfo.imageUrl
                                           done:^(UIImage *image, SDImageCacheType cacheType) {
                                             if (image) {
                                                 weakSelf.photoContentImageView.image = image;
                                             } else {
                                                 [weakSelf.photoContentImageView
                                                     sd_setImageWithURL:[NSURL URLWithString:photoInfo.imageUrl]
                                                       placeholderImage:nil
                                                                options:SDWebImageHighPriority
                                                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                                if (image) {
                                                                    [[SDImageCache sharedImageCache] storeImage:image forKey:imageURL.absoluteString];
                                                                }
                                                              }];
                                             }
                                           }];
}
- (void)saveCurrentImage
{
    if (self.photoContentImageView.image) {
        UIImage *image = self.photoContentImageView.image;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
          UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        });
    }
}
#pragma mark - UILongPressGestureRecognizer
- (void)setupGesture
{
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleHoldGesture:)];
    longPressGesture.minimumPressDuration = 0.5;
    longPressGesture.allowableMovement = 800;
    longPressGesture.delegate = self;
    [self.photoContentImageView addGestureRecognizer:longPressGesture];
}

- (void)handleHoldGesture:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Image?"
                                                    message:@"Would you like to save image?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
            [self saveCurrentImage];
            break;
        default:
            break;
    }
}

@end
