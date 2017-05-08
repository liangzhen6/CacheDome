//
//  HttpRequest.h
//  CacheDome
//
//  Created by shenzhenshihua on 2017/5/8.
//  Copyright © 2017年 shenzhenshihua. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successBlock)(id responseObject);
typedef void (^failureBlock)(NSError *error);

@interface HttpRequest : NSObject

+ (id)shareHttpResquest; ///< 初始化方法,尽量使用单利；

- (void)GET:(NSString *)URLString parameters:(id)parameters cache:(BOOL)cache success:(successBlock)success failure:(failureBlock)failure;

- (void)POST:(NSString *)URLString parameters:(id)parameters cache:(BOOL)cache success:(successBlock)success failure:(failureBlock)failure;

@end
