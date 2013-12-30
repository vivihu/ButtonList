//
//  MainViewController.h
//  HWWButtonList
//
//  Created by icreative-mini on 13-12-24.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonList.h"

@interface MainViewController : UIViewController<HWWButtonListDelegate>

- (IBAction)showButtonList:(UIButton *)sender;

@end
