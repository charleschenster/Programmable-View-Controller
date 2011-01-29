//
//  ProgrammableViewController.h
//  Programmable
//
//  Created by Charles Chen on 1/26/11.
//  Copyright Stanford University 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgView.h"
//#import "asi/ASIHTTPRequest.h"
@class ProgView;
@class ProgViewController;

@interface ProgrammableViewController : UIViewController {
	ProgView *progView;
	ProgViewController *progViewCont;
}

@property (nonatomic,assign) ProgView *progView;
@property (nonatomic,assign) ProgViewController *progViewCont;

- (void) readyButton;

@end

