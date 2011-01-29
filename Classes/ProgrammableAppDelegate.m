//
//  ProgrammableAppDelegate.m
//  Programmable
//
//  Created by Charles Chen on 1/26/11.
//  Copyright Stanford University 2011. All rights reserved.
//

#import "ProgrammableAppDelegate.h"
#import "ProgrammableViewController.h"
#import <Three20/Three20.h>

@implementation ProgrammableAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    TTNavigator* navigator = [TTNavigator navigator];
	navigator.window = window;
	
	//TTURLMap* map = navigator.URLMap;
	//[map          from:@"action://progview/(buttonPressed:)"
	//  toViewController:[ProgViewController class]];
	
	
	
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
