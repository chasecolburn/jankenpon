//
//  GameTokenView.h
//  Jankenpon
//
//  Created by Chase Colburn on 6/23/11.
//  Copyright 2011 Clever Monkey Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TokenRock,
    TokenPaper,
    TokenScissors
} Token;

typedef enum {
    PlayerOne,
    PlayerTwo
} Player;

typedef enum {
    ResultWin,
    ResultLose,
    ResultDraw
} Result;

@interface GameTokenView : UIButton {
    Token token;
    Player player;
    BOOL flipped;
    BOOL selected;
    BOOL played;
}

@property(nonatomic, assign) Token token;
@property(nonatomic, assign) Player player;
@property(nonatomic, assign) BOOL flipped;
@property(nonatomic, assign) BOOL selected;
@property(nonatomic, assign) BOOL played;

-(id)initWithOrigin:(CGPoint)origin;
-(void)toggleSelected;

-(void)resetTokenTransformation:(CGFloat)delay;
-(void)flipToken:(CGFloat)delay;
-(void)setCenter:(CGPoint)center withDelay:(CGFloat)delay;
-(Result)compare:(GameTokenView*)opponent;

@end
