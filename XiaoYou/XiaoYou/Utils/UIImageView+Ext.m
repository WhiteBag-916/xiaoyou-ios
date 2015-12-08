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
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", api_icon_base_url, url]] placeholderImage:[UIImage imageNamed:@"common_head_loading"]];
    
}

//增加默认图
- (void)setNormalImageWithUrl:(NSString *)url {
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    self.userInteractionEnabled = false;
//    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", api_icon_base_url, url]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image != nil) {
//            self.userInteractionEnabled = true;
//        }
//    }];
    
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", api_icon_base_url, url]] placeholderImage:[UIImage imageNamed:@"common_picture_loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil) {
            self.userInteractionEnabled = true;
        }
    }];
    
    
}

- (void)setImageWithUrlWithoutPlaceholder:(NSString *)url
{
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    self.userInteractionEnabled = false;
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", api_icon_base_url, url]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil) {
            self.userInteractionEnabled = true;
        }
    }];
}

#pragma mark 编码解码函数，暂时未测试
//- (NSString *)encodeToPercentEscapeString: (NSString *)input
//{
//    NSString*
//    outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
//                                                                             NULL, /* allocator */
//                                                                             
//                                                                             (__bridge CFStringRef)input,
//                                                                             
//                                                                             NULL, /* charactersToLeaveUnescaped */
//                                                                             
//                                                                             (CFStringRef)@"!*'();:@&=+$,/?%#[]",
//                                                                             
//                                                                             kCFStringEncodingUTF8);
//    
//    
//    return
//    outputStr;
//}
//- (NSString *)decodeFromPercentEscapeString: (NSString *) input
//{
//    NSMutableString *outputStr = [NSMutableString stringWithString:input];
//    [outputStr replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch
//                                    range:NSMakeRange(0,[outputStr length])];
//    
//    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//}

@end
