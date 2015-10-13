//
//  MyFlowLayout.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MyFlowLayout.h"

@implementation MyFlowLayout

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *answer = [super layoutAttributesForElementsInRect:rect];
    
    for(int i = 1; i < [answer count]; ++i) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];
        NSInteger maximumSpacing = 10;
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    return answer;
}

@end
