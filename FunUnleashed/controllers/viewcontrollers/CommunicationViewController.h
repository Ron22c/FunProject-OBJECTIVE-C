//
//  CommunicationViewController.h
//  FunUnleashed
//
//  Created by Ranajit Chandra on 15/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommunicationViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,
                                            MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@end

NS_ASSUME_NONNULL_END
