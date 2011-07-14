//
//  ClassicGameViewController.m
//  Jankenpon
//
//  Created by Chase Colburn on 6/21/11.
//  Copyright 2011 Clever Monkey Technologies. All rights reserved.
//

#import "ClassicGameViewController.h"

@interface ClassicGameViewController()
-(void)initGame;
-(void)animateLabel;
-(void)beginCountdown;
-(void)compareTokens;
-(void)tokenWasSelected:(id)sender;
@end

@implementation ClassicGameViewController

@synthesize nextRoundButton;
@synthesize doneButton;
@synthesize weaponLabel;
@synthesize infoLabel;
@synthesize playerLabel;
@synthesize computerLabel;

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark Memory management

-(id)initWithGameType:(GameType)aGameType {
    self = [super initWithNibName:@"ClassicGameView" bundle:nil];
    if(self) {
        gameType = aGameType;
        gameViewTokens = [[NSMutableArray alloc] init];
        opponentTokenView = [[GameTokenView alloc] initWithOrigin:CGPointMake(120, 80)];
        [self initGame];
    }
    return self;
}

-(void)initGame {
    countdown = 3;
    result = -1;
    tokenSelected = NO;
}

-(void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

-(void)dealloc {
    [nextRoundButton release];
    [doneButton release];
    [weaponLabel release];
    [infoLabel release];
    [playerLabel release];
    [computerLabel release];
    [gameViewTokens release];
    [playerTokenView release];
    [opponentTokenView release];
    [super dealloc];
}

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark View lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.nextRoundButton.alpha = 0.0;
    self.doneButton.alpha = 0.0;
    self.weaponLabel.alpha = 1.0;
    self.infoLabel.alpha = 0.0;
}

-(void)viewDidUnload {
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    self.nextRoundButton = nil;
    self.doneButton = nil;
    self.weaponLabel = nil;
    self.infoLabel = nil;
    self.playerLabel = nil;
    self.computerLabel = nil;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create the 3 tokens(rock, paper, scissors) for the user to select from
    for(int col = 0; col < 3; col++) {
        int x = 20 + (100 * col);
        int y = 350;
        
        Token token = col;
        GameTokenView *tokenView = [[GameTokenView alloc] initWithOrigin:CGPointMake(x, y)];
        [tokenView addTarget:self action:@selector(tokenWasSelected:) forControlEvents:UIControlEventTouchUpInside];
        tokenView.token = token;
        tokenView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        [self.view addSubview:tokenView];
        [gameViewTokens addObject:tokenView];
        [tokenView release];
    }
    
    // Select a random throw for the opponent
    Token token = arc4random() % 3;
    opponentTokenView.token = token;
    [opponentTokenView flipToken:0.0];
    opponentTokenView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [self.view addSubview:opponentTokenView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSTimeInterval delay = 0.0;
    
    // Display tokens
    opponentTokenView.transform = CGAffineTransformMakeScale(2.0, 2.0);
    
    for(GameTokenView *tokenView in gameViewTokens) {
        [tokenView resetTokenTransformation:delay];
        delay += 0.2;
    }
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark Animate Views

-(void)showButton:(UIButton*)button withDelay:(CGFloat)delay {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelay:delay];
    button.alpha = 1.0;
    [UIView commitAnimations];
}

-(void)hideButton:(UIButton*)button withDelay:(CGFloat)delay {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelay:delay];
    button.alpha = 0.0;
    [UIView commitAnimations];
}

-(void)showLabel:(UILabel*)label withDelay:(CGFloat)delay {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelay:delay];
    label.alpha = 1.0;
    [UIView commitAnimations];
}

-(void)hideLabel:(UILabel*)label withDelay:(CGFloat)delay {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelay:delay];
    label.alpha = 0.0;
    [UIView commitAnimations];
}

-(void)hideInfoLabelWithDelay:(CGFloat)delay {    
    // Once the Info Label is hidden, call the animateLabel function again with the countdown
    // integer decremented by 1. If the Info Label text is 'FIGHT!', compare the tokens
    [UIView animateWithDuration:0.2 delay:delay options:0 animations:^{
        self.infoLabel.alpha = 0.0;
    }completion:^(BOOL finished) {
        if(![self.infoLabel.text isEqualToString:@"FIGHT!"]) {
            [self animateLabel];
        }else {
            [self compareTokens];
        }
    }];
    
    if([self.infoLabel.text isEqualToString:@"FIGHT!"]) {
        // Flip over tokens
        //[playerTokenView flipToken:0.0];
        [opponentTokenView flipToken:0.0];
    }
}

-(void)animateLabel {
    float labelScale;
    float animateDelay;
    
    // Replace the Info Label text with the countdown integer until it gets to 0,
    // Then replace it with 'FIGHT!'
    if(result != -1) {
        switch (result) {
            case ResultWin:
                self.infoLabel.text = @"You Win!";
                labelScale = 1.5;
                break;
            case ResultLose:
                self.infoLabel.text = @"You Lose!";
                labelScale = 1.5;
                break;
            case ResultDraw:
                self.infoLabel.text = @"Draw!";
                labelScale = 2.0;
                break;
        }
        animateDelay = 0.8;
    }else if (countdown == 0) {
        self.infoLabel.text = @"FIGHT!";
        labelScale = 2.5;
        animateDelay = 0.6;
    }else {
        self.infoLabel.text = [NSString stringWithFormat:@"%d", countdown--];
        labelScale = 5.0;
        animateDelay = 0.3;
    }
    
    // Strink the text
    self.infoLabel.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    // Begin the countdown animation by showing the Info Label
    [self showLabel:infoLabel withDelay:0.0];
    
    // Increase the size of the label
    [UIView animateWithDuration:0.4 delay:0.1 options:0 animations:^{
        self.infoLabel.transform = CGAffineTransformMakeScale(labelScale, labelScale);
    }completion:^(BOOL finished) {
        // If the comparison has been completed and result is set, show the next round and done
        // buttons and increment the score of the winner
        if(result != -1) {
            [self showButton:nextRoundButton withDelay:0.0];
            [self showButton:doneButton withDelay:0.0];
            
            if(result == ResultWin) {
                playerScore++;
                self.playerLabel.text = [NSString stringWithFormat:@"%d", playerScore];
            }else if(result == ResultLose)  {
                computerScore++;
                self.computerLabel.text = [NSString stringWithFormat:@"%d", computerScore];
            }
        }
    }];
    
    // If the result has not been set yet, the countdown is still in progress. Hide the info
    // label and trigger the next number to be displayed
    if(result == -1) {
        [self hideInfoLabelWithDelay:animateDelay];
    }
}

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark Input Events

-(void)nextRoundButtonWasPressed:(id)sender {
    // Reset game for next round
    [self hideButton:nextRoundButton withDelay:0.0];
    [self hideButton:doneButton withDelay:0.0];
    
    opponentTokenView.flipped = YES;
    [opponentTokenView flipToken:0.0];
    
    [UIView animateWithDuration:0.4 animations:^{
        playerTokenView.alpha = 0.0;
        playerTokenView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }];
    
    [self hideLabel:infoLabel withDelay:0.0];
    [self showLabel:weaponLabel withDelay:0.0];

    [gameViewTokens removeAllObjects];
    
    [self initGame];
    [self viewWillAppear:YES];
    [self viewDidAppear:YES];
}

-(void)doneButtonWasPressed:(id)sender {
    // Return to main view
	[self dismissModalViewControllerAnimated:YES];	
}

-(void)tokenWasSelected:(id)sender {
    if(tokenSelected) return;
    
    tokenSelected = YES;
    
    if([sender isKindOfClass:[GameTokenView class]]) {
        // Get selected token
        playerTokenView = (GameTokenView*)sender;
        
        // Hide non selected tokens and remove them from the array
        for(GameTokenView *tokenView in gameViewTokens) {
            // Skip over selected token
            if(tokenView.token == playerTokenView.token) continue;
            
            // Once token is hidden, remove it from the array
            [UIView animateWithDuration:0.4 animations:^{
                tokenView.alpha = 0.0;
            }completion:^(BOOL finished) {
                [gameViewTokens removeObject:tokenView];
            }];
        }
        
        // Flip over token and move selected to the center
        //[playerTokenView flipToken:0.0];
        
        [playerTokenView setCenter:CGPointMake(160.0, 340.0) withDelay:0.0];
        
        // Once player token is in place, begin countdown
        [UIView animateWithDuration:0.3 delay:0.1 options:0 animations:^{
            playerTokenView.transform = CGAffineTransformMakeScale(2.0, 2.0);
        }completion:^(BOOL finished) {
            [self beginCountdown];
        }];
        
        [self hideLabel:weaponLabel withDelay:0.0];
    }
}

-(void)beginCountdown {
    // Center info label and move to the foreground
    self.infoLabel.textAlignment = UITextAlignmentCenter;
    [self.view bringSubviewToFront:infoLabel];
    
    // Begin Countdown animation
    [self animateLabel];
}

-(void)compareTokens {    
    // Determine who wins
    result = [playerTokenView compare:opponentTokenView];
    
    // Display results
    [self animateLabel];
}

@end
