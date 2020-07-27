//
//  AppDelegate.h
//  FunUnleashed
//
//  Created by Ranajit Chandra on 13/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

API_AVAILABLE(ios(10.0))
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) UIWindow * window;

- (void)saveContext;


@end
