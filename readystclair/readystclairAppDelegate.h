//
//  readystclairAppDelegate.h
//  readystclair
//
//  Created by james whetsell on 1/16/12.
//  Copyright 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface readystclairAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
