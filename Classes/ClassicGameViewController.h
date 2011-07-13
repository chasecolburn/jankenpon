//
//  ClassicGameViewController.h
//  Jankenpon
//
//  Created by Chase Colburn on 6/21/11.
//  Copyright 2011 Clever Monkey Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "GameTokenView.h"

@interface ClassicGameViewController : UIViewController {
    UIButton *nextRoundButton;
    UIButton *doneButton;
    UILabel *weaponLabel;
    UILabel *infoLabel;
    UILabel *playerLabel;
    UILabel *computerLabel;
@private
    GameType gameType;
    NSMutableArray *gameViewTokens;
    GameTokenView *playerTokenView;
    GameTokenView *opponentTokenView;
    int countdown;
    int playerScore;
    int computerScore;
    Result result;
    BOOL tokenSelected;
}

@property(nonatomic, retain) IBOutlet UIButton *nextRoundButton;
@property(nonatomic, retain) IBOutlet UIButton *doneButton;
@property(nonatomic, retain) IBOutlet UILabel *weaponLabel;
@property(nonatomic, retain) IBOutlet UILabel *infoLabel;
@property(nonatomic, retain) IBOutlet UILabel *playerLabel;
@property(nonatomic, retain) IBOutlet UILabel *computerLabel;

-(id)initWithGameType:(GameType)gameType;

-(IBAction)nextRoundButtonWasPressed:(id)sender;
-(IBAction)doneButtonWasPressed:(id)sender;

@end
