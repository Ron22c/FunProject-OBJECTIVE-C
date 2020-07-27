#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PokktModels.h"


@class PokktNativeAd;

@protocol PokktAdDelegate <NSObject>

@optional
- (void)adCachingResult:(NSString *)screenId isSuccess:(BOOL)success withReward:(double)reward errorMessage:(NSString *)errorMessage;
- (void)adDisplayResult:(NSString *)screenId isSuccess:(BOOL)success errorMessage:(NSString *)errorMessage;
- (void)adClosed:(NSString *)screenId adCompleted:(BOOL)adCompleted;
- (void)adClicked:(NSString *)screenId;
- (void)adGratified:(NSString *)screenId withReward:(double)reward;

- (void)adReady:(NSString *)screenId withNativeAd:(PokktNativeAd *)pokktNativeAd;
- (void)adFailed:(NSString *)screenId error:(NSString *)errorMessage;

@end


@interface PokktNativeAd : NSObject

- (UIView *)getMediaView;
- (void)dismiss;

// internal for pokkt sdk
- (instancetype)initWithAd:(id)ad;
- (id)getAd;

@end


@interface PokktConsentInfo : NSObject

@property (nonatomic) BOOL isGDPRApplicable;
@property (nonatomic) BOOL isGDPRConsentAvailable;

@end


@interface PokktAds : NSObject

+ (void)setPokktConfigWithAppId:(NSString *)appId securityKey:(NSString *)securityKey;

+ (BOOL)isAdCached:(NSString *)screenId;
+ (void)cacheAd:(NSString *)screenId withDelegate:(id<PokktAdDelegate>)delegate;

+ (void)showAd:(NSString *)screenId withDelegate:(id<PokktAdDelegate>)delegate presentingVC:(UIViewController *)viewController;
+ (void)showAd:(NSString *)screenId withDelegate:(id<PokktAdDelegate>)delegate inContainer:(UIView *)adContainer;

+ (void)requestNativeAd:(NSString *)screenId withDelegate:(id<PokktAdDelegate>)delegate;
+ (void)dismissAd:(NSString *)screenId;

+ (void)setPokktConsentInfo:(PokktConsentInfo *)consentObject;
+ (PokktConsentInfo *)getPokktConsentInfo;


+ (NSString *)getSDKVersion;
+ (void)setThirdPartyUserId:(NSString *)userId;
+ (void)setCallbackExtraParam:(NSDictionary *)extraParam;
+ (void)setUserDetails:(PokktUserInfo *)userInfo;
+ (void)setPokktAdPlayerViewConfig:(PokktAdPlayerViewConfig *)adPlayerViewConfig;

@end


@interface PokktDebugger : NSObject

+ (BOOL)isDebugEnabled;
+ (void)setDebug:(BOOL)isDebug;
+ (void)printLog:(NSString *)message;
+ (void)showToast:(NSString *)message
   viewController:(UIViewController *)viewController;

@end
