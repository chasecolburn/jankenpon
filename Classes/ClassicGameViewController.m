//
//  ClassicGameViewController.m
//  Jankenpon
//
//  Created by Chase Colburn on 6/21/11.
//  Copyright 2011 Clever Monkey Technologies. All rights reserved.
//

#import "ClassicGameViewController.h"
#import "GameTokenView.h"

@interface ClassicGameViewController()
//-(void)flipGameTokens;
-(void)tokenWasSelected:(id)sender;
//-(GameTokenView*)selectedTokenForPlayer:(Player)player;
//-(NSString*)resultMessage:(Result)result;
@end

@implementation ClassicGameViewController

@synthesize fightButton;
@synthesize weaponLabel;

//----------------------------------------------------------------------------
#pragma mark -
#pragma mark Memory management

-(id)initWithGameType:(GameType)aGameType {
    self = [super initWithNibName:@"ClassicGameView" bundle:nil];
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
    [weaponLabel release];
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
    self.weaponLabel.alpha = 1.0;
}

-(void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.fightButton = nil;
    self.weaponLabel = nil;
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
    GameTokenView *tokenView = [[GameTokenView alloc] initWithOrigin:CGPointMake(120, 50)];
    tokenView.token = token;
    tokenView.flipped = YES;
    tokenView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [self.view addSubview:tokenView];
    [gameViewTokens addObject:tokenView];
    [tokenView release];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSTimeInterval delay = 0.0;
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


-(void)fightButtonWasPressed:(id)sender {
    self.weaponLabel.alpha = 0.0;
}

-(void)showWeaponLabel {
    
}

-(void)hideWeaponLabel {
    
}

-(void)tokenWasSelected:(id)sender {
    if(animating) return;

}

@end
