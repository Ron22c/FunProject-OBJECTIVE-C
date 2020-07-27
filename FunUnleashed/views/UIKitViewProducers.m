//
//  UIKitViewProducers.m
//  FunUnleashed
//
//  Created by Ranajit Chandra on 13/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "UIKitViewProducers.h"

@interface UIKitViewProducers ()

@end

@implementation UIKitViewProducers

+ (UIButton *)getBrowser:(SEL)methodSelector
          withController:(UIViewController *)controller
                position:(CGRect)position
                    name:(NSString *)name {
    UIButton *btn = [[UIButton alloc]
                     initWithFrame:CGRectMake(position.origin.x, position.origin.y, position.size.width, position.size.height)];

    [btn setTitle:name forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn addTarget:controller action:methodSelector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end
