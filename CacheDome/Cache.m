//
//  Cache.m
//  CacheDome
//
//  Created by shenzhenshihua on 2017/5/8.
//  Copyright © 2017年 shenzhenshihua. All rights reserved.
//

#import "Cache.h"

@implementation Cache

+ (id)shareCache {
    static Cache * cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[Cache alloc] init];
    });
    return cache;
}

- (NSString *)returnThePath:(NSString *)str{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:str];
    return path;
}

- (BOOL)writeID:(id)objects pathString:(NSString *)string{
    
    NSString * path = [self returnThePath:string];
    BOOL result = [NSKeyedArchiver archiveRootObject:objects toFile:path];
    return result;
}

- (id)readWithPathString:(NSString *)string{
    
    NSString * path = [self returnThePath:string];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

@end
