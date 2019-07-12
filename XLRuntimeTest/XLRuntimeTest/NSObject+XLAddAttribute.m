//
//  NSObject+XLAddAttribute.m
//  XLRuntimeTest
//
//  Created by Mac-Qke on 2019/7/12.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "NSObject+XLAddAttribute.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation NSObject (XLAddAttribute)
//2 动态添加属性
- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, @"name",name , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (NSString *)name{
    return objc_getAssociatedObject(self, @"name");
}
@end
