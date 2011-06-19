//
//  MainViewController.m
//  Jankenpon
//
//  Created by Chase Colburn on 1/8/11.
//  Copyright 2011 Cerego. All rights reserved.
//

#import "MainViewController.h"


@implementation MainViewController

@synthesize multiPlayerPanel;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	// Set border image for multi player panel
	multiPlayerPanel.image = [[UIImage imageNamed:@"frame.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	
	[super viewDidLoad];
}


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)showInfo:(id)sender {    
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	self.multiPlayerPanel = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
	[multiPlayerPanel release];
    [super dealloc];
}


@end
