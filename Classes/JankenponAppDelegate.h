//
//  JankenponAppDelegate.h
//  Jankenpon
//
//  Created by Chase Colburn on 1/8/11.
//  Copyright 2011 Clever Monkey Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface JankenponAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;

@end

