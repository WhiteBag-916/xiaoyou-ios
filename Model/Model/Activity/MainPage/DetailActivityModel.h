//
//  DetailActivityModel.h
//  Model
//
//  Created by sheng on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailActivityModel : NSObject

@property (nonatomic,strong) NSString *headImageUrl;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *brief;
@property (nonatomic,strong) NSString *photosUrl;
@property (nonatomic,strong) NSString *enrollEndTime;

@property (nonatomic,strong) NSString *activityBeginTime;
@property (nonatomic,strong) NSString *activityEndTime;
@property (nonatomic,strong) NSString *location;
@property (nonatomic,strong) NSString *type;
@end
