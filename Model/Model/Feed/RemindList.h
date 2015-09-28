//
//  RemindList.h
//  Model
//
//  Created by sheng on 15/9/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"
@interface RemindList : YModel <NSCoding, NSCopying>

@property (nonatomic,copy) NSString *remindTitle;
@property (nonatomic,copy) NSString *noticeTitle;
@property (nonatomic,copy) NSString *noticeContent;
@property (nonatomic,copy) NSString *remindTrail;
@end
