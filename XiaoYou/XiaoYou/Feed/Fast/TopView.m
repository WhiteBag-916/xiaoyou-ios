//
//  TopView.m
//  XiaoYou
//
//  Created by sheng on 15/9/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TopView.h"
#import "PhotoStackView.h"
@interface TopView ()<PhotoStackViewDataSource, PhotoStackViewDelegate>

@property (nonatomic,retain) UILabel *nameLabel;
@property (nonatomic,retain) UILabel *genderLabel;
@property (nonatomic,retain) UIView  *photoView;

#pragma mark 数据源数据和响应的图片数据
@property (nonatomic,retain) NSArray *photos;
@property (nonatomic, strong) PhotoStackView *photoStack;
@end

@implementation TopView

-(instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}


+(TopView *)topView
{
    TopView *topView = [[TopView alloc]init];
    [topView photoStack];
    return topView;
}

-(NSArray *)photos {
    if(!_photos) {
        
        _photos = [NSArray arrayWithObjects:
                   [UIImage imageNamed:@"photo1.jpg"],
                   [UIImage imageNamed:@"photo6.jpg"],
                   [UIImage imageNamed:@"photo4.jpg"],
                   [UIImage imageNamed:@"photo2.jpg"],
                   [UIImage imageNamed:@"photo1.jpg"],
                   nil];
        
    }
    return _photos;
}

-(PhotoStackView *)photoStack {
    if(!_photoStack) {
        _photoStack = [[PhotoStackView alloc] init];
        [self addSubview:_photoView];
        _photoView.backgroundColor = [UIColor redColor];
        _photoStack.dataSource = self;
        _photoStack.delegate = self;
        
        
        [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(0);
            make.trailing.mas_equalTo(0);
            make.top.equalTo(self);
            make.height.mas_equalTo(@300);
        }];
        
    }
    
    return _photoStack;
}



#pragma mark -
#pragma mark Deck DataSource Protocol Methods

-(NSUInteger)numberOfPhotosInPhotoStackView:(PhotoStackView *)photoStack {
    return [self.photos count];
}

-(UIImage *)photoStackView:(PhotoStackView *)photoStack photoForIndex:(NSUInteger)index {
    return [self.photos objectAtIndex:index];
}



#pragma mark -
#pragma mark Deck Delegate Protocol Methods

-(void)photoStackView:(PhotoStackView *)photoStackView willStartMovingPhotoAtIndex:(NSUInteger)index {
    // User started moving a photo
}

-(void)photoStackView:(PhotoStackView *)photoStackView willFlickAwayPhotoAtIndex:(NSUInteger)index {
    // User flicked the photo away, revealing the next one in the stack
}

-(void)photoStackView:(PhotoStackView *)photoStackView didRevealPhotoAtIndex:(NSUInteger)index {
    //self.pageControl.currentPage = index;
}

-(void)photoStackView:(PhotoStackView *)photoStackView didSelectPhotoAtIndex:(NSUInteger)index {
    //NSLog(@"selected %d", index);
}

@end
