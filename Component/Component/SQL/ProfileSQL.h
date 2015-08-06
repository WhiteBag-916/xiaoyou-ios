//
//  ProfileSQL.h
//  Component
//
//  Created by 熊宸 on 15/8/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#ifndef Component_ProfileSQL_h
#define Component_ProfileSQL_h

#define kDB_Profile_TableName @"Profile"

#define kSQL_Profile_TableCreate @"CREATE TABLE Profile (_ID INTEGER primary key autoincrement,updateTime TEXT,isDelete TEXT,dataIdentifier TEXT,roleType TEXT,discussNum TEXT,isClear TEXT,cacheTime TEXT,delReason TEXT,credit TEXT,progressType TEXT,isProject TEXT,dataDescription TEXT,descriptionShort TEXT,stateId TEXT,isOpen TEXT,openCanvas TEXT,regTime TEXT,investType TEXT,badNum TEXT,goodNum TEXT,projectAdvantage TEXT,stepNum TEXT,tuijianTime TEXT,industryType TEXT,investment TEXT,partnerRepay TEXT,adminDelete TEXT,followNums TEXT,partnerDuty TEXT,name TEXT,totalNum TEXT,oldId TEXT,advantage TEXT,username TEXT,partTime TEXT,sDescription TEXT,lastLogin TEXT,viewCount TEXT,cashType TEXT,marketPosition TEXT,ownerId TEXT,cityId TEXT,nowTeam TEXT,title TEXT,isTuijian TEXT,imagePath TEXT,coopMode TEXT,roleTypeStr TEXT,fullTime TEXT)"

#endif
