//
//  ProgrammableViewController.m
//  Programmable
//
//  Created by Charles Chen on 1/26/11.
//  Copyright Stanford University 2011. All rights reserved.
//

#import "ProgrammableViewController.h"
#import "json/JSON.h"
#import "ProgViewController.h"
//#import "asi/ASIHTTPRequest.h"

@implementation ProgrammableViewController
@synthesize progView;
@synthesize progViewCont;

- (void) loadView {
		
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
	
	NSLog(@"Add button to main screen");
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	//NSLog(@"Button %@ has x location %d", [buttonKeys objectAtIndex:i], [[currentButton objectForKey:@"x"] intValue]);
	//[array objectAtIndex:i].frame = CGRectMake([[currentButton objectForKey:@"x"] intValue], [[currentButton objectForKey:@"y"] intValue], [[currentButton objectForKey:@"xsize"] intValue], [[currentButton objectForKey:@"ysize"] intValue]);
	
	[button setFrame:CGRectMake(135, 200, 50, 50)];
	[button setTitle:@"Go" forState:UIControlStateNormal];
	//[button	setBackgroundImage:[[UIImage imageNamed:@"greenButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0 forState:UIControlStateNormal]];
	[button	setBackgroundImage:[[UIImage imageNamed:@"greenButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
	[button	addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
	
	
		
	// Custom initialization
	if (self.progViewCont == nil) {
		NSLog(@"Programmable View Controller getting initialized");
		
		ProgViewController *view = [[ProgViewController alloc] initWithNibName:nil bundle:nil];
		
		view.progViewController = self;
		self.progViewCont = view;
	} else {
		UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
		//NSLog(@"Button %@ has x location %d", [buttonKeys objectAtIndex:i], [[currentButton objectForKey:@"x"] intValue]);
		//[array objectAtIndex:i].frame = CGRectMake([[currentButton objectForKey:@"x"] intValue], [[currentButton objectForKey:@"y"] intValue], [[currentButton objectForKey:@"xsize"] intValue], [[currentButton objectForKey:@"ysize"] intValue]);
		
		[button2 setFrame:CGRectMake(135, 100, 50, 50)];
		[button2 setTitle:@"Go" forState:UIControlStateNormal];
		//[button	setBackgroundImage:[[UIImage imageNamed:@"greenButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0 forState:UIControlStateNormal]];
		[button2	setBackgroundImage:[[UIImage imageNamed:@"greenButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
		[button2	addTarget:self action:@selector(buttonPressed2) forControlEvents:UIControlEventTouchUpInside];
		
		[self.view addSubview:button2];	
	}
	
	[self.view addSubview:button];
}

- (void) buttonPressed {
	NSLog(@"Called buttonPressed");
	NSLog(@"Create view and use it");
	
	
	ProgView *view = [[ProgView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    view.progViewController = self;
    self.view = view;
    self.progView = view;
	
	[view release];
	/*if (nextView == nil) {
		nextView = [[ProgView alloc] init];
	}
	
	[self.view addSubview:nextView];*/
	
	//[self.navigationController pushViewController:nextView animated:YES];
}

- (void) buttonPressed2 {
	NSLog(@"Called buttonPressed2");
	NSLog(@"Create view controller and use it");
	
	[self.progViewCont check_ready];
	[self.view addSubview:self.progViewCont.view];
    //self.view = self.progViewCont.view;
	//[self.view addSubview:self.progViewCont.view];
    //self.progView = view;
	
	//[view release];
	/*if (nextView == nil) {
	 nextView = [[ProgView alloc] init];
	 }
	 
	 [self.view addSubview:nextView];*/
	
	//[self.navigationController pushViewController:nextView animated:YES];
}


- (void) readyButton {
	UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
	//NSLog(@"Button %@ has x location %d", [buttonKeys objectAtIndex:i], [[currentButton objectForKey:@"x"] intValue]);
	//[array objectAtIndex:i].frame = CGRectMake([[currentButton objectForKey:@"x"] intValue], [[currentButton objectForKey:@"y"] intValue], [[currentButton objectForKey:@"xsize"] intValue], [[currentButton objectForKey:@"ysize"] intValue]);
	
	[button2 setFrame:CGRectMake(135, 100, 50, 50)];
	[button2 setTitle:@"Go" forState:UIControlStateNormal];
	//[button	setBackgroundImage:[[UIImage imageNamed:@"greenButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0 forState:UIControlStateNormal]];
	[button2	setBackgroundImage:[[UIImage imageNamed:@"greenButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
	[button2	addTarget:self action:@selector(buttonPressed2) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:button2];	
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
								
    }
	
    return self;
}*/


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
