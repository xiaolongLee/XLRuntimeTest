//
//  Person.m
//  XLRuntimeTest
//
//  Created by Mac-Qke on 2019/7/12.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "Person.h"

@implementation Person
+ (void)coding{
    NSLog(@"%s",__func__);
}

- (void)coding{
    NSLog(@"%s",__func__);
}
- (NSString *)eating{
    return @"eating";
}
- (NSString *)changeMethod{
    return @"changeMethod";
}
@end
