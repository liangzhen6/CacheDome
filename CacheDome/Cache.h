//
//  Cache.h
//  CacheDome
//
//  Created by shenzhenshihua on 2017/5/8.
//  Copyright © 2017年 shenzhenshihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cache : NSObject

+ (id)shareCache; ///< 最好使用单利

- (id)readWithPathString:(NSString *)string;
- (BOOL)writeID:(id)objects pathString:(NSString *)string;

@end
