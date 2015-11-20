/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "UIImageView+EMWebCache.h"
#import "EMChatImageBubbleView.h"
#import "SDPhotoBrowser.h"
#import "UIImageView+Ext.h"

NSString *const kRouterEventImageBubbleTapEventName = @"kRouterEventImageBubbleTapEventName";

@interface EMChatImageBubbleView ()<SDPhotoBrowserDelegate>

//放大图片
@property (nonatomic,strong) UIImage * showImage;

@end

@implementation EMChatImageBubbleView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize retSize = self.model.size;
    if (retSize.width == 0 || retSize.height == 0) {
        retSize.width = MAX_SIZE;
        retSize.height = MAX_SIZE;
    }
    if (retSize.width > retSize.height) {
        CGFloat height =  MAX_SIZE / retSize.width  *  retSize.height;
        retSize.height = height;
        retSize.width = MAX_SIZE;
    }else {
        CGFloat width = MAX_SIZE / retSize.height * retSize.width;
        retSize.width = width;
        retSize.height = MAX_SIZE;
    }
    
    return CGSizeMake(retSize.width + BUBBLE_VIEW_PADDING * 2 + BUBBLE_ARROW_WIDTH, 2 * BUBBLE_VIEW_PADDING + retSize.height);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    frame.size.width -= BUBBLE_ARROW_WIDTH;
    frame = CGRectInset(frame, BUBBLE_VIEW_PADDING, BUBBLE_VIEW_PADDING);
    if (self.model.isSender) {
        frame.origin.x = BUBBLE_VIEW_PADDING;
    }else{
        frame.origin.x = BUBBLE_VIEW_PADDING + BUBBLE_ARROW_WIDTH;
    }
    
    frame.origin.y = BUBBLE_VIEW_PADDING;
    [self.imageView setFrame:frame];
}

#pragma mark - setter

- (void)setModel:(MessageModel *)model
{
    [super setModel:model];
    UIImage *image = _model.isSender ? _model.image : _model.thumbnailImage;
    if (!image) {
        image = _model.image;
        if (!image) {
            [self.imageView sd_setImageWithURL:_model.imageRemoteURL placeholderImage:[UIImage imageNamed:@"imageDownloadFail.png"]];
        } else {
             self.imageView.image = image;
        }
    } else {
        self.imageView.image = image;
    }
}

#pragma mark - public

-(void)bubbleViewPressed:(id)sender
{
//    [self routerEventWithName:kRouterEventImageBubbleTapEventName
//                     userInfo:@{KMESSAGEKEY:self.model}];

    NSString *localPath = _model.message == nil ? _model.localPath : [[_model.message.messageBodies firstObject] localPath];
    if (localPath && localPath.length > 0) {
        UIImage *image = [UIImage imageWithContentsOfFile:localPath];
        if (image)
        {
            _showImage = image;
            
        }
        else
        {
             NSData * data = [NSData dataWithContentsOfURL:self.model.imageRemoteURL];
            _showImage = [UIImage imageWithData:data];
        }
    }
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    
    browser.sourceImagesContainerView = self;
    
    browser.imageCount = 1;
    
    browser.currentImageIndex = 0;
    
    browser.delegate = self;
    
    browser.hasSaveBtn = YES;
    
    [browser show];
}


+(CGFloat)heightForBubbleWithObject:(MessageModel *)object
{
    CGSize retSize = object.size;
    if (retSize.width == 0 || retSize.height == 0) {
        retSize.width = MAX_SIZE;
        retSize.height = MAX_SIZE;
    }else if (retSize.width > retSize.height) {
        CGFloat height =  MAX_SIZE / retSize.width  *  retSize.height;
        retSize.height = height;
        retSize.width = MAX_SIZE;
    }else {
        CGFloat width = MAX_SIZE / retSize.height * retSize.width;
        retSize.width = width;
        retSize.height = MAX_SIZE;
    }
    return 2 * BUBBLE_VIEW_PADDING + retSize.height;
}

#pragma SDPhotoBrowser
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    return _showImage;
}

@end
