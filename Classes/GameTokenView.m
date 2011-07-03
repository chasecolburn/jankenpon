//
//  GameTokenView.m
//  Jankenpon
//
//  Created by Chase Colburn on 6/23/11.
//  Copyright 2011 Clever Monkey Technologies. All rights reserved.
//

#import "GameTokenView.h"


@interface GameTokenView()
-(UIImage*)tokenImage;
@end

@implementation GameTokenView

@synthesize token;
@synthesize player;
@synthesize flipped;
@synthesize selected;
@synthesize played;

-(id)initWithOrigin:(CGPoint)origin {
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, 80, 80)];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
        flipped = NO;
        selected = NO;
        played = NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)dealloc {
    [super dealloc];
}

-(void)setToken:(Token)_token {
    token = _token;
    [self setImage:[self tokenImage] forState:UIControlStateNormal];
}

-(void)toggleSelected {
    self.selected = !selected;
}

-(void)setSelected:(BOOL)_selected {
    if(selected != _selected) {
        selected = _selected;
        CGFloat x = player == PlayerOne ? (selected ? 40 : 0) : (selected ? -40 : 0);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4];
        self.transform = CGAffineTransformMakeTranslation(x, 0);
        [UIView commitAnimations]; 
    }
}

-(void)resetTokenTransformation:(CGFloat)delay {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelay:delay];
    self.transform = CGAffineTransformIdentity;
    [UIView commitAnimations]; 
}

-(void)flipToken:(CGFloat)delay {
    flipped = !flipped;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6];
    [UIView setAnimationDelay:delay];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
    [UIView commitAnimations];
    if(flipped) {
        [self setImage:[UIImage imageNamed:@"token_monkey.png"] forState:UIControlStateNormal];
    }else {
        [self setImage:[self tokenImage] forState:UIControlStateNormal];
    }
}

-(void)setCenter:(CGPoint)center withDelay:(CGFloat)delay {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelay:delay];
    self.transform = CGAffineTransformIdentity;
    self.center = center;
    [UIView commitAnimations];
}

-(UIImage*)tokenImage {
    switch(token) {
        case TokenRock:
            return [UIImage imageNamed:@"token_rock.png"];
        case TokenPaper:
            return [UIImage imageNamed:@"token_paper.png"];
        case TokenScissors:
            return [UIImage imageNamed:@"token_scissors.png"];
        default:
            return nil;
    }
}

-(Result)compare:(GameTokenView*)opponent {
    switch(token) {
        case TokenRock:
            switch(opponent.token) {
                case TokenRock:
                    return ResultDraw;
                case TokenPaper:
                    return ResultLose;
                case TokenScissors:
                    return ResultWin;
            }
        case TokenPaper:
            switch(opponent.token) {
                case TokenRock:
                    return ResultWin;
                case TokenPaper:
                    return ResultDraw;
                case TokenScissors:
                    return ResultLose;
            }
        case TokenScissors:
            switch(opponent.token) {
                case TokenRock:
                    return ResultLose;
                case TokenPaper:
                    return ResultWin;
                case TokenScissors:
                    return ResultDraw;
            }
    }
    return ResultDraw;
}

@end
