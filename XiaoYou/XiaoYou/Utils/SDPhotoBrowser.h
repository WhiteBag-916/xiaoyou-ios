//
//  SDPhotoBrowser.h
//  photobrowser
//
//  Created by aier on 15-2-3.
//  Copyright (c) 2015年 aier. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SDButton, SDPhotoBrowser;

@protocol SDPhotoBrowserDelegate <NSObject>

@required

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;

@optional

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index;

//删除某张图片
- (void)deleteImageWithCurrentIndex:(int)currentIndex;


@end


@interface SDPhotoBrowser : UIView <UIScrollViewDelegate>

@property (nonatomic, weak) UIView *sourceImagesContainerView;
@property (nonatomic, assign) int currentImageIndex;
@property (nonatomic, assign) NSInteger imageCount;
@property (nonatomic, assign) BOOL hasSaveBtn;
@property (nonatomic, assign) BOOL hasDeleteBtn;
@property (nonatomic, assign) BOOL isHiddenIndex;
@property (nonatomic, weak) id<SDPhotoBrowserDelegate> delegate;

- (void)show;

@end
