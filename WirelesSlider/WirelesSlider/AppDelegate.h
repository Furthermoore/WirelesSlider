//
//  AppDelegate.h
//  WirelesSlider
//
//  Created by Dan Moore on 4/8/14.
//  Copyright (c) 2014 Dan Moore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPCHandler.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// global multipeer object
@property (strong, nonatomic) MPCHandler *mpcHandler;

@end
