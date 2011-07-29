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
#import "GameStatistics.h"

@interface ClassicGameViewController : UIViewController {
    UIButton *nextRoundButton;
    UIButton *doneButton;
    UIButton *mainMenuButton;
    UILabel *weaponLabel;
    UILabel *infoLabel;
    UILabel *playerLabel;
    UILabel *computerLabel;
    UILabel *roundLabel;
    UIView *statisticsView;
@private
    GameType gameType;
    NSMutableArray *gameViewTokens;
    GameTokenView *playerTokenView;
    GameTokenView *computerTokenView;
    GameStatistics *gameStatistics;
//    NSDate *startDate;
    int countdown;
//    int playerScore;
//    int computerScore;
    int round;
//    int numRock;
//    int numPaper;
//    int numScissors;
//    int numComputerRock;
//    int numComputerPaper;
//    int numComputerScissors;
    Result result;
    BOOL tokenSelected;
}

@property(nonatomic, retain) IBOutlet UIButton *nextRoundButton;
@property(nonatomic, retain) IBOutlet UIButton *doneButton;
@property(nonatomic, retain) IBOutlet UIButton *mainMenuButton;
@property(nonatomic, retain) IBOutlet UILabel *weaponLabel;
@property(nonatomic, retain) IBOutlet UILabel *infoLabel;
@property(nonatomic, retain) IBOutlet UILabel *playerLabel;
@property(nonatomic, retain) IBOutlet UILabel *computerLabel;
@property(nonatomic, retain) IBOutlet UILabel *roundLabel;
@property(nonatomic, retain) IBOutlet UIView *statisticsView;
@property(nonatomic, retain) NSDate *startDate;

-(id)initWithGameType:(GameType)gameType;

-(IBAction)nextRoundButtonWasPressed:(id)sender;
-(IBAction)doneButtonWasPressed:(id)sender;
-(IBAction)mainMenuButtonWasPressed:(id)sender;

@end
