//
//  FileUtil.m
//  three20test
//
//  Created by qqn_pipi on 10-3-23.
//  Copyright 2010 QQN-PIPI.com. All rights reserved.
//

#import "FileUtil.h"
#import "TMLogUtil.h"



#include <sys/stat.h>
#include <dirent.h>

@implementation FileUtil

+ (BOOL)createDir:(NSString*)fullPath
{
    
    // Check if the directory already exists
    if (![[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
        
        // Directory does not exist so create it
        TMLog(@"create dir = %@", fullPath);

        NSError* error = nil;
        BOOL result = [[NSFileManager defaultManager] createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (result == NO){
            NSLog(@"create dir (%@) but error (%@)", fullPath, [error description]);
        }        
        
        return result;
    }
    else{
        return YES;
    }
}

+ (NSString*)getAppHomeDir
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [paths objectAtIndex:0];
	
	return documentDir;
}

+ (NSString*)getAppDocumentDir
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [paths objectAtIndex:0];
	
	return documentDir;
}


+ (NSString*)getAppCacheDir
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *retDir = [paths objectAtIndex:0];
	
	return retDir;    
}

+ (NSString *)filePathInAppDocument:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *retDir = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    return retDir;
}

+ (NSURL *)fileURLInAppDocument:(NSString *)fileName{
	NSURL *url = [NSURL fileURLWithPath:[self filePathInAppDocument:fileName]];
	return url;
}

+ (NSString*)getAppTempDir
{	
	return NSTemporaryDirectory();
}

//+ (NSString*)generateTempFileInTempDir
//{
//    NSString* tempFile = [NSString GetUUID];
//    return [NSTemporaryDirectory() stringByAppendingPathComponent:tempFile];
//}

+ (NSString*)getFileFullPath:(NSString*)fileName
{
	return [[FileUtil getAppHomeDir] stringByAppendingPathComponent:fileName];
}

// find database file in given databasePath, and copy it to Document directory as initialize DB
+ (BOOL) copyFileFromBundleToAppDir:(NSString *)bundleResourceFile appDir:(NSString *)appDir overwrite:(BOOL)overwrite
{
	BOOL success = NO;
	
	// init file manager
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// init path
	NSString* bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundleResourceFile];
//	NSString* appPath = [NSString stringWithFormat:@"%@/%@", appDir, bundleResourceFile];
    NSString *appPath = [appDir stringByAppendingPathComponent:bundleResourceFile];
	    
	// check if file exist to app directory
	success = [fileManager fileExistsAtPath:appPath];
	if (success) {
//		NSLog(@"<copyFileFromBundleToAppDir> targeted file (%@) exists", appPath);
	}
	
	if (overwrite == NO && success == YES){
//		NSLog(@"<copyFileFromBundleToAppDir> don't overwrite, return");
		return YES;
	}
	
	// now copy to file
    NSError* error = nil;
	if ((success = [fileManager copyItemAtPath:bundlePath toPath:appPath error:nil]) == YES)
		NSLog(@"<copyFileFromBundleToAppDir> copy file from %@ to %@ successfully", bundlePath, appPath);
	else {
		NSLog(@"<copyFileFromBundleToAppDir> copy file from %@ to %@ failure, error=%@", bundlePath, appPath, [error description]);
	}
	return success;
}

+ (NSURL*)bundleURL:(NSString*)filename
{
    if (filename == nil)
        return nil;
    
	NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",filename]];
	NSURL* url = [NSURL fileURLWithPath:path];	    
    return url;
}

+ (NSString*)getFileNameByFullPath:(NSString *)path
{
    NSArray* stringArray = [path componentsSeparatedByString:@"/"];
    if (stringArray.count > 1) {
        return (NSString*)[stringArray objectAtIndex:(stringArray.count-1)];
    }
    return path;
}

+ (BOOL)removeFile:(NSString *)fullPath
{
    if ([fullPath length] == 0){
        TMLog(@"<removeFile> but %@ is nil or empty", fullPath);
        return NO;
    }
    
    TMLog(@"<removeFile> %@", fullPath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:fullPath error:nil];
}

+ (NSInteger)numberOfFilesBelowDir:(NSString *)fullDirPath
{
    if ([fullDirPath length] == 0) {
        TMLog(@"warnning<numberOfFilesBelowDir>: parameter is illegal,dir = %@",fullDirPath);
        return 0;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    if ([fileManager fileExistsAtPath:fullDirPath isDirectory:&isDir]) {
        if (!isDir) {
            TMLog(@"warnning:<numberOfFilesBelowDir> %@ is not a directory",fullDirPath);
            return 0;
        }
        //delete the files.
        NSArray *fileList = [fileManager contentsOfDirectoryAtPath:fullDirPath error:nil];
        return [fileList count];
    }
    TMLog(@"warnning:<numberOfFilesBelowDir> %@  not exists!",fullDirPath);
    return NO;

}

+ (BOOL)removeFilesBelowDir:(NSString *)fullDirPath 
           timeIntervalSinceNow:(NSTimeInterval)timeInterval
{
    if ([fullDirPath length] == 0) {
        TMLog(@"warnning<removeFilesBelowDir>: parameter is illegal,dir = %@, date = %f",fullDirPath, timeInterval);
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    if ([fileManager fileExistsAtPath:fullDirPath isDirectory:&isDir]) {
        if (!isDir) {
            TMLog(@"warnning:<removeFilesBelowDir> %@ is not a directory",fullDirPath);
            return NO;
        }
        //delete the files.
        NSArray *fileList = [fileManager contentsOfDirectoryAtPath:fullDirPath error:nil];
        for (NSString *file in fileList) {
            NSString *filePath = [fullDirPath stringByAppendingPathComponent:file];
            NSDictionary *attr = [fileManager attributesOfItemAtPath:filePath error:nil];
            if (attr) {
                NSDate *modifyDate = [attr objectForKey:NSFileModificationDate];
                NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:modifyDate];
                if (interval >= timeInterval) {
                    TMLog(@"remove the file = %@, modify date = %@", filePath,modifyDate);
                    [FileUtil removeFile:filePath];
                }
            }
        }
        return YES;
    }
    TMLog(@"warnning:<removeFilesBelowDir> %@  not exists!",fullDirPath);
    return NO;
}

+ (NSArray *)fileNameListBelowDir:(NSString *)dirPath suffix:(NSString *)suffix
{
    NSString *fullDirPath = dirPath;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    if ([fileManager fileExistsAtPath:fullDirPath isDirectory:&isDir]) {
        if (!isDir) {
            TMLog(@"warnning:<removeFilesBelowDir> %@ is not a directory",fullDirPath);
            return nil;
        }
        //delete the files.
        NSArray *fileList = [fileManager contentsOfDirectoryAtPath:fullDirPath error:nil];
        NSMutableArray *list = [NSMutableArray array];
        for (NSString *file in fileList) {
            
            if (suffix != nil && ![file hasSuffix:suffix]) {
                continue;
            }else{
                [list addObject:file];
            }
        }
        return list;
    }
    return nil;
}

#define KEY_FILE_VERSION(fileName)  [NSString stringWithFormat:@"%@_version", fileName]

//+ (void)unzipFile:(NSString *)zipFileName
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    BOOL hasUnzip = [userDefaults boolForKey:zipFileName];
//    
//    // set path to cache path to avoid the data is backup by iCloud
//    NSString* destPath = [FileUtil getAppCacheDir];
//    NSString *zipFilePath = [destPath stringByAppendingPathComponent:zipFileName];
//    BOOL isFileExist = [[NSFileManager defaultManager] fileExistsAtPath:zipFilePath];
//
//    NSString *lastversion = [userDefaults stringForKey:KEY_FILE_VERSION(zipFileName)];
//    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//    
//    if (hasUnzip && [lastversion isEqualToString:currentVersion] && isFileExist == NO){
//        PPDebug(@"<FileUtil> already unzip file %@, skip", zipFileName);
//        return ;
//    }
//    
//    [FileUtil copyFileFromBundleToAppDir:zipFileName
//                                  appDir:destPath
//                               overwrite:YES];        
//    
//    PPDebug(@"<FileUtil> start unzip %@", zipFileName);
//    if ([SSZipArchive unzipFileAtPath:zipFilePath
//                        toDestination:destPath
//                            overwrite:YES
//                             password:nil
//                                error:nil]) {
//        PPDebug(@"<FileUtil> unzip %@ successfully", zipFileName);
//        [userDefaults setBool:YES forKey:zipFileName];
//    } else {
//        PPDebug(@"<FileUtil> unzip %@ fail", zipFileName);
//        [userDefaults setBool:NO forKey:zipFileName];
//    }
//    
//    [userDefaults setValue:currentVersion forKey:KEY_FILE_VERSION(zipFileName)];    
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // delete files after it's unzip
//        [FileUtil removeFile:zipFilePath];
//    });
//    
//    return;
//    
//}

+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        long long fileSize =  [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        return fileSize;
    }
    return 0;
}

+ (long long)clearOnlyFilesAtPath:(NSString*) folderPath{
//    NSFileManager* manager = [NSFileManager defaultManager];
//    if (![manager fileExistsAtPath:folderPath]) return 0;
//    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
//    NSString* fileName;
//    long long folderSize = 0;
//    while ((fileName = [childFilesEnumerator nextObject]) != nil){
//        BOOL isDirectory;
//        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
//        if ([manager fileExistsAtPath:fileAbsolutePath isDirectory:&isDirectory] && !isDirectory) {
//            folderSize += [self fileSizeAtPath:fileAbsolutePath];
//            
//            [FileUtil removeFile:fileAbsolutePath];
//        } else {
//            PPDebug(@"<FileUtil> keep directory -- %@", fileAbsolutePath);
//        }
//        
//    }
//    return folderSize;
    return [self clearFolderAtPath:[folderPath cStringUsingEncoding:NSUTF8StringEncoding]];
}

//+ (long long) folderSizeAtPath3:(NSString*) folderPath{
//    return [self _folderSizeAtPath:[folderPath cStringUsingEncoding:NSUTF8StringEncoding]];
//}

+ (long long)clearFolderAtPath: (const char*)folderPath{
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) return 0;
    struct dirent* child;
    while ((child = readdir(dir))!=NULL) {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        )) continue;
        
        u_long folderPathLength = strlen(folderPath);
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/'){
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR){ // directory
            folderSize += [self clearFolderAtPath:childPath]; // 递归调用子目录
            // 把目录本身所占的空间也加上
//            struct stat st;
//            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }else if (child->d_type == DT_REG || child->d_type == DT_LNK){ // file or link
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
            remove(childPath);
        }
    }
    return folderSize;
}

/*
+ (void)unzipFile:(NSString *)zipFileName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL hasUnzip = [userDefaults boolForKey:zipFileName];
    
    NSString *lastversion = [userDefaults stringForKey:KEY_FILE_VERSION(zipFileName)];
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    if (hasUnzip && [lastversion isEqualToString:currentVersion]) {
        PPDebug(@"<FileUtil> already unzip file %@, skip", zipFileName);
        return ;
    }
    
    [FileUtil copyFileFromBundleToAppDir:zipFileName
                                  appDir:[self getAppHomeDir]
                               overwrite:YES];
    
    NSString *zipFilePath = [[FileUtil getAppHomeDir] stringByAppendingPathComponent:zipFileName];
    
    PPDebug(@"<FileUtil> start unzip %@", zipFileName);
    if ([SSZipArchive unzipFileAtPath:zipFilePath 
                        toDestination:[FileUtil getAppHomeDir] 
                            overwrite:YES 
                             password:nil 
                                error:nil]) {
        PPDebug(@"<FileUtil> unzip %@ successfully", zipFileName);
        [userDefaults setBool:YES forKey:zipFileName];
    } else {
        PPDebug(@"<FileUtil> unzip %@ fail", zipFileName);
        [userDefaults setBool:NO forKey:zipFileName];
    }
    
    [userDefaults setValue:currentVersion forKey:KEY_FILE_VERSION(zipFileName)];
    
    return;
}
 */


//计算文件夹下文件的总大小
+ (long long)fileSizeForDir:(NSString*)path
{
    long long size = 0;
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            size += fileAttributeDic.fileSize;
        }
        else
        {
            size += [self fileSizeForDir:fullPath];
        }
    }
    return size;
}

+ (BOOL)isPathExist:(NSString*)path
{
    BOOL isDir;
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    TMLog(@"<isPathExist> path(%@) isDir(%d) exist(%d)", path, isDir, exist);
    return exist;
}

@end
