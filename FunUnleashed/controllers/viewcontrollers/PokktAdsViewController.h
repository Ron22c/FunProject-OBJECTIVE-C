//
//  PokktAdsViewController.h
//  FunUnleashed
//
//  Created by Ranajit Chandra on 16/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PokktSDK/PokktSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface PokktAdsViewController : UIViewController<PokktAdDelegate>

@end

@interface BannerDelegate : NSObject<PokktAdDelegate>

@end

NS_ASSUME_NONNULL_END
