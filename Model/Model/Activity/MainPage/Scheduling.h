//
//  Scheduling.h
//
//  Created by sheng  on 15/11/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Scheduling : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double startTime;
@property (nonatomic, assign) double schedulingIdentifier;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, assign) double endTime;
@property (nonatomic, strong) NSString *type;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
