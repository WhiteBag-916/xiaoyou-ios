//
//  MGCTimedEventsViewLayout.m
//  Graphical Calendars Library for iOS
//
//  Distributed under the MIT License
//  Get the latest version from here:
//
//	https://github.com/jumartin/Calendar
//
//  Copyright (c) 2014-2015 Julien Martin
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "MGCTimedEventsViewLayout.h"
#import "MGCEventCellLayoutAttributes.h"


// In iOS 8.1.2 and older, there is a bug with UICollectionView that will make
// cells disappear when their frame overlap vertically the visible rect (i.e the one passed in
// layoutAttributesForElementsInRect:)
// To avoid this, we constraint the height of the cells frame so that they entirely fit in the rect.
// Then we have to remember to invalidate the whole layout whenever this visible rect changes

// see http://stackoverflow.com/questions/13770484/large-uicollectionviewcells-disappearing-with-custom-layout
// or https://github.com/mattjgalloway/CocoaBugs/blob/master/UICollectionView-MissingCells/README.md

#define BUG_FIX


@interface MGCTimedEventsViewLayout()

@property (nonatomic) NSMutableDictionary *layoutInfo;

#ifdef BUG_FIX
@property (nonatomic) CGRect visibleBounds;
@property (nonatomic) BOOL shouldInvalidate;
#endif

@end


@implementation MGCTimedEventsViewLayout

- (instancetype)init {
	if (self = [super init]) {
		_minimumVisibleHeight = 15.;
	}
	return self;
}

- (NSMutableDictionary*)layoutInfo
{
	if (!_layoutInfo) {
		NSInteger numSections = self.collectionView.numberOfSections;
		_layoutInfo = [NSMutableDictionary dictionaryWithCapacity:numSections];
	}
	return _layoutInfo;
}

- (NSArray*)layoutAttributesForSection:(NSUInteger)section
{
	NSArray *sectionAttribs = [self.layoutInfo objectForKey:@(section)];
	if (!sectionAttribs) {
		
		NSInteger numItems = [self.collectionView numberOfItemsInSection:section];
		NSMutableArray *attribs = [NSMutableArray arrayWithCapacity:numItems];
		
		for (NSInteger item = 0; item < numItems; item++) {
			NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
			MGCEventCellLayoutAttributes *cellAttribs = [MGCEventCellLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
			
			CGFloat left = self.dayColumnSize.width * indexPath.section;
			CGFloat top = [self.delegate collectionView:self.collectionView layout:self yPosForEventAtIndexPath:indexPath];
			CGFloat height = [self.delegate collectionView:self.collectionView layout:self heightForEventAtIndexPath:indexPath];
			height = fmax(self.minimumVisibleHeight, height);
			
			cellAttribs.frame = CGRectInset(CGRectMake(left, top, self.dayColumnSize.width, height), 0, 1);
			cellAttribs.visibleHeight = cellAttribs.frame.size.height;
			
			[attribs addObject:cellAttribs];
		}
		
		sectionAttribs = [self adjustLayoutForOverlappingCells:attribs inSection:section];
		
		[self.layoutInfo setObject:sectionAttribs forKey:@(section)];
	}
	
	return sectionAttribs;
}

- (NSArray*)adjustLayoutForOverlappingCells:(NSArray*)attributes inSection:(NSUInteger)section
{
    if (attributes.count < 2) {
        return attributes;
    }
    
	// sort layout attributes by frame y-position
//    NSArray *adjustedAttributes = [NSArray arrayWithArray:attributes];
	NSArray *adjustedAttributes = [attributes sortedArrayUsingComparator:^NSComparisonResult(MGCEventCellLayoutAttributes *att1, MGCEventCellLayoutAttributes *att2) {
		if (att1.frame.origin.y > att2.frame.origin.y) {
			 return NSOrderedDescending;
		}
		else if (att1.frame.origin.y < att2.frame.origin.y) {
			 return NSOrderedAscending;
		}
		return NSOrderedSame;
    }];
    
    //算最大交集
    NSMutableArray *allArray = [[NSMutableArray alloc] init];
    NSInteger startNum = 1;
    while (1) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        MGCEventCellLayoutAttributes *attribs = [adjustedAttributes objectAtIndex:startNum-1];
        [array addObject:attribs];
        CGRect maxRect = attribs.frame;
        for (NSInteger i = startNum; i < adjustedAttributes.count; i++) {
            MGCEventCellLayoutAttributes *attribs2 = [adjustedAttributes objectAtIndex:i];
            if (CGRectIntersectsRect(maxRect, attribs2.frame)) {
                [array addObject:attribs2];
                CGFloat maxY = attribs2.frame.origin.y+attribs2.frame.size.height;
                if (maxY > maxRect.origin.x+maxRect.size.height) {
                    maxRect = CGRectMake(maxRect.origin.x, maxRect.origin.y, maxRect.size.width, maxY);
                }
            }
        }
        [allArray addObject:array];
        
        startNum += array.count;
        
        if (startNum-1 == adjustedAttributes.count) {
            break;
        }
    }
    
    //排列
    for (NSMutableArray *array in allArray) {
        if (array.count == 1) {
            continue;
        }
        //按列分数组
        NSMutableArray *layoutGroup = [[NSMutableArray alloc] init];
        while (1) {
            NSMutableArray *numArray = [[NSMutableArray alloc] init];
            MGCEventCellLayoutAttributes *attribs1 = [array objectAtIndex:0];
            [numArray addObject:array[0]];
            [array removeObjectAtIndex:0];
            CGFloat maxY = attribs1.frame.origin.y+attribs1.frame.size.height;
            //如果Y轴没有交集
            for (NSInteger i = 0; i<array.count; ++i) {
                MGCEventCellLayoutAttributes *attribs2 = [array objectAtIndex:i];
                
                if (maxY < attribs2.frame.origin.y) {
                    [numArray addObject:attribs2];
                    maxY = attribs2.frame.origin.y+attribs2.frame.size.height;
                    [array removeObjectAtIndex:i];
                    --i;
                }
            }
            
            [layoutGroup addObject:numArray];
            if (0 == array.count) {
                break;
            }
        }
        
        //计算X Width
        CGFloat totalWidth = self.dayColumnSize.width - (layoutGroup.count-1)*_midOffset;
        
        //以组的数据计算最大宽度
        CGFloat colWidth = totalWidth / layoutGroup.count;
        
        CGFloat x = section * self.dayColumnSize.width;
        
        for (NSArray *array in layoutGroup) {
            for (MGCEventCellLayoutAttributes* attribs in array) {
                attribs.frame = CGRectMake(x, attribs.frame.origin.y, colWidth, attribs.frame.size.height);
            }
            x += colWidth;
            x += _midOffset;//间距
        }
    }
	
	return adjustedAttributes;
}

#pragma mark - UICollectionViewLayout

+ (Class)layoutAttributesClass
{
	return [MGCEventCellLayoutAttributes class];
}

- (MGCEventCellLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath*)indexPath
{
	//NSLog(@"layoutAttributesForItemAtIndexPath %@", indexPath);
	
	NSArray *attribs = [self layoutAttributesForSection:indexPath.section];
	return [attribs objectAtIndex:indexPath.item];
}

- (MGCEventCellLayoutAttributes*)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath*)indexPath
{
	return (MGCEventCellLayoutAttributes*)[self layoutAttributesForItemAtIndexPath:indexPath];
}

- (MGCEventCellLayoutAttributes*)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath*)indexPath
{
	return (MGCEventCellLayoutAttributes*)[self layoutAttributesForItemAtIndexPath:indexPath];
}

- (void)prepareForCollectionViewUpdates:(NSArray*)updateItems
{
	//NSLog(@"prepare Collection updates");
	
	[super prepareForCollectionViewUpdates:updateItems];
}

- (void)invalidateLayout
{
	//NSLog(@"invalidateLayout");
	
	[super invalidateLayout];
	self.layoutInfo = nil;
}

- (CGSize)collectionViewContentSize
{
	return CGSizeMake(self.dayColumnSize.width * self.collectionView.numberOfSections, self.dayColumnSize.height);
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
	//NSLog(@"layoutAttributesForElementsInRect %@", NSStringFromCGRect(rect));
	
#ifdef BUG_FIX
	self.shouldInvalidate = self.visibleBounds.origin.y != rect.origin.y || self.visibleBounds.size.height != rect.size.height;
	//self.shouldInvalidate = !CGRectEqualToRect(self.visibleBounds, rect);
	self.visibleBounds = rect;
#endif
	
	NSMutableArray *allAttribs = [NSMutableArray array];
	
	// determine first and last day intersecting rect
	NSUInteger maxSection = self.collectionView.numberOfSections;
	NSUInteger first = MAX(0, floorf(rect.origin.x  / self.dayColumnSize.width));
	NSUInteger last = MIN(maxSection, ceilf(CGRectGetMaxX(rect) / self.dayColumnSize.width));
	
	for (NSInteger day = first; day < last; day++) {
		NSArray *attribs = [self layoutAttributesForSection:day];
		
		for (MGCEventCellLayoutAttributes *a in attribs) {
			if (CGRectIntersectsRect(rect, a.frame)) {
#ifdef BUG_FIX
				CGRect frame = a.frame;
				frame.size.height = fminf(frame.size.height, CGRectGetMaxY(rect) - frame.origin.y);
				a.frame = frame;
#endif
				[allAttribs addObject:a];
			}
		}
	}

	return allAttribs;
}

#ifdef BUG_FIX

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
	//NSLog(@"shouldInvalidateLayoutForBoundsChange %@", NSStringFromCGRect(newBounds));
	return self.shouldInvalidate;
}

#endif

@end
