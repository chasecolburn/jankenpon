//
//  UltimateGameViewController.h
//  Jankenpon
//
//  Created by Chase Colburn on 6/21/11.
//  Copyright 2011 Clever Monkey Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GameTypeSinglePlayer,
    GameTypeMultiplePlayer
} GameType;

@interface UltimateGameViewController : UIViewController {
    UIButton *fightButton;
    UILabel *resultLabel;
@private
    GameType gameType;
    NSMutableArray *gameViewTokens;
    BOOL animating;
}

@property(nonatomic, retain) IBOutlet UIButton *fightButton;
@property(nonatomic, retain) IBOutlet UILabel *resultLabel;

-(id)initWithGameType:(GameType)gameType;

-(IBAction)doneButtonWasPressed:(id)sender;
-(IBAction)fightButtonWasPressed:(id)sender;

@end
