//
//  FlipsideViewController.m
//  Jankenpon
//
//  Created by Chase Colburn on 1/8/11.
//  Copyright 2011 Clever Monkey Technologies. All rights reserved.
//

#import "InfoViewController.h"


@implementation InfoViewController

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark Memory management

-(id)init {
    self = [super initWithNibName:@"InfoView" bundle:nil];
    if(self) {
    }
    return self;
}

-(void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

-(void)dealloc {
    [super dealloc];
}

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark View lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark IBAction methods

-(IBAction)done:(id)sender {
	[self dismissModalViewControllerAnimated:YES];	
}

@end
