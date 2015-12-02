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
    
    for(int i = 0; i < [answer count]; ++i) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
        
        NSInteger maximumSpacing = 10;
        CGFloat startOffX = 5;
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:currentLayoutAttributes];
        for (int j = i-1; j >= 0; --j) {
            UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[j];
            if (CGRectGetMinY(prevLayoutAttributes.frame) ==
                CGRectGetMinY(currentLayoutAttributes.frame)) {
                [array addObject:prevLayoutAttributes];
            }
        }
        CGFloat offX = startOffX;
        for (UICollectionViewLayoutAttributes *attr in [array reverseObjectEnumerator]) {
            attr.frame = CGRectMake(offX, CGRectGetMinY(attr.frame), CGRectGetWidth(attr.frame), CGRectGetHeight(attr.frame));
            
            offX=CGRectGetMaxX(attr.frame);
            offX+=maximumSpacing;
        }
        
//        UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];
//        NSInteger maximumSpacing = 10;
//        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
//        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width <
//        self.collectionViewContentSize.width) {
//            CGRect frame = currentLayoutAttributes.frame;
//            frame.origin.x = origin + maximumSpacing;
//            currentLayoutAttributes.frame = frame;
//        }
    }
    return answer;
}

@end
