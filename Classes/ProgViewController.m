//
//  ProgViewController.m
//  Programmable
//
//  Created by Charles Chen on 1/27/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "ProgViewController.h"
#import "ProgrammableViewController.h"
#import "asi/ASIHTTPRequest.h"
#import <Three20/Three20.h>
//@class TTNavigator;
//@class TTURLMap;

@implementation ProgViewController
@synthesize progViewController;
@synthesize ready;
@synthesize dictionary;


- (void) loadView {
	TTNavigator* navigator = [TTNavigator navigator];
	
	TTURLMap* map = navigator.URLMap;
	[map          from:@"action://progview/(buttonAction:)"
	  toViewController:self];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *imageFilePath;
	
	NSDictionary *currentView = [self.dictionary objectForKey:@"view"];
	
	CGRect rect = CGRectMake([[currentView objectForKey:@"x"] intValue], 
							  [[currentView objectForKey:@"y"] intValue],
							  [[currentView objectForKey:@"xsize"] intValue], 
							  [[currentView objectForKey:@"ysize"] intValue]);

	self.view = [[UIView alloc] initWithFrame:rect];
	
	if ([currentView objectForKey:@"image"] != nil) {
		imageFilePath = [documentsDirectory stringByAppendingPathComponent:[currentView objectForKey:@"image"]];
		
		/*UIColor *background = [[UIColor alloc] initWithPatternImage:
		 [[UIImage imageWithContentsOfFile:imageFilePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0]];
		 */
		UIImage *bgimage = [[UIImage imageWithContentsOfFile:imageFilePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0];
		//[bgimage drawInRect:rect];
		
		UIImageView *bgimageview = [[UIImageView alloc] initWithImage:bgimage];
		[bgimageview setFrame:rect];
		
		[self.view addSubview:bgimageview];
	}
	
	NSLog(@"Loading View!");
	NSLog(@"View dimensions should be %d, %d, %d, %d", 
		  [[currentView objectForKey:@"x"] intValue], 
		  [[currentView objectForKey:@"y"] intValue],
		  [[currentView objectForKey:@"xsize"] intValue], 
		  [[currentView objectForKey:@"ysize"] intValue]);

	NSLog(@"Ready!");
	
	NSLog(@"Generating buttons");
	
	arrayButton = [NSMutableArray new];
	arrayButtonDict = [NSMutableArray new];
	NSArray *buttonKeys = [[self.dictionary objectForKey:@"button"] allKeys];
	NSDictionary *currentButton;
	
	NSArray *subviews = [[self.dictionary objectForKey:@"view"] objectForKey:@"subview"];
	
	for (int i = 0; i < subviews.count; i++) {
		NSLog(@"Generating view of type %@", [[subviews objectAtIndex:i] objectForKey:@"type"]);
		if ([[[subviews objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"button"]) {
			NSDictionary *currentButton = [subviews objectAtIndex:i];
			[arrayButton addObject:[UIButton buttonWithType:UIButtonTypeCustom]];
			NSLog(@"Button has x location %d", [[currentButton objectForKey:@"x"] intValue]);
			[[arrayButton objectAtIndex:arrayButton.count -1] setFrame:CGRectMake([[currentButton objectForKey:@"x"] intValue], [[currentButton objectForKey:@"y"] intValue], [[currentButton objectForKey:@"xsize"] intValue], [[currentButton objectForKey:@"ysize"] intValue])];
			
			if ([currentButton objectForKey:@"title"] != nil) {
				[[arrayButton objectAtIndex:arrayButton.count -1] setTitle:[currentButton objectForKey:@"title"] forState:UIControlStateNormal];
			}
			
			imageFilePath = [documentsDirectory stringByAppendingPathComponent:[currentButton objectForKey:@"image"]];
			if([fileManager fileExistsAtPath:imageFilePath])
			{
				[[arrayButton objectAtIndex:arrayButton.count -1] setBackgroundImage:[[UIImage imageWithContentsOfFile:imageFilePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
			}
			
			[[arrayButton objectAtIndex:arrayButton.count -1] addTarget:self action:NSSelectorFromString([currentButton objectForKey:@"imageAction"]) forControlEvents:UIControlEventTouchUpInside];
			[[arrayButton objectAtIndex:arrayButton.count -1] setTag:arrayButtonDict.count];
			[arrayButtonDict addObject:currentButton];
			[self.view addSubview:[arrayButton objectAtIndex:arrayButton.count -1]];
			
		}
		if ([[[subviews objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"text"]) {
			NSLog(@"%@", [subviews objectAtIndex:i]);
			NSDictionary *currentText = [subviews objectAtIndex:i];
			UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([[currentText objectForKey:@"x"] intValue], 
																	   [[currentText objectForKey:@"y"] intValue], 
																	   [[currentText objectForKey:@"xsize"] intValue], 
																	   [[currentText objectForKey:@"ysize"] intValue])];
			//NSLog(@"Test1");
			label.text = [currentText objectForKey:@"txt"];
			
			if ([currentText objectForKey:@"r"] != nil) {
				label.textColor = [[UIColor alloc] initWithRed:[[currentText objectForKey:@"r"] floatValue] 
														 green:[[currentText objectForKey:@"g"] floatValue] 
														  blue:[[currentText objectForKey:@"b"] floatValue] 
														 alpha:[[currentText objectForKey:@"alpha"] floatValue]];
				
			}
			
			if ([currentText objectForKey:@"font"] != nil) {
				label.font = [UIFont fontWithName:[currentText objectForKey:@"font"] 
											 size:[[currentText objectForKey:@"fontsize"] floatValue]];
			}
			
			label.backgroundColor = [UIColor clearColor];
			[self.view addSubview:label];	
		}
	}
	
	/*
	for (int i = 0; i < buttonKeys.count; i++) {
		NSLog(@"Button %@", [buttonKeys objectAtIndex:i]);
		currentButton = [[self.dictionary objectForKey:@"button"] objectForKey:[buttonKeys objectAtIndex:i]];
		[arrayButton addObject:[UIButton buttonWithType:UIButtonTypeCustom]];
		NSLog(@"Button %@ has x location %d", [buttonKeys objectAtIndex:i], [[currentButton objectForKey:@"x"] intValue]);
		//[array objectAtIndex:i].frame = CGRectMake([[currentButton objectForKey:@"x"] intValue], [[currentButton objectForKey:@"y"] intValue], [[currentButton objectForKey:@"xsize"] intValue], [[currentButton objectForKey:@"ysize"] intValue]);
		
		
		[[arrayButton objectAtIndex:i] setFrame:CGRectMake([[currentButton objectForKey:@"x"] intValue], [[currentButton objectForKey:@"y"] intValue], [[currentButton objectForKey:@"xsize"] intValue], [[currentButton objectForKey:@"ysize"] intValue])];
		
		if ([currentButton objectForKey:@"title"] != nil) {
			[[arrayButton objectAtIndex:i] setTitle:[currentButton objectForKey:@"title"] forState:UIControlStateNormal];
		}
		
		imageFilePath = [documentsDirectory stringByAppendingPathComponent:[currentButton objectForKey:@"image"]];
		if([fileManager fileExistsAtPath:imageFilePath])
		{
			[[arrayButton objectAtIndex:i] setBackgroundImage:[[UIImage imageWithContentsOfFile:imageFilePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
		}
		
		[[arrayButton objectAtIndex:i] addTarget:self action:NSSelectorFromString([currentButton objectForKey:@"imageAction"]) forControlEvents:UIControlEventTouchUpInside];
		[[arrayButton objectAtIndex:i] setTag:i];
		[arrayButtonDict addObject:currentButton];
		[self.view addSubview:[arrayButton objectAtIndex:i]];										
	}*/
	/*
	NSLog(@"Generating text");
	NSArray *textKeys = [[self.dictionary objectForKey:@"text"] allKeys];
	NSDictionary *currentText;
	UILabel *label;
	for (int i = 0; i < textKeys.count; i++) {
		NSLog(@"Text %@", [textKeys objectAtIndex:i]);
		currentText = [[self.dictionary objectForKey:@"text"] objectForKey:[textKeys objectAtIndex:i]];
		label = [[UILabel alloc] initWithFrame:CGRectMake([[currentText objectForKey:@"x"] intValue], 
														  [[currentText objectForKey:@"y"] intValue], 
														  [[currentText objectForKey:@"xsize"] intValue], 
														  [[currentText objectForKey:@"ysize"] intValue])];
		label.text = [currentText objectForKey:@"txt"];
		
		if ([currentText objectForKey:@"r"] != nil) {
			label.textColor = [[UIColor alloc] initWithRed:[[currentText objectForKey:@"r"] floatValue] 
													 green:[[currentText objectForKey:@"g"] floatValue] 
													  blue:[[currentText objectForKey:@"b"] floatValue] 
													 alpha:[[currentText objectForKey:@"alpha"] floatValue]];
			
		}
		
		if ([currentText objectForKey:@"font"] != nil) {
			label.font = [UIFont fontWithName:[currentText objectForKey:@"font"] 
										 size:[[currentText objectForKey:@"fontsize"] floatValue]];
		}
		
		label.backgroundColor = [UIColor clearColor];
		[self.view addSubview:label];		
	}*/
}

- (void) reloadView {
	[self.view removeFromSuperview];
	[self loadView];
	[self.progViewController.view addSubview:self.view];
}

- (void) buttonAction: (NSString *) urlAction {
	NSLog(@"Called %@", urlAction);
	if ([urlAction isEqualToString:@"buttonPressed"]) {
		NSLog(@"Called %@ from urlAction", urlAction);
		action = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
		[action addButtonWithTitle:@"Post to Twitter"];
		[action addButtonWithTitle:@"Post to Facebook"];
		[action addButtonWithTitle:@"Post to Post"];
		[action addButtonWithTitle:@"Cancel"];
		action.cancelButtonIndex = 3;
		[action showInView:self.view];
		[action release];
	} else if ([urlAction isEqualToString:@"buttonPressed2"]) {
		NSLog(@"Called %@ from urlAction", urlAction);
		action2 = [[UIActionSheet alloc] initWithTitle:@"Share2" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
		[action2 addButtonWithTitle:@"Post to Post"];
		[action2 addButtonWithTitle:@"Post to Twitter"];
		[action2 addButtonWithTitle:@"Cancel"];
		action2.cancelButtonIndex = 2;
		[action2 showInView:self.view];
		[action2 release];
	} else if ([urlAction isEqualToString:@"buttonPressed3"]) {
		NSLog(@"Called %@ from urlAction", urlAction);
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"This is button c" message:@"This is c!" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[alert show];
		[alert release];
	} else if ([urlAction isEqualToString:@"buttonPressed4"]) {
		NSLog(@"Called %@ from urlAction", urlAction);
		[self.view removeFromSuperview];
	} else {
		NSLog(@"Unrecognized action");
	}

	
}

- (void) buttonMap: (id) sender {
	NSLog(@"Pressed button, call correct url from sender %d", [sender tag]);
	
	NSDictionary *currentButtonDict = [arrayButtonDict objectAtIndex:[sender tag]];
	NSString *urlFullAction = [currentButtonDict objectForKey:@"urlAction"];
	
	NSLog(@"Url for this button is %@", urlFullAction);
	[[TTNavigator navigator] openURLAction:
	 [TTURLAction actionWithURLPath:urlFullAction]];
	
	
}

- (void) buttonPressed: (id) sender {
	NSLog(@"Called buttonPressed from sender %d", [sender tag]);
	action = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	[action addButtonWithTitle:@"Post to Twitter"];
	[action addButtonWithTitle:@"Post to Facebook"];
	[action addButtonWithTitle:@"Post to Post"];
	[action addButtonWithTitle:@"Cancel"];
	action.cancelButtonIndex = 3;
	[action showInView:self.view];
	[action release];
	
}

- (void) buttonPressed2: (id) sender {
	NSLog(@"Called buttonPressed2 from %d", [sender tag]);
	action2 = [[UIActionSheet alloc] initWithTitle:@"Share2" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	[action2 addButtonWithTitle:@"Post to Post"];
	[action2 addButtonWithTitle:@"Post to Twitter"];
	[action2 addButtonWithTitle:@"Cancel"];
	action2.cancelButtonIndex = 2;
	[action2 showInView:self.view];
	[action2 release];
	
}

- (void) buttonPressed3: (id) sender {
	NSLog(@"Called buttonPressed3 from %d", [sender tag]);
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"This is button c" message:@"This is c!" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}

- (void) buttonPressed4: (id) sender {
	NSLog(@"Called buttonPressed4 from %d", [sender tag]);
	[self.view removeFromSuperview];
	//[self.progViewController loadView];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (actionSheet == action) {
		if (buttonIndex == 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"This is a view" message:@"This is an!" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		
		if (buttonIndex == 1) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"This is a alert view" message:@"This is an alert!" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	}
	if (actionSheet == action2) {
		if (buttonIndex == 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"view" message:@"view!" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		
		if (buttonIndex == 1) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert" message:@"alert!" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	}
}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		NSLog(@"Prog View Controller getting initialized");
		NSLog(@"Downloading json");
		
		self.ready = NO;
		reload = NO;
		self.dictionary = nil;
		responseDataHashes = nil;
		urlstringjson = @"http://pandamoniumpanda.appspot.com/jsonbanner";
		urlstringhash = @"http://pandamoniumpanda.appspot.com/jsonbannerhash";
		
		NSURL *url = [NSURL URLWithString:urlstringjson];
		requestjson = [ASIHTTPRequest requestWithURL:url];
		[requestjson setDelegate:self];
		[requestjson startAsynchronous];
		[requestjson setNumberOfTimesToRetryOnTimeout:2];
		
		NSURL *urlhash = [NSURL URLWithString:urlstringhash];
		requesthash = [ASIHTTPRequest requestWithURL:urlhash];
		[requesthash setDelegate:self];
		[requesthash startAsynchronous];
		[requesthash setNumberOfTimesToRetryOnTimeout:2];
    }
    return self;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	// Use when fetching binary data
	//NSData *responseData = [request responseData];
	if (request == requestjson) {
		NSLog(@"Received a copy of JSON comparing...");
		NSData *responseData = [request responseData];
		
		if (self.ready == YES) {
			NSLog(@"Received new copy of JSON comparing...");
			NSString *responseCompare = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
			
			if ([responseString isEqualToString:responseCompare]) {
				NSLog(@"Same JSON no update needed");
				return;
			} else {
				NSLog(@"Different JSON update needed");
				self.ready = NO;
				//[self.dictionary release];
				self.dictionary = nil;
				[responseString release];
				responseString = responseCompare;
				//[arrayASI makeObjectsPerformSelector:@selector(release)];
				[arrayASI release];
				//[arrayASIfinished makeObjectsPerformSelector:@selector(release)];
				[arrayASIfinished release];
			}
		} else {
			responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
		}
		
		NSLog(responseString);
		
		self.dictionary = [responseString JSONValue];
		NSLog(@"Dictionary value for \"image\" 0 is \"%@\"", [[[self.dictionary objectForKey:@"button"] objectForKey:@"0"] objectForKey:@"image"]);	
		NSLog(@"Dictionary value for \"imageAction\" 0 is \"%@\"", [[[self.dictionary objectForKey:@"button"] objectForKey:@"0"] objectForKey:@"imageAction"]);	
		NSLog(@"Dictionary value for \"x\" 0 is \"%d\"", [[[[self.dictionary objectForKey:@"button"] objectForKey:@"0"] objectForKey:@"x"] intValue]);
		NSLog(@"Dictionary value for \"imageDict\" \"test\" is \"%d\"", [[[self.dictionary objectForKey:@"imageDict"] objectForKey:@"test"] intValue]);	
		
		NSArray *temp = [self.dictionary allKeys];
		
		NSEnumerator *enumerator = [temp objectEnumerator];
		id anObject;
		
		NSLog(@"Dictionary has %d keys", temp.count);
		NSLog(@"Dictionary has %d buttons", [[self.dictionary objectForKey:@"button"] allKeys].count);
		
		NSLog(@"Dictionary keys include:");
		while (anObject = [enumerator nextObject]) {
			NSLog(@"key: \"%@\"", anObject);
		}
		
		// Get path to settings file.
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *imageFilePath;
		
		// Get pointer to file manager.
		NSFileManager *fileManager = [NSFileManager defaultManager];
		
		arrayASI = [NSMutableArray new];
		arrayASIfinished = [NSMutableArray new];
		
		NSArray *subviews = [[self.dictionary objectForKey:@"view"] objectForKey:@"subview"];
		
		for (int i = 0; i < subviews.count; i++) {
			NSLog(@"This view is of type %@", [[subviews objectAtIndex:i] objectForKey:@"type"]);
			if ([[[subviews objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"button"]) {
				NSDictionary *currentButton = [subviews objectAtIndex:i];
				NSString *buttonFilePath = [documentsDirectory stringByAppendingPathComponent:[currentButton objectForKey:@"image"]];
				if (![fileManager fileExistsAtPath:buttonFilePath]) {
					NSLog(@"Button image %@ not found commencing download", [currentButton objectForKey:@"image"]);
					
					NSURL *url = [NSURL URLWithString:[currentButton objectForKey:@"imageurl"]];
					ASIHTTPRequest *requestbutton = [ASIHTTPRequest requestWithURL:url];
					[requestbutton setDelegate:self];
					[requestbutton startAsynchronous];
					[arrayASI addObject:requestbutton];
					[arrayASIfinished addObject:[currentButton objectForKey:@"image"]];
				} else {
					NSLog(@"Button image %@ found do not download", [currentButton objectForKey:@"image"]);
					NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
					ASIHTTPRequest *requestbutton = [ASIHTTPRequest requestWithURL:url];
					[requestbutton setDelegate:self];
					[requestbutton startAsynchronous];				
					[arrayASI addObject:requestbutton];
					[arrayASIfinished addObject:@"1"];
				}
			}
		}
		
		/*
		NSArray *buttonKeys = [[self.dictionary objectForKey:@"button"] allKeys];
		NSDictionary *currentButton;
		NSString *buttonFilePath;
		for (int i = 0; i < buttonKeys.count; i++) {
			currentButton = [[self.dictionary objectForKey:@"button"] objectForKey:[buttonKeys objectAtIndex:i]];
			buttonFilePath = [documentsDirectory stringByAppendingPathComponent:[currentButton objectForKey:@"image"]];
			if (![fileManager fileExistsAtPath:buttonFilePath]) {
				NSLog(@"Button %@ image %@ not found commencing download", [buttonKeys objectAtIndex:i], [currentButton objectForKey:@"image"]);
				
				NSURL *url = [NSURL URLWithString:[currentButton objectForKey:@"imageurl"]];
				ASIHTTPRequest *requestbutton = [ASIHTTPRequest requestWithURL:url];
				[requestbutton setDelegate:self];
				[requestbutton startAsynchronous];
				[arrayASI addObject:requestbutton];
				[arrayASIfinished addObject:[currentButton objectForKey:@"image"]];
			} else {
				NSLog(@"Button %@ image %@ found do not download", [buttonKeys objectAtIndex:i], [currentButton objectForKey:@"image"]);
				NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
				ASIHTTPRequest *requestbutton = [ASIHTTPRequest requestWithURL:url];
				[requestbutton setDelegate:self];
				[requestbutton startAsynchronous];				
				[arrayASI addObject:requestbutton];
				[arrayASIfinished addObject:@"1"];
			}			
		}*/
		
		NSDictionary *currentView = [self.dictionary objectForKey:@"view"];	
		NSString *buttonFilePath;
		if ([currentView objectForKey:@"image"] != nil) {
			buttonFilePath = [documentsDirectory stringByAppendingPathComponent:[currentView objectForKey:@"image"]];
			
			if (![fileManager fileExistsAtPath:buttonFilePath]) {
				NSLog(@"BG image %@ not found commencing download", [currentView objectForKey:@"image"]);
				
				NSURL *url = [NSURL URLWithString:[currentView objectForKey:@"imageurl"]];
				ASIHTTPRequest *requestbutton = [ASIHTTPRequest requestWithURL:url];
				[requestbutton setDelegate:self];
				[requestbutton startAsynchronous];
				[arrayASI addObject:requestbutton];
				[arrayASIfinished addObject:[currentView objectForKey:@"image"]];
			} else {
				NSLog(@"BG image %@ found do not download", [currentView objectForKey:@"image"]);
				NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
				ASIHTTPRequest *requestbutton = [ASIHTTPRequest requestWithURL:url];
				[requestbutton setDelegate:self];
				[requestbutton startAsynchronous];				
				[arrayASI addObject:requestbutton];
				[arrayASIfinished addObject:@"1"];
			}
		}
		
		
		
		[self check_ready];
		
		return;
	}
	
	if (request == requesthash) {
		NSData *data = [request responseData];
		if (self.ready == NO) {
			NSLog(@"Received hash");
			responseDataHashes = [[NSData alloc] initWithData:data];
			
			//responseStringHash = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
			
			//NSLog(@"%@",responseStringHash);
			[self check_ready];
		} else {
			NSLog(@"Received new hash, comparing");
			//NSString *responseCompare = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
			
			if ([responseDataHashes isEqualToData:data]) {
				NSLog(@"Same signature no update needed");
				return;
			}else {
				NSLog(@"Diff signature need to update");
				self.ready = NO;
				reload = YES;
				self.dictionary = nil;
				//[responseDataHash release];
				responseDataHashes = [[NSData alloc] initWithData:data];
				[arrayASI release];
				[arrayASIfinished release];
				//[self.view release];
				NSLog(@"Redownloading json to make sure up to date");
				NSURL *url = [NSURL URLWithString:urlstringjson];
				requestjson = [ASIHTTPRequest requestWithURL:url];
				[requestjson setDelegate:self];
				[requestjson startAsynchronous];
			}

		}
		
		
		return;		
	}
	// If request is not a requestjson then it is an image request
	for (int i = 0; i < arrayASI.count; i++) {
		if (request == [arrayASI objectAtIndex:i] && [arrayASIfinished objectAtIndex:i] != @"1") {
			NSLog(@"Request for %d completed", i);
			
			NSData *responseData = [request responseData];
			
			NSFileManager *fileManager = [NSFileManager defaultManager];
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *documentsDirectory = [paths objectAtIndex:0];	
			
			NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:[arrayASIfinished objectAtIndex:i]];
			
			[fileManager createFileAtPath:imagePath contents:responseData attributes:nil];
			
			[arrayASIfinished replaceObjectAtIndex:i withObject:@"1"];
			
			NSLog(@"Saved image to %@", imagePath);
			
			[self check_ready];
			
			return;
			
		}
	}
	
	
}

- (void)check_ready {
	if (self.ready == YES) {
		NSLog(@"Redownloading hash to make sure up to date");
		requestjson = nil;
		NSURL *urlhash = [NSURL URLWithString:urlstringhash];
		requesthash = [ASIHTTPRequest requestWithURL:urlhash];
		[requesthash setDelegate:self];
		[requesthash startAsynchronous];		
	} else {
		if (self.dictionary != nil && responseDataHashes != nil) {
			for (int i = 0; i < arrayASI.count; i++) {
				if ([arrayASIfinished objectAtIndex:i] != @"1") {
					NSLog(@"Image %d not downloaded yet", i);
					self.ready = NO;
					return;
				}
			}
			NSLog(@"All images downloaded");
			if (self.ready == NO) {
				[self.progViewController readyButton];
			}
			self.ready = YES;
			NSLog(@"Calling load view to reload view");
			if (reload == YES) {
				reload = NO;
				[self reloadView];
			}
			//[self reloadView];
		} else {
			NSLog(@"JSON not downloaded");
			self.ready = NO;
		}
	}
	
}



/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"viewDidLoad");
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
