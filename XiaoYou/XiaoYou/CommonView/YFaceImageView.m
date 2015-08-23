//
//  YFaceImageView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YFaceImageView.h"
#import "UIImageView+WebCache.h"

@interface YFaceImageView()

@property (nonatomic, copy, readwrite) NSString *userId;
@property (nonatomic, copy, readwrite) NSString *imgUrl;

@end

@implementation YFaceImageView

- (id)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setData:(NSString *)userId imageUrl:(NSString *)imageUrl {
    _userId = userId;
    _imgUrl = imageUrl;
    [self setFaceImageWithUrl:imageUrl];
}

- (void)didClick {
    if (_userId.length != 0) {
        
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.frame.size.width/2;
    self.clipsToBounds = true;
}
@end
