//
//  XLCountButton.h
//  XLRuntimeTest
//
//  Created by Mac-Qke on 2019/7/12.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLCountButton : UIButton

@property (nonatomic, assign) NSInteger count;
@end

@interface XLClickCount : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)clickCount;

@end


NS_ASSUME_NONNULL_END
