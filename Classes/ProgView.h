//
//  ProgView.h
//  Programmable
//
//  Created by Charles Chen on 1/26/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgrammableViewController.h"
@class ProgrammableViewController;

@interface ProgView : UIView {
	ProgrammableViewController *progViewController;
	//UIView *contentView;
}

@property (nonatomic,assign) ProgrammableViewController *progViewController;
@end
