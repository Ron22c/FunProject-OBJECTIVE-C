//
//  main.m
//  FunUnleashed
//
//  Created by Ranajit Chandra on 13/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        if (@available(iOS 10.0, *)) {
            appDelegateClassName = NSStringFromClass([AppDelegate class]);
        } else {
            // Fallback on earlier versions
        }
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
