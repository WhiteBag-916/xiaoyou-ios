//
//  SchoolDetailModel.h
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SchoolDetailModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *introduce;
@property (nonatomic, strong) NSString *history;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *information;
@property (nonatomic, strong) NSString *introduceImagePath;
@property (nonatomic, strong) NSString *schoolName;
@property (nonatomic, strong) NSString *historyImagePath;
@property (nonatomic, strong) NSString *departmentImagePath;
@property (nonatomic, strong) NSString *schoolLogoPath;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
