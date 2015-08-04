//
//  CheckAccountModel.h
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CheckAccountModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *mobileBindMessage;
@property (nonatomic, assign) BOOL mobileBindFlg;
@property (nonatomic, strong) NSString *accountCheckMessage;
@property (nonatomic, assign) BOOL accountCheckFlg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
