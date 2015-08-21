//
//  YDirectory+Data.h
//  Model
//
//  Created by 熊宸 on 15/5/7.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YDirectory.h"

//缓存文件文件夹名
#define kFileCache             @"/FileCache/"
//缓存图片
#define kImgCache             @"/ImgCache/"

@interface YDirectory (Data)

/*********************************************************************
 函数名称 : fileCache
 函数描述 : 文件路径
 参数 : N/A
 返回值 : 路径
 作者 : XiongChen
 *********************************************************************/
+ (NSString *)fileCache;

/*********************************************************************
 函数名称 : newProjectCache
 函数描述 : 文件路径
 参数 : N/A
 返回值 : 路径
 作者 : XiongChen
 *********************************************************************/
+ (NSString *)newProjectCache;

/**
 *  @author xiongchen
 *
 *  创建文件夹
 *
 *  @param
 *
 *  @return
 */
+ (void)createFolders;

/**
 *  @author xiongchen
 *
 *  从json文件取数据
 *
 *  @param filePath 文件路径
 *
 *  @return 数组
 */
+ (instancetype)dataByJson:(NSString *)filePath type:(NSString *)fileType;

@end
