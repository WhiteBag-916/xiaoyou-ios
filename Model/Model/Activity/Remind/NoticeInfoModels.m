//
//  BaseClass.m
//
//  Created by sheng  on 15/10/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NoticeInfoModels.h"
#import "NoticeInfo.h"


NSString *const kBaseClassMessage = @"message";
NSString *const kBaseClassObj = @"obj";
NSString *const kBaseClassCode = @"code";


@interface NoticeInfoModels ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NoticeInfoModels

@synthesize message = _message;
@synthesize obj = _obj;
@synthesize code = _code;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.message = [self objectOrNilForKey:kBaseClassMessage fromDictionary:dict];
    NSObject *receivedObj = [dict objectForKey:kBaseClassObj];
    NSMutableArray *parsedObj = [NSMutableArray array];
    if ([receivedObj isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedObj) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedObj addObject:[NoticeInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedObj isKindOfClass:[NSDictionary class]]) {
       [parsedObj addObject:[NoticeInfo modelObjectWithDictionary:(NSDictionary *)receivedObj]];
    }

    self.obj = [NSArray arrayWithArray:parsedObj];
            self.code = [[self objectOrNilForKey:kBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kBaseClassMessage];
    NSMutableArray *tempArrayForObj = [NSMutableArray array];
    for (NSObject *subArrayObject in self.obj) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForObj addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForObj addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForObj] forKey:kBaseClassObj];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kBaseClassCode];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.message = [aDecoder decodeObjectForKey:kBaseClassMessage];
    self.obj = [aDecoder decodeObjectForKey:kBaseClassObj];
    self.code = [aDecoder decodeDoubleForKey:kBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kBaseClassMessage];
    [aCoder encodeObject:_obj forKey:kBaseClassObj];
    [aCoder encodeDouble:_code forKey:kBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    NoticeInfoModels *copy = [[NoticeInfoModels alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.obj = [self.obj copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
