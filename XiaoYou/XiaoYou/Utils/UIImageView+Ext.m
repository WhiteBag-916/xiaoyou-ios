//
//  UIImageView+Ext.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/23.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "UIImageView+Ext.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (Ext)

- (void)setFaceImageWithUrl:(NSString *)url {
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", api_icon_base_url, url]] placeholderImage:[UIImage imageNamed:@"default_head"]];
    
}

- (void)setNormalImageWithUrl:(NSString *)url {
    self.userInteractionEnabled = false;
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", api_icon_base_url, url]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil) {
            self.userInteractionEnabled = true;
        }
    }];
}
@end
