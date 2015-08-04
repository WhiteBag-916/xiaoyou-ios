//
//  PushInfoListModel.h
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PushInfoListModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) id tablename;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, strong) NSString *sendStudentNo;
@property (nonatomic, assign) id realtion;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *isRead;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *reciveStudentNo;
@property (nonatomic, assign) id icon;
@property (nonatomic, strong) NSString *reciveIsDel;
@property (nonatomic, strong) NSString *isShield;
@property (nonatomic, strong) NSString *sendIsDel;
@property (nonatomic, strong) NSString *content;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
