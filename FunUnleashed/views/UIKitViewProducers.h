//
//  UIKitViewProducers.h
//  FunUnleashed
//
//  Created by Ranajit Chandra on 13/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIKitViewProducers : NSObject

+ (UIButton *)getBrowser:(SEL)methodSelector
          withController:(UIViewController *)controller
                position:(CGRect)position
                    name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
