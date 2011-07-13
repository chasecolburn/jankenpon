//
//  ClassicGameViewController.m
//  Jankenpon
//
//  Created by Chase Colburn on 6/21/11.
//  Copyright 2011 Clever Monkey Technologies. All rights reserved.
//

#import "ClassicGameViewController.h"

@interface ClassicGameViewController()
-(void)animateLabel;
-(void)tokenWasSelected:(id)sender;
//-(GameTokenView*)selectedTokenForPlayer:(Player)player;
//-(NSString*)resultMessage:(Result)result;
@end

@implementation ClassicGameViewController

@synthesize fightButton;
@synthesize weaponLabel;
@synthesize infoLabel;

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark Memory management

-(id)initWithGameType:(GameType)aGameType {
    self = [super initWithNibName:@"ClassicGameView" bundle:nil];
    if(self) {
        gameType = aGameType;
        gameViewTokens = [[NSMutableArray alloc] init];
        opponentTokenView = [[GameTokenView alloc] initWithOrigin:CGPointMake(120, 80)];
        countdown = 3;
    }
    return self;
}

-(void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

-(void)dealloc {
    [fightButton release];
    [weaponLabel release];
    [infoLabel release];
    [gameViewTokens release];
    [opponentTokenView release];
    [super dealloc];
}

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark View lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.fightButton.alpha = 0.0;
    self.weaponLabel.alpha = 1.0;
    self.infoLabel.alpha = 0.0;
}

-(void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.fightButton = nil;
    self.weaponLabel = nil;
    self.infoLabel = nil;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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
    
    Token token = arc4random() % 3;
    opponentTokenView.token = token;
    [opponentTokenView flipToken:0.0];
    opponentTokenView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [self.view addSubview:opponentTokenView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSTimeInterval delay = 0.0;
    
    opponentTokenView.transform = CGAffineTransformMakeScale(2.0, 2.0);
    
    for(GameTokenView *tokenView in gameViewTokens) {
        [tokenView resetTokenTransformation:delay];
        delay += 0.2;
    }
    
//    [self performSelector:@selector(flipGameTokens) withObject:nil afterDelay:delay];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

-(void)showFightButton:(CGFloat)delay {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelay:delay];
    self.fightButton.alpha = 1.0;
    [UIView commitAnimations];
}

-(void)hideFightButton:(CGFloat)delay {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelay:delay];
    self.fightButton.alpha = 0.0;
    [UIView commitAnimations];
}

-(void)hideWeaponLabel {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    self.weaponLabel.alpha = 0.0;
    [UIView commitAnimations];
}

-(void)showInfoLabel:(CGFloat)delay {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelay:delay];
    self.infoLabel.alpha = 1.0;
    [UIView commitAnimations];
}

-(void)hideInfoLabel:(CGFloat)delay {    
    [UIView animateWithDuration:0.4 delay:delay options:0 animations:^{
        self.infoLabel.alpha = 0.0;
    }completion:^(BOOL finished) {
        if(self.infoLabel.text != @"FIGHT!") {
            [self animateLabel];
        }
    }];
}

-(void)animateLabel {
    if(countdown == 0) {
        self.infoLabel.text = @"FIGHT!";
    } else {
        self.infoLabel.text = [NSString stringWithFormat:@"%d", countdown--];
    }
    
    self.infoLabel.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    [self showInfoLabel:0.0];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    self.infoLabel.transform = CGAffineTransformMakeScale(6.0, 6.0);

    [UIView setAnimationDelay:0.4];
    
    [self.view bringSubviewToFront:infoLabel];
    [UIView commitAnimations];

    [self hideInfoLabel:0.4];
}

-(void)fightButtonWasPressed:(id)sender {
    [self hideFightButton:0.0];
    
    self.infoLabel.textAlignment = UITextAlignmentCenter;
    
    
    [self animateLabel];
    
    
//        [self showInfoLabel:0.0];
//    
//        [UIView beginAnimations:nil context:nil];
//        [UIView animateWithDuration:0.4 animations:^{
//            self.infoLabel.transform = CGAffineTransformMakeScale(6.0, 6.0);
//        }completion:^(BOOL finished) {
//            
//        }];
//        //[UIView setAnimationDelay:((3 - i) * 0.4)];
//        [UIView setAnimationDelay:0.4];
//        
//        [self.view bringSubviewToFront:infoLabel];
//        [UIView commitAnimations]; 
//    
//        //[self hideInfoLabel:((3 - i) * 0.4)];
//        [self hideInfoLabel:0.4];

    

}

-(void)tokenWasSelected:(id)sender {
    if(animating) return;
    
    if([sender isKindOfClass:[GameTokenView class]]) {
        animating = YES;
        
        GameTokenView *selectedTokenView = (GameTokenView*)sender;
        
        
        for(GameTokenView *tokenView in gameViewTokens) {
            if(tokenView.token == selectedTokenView.token) continue;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.4];
            tokenView.alpha = 0.0;
            [UIView commitAnimations];
            //[gameViewTokens removeObject:tokenView];
        }
        
        [selectedTokenView flipToken:0.0];
        
        [selectedTokenView setCenter:CGPointMake(160.0, 340.0) withDelay:0.6];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationDelay:1.0];
        selectedTokenView.transform = CGAffineTransformMakeScale(2.0, 2.0);
        [UIView commitAnimations];
        
        [self hideWeaponLabel];
        [self showFightButton:1.4];
        
        [selectedTokenView release];
    }
}

@end
