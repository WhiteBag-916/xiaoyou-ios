//
//  RemindList.m
//  Model
//
//  Created by sheng on 15/9/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RemindList.h"

@implementation RemindList





#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
//    self.isRead = [aDecoder decodeBoolForKey:kAlertListIsRead];
//    self.content = [aDecoder decodeObjectForKey:kAlertListContent];
//    self.userId = [aDecoder decodeObjectForKey:kAlertListUserId];
//    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kAlertListId];
//    self.affectId = [aDecoder decodeDoubleForKey:kAlertListAffectId];
//    self.createTime = [aDecoder decodeDoubleForKey:kAlertListCreateTime];
//    self.lastReadTime = [aDecoder decodeDoubleForKey:kAlertListLastReadTime];
//    self.hedPic = [aDecoder decodeObjectForKey:kAlertListHedPic];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
//    [aCoder encodeBool:_isRead forKey:kAlertListIsRead];
//    [aCoder encodeObject:_content forKey:kAlertListContent];
//    [aCoder encodeObject:_userId forKey:kAlertListUserId];
//    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kAlertListId];
//    [aCoder encodeDouble:_affectId forKey:kAlertListAffectId];
//    [aCoder encodeDouble:_createTime forKey:kAlertListCreateTime];
//    [aCoder encodeDouble:_lastReadTime forKey:kAlertListLastReadTime];
//    [aCoder encodeObject:_hedPic forKey:kAlertListHedPic];
}

- (id)copyWithZone:(NSZone *)zone
{
//    AlertList *copy = [[AlertList alloc] init];
//    
//    if (copy) {
//        
//        copy.isRead = self.isRead;
//        copy.content = [self.content copyWithZone:zone];
//        copy.userId = [self.userId copyWithZone:zone];
//        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
//        copy.affectId = self.affectId;
//        copy.createTime = self.createTime;
//        copy.lastReadTime = self.lastReadTime;
//        copy.hedPic = [self.hedPic copyWithZone:zone];
//    }
//    
//    return copy;
    return @"aa";
}

@end
