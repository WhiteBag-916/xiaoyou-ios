//
//  ImageUploadModel.m
//
//  Created by   on 15/10/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ImageUploadModel.h"


NSString *const kImageUploadModelImages = @"images";
NSString *const kImageUploadModelSnapImages = @"snapImages";


@interface ImageUploadModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ImageUploadModel

@synthesize images = _images;
@synthesize snapImages = _snapImages;


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
            self.images = [self objectOrNilForKey:kImageUploadModelImages fromDictionary:dict];
            self.snapImages = [self objectOrNilForKey:kImageUploadModelSnapImages fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForImages = [NSMutableArray array];
    for (NSObject *subArrayObject in self.images) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImages addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImages addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImages] forKey:kImageUploadModelImages];
    NSMutableArray *tempArrayForSnapImages = [NSMutableArray array];
    for (NSObject *subArrayObject in self.snapImages) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSnapImages addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSnapImages addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSnapImages] forKey:kImageUploadModelSnapImages];

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

    self.images = [aDecoder decodeObjectForKey:kImageUploadModelImages];
    self.snapImages = [aDecoder decodeObjectForKey:kImageUploadModelSnapImages];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_images forKey:kImageUploadModelImages];
    [aCoder encodeObject:_snapImages forKey:kImageUploadModelSnapImages];
}

- (id)copyWithZone:(NSZone *)zone
{
    ImageUploadModel *copy = [[ImageUploadModel alloc] init];
    
    if (copy) {

        copy.images = [self.images copyWithZone:zone];
        copy.snapImages = [self.snapImages copyWithZone:zone];
    }
    
    return copy;
}


@end
