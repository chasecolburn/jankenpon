//
//  MainViewController.m
//  Jankenpon
//
//  Created by Chase Colburn on 1/8/11.
//  Copyright 2011 Clever Monkey Technologies. All rights reserved.
//

#import "MainViewController.h"
#import "UltimateGameViewController.h"
#import "ClassicGameViewController.h"


@implementation MainViewController

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark Memory management

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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void)viewDidLoad {	
	[super viewDidLoad];
}

-(void)viewDidUnload {
	// Release any retained subviews of the main view.
}

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark IBAction methods

-(IBAction)startSinglePlayerClassic:(id)sender {
    ClassicGameViewController *viewController = [[ClassicGameViewController alloc] initWithGameType:GameTypeSinglePlayer];
    viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:viewController animated:YES];
    [viewController release];
}

-(IBAction)startSinglePlayerUltimate:(id)sender {
    UltimateGameViewController *viewController = [[UltimateGameViewController alloc] initWithGameType:GameTypeSinglePlayer];
	viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:viewController animated:YES];
	[viewController release];
}

-(IBAction)startMultiPlayerClassic:(id)sender {
    ClassicGameViewController *viewController = [[ClassicGameViewController alloc] initWithGameType:GameTypeMultiPlayer];
    viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:viewController animated:YES];
    [viewController release];
}

-(IBAction)startMultiPlayerUltimate:(id)sender {
    UltimateGameViewController *viewController = [[UltimateGameViewController alloc] initWithGameType:GameTypeMultiPlayer];
	viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:viewController animated:YES];
	[viewController release];
}

-(IBAction)showInfo:(id)sender {    
	InfoViewController *viewController = [[InfoViewController alloc] init];
	viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:viewController animated:YES];
	[viewController release];
}

@end
