//
//  CCUtility.h
//  FSToolBarDemo
//
//  Created by forget on 2020/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCUtility : NSObject

#pragma mark - ============================= 时间 =============================

/// 根据格式生成时间字符串
/// @param date 时间NSDate
/// @param formatStr 时间格式 eg:"YYYY-MM-dd HH:mm:ss"
+ (NSString *)stringFromDate:(NSDate *)date
                   formatStr:(NSString *)formatStr;

/// 根据格式生成NSDate
/// @param dateString 时间
/// @param formatStr 时间格式 eg:"YYYY-MM-dd HH:mm:ss"
+ (NSDate *)dateFromString:(NSString *)dateString
                 formatStr:(NSString *)formatStr;
/// 获取当前时间戳(秒)
+ (NSNumber *)getCurrentTimeStampSec;
/// 获取当前时间戳(毫秒)
+ (NSNumber *)getCurrentTimeStampMilliSec;

#pragma mark - ============================ 合法性 =============================

/// 判断手机号是否合法
/// @param mobile 手机号
+ (BOOL)isValidMobile:(NSString *)mobile;

/// 判断Url是否合法
/// @param urlStr 字符串url
+ (BOOL)isValidUrl:(NSString *)urlStr;

/// 判断银行卡是否合法
/// @param cardNumber 银行卡
+ (BOOL)isValidCardNo:(NSString *)cardNumber;

/// 判断身份证(中国大陆)身份证是否合法
/// @param value 身份证卡号
+ (BOOL)isValidIDCardNo:(NSString *)value;
@end

NS_ASSUME_NONNULL_END
