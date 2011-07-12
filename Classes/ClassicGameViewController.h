//
//  ClassicGameViewController.h
//  Jankenpon
//
//  Created by Chase Colburn on 6/21/11.
//  Copyright 2011 Clever Monkey Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface ClassicGameViewController : UIViewController {
    UIButton *fightButton;
    UILabel *weaponLabel;
@private
    GameType gameType;
    NSMutableArray *gameViewTokens;
    BOOL animating;
}

@property(nonatomic, retain) IBOutlet UIButton *fightButton;
@property(nonatomic, retain) IBOutlet UILabel *weaponLabel;

-(id)initWithGameType:(GameType)gameType;

-(IBAction)fightButtonWasPressed:(id)sender;

@end
