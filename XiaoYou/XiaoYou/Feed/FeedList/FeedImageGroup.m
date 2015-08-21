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
@interface FeedImageGroup()<SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *smallImgs;
@property (nonatomic, strong) NSArray *bigImgs;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIImageView *camera;

@property (nonatomic, assign) float imgSize;

@end

@implementation FeedImageGroup

- (id)init {
    self = [super init];
    if (self) {
        _imgSize = SCALE_NUM(70);
        [self initImgs];
    }
    return self;
}
- (id)initWithCamera {
    self = [super init];
    if (self) {
        _imgSize = SCALE_NUM(75);
        [self initImgs];
        _camera = [[UIImageView alloc] init];
        [self addSubview:_camera];
        _camera.backgroundColor = [UIColor redColor];
        [_camera mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_contentView.subviews[0]);
        }];
        [self moveToLine:0];
        for (int i = 1; i < 9; i++) {
            [_contentView.subviews[i] setHidden:true];
        }
    }
    return self;
}

- (void)initImgs {
    
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    _contentView.clipsToBounds = true;
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
                make.width.height.mas_equalTo(_imgSize);
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
    if (_smallImgs.count == 0) {
        [self moveToLine:-1];
    } else if (_smallImgs.count == 1) {
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

- (void)updateWithPhotos:(NSArray *)pics bigPics:(NSArray *)bigPics {
    _bigImgs = [NSArray arrayWithArray:bigPics];
    int index = (int)(_bigImgs.count + 1) / 3;
    [self moveToLine:index];
    for (int i = 0; i < pics.count; i ++) {
        [(UIImageView *)[_contentView viewWithTag:KIMGTAG+i] setImage:pics[i]];
    }
    if (pics.count < 9) {
        int ct = 0;
        if (index != 1) {
            ct = (int)_bigImgs.count;
        } else {
            ct = (int)_bigImgs.count + 3;
        }
        [_camera mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_contentView.subviews[ct]);
        }];
    }
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
        make.width.height.mas_equalTo(_imgSize);
    }];
    img.contentMode = UIViewContentModeScaleAspectFill;
    
    for (int i = 0; i < 9; i++) {
        [_contentView.subviews[i] setHidden:true];
        [_contentView.subviews[i] setTag:KIMGTAG - i-1];
    }
    if (index != 1) {
        for (int i = 0; i < _bigImgs.count; i++) {
            [_contentView.subviews[i] setHidden:false];
            [_contentView.subviews[i] setTag:KIMGTAG + i];
        }
    } else {
        for (int i = 0; i < 3; i++) {
            [_contentView.subviews[i] setHidden:false];
            [_contentView.subviews[i] setTag:KIMGTAG + i];
        }
        for (int i = 6; i < _bigImgs.count + 3; i++) {
            [_contentView.subviews[i] setHidden:false];
            [_contentView.subviews[i] setTag:KIMGTAG + i-3];
        }
    }
    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        if (index == -1) {
            make.height.mas_equalTo(0);
        } else if (index == 0) {
            make.height.mas_equalTo(_imgSize);
        } else if (index == 1) {
            make.height.equalTo(_contentView.mas_width).multipliedBy(0.5).offset(_imgSize/2);
        } else {
            make.height.equalTo(_contentView.mas_width);
        }
    }];
    
}

- (void)choosePic:(UITapGestureRecognizer *)tap {
    int index = (int)tap.view.tag - KIMGTAG;
    if (index < 0 || index >= _bigImgs.count) {
        return;
    }
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
