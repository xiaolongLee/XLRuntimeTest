//
//  NSObject+XLKeyValues.h
//  XLRuntimeTest
//
//  Created by Mac-Qke on 2019/7/12.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ModelDelegate <NSObject>
// 用在三级数组转换
+(NSDictionary *)arrayContainModelClass;


@end


@interface NSObject (XLKeyValues)
/** 字典转模型 **/
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
