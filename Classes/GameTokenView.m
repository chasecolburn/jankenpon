//
//  GameTokenView.m
//  Jankenpon
//
//  Created by Chase Colburn on 6/23/11.
//  Copyright 2011 Clever Monkey Technologies. All rights reserved.
//

#import "GameTokenView.h"


@implementation GameTokenView

-(id)initWithOrigin:(CGPoint)origin {
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, 60, 90)];
    if (self) {
        // Initialization code
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"token_background.png"]];
        [self addSubview:backgroundView];
        [backgroundView release];
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

@end
