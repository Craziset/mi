//
//  LBClearCacheTool.m
//  clearTest
//
//  Created by li  bo on 16/5/29.
//  Copyright © 2016年 li  bo. All rights reserved.
//

#import "LBClearCacheTool.h"

#define fileManager [NSFileManager defaultManager]

@implementation LBClearCacheTool
-(float)clearCache
{
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSFileManager*filemanager=[NSFileManager defaultManager];
    float folderSize;
    if ([filemanager fileExistsAtPath:path]) {
        //拿到有文件的数组
        NSArray*ChildFile=[filemanager subpathsAtPath:path];
        //拿到每个文件的名字，如果不想清除的文件在这里判断
        for (NSString *fileNaem  in  ChildFile) {
            //将路径拼接一起
            NSString*fullPath=[path stringByAppendingPathComponent:fileNaem];
            folderSize+=[self fileSizePath:fullPath];
        }
    }
    return folderSize;//总文件的大小
}
//计算文件的大小
-(float)fileSizePath:(NSString*)path
{
    NSFileManager *fileManage=[NSFileManager defaultManager];
    if ([fileManage fileExistsAtPath:path]) {
        long long size=[fileManage attributesOfItemAtPath:path error:nil].fileSize;
       
        return size/1024.0/1024.0;
    }
    return 0;
}
-(void)removeChace
{
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSFileManager*filemanager=[NSFileManager defaultManager];
   
    if ([filemanager fileExistsAtPath:path]) {
        //拿到有文件的数组
        NSArray*ChildFiles=[filemanager subpathsAtPath:path];
        //拿到每个文件的名字，如果不想清除的文件在这里判断
        for (NSString *fileNaeme  in  ChildFiles) {
            //将路径拼接一起
            NSString*absoluePath=[path stringByAppendingPathComponent:fileNaeme];
            [filemanager removeItemAtPath:absoluePath error:nil];
        }
    }

    

}


@end
