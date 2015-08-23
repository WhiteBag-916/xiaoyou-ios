//
//  Tags.m
//
//  Created by   on 15/8/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Tags.h"


NSString *const kTagsName = @"name";
NSString *const kTagsEqual = @"equal";
NSString *const kTagsId = @"id";


@interface Tags ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Tags

@synthesize name = _name;
@synthesize equal = _equal;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;


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
            self.name = [self objectOrNilForKey:kTagsName fromDictionary:dict];
            self.equal = [[self objectOrNilForKey:kTagsEqual fromDictionary:dict] boolValue];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kTagsId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kTagsName];
    [mutableDict setValue:[NSNumber numberWithBool:self.equal] forKey:kTagsEqual];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kTagsId];

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

    self.name = [aDecoder decodeObjectForKey:kTagsName];
    self.equal = [aDecoder decodeBoolForKey:kTagsEqual];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kTagsId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kTagsName];
    [aCoder encodeBool:_equal forKey:kTagsEqual];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kTagsId];
}

- (id)copyWithZone:(NSZone *)zone
{
    Tags *copy = [[Tags alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.equal = self.equal;
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
    }
    
    return copy;
}


@end
