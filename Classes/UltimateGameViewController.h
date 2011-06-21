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
    GameTypeMultiplePLayer
} GameType;

@interface UltimateGameViewController : UIViewController {
@private
    GameType gameType;
}

-(id)initWithGameType:(GameType)gameType;

-(IBAction)doneButtonWasPressed:(id)sender;

@end
