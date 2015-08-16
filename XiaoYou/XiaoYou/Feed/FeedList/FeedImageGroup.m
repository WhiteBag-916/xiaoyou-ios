//
//  FeedImageGroup.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/15.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedImageGroup.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "YUtils+Component.h"
#import "SDPhotoBrowser/SDPhotoBrowser.h"

#define KIMGTAG 10000
#define KIMGSIZE SCALE_NUM(100)
@interface FeedImageGroup()<SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *smallImgs;
@property (nonatomic, strong) NSArray *bigImgs;

@property (nonatomic, strong) UIView *contentView;

@end

@implementation FeedImageGroup

- (id)init {
    self = [super init];
    if (self) {
        [self initImgs];
    }
    return self;
}

- (void)initImgs {
    
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.equalTo(_contentView.mas_width);
    }];
    
    for (int i = 0; i < 3; i ++) {
        for (int j = 0; j < 3; j++) {
            UIImageView *img = [[UIImageView alloc] init];
            img.tag = KIMGTAG + i*3 + j;
            img.contentMode = UIViewContentModeScaleAspectFill;
            img.clipsToBounds = true;
            img.userInteractionEnabled = true;
            [_contentView addSubview:img];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePic:)];
            [img addGestureRecognizer:tap];
            
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(KIMGSIZE);
                if (i == 0) {
                    make.top.equalTo(_contentView);
                } else if (i == 1)
                    make.centerY.equalTo(_contentView.mas_centerY);
                else
                    make.bottom.equalTo(_contentView.mas_bottom);
                
                if (j == 0) {
                    make.left.equalTo(_contentView);
                } else if (j == 1)
                    make.centerX.equalTo(_contentView);
                else
                    make.right.equalTo(_contentView);
            }];
            
        }
    }
}

- (void)updateWithImgs:(NSArray *)smallPics bigPics:(NSArray *)bigPics {
    _smallImgs = [NSArray arrayWithArray:smallPics];
    _bigImgs = [NSArray arrayWithArray:bigPics];
    
    if (smallPics.count == 1) {
        [self specialForOneImage:[smallPics objectAtIndex:0]];
    } else {
        [self normalForImages:smallPics];
    }
    
}

- (void)specialForOneImage:(NSString *)url {
    [self moveToLine:3];
    for (int i = 1; i < 9; i++) {
        [_contentView.subviews[i] setHidden:true];
    }
    UIImageView *img = (UIImageView *)[_contentView viewWithTag:KIMGTAG];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_contentView);
    }];
    img.contentMode = UIViewContentModeScaleAspectFit;
    [img sd_setImageWithURL:[NSURL URLWithString:url]];
}
- (void)normalForImages:(NSArray *)urls {
    [self moveToLine:(int)(urls.count / 3)];
    for (int i = 0; i < urls.count; i ++) {
        [(UIImageView *)[_contentView viewWithTag:KIMGTAG+i] sd_setImageWithURL:[NSURL URLWithString:urls[i]]];
    }
}
- (void)moveToLine:(int)index {
    UIImageView *img = (UIImageView *)[_contentView viewWithTag:KIMGTAG];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_contentView);
        make.width.height.mas_equalTo(KIMGSIZE);
    }];
    img.contentMode = UIViewContentModeScaleAspectFill;
    
    for (int i = 0; i < 3; i++) {
        [_contentView.subviews[i] setHidden:false];
    }
    for (int i = 3; i < 9; i++) {
        [_contentView.subviews[i] setHidden:true];
        [_contentView.subviews[i] setTag:KIMGTAG - i];
    }
    if (index == 1) {
        for (int i = 6; i < 9; i++) {
            [_contentView.subviews[i] setHidden:false];
            [_contentView.subviews[i] setTag:KIMGTAG + i-3];
        }
    } else {
        for (int i = 3; i < 9; i++) {
            [_contentView.subviews[i] setHidden:false];
            [_contentView.subviews[i] setTag:KIMGTAG + i];
        }
    }
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        if (index == 0) {
            make.height.mas_equalTo(KIMGSIZE);
        } else if (index == 1) {
            make.height.equalTo(_contentView.mas_width).multipliedBy(0.5).offset(KIMGSIZE/2);
        } else {
            make.height.equalTo(_contentView.mas_width);
        }
    }];
    
}

- (void)choosePic:(UITapGestureRecognizer *)tap {
    int index = (int)tap.view.tag - KIMGTAG;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    
    browser.sourceImagesContainerView = _contentView;
    
    browser.imageCount = _bigImgs.count;
    
    browser.currentImageIndex = index;
    
    browser.delegate = self;
    
    [browser show];
}

#pragma SDPhotoBrowser
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    UIImage *image = [(UIImageView *)[_contentView viewWithTag:KIMGTAG+index] image];
    return image;
}

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    return [NSURL URLWithString:_bigImgs[index]];
}
@end
