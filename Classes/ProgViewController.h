//
//  ProgViewController.h
//  Programmable
//
//  Created by Charles Chen on 1/27/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgrammableViewController.h"
#import "asi/ASIHTTPRequest.h"

@class ProgrammableViewController;

@interface ProgViewController : UIViewController <UIActionSheetDelegate>{
	UIActionSheet *action;
	UIActionSheet *action2;
	ASIHTTPRequest *requestjson;
	ASIHTTPRequest *requesthash;
	//NSData *responseData;
	NSString *responseString;
	NSString *urlstringjson;
	NSString *urlstringhash;
	NSData *responseDataHashes;
	NSDictionary *dictionary;
	NSMutableArray *arrayButton;
	NSMutableArray *arrayButtonDict;
	NSMutableArray *arrayASI;
	NSMutableArray *arrayASIfinished;
	BOOL ready;
	BOOL reload;
	
	ProgrammableViewController *progViewController;
}

- (void) check_ready;

@property (nonatomic,assign) ProgrammableViewController *progViewController;
@property(nonatomic) BOOL ready;
@property(nonatomic, retain) NSDictionary *dictionary;
@end
