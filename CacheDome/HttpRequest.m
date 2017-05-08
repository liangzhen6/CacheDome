//
//  HttpRequest.m
//  CacheDome
//
//  Created by shenzhenshihua on 2017/5/8.
//  Copyright © 2017年 shenzhenshihua. All rights reserved.
//

#import "HttpRequest.h"
#import <AFNetworking.h>
#import "Cache.h"
#import <CommonCrypto/CommonDigest.h>

@interface HttpRequest ()

@end

@implementation HttpRequest

+ (id)shareHttpResquest {
    static HttpRequest * request;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[HttpRequest alloc] init];
    });
    return request;
}

/**
 MD5将路径转化为字符串
 */
- (NSString *)md5To32bit:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr),digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}
- (NSString *)returnPathWithBaseUrlStr:(NSString *)base parameters:(NSDictionary *)parameters {
    NSMutableString * subString = [[NSMutableString alloc] init];
    NSArray * keyArr = [parameters allKeys];
    for (NSInteger i = 0; i < keyArr.count; i++) {
        NSString * title = [keyArr objectAtIndex:i];
        if (i==0 && [base rangeOfString:@"?"].location == NSNotFound) {
            [subString appendFormat:@"?%@=%@",title,[parameters objectForKey:title]];
        } else {
            [subString appendFormat:@"&%@=%@",title,[parameters objectForKey:title]];
        }
    }
    
    NSString * path = [[NSString stringWithFormat:@"%@%@",base,subString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [self md5To32bit:path];
}

- (void)GET:(NSString *)URLString parameters:(id)parameters cache:(BOOL)cache success:(successBlock)success failure:(failureBlock)failure {
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
   /*
    Cache * myCache = [Cache shareCache];
    NSString * cachePath = [self returnPathWithBaseUrlStr:URLString parameters:parameters];
    NSDictionary * dataDcit = [myCache readWithPathString:cachePath];
    if (cache && dataDcit) {
        parameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
        //将上一次服务器返回的时间戳加入到parameters，让服务器自己判断用不用更新数据，字段可以设置成lastModified
        
    }*/
    
    [manger GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            /*
            if (cache) {
                //这里需要处理服务器返回的状态码
                //1.如果已经是最新数居，直接把我们自己缓存的数据返回if
                success(dataDcit);
                //2.如果不是最新的数据服务器会返回最新的数据,；另外把数据缓存
                [myCache writeID:dict pathString:cachePath];
                success(dict);
                
            } else {
                success(dict);
            }*/
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

- (void)POST:(NSString *)URLString parameters:(id)parameters cache:(BOOL)cache success:(successBlock)success failure:(failureBlock)failure {
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    /*
    Cache * myCache = [Cache shareCache];
    NSString * cachePath = [self returnPathWithBaseUrlStr:URLString parameters:parameters];
    NSDictionary * dataDcit = [myCache readWithPathString:cachePath];
    if (cache && dataDcit) {
        parameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
        //将上一次服务器返回的时间戳加入到parameters，让服务器自己判断用不用更新数据，字段可以设置成lastModified
        
    }*/

    [manger POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            /*
             if (cache) {
             //这里需要处理服务器返回的状态码
             //1.如果已经是最新数居，直接把我们自己缓存的数据返回if
             success(dataDcit);
             //2.如果不是最新的数据服务器会返回最新的数据,；另外把数据缓存
             [myCache writeID:dict pathString:cachePath];
             success(dict);
             
             } else {
             success(dict);
             }*/
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
