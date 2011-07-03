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
-(void)tokenWasSelected:(id)sender;
-(GameTokenView*)selectedTokenForPlayer:(Player)player;
-(NSString*)resultMessage:(Result)result;
@end

@implementation UltimateGameViewController

@synthesize fightButton;
@synthesize resultLabel;

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark Memory management

-(id)initWithGameType:(GameType)aGameType {
    self = [super initWithNibName:@"UltimateGameView" bundle:nil];
    if(self) {
        gameType = aGameType;
        gameViewTokens = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

-(void)dealloc {
    [fightButton release];
    [resultLabel release];
    [gameViewTokens release];
    [super dealloc];
}

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark View lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.fightButton.alpha = 0.0;
    self.resultLabel.alpha = 0.0;
}

-(void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    for(int col = 0; col < 3; col++) {
        int x = 20 + (100 * col);
        for(int row = 0; row < 4; row++) {
            int y = 40 + (100 * row);
            Token token = arc4random() % 3;
            GameTokenView *tokenView = [[GameTokenView alloc] initWithOrigin:CGPointMake(x, y)];
            [tokenView addTarget:self action:@selector(tokenWasSelected:) forControlEvents:UIControlEventTouchUpInside];
            tokenView.token = token;
            tokenView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            [self.view addSubview:tokenView];
            [gameViewTokens addObject:tokenView];
            [tokenView release];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [gameViewTokens shuffle];
    
    NSTimeInterval delay = 0.0;
    for(GameTokenView *tokenView in gameViewTokens) {
        [tokenView resetTokenTransformation:delay];
        delay += 0.2;
    }

    [self performSelector:@selector(flipGameTokens) withObject:nil afterDelay:delay];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark View lifecycle

-(IBAction)doneButtonWasPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)fightButtonWasPressed:(id)sender {
    if(animating) return; animating = YES;
    
    GameTokenView *p1TokenView = [self selectedTokenForPlayer:PlayerOne];
    GameTokenView *p2TokenView = [self selectedTokenForPlayer:PlayerTwo];
    
    [self.view bringSubviewToFront:p1TokenView];
    [p1TokenView setCenter:CGPointMake(160, 115) withDelay:0.0];
    [self.view bringSubviewToFront:p2TokenView];
    [p2TokenView setCenter:CGPointMake(160, 345) withDelay:0.0];
    
    [self performSelector:@selector(revealSelectedGameTokens) withObject:nil afterDelay:1.0];
}

-(void)revealSelectedGameTokens {
    GameTokenView *p1TokenView = [self selectedTokenForPlayer:PlayerOne];
    GameTokenView *p2TokenView = [self selectedTokenForPlayer:PlayerTwo];
    
    [p1TokenView flipToken:0.0];
    [p2TokenView flipToken:0.0];
    
    [self performSelector:@selector(hideSelectedGameTokens) withObject:nil afterDelay:2.0];
    [self performSelector:@selector(showResult) withObject:nil afterDelay:1.0];
}

-(void)showResult {
    GameTokenView *p1TokenView = [self selectedTokenForPlayer:PlayerOne];
    GameTokenView *p2TokenView = [self selectedTokenForPlayer:PlayerTwo];
    Result result = [p1TokenView compare:p2TokenView];
    resultLabel.text = [self resultMessage:result];
    resultLabel.transform = CGAffineTransformMakeScale(0.5, 0.5);
    resultLabel.alpha = 0.0;
    
    [UIView beginAnimations:@"ShowResult" context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    resultLabel.transform = CGAffineTransformMakeScale(0.9, 0.9);
    resultLabel.alpha = 1.0;
    [UIView commitAnimations]; 
}

-(void)moveResult {
    [UIView beginAnimations:@"MoveResult" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    resultLabel.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView commitAnimations]; 
}

-(void)hideResult {
    [UIView beginAnimations:@"HideResult" context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    resultLabel.transform = CGAffineTransformMakeScale(1.5, 1.5);
    resultLabel.alpha = 0.0;
    [UIView commitAnimations]; 
}

-(void)hideSelectedGameTokens {
    GameTokenView *p1TokenView = [self selectedTokenForPlayer:PlayerOne];
    GameTokenView *p2TokenView = [self selectedTokenForPlayer:PlayerTwo];
    
    p1TokenView.played = YES;
    p2TokenView.played = YES;
    
    [UIView beginAnimations:@"HideGameTokens" context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    fightButton.alpha = 0.0;
    p1TokenView.alpha = 0.0;
    p2TokenView.alpha = 0.0;
    [UIView commitAnimations]; 
}
//----------------------------------------------------------------------------
#pragma mark -
#pragma mark Animation emthods

-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if([animationID isEqualToString:@"HideGameTokens"]) {
        animating = NO;
    }
    else if([animationID isEqualToString:@"ShowResult"]) {
        [self moveResult];
    }
    else if([animationID isEqualToString:@"MoveResult"]) {
        [self hideResult];
    }
}

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark Private emthods

-(void)flipGameTokens {
    [gameViewTokens shuffle];
    
    NSTimeInterval delay = 0.0;
    for(GameTokenView *tokenView in gameViewTokens) {
        [tokenView flipToken:delay];
        delay += 0.3;
    }
    
    [self performSelector:@selector(dealGameTokens) withObject:nil afterDelay:delay + 0.5];
}

-(void)dealGameTokens {
    [gameViewTokens shuffle];
    
    NSTimeInterval delay = 0.0;
    BOOL left = YES;
    CGFloat x = 0, y = 80;
    
    for(GameTokenView *tokenView in gameViewTokens) {
        tokenView.player = left ? PlayerOne : PlayerTwo;
        [self.view bringSubviewToFront:tokenView];
        [tokenView setCenter:CGPointMake(x, y) withDelay:delay];

        delay += 0.2;
        if(left) {
            x = 320;
        }else {
            x = 0; y += 60;
        }
        left = !left;
    }
    [self performSelector:@selector(finishAnimating) withObject:nil afterDelay:delay + 0.5];
}

-(void)finishAnimating {
    animating = NO;
}

-(void)tokenWasSelected:(id)sender {
    if(animating) return;
    
    if([sender isKindOfClass:[GameTokenView class]]) {
        BOOL p1HasSelection = NO, p2HasSelection = NO;
        GameTokenView *selectedTokenView = (GameTokenView*)sender;
        [selectedTokenView toggleSelected];
        for(GameTokenView *tokenView in gameViewTokens) {
            if(tokenView != selectedTokenView && tokenView.player == selectedTokenView.player) {
                [tokenView setSelected:NO];
            }
            if(!tokenView.played && tokenView.selected) {
                if(tokenView.player == PlayerOne) {
                    p1HasSelection = YES;
                }
                if(tokenView.player == PlayerTwo) {
                    p2HasSelection = YES;
                }
            }
        }
        if(p1HasSelection && p2HasSelection) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.4];
            self.fightButton.alpha = 1.0;
            [UIView commitAnimations];
        }else{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.4];
            self.fightButton.alpha = 0.0;
            [UIView commitAnimations];            
        }
    }
}

-(GameTokenView*)selectedTokenForPlayer:(Player)player {
    for(GameTokenView *tokenView in gameViewTokens) {
        if(tokenView.selected && tokenView.player == player) {
            return tokenView;
        }
    }
    return nil;
}

-(NSString*)resultMessage:(Result)result {
    switch(result) {
        case ResultWin:
            return @"Player 1 Wins";
        case ResultLose:
            return @"Player 2 Wins";
        case ResultDraw:
            return @"You All Lose!";
    }
    return nil;
}

@end
