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
    UIButton *fightButton;
    UILabel *weaponLabel;
    UILabel *infoLabel;
@private
    GameType gameType;
    NSMutableArray *gameViewTokens;
    GameTokenView *opponentTokenView;
    BOOL animating;
}

@property(nonatomic, retain) IBOutlet UIButton *fightButton;
@property(nonatomic, retain) IBOutlet UILabel *weaponLabel;
@property(nonatomic, retain) IBOutlet UILabel *infoLabel;

-(id)initWithGameType:(GameType)gameType;

-(IBAction)fightButtonWasPressed:(id)sender;

@end
