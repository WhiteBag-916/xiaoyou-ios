//
//  SchoolListModel.h
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface SchoolListModel : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) id introduce;
@property (nonatomic, assign) id history;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) id introduceImagePath;
@property (nonatomic, assign) id departmentImagePath;
@property (nonatomic, strong) NSString *schoolName;
@property (nonatomic, assign) id historyImagePath;
@property (nonatomic, strong) NSString *schoolLogoPath;
@property (nonatomic, strong) NSString *schoolLocation;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
