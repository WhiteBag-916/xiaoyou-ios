//
//  FindMyCourseModel.m
//
//  Created by   on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FindMyCourseModel.h"
#import "CourseTeacherlist.h"


NSString *const kFindMyCourseModelCourseYear = @"courseYear";
NSString *const kFindMyCourseModelCourseSemester = @"courseSemester";
NSString *const kFindMyCourseModelCourseName = @"courseName";
NSString *const kFindMyCourseModelCourseCode = @"courseCode";
NSString *const kFindMyCourseModelSchoolCode = @"schoolCode";
NSString *const kFindMyCourseModelCourseTeacherlist = @"courseTeacherlist";


@interface FindMyCourseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FindMyCourseModel

@synthesize courseYear = _courseYear;
@synthesize courseSemester = _courseSemester;
@synthesize courseName = _courseName;
@synthesize courseCode = _courseCode;
@synthesize schoolCode = _schoolCode;
@synthesize courseTeacherlist = _courseTeacherlist;


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
            self.courseYear = [self objectOrNilForKey:kFindMyCourseModelCourseYear fromDictionary:dict];
            self.courseSemester = [self objectOrNilForKey:kFindMyCourseModelCourseSemester fromDictionary:dict];
            self.courseName = [self objectOrNilForKey:kFindMyCourseModelCourseName fromDictionary:dict];
            self.courseCode = [self objectOrNilForKey:kFindMyCourseModelCourseCode fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kFindMyCourseModelSchoolCode fromDictionary:dict];
    NSObject *receivedCourseTeacherlist = [dict objectForKey:kFindMyCourseModelCourseTeacherlist];
    NSMutableArray *parsedCourseTeacherlist = [NSMutableArray array];
    if ([receivedCourseTeacherlist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCourseTeacherlist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCourseTeacherlist addObject:[CourseTeacherlist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCourseTeacherlist isKindOfClass:[NSDictionary class]]) {
       [parsedCourseTeacherlist addObject:[CourseTeacherlist modelObjectWithDictionary:(NSDictionary *)receivedCourseTeacherlist]];
    }

    self.courseTeacherlist = [NSArray arrayWithArray:parsedCourseTeacherlist];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.courseYear forKey:kFindMyCourseModelCourseYear];
    [mutableDict setValue:self.courseSemester forKey:kFindMyCourseModelCourseSemester];
    [mutableDict setValue:self.courseName forKey:kFindMyCourseModelCourseName];
    [mutableDict setValue:self.courseCode forKey:kFindMyCourseModelCourseCode];
    [mutableDict setValue:self.schoolCode forKey:kFindMyCourseModelSchoolCode];
    NSMutableArray *tempArrayForCourseTeacherlist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.courseTeacherlist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCourseTeacherlist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCourseTeacherlist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCourseTeacherlist] forKey:kFindMyCourseModelCourseTeacherlist];

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

    self.courseYear = [aDecoder decodeObjectForKey:kFindMyCourseModelCourseYear];
    self.courseSemester = [aDecoder decodeObjectForKey:kFindMyCourseModelCourseSemester];
    self.courseName = [aDecoder decodeObjectForKey:kFindMyCourseModelCourseName];
    self.courseCode = [aDecoder decodeObjectForKey:kFindMyCourseModelCourseCode];
    self.schoolCode = [aDecoder decodeObjectForKey:kFindMyCourseModelSchoolCode];
    self.courseTeacherlist = [aDecoder decodeObjectForKey:kFindMyCourseModelCourseTeacherlist];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_courseYear forKey:kFindMyCourseModelCourseYear];
    [aCoder encodeObject:_courseSemester forKey:kFindMyCourseModelCourseSemester];
    [aCoder encodeObject:_courseName forKey:kFindMyCourseModelCourseName];
    [aCoder encodeObject:_courseCode forKey:kFindMyCourseModelCourseCode];
    [aCoder encodeObject:_schoolCode forKey:kFindMyCourseModelSchoolCode];
    [aCoder encodeObject:_courseTeacherlist forKey:kFindMyCourseModelCourseTeacherlist];
}

- (id)copyWithZone:(NSZone *)zone
{
    FindMyCourseModel *copy = [[FindMyCourseModel alloc] init];
    
    if (copy) {

        copy.courseYear = [self.courseYear copyWithZone:zone];
        copy.courseSemester = [self.courseSemester copyWithZone:zone];
        copy.courseName = [self.courseName copyWithZone:zone];
        copy.courseCode = [self.courseCode copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.courseTeacherlist = [self.courseTeacherlist copyWithZone:zone];
    }
    
    return copy;
}


@end
