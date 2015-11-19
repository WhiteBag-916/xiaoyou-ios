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
#define KIMGSIZE SCALE_NUM(200)
@interface FeedImageGroup()<SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSMutableArray *smallImgs;

@property (nonatomic, strong) NSMutableArray *bigImgs;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIImageView *camera;

@property (nonatomic, assign) float imgSize;

@property (nonatomic, strong) UIImageView *singleImg;

@property (nonatomic, assign) int currentIndex;

@property (nonatomic, strong) SDPhotoBrowser *browser;
@end

@implementation FeedImageGroup

- (id)init {
    self = [super init];
    if (self) {
        _imgSize = SCALE_NUM(77);
        _smallImgs = [NSMutableArray array];
        [self initImgs];
        _currentIndex = 0;
    }
    return self;
}

- (id)initWithCamera {
    self = [super init];
    if (self) {
        _imgSize = SCALE_NUM(75);
        _smallImgs = [NSMutableArray array];
        _camera = [[UIImageView alloc] init];
        
        [self initImgs];
        [self addSubview:_camera];
        _camera.contentMode = UIViewContentModeCenter;
        _camera.image = [UIImage imageNamed:@"camera"];
        [_camera mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_contentView.subviews[0]);
        }];
        _camera.userInteractionEnabled = true;
        [_camera addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openPhoto)]];
        [self moveToLine:0];
        for (int i = 1; i < 9; i++) {
            [_contentView.subviews[i] setHidden:true];
        }
    }
    return self;
}

- (void)initImgs {
    _hasSaveBtn = true;
    _hasDeleteBtn = false;
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
            
            if (_camera != nil) {
                UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
                [img addGestureRecognizer:press];
            }
            
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

- (void)updateWithImgs:(NSArray *)smallPics bigPics:(NSArray *)bigPics{
    _smallImgs = [NSMutableArray arrayWithArray:smallPics];
    _bigImgs = [NSMutableArray arrayWithArray:bigPics];
    [self updateAll];
    
}
//更新控件布局
- (void)updateAll {
    if (_camera == nil) {
        if (_smallImgs.count == 0) {
            [self moveToLine:-1];
        } else if (_smallImgs.count == 1) {
            [self specialForOneImage:[_bigImgs objectAtIndex:0]];
        } else {
            [self normalForImages:_smallImgs];
        }
    } else {
        int index = (int)(_smallImgs.count) / 3;
        if (index == 3) {
            index = 2;
            _camera.hidden = true;
        } else {
            _camera.hidden = false;
        }
        [self moveToLine:index];
        for (int i = 0; i < _smallImgs.count; i ++) {
            [(UIImageView *)[_contentView viewWithTag:KIMGTAG+i] setImage:_smallImgs[i]];
        }
        if (_smallImgs.count < 9) {
            int ct = 0;
            if (index != 1) {
                ct = (int)_smallImgs.count;
            } else {
                ct = (int)_smallImgs.count + 3;
            }
            [_camera mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(_contentView.subviews[ct]);
            }];
        }

    }
}
//单图片特殊处理
- (void)specialForOneImage:(NSString *)url {
    UIImageView *img = (UIImageView *)[_contentView subviews][0];
    [img mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KIMGSIZE);
        make.height.equalTo(img.mas_width);
        make.top.left.equalTo(_contentView);
    }];
    img.contentMode = UIViewContentModeScaleAspectFill;
    [self moveToLine:3];
    [img setNormalImageWithUrl:url];
    for (int i = 1; i < 9; i++) {
        [_contentView.subviews[i] setHidden:true];
    }
    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.mas_equalTo(KIMGSIZE).priorityLow();
    }];
}
- (void)addPhoto:(UIImage *)image {
    [_smallImgs addObject:image];
    [self updateAll];
}
//普通图片处理
- (void)normalForImages:(NSArray *)urls {
    UIImageView *img = (UIImageView *)[_contentView subviews][0];
    [img mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_contentView);
        make.width.height.mas_equalTo(_imgSize);
    }];
    img.contentMode = UIViewContentModeScaleAspectFill;
    [self moveToLine:(int)((urls.count-1) / 3)];
    for (int i = 0; i < urls.count; i ++) {
        [(UIImageView *)[_contentView viewWithTag:KIMGTAG+i] setNormalImageWithUrl:urls[i]];
    }
}
//修正group的高度
- (void)moveToLine:(int)index {
    for (int i = 0; i < 9; i++) {
        [_contentView.subviews[i] setHidden:true];
        [_contentView.subviews[i] setTag:KIMGTAG - i-1];
    }
    //限制图片上传不能超过9张
    if (index != 1) {
        for (int i = 0; i < _smallImgs.count && i<9; i++) {
            [_contentView.subviews[i] setHidden:false];
            [_contentView.subviews[i] setTag:KIMGTAG + i];
        }
    } else {
        for (int i = 0; i < 3; i++) {
            [_contentView.subviews[i] setHidden:false];
            [_contentView.subviews[i] setTag:KIMGTAG + i];
        }
        for (int i = 6; i < _smallImgs.count + 3; i++) {
            [_contentView.subviews[i] setHidden:false];
            [_contentView.subviews[i] setTag:KIMGTAG + i-3];
        }
    }
    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        if (index == -1) {
            make.height.mas_equalTo(0);
        } else if (index == 0) {
            make.height.mas_equalTo(_imgSize).priorityLow();
        } else if (index == 1) {
            make.height.equalTo(_contentView.mas_width).multipliedBy(0.5).offset(_imgSize/2).priorityLow();
        } else {
            make.height.equalTo(_contentView.mas_width).priorityLow();
        }
    }];
    
}
//长按删除图片
- (void)longPress:(UILongPressGestureRecognizer *)press {
    if (press.state == UIGestureRecognizerStateBegan) {
        int index = (int)press.view.tag - KIMGTAG;
        if (index < 0 || index >= _smallImgs.count) {
            return;
        }
        [_smallImgs removeObjectAtIndex:index];
        [self updateAll];
    }
}
//放大图片
- (void)choosePic:(UITapGestureRecognizer *)tap {
    int index = (int)tap.view.tag - KIMGTAG;
    if (index < 0 || index >= _smallImgs.count) {
        return;
    }
    _browser = [[SDPhotoBrowser alloc] init];
    
    _browser.sourceImagesContainerView = _contentView;
    
    _browser.imageCount = _smallImgs.count;
    
    _browser.currentImageIndex = index;
    
    _browser.delegate = self;
    
    _browser.hasSaveBtn = _hasSaveBtn;
    _browser.hasDeleteBtn = _hasDeleteBtn;
    
    [_browser show];
}
- (int)getImgCount {
    return (int)_smallImgs.count;
}

#pragma SDPhotoBrowser
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    _currentIndex = browser.currentImageIndex;
    UIImage *image = [(UIImageView *)[_contentView viewWithTag:KIMGTAG+index] image];
    return image;
}
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    _currentIndex = browser.currentImageIndex;
    if (_bigImgs.count == _smallImgs.count) {
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",api_icon_base_url, _bigImgs[index]]];
    }
    return nil;
}
//删除某张照片
-(void)deleteImageWithCurrentIndex:(int)currentIndex
{
    [self.smallImgs removeObjectAtIndex:_currentIndex];
    [self.bigImgs removeObjectAtIndex:_currentIndex];
    [self updateAll];
    [_browser removeFromSuperview];
    _browser = nil;
    
    //图片被删除完，或者删除的最后一张
//    if (self.smallImgs.count == 0) return;
//    if (self.smallImgs.count < currentIndex +1)
//        self.currentIndex = self.currentIndex - 1;
//    
//    _browser = [[SDPhotoBrowser alloc] init];
//    
//    _browser.sourceImagesContainerView = _contentView;
//    
//    _browser.imageCount = _smallImgs.count;
//    
//    _browser.currentImageIndex = _currentIndex;
//    
//    _browser.delegate = self;
//    
//    _browser.hasSaveBtn = _hasSaveBtn;
//    _browser.hasDeleteBtn = _hasDeleteBtn;
//    [_browser show];
}

//打开拍照功能
- (void)openPhoto {
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Present_TakePhoto object:nil];
}


@end
