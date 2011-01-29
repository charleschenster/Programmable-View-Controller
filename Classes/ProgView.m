//
//  ProgView.m
//  Programmable
//
//  Created by Charles Chen on 1/26/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "ProgView.h"
#import "ProgrammableViewController.h"


@implementation ProgView
@synthesize progViewController;
/*- (id)initWithFrame: (CGRect)inFrame;
{
    if ( (self = [super initWithFrame: inFrame]) ) {
        [[NSBundle mainBundle] loadNibNamed: @"ProgView.nib"
                                      owner: self
                                    options: nil];
        contentView.size = inFrame.size;
        // do extra loading here
        [self addSubview: contentView];
    }
    return self;
}*/


- (id)initWithFrame:(CGRect)frame {
	
    if (self = [super initWithFrame:frame]) {
        NSLog(@"Add button to main screen");
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		//NSLog(@"Button %@ has x location %d", [buttonKeys objectAtIndex:i], [[currentButton objectForKey:@"x"] intValue]);
		//[array objectAtIndex:i].frame = CGRectMake([[currentButton objectForKey:@"x"] intValue], [[currentButton objectForKey:@"y"] intValue], [[currentButton objectForKey:@"xsize"] intValue], [[currentButton objectForKey:@"ysize"] intValue]);
		
		[button setFrame:CGRectMake(135, 400, 50, 50)];
		[button setTitle:@"Go" forState:UIControlStateNormal];
		[button	setBackgroundImage:[[UIImage imageNamed:@"blueButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
		[button	addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
		
		[self addSubview:button];
	}
    return self;
}

- (void) buttonPressed {
	
	NSLog(@"Got to press the subview's button");
	[self.progViewController loadView];
}

/*
- (void) loadView {
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
	
	NSLog(@"Add button to main screen");
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	//NSLog(@"Button %@ has x location %d", [buttonKeys objectAtIndex:i], [[currentButton objectForKey:@"x"] intValue]);
	//[array objectAtIndex:i].frame = CGRectMake([[currentButton objectForKey:@"x"] intValue], [[currentButton objectForKey:@"y"] intValue], [[currentButton objectForKey:@"xsize"] intValue], [[currentButton objectForKey:@"ysize"] intValue]);
	
	[button setFrame:CGRectMake(135, 400, 50, 50)];
	[button setTitle:@"Go" forState:UIControlStateNormal];
	[button	setBackgroundImage:[[UIImage imageNamed:@"greenButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0 forState:UIControlStateNormal]];
	[button	addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:button];
}*/

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
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


- (void)dealloc {
	//contentView = nil;
    [super dealloc];
}


@end
