//
//  UltimateGameViewController.m
//  Jankenpon
//
//  Created by Chase Colburn on 6/21/11.
//  Copyright 2011 Clever Monkey Technologies. All rights reserved.
//

#import "UltimateGameViewController.h"
#import "GameTokenView.h"


@interface UltimateGameViewController()
-(void)flipGameTokens;
@end

@implementation UltimateGameViewController

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark Memory management

-(id)initWithGameType:(GameType)aGameType {
    self = [super initWithNibName:@"UltimateGameView" bundle:nil];
    if(self) {
        gameType = aGameType;
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
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    for(int col = 0; col < 3; col++) {
        int x = 35 + (95 * col);
        for(int row = 0; row < 4; row++) {
            int y = 20 + (110 * row);
            GameTokenView *tokenView = [[GameTokenView alloc] initWithOrigin:CGPointMake(x, y)];
            tokenView.backgroundColor = [UIColor redColor];
            [self.view addSubview:tokenView];
            [tokenView release];
        }
    }
    [self performSelector:@selector(flipGameTokens) withObject:nil afterDelay:0.4];
}

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark View lifecycle

-(IBAction)doneButtonWasPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark Private emthods

-(void)flipGameTokens {
    NSMutableArray *views = [NSMutableArray arrayWithArray:[self.view subviews]];
    [views shuffle];
    NSTimeInterval delay = 0.0;
    for(UIView *tokenView in views) {
        if([tokenView isKindOfClass:[GameTokenView class]]) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1.0];
            [UIView setAnimationDelay:delay];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:tokenView cache:YES];
            [UIView commitAnimations];
            tokenView.backgroundColor = [UIColor greenColor];
            delay += 0.4;
        }
    }
}

@end
