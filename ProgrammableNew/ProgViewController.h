//
//  ProgViewController.h
//  Programmable
//
//  Created by Charles Chen on 1/27/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Pulse_NewsViewController.h"
//#import "NewsRackController.h"
//#import "TileDragRefreshView.h"
#import "ASIHTTPRequest.h"

//@class Pulse_NewsViewController;

@interface ProgViewController : UIViewController <UIActionSheetDelegate>{
	UIActionSheet *action;
	UIActionSheet *action2;
	ASIHTTPRequest *requestjson;
	ASIHTTPRequest *requesthash;
	//NSData *responseData;
	NSString *responseString;
	NSString *urlstringjson;
	NSString *urlstringhash;
	NSString *progViewEndPoint;
	NSData *responseDataHashes;
	NSDictionary *dictionary;
	NSMutableArray *arrayButton;
	NSMutableArray *arrayButtonDict;
	NSMutableArray *arrayASI;
	NSMutableArray *arrayASIfinished;
	BOOL ready;
	BOOL reload;
	
	UIView *progVC;
}

- (void) check_ready;

@property (nonatomic,assign) UIView *progVC;
@property(nonatomic) BOOL ready;
@property(nonatomic, retain) NSDictionary *dictionary;
@end
