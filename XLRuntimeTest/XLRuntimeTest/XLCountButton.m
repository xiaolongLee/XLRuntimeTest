//
//  XLCountButton.m
//  XLRuntimeTest
//
//  Created by Mac-Qke on 2019/7/12.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "XLCountButton.h"
#import <objc/runtime.h>
@implementation XLCountButton

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oriMethod = class_getInstanceMethod(self.class, @selector(sendAction:to:forEvent:));
        Method curMethod = class_getInstanceMethod(self.class, @selector(customSendAction:to:forEvent:));
        // 判断自定义的方法是否实现, 避免崩溃
        BOOL addSucess = class_addMethod(self.class, @selector(sendAction:to:forEvent:), method_getImplementation(curMethod), method_getTypeEncoding(curMethod));
        if (!addSucess) {
            // 没有实现, 将源方法的实现替换到交换方法的实现
            class_replaceMethod(self.class, @selector(customSendAction:to:forEvent:), method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else{
              // 已经实现, 直接交换方法
            method_exchangeImplementations(oriMethod, curMethod);
        }
        
        
    });
}

- (void)customSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    _count = [[XLClickCount sharedInstance] clickCount];
    [self customSendAction:action to:target forEvent:event];
}

@end


@interface XLClickCount ()

@property (nonatomic, assign) NSInteger count;

@end

@implementation XLClickCount

+ (instancetype)sharedInstance {
    static XLClickCount *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

- (NSInteger)clickCount {
    ++_count;
    NSLog(@"点击了 %ld次", _count);
    return _count;
}

@end
