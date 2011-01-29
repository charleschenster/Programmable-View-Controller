//
//  ProgrammableAppDelegate.h
//  Programmable
//
//  Created by Charles Chen on 1/26/11.
//  Copyright Stanford University 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProgrammableViewController;

@interface ProgrammableAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ProgrammableViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ProgrammableViewController *viewController;

@end

