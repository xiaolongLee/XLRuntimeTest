//
//  Person.h
//  XLRuntimeTest
//
//  Created by Mac-Qke on 2019/7/12.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic,copy) NSString *name;
+ (void)coding;
- (void)coding;
- (NSString *)eating;
- (NSString *)changeMethod;
@end

NS_ASSUME_NONNULL_END
