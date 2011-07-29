//
//  GameStatistics.m
//  Jankenpon
//
//  Created by Clayton on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameStatistics.h"

@implementation GameStatistics

@synthesize p1Score;
@synthesize p2Score;
@synthesize p1NumRock;
@synthesize p1NumPaper;
@synthesize p1NumScissors;
@synthesize p2NumRock;
@synthesize p2NumPaper;
@synthesize p2NumScissors;
@synthesize p1PercentRock;
@synthesize p1PercentPaper;
@synthesize p1PercentScissors;
@synthesize p2PercentRock;
@synthesize p2PercentPaper;
@synthesize p2PercentScissors;
@synthesize winPercentage;
@synthesize winRatio;
@synthesize elapsedTime;
@synthesize startDate;
@synthesize endDate;

-(void)dealloc {
    [startDate release];
    [endDate release];
    [super dealloc];
}

-(void)initStats {
    p1NumRock = 0;
    p1NumPaper = 0;
    p1NumScissors = 0;
    p2NumRock = 0;
    p2NumPaper = 0;
    p2NumScissors = 0;
    
    p1PercentRock = 0.0;
    p1PercentPaper = 0.0;
    p1PercentScissors = 0.0;
    p2PercentRock = 0.0;
    p2PercentPaper = 0.0;
    p2PercentScissors = 0.0;
    
    winPercentage = 0;
    winRatio = 0;
}

-(void)setStartDate {
    self.startDate = [NSDate date];
}

-(void)setEndDate {
    self.endDate = [NSDate date];
}

-(void)calculateStatistics:(int)rounds {
    elapsedTime = [endDate timeIntervalSinceDate:startDate];
    
    p1PercentRock = ((float)p1NumRock / (float)rounds) * 100.0;
    p1PercentPaper = ((float)p1NumPaper / (float)rounds) * 100.0;
    p1PercentScissors = ((float)p1NumScissors / (float)rounds) * 100.0;
    p2PercentRock = ((float)p2NumRock / (float)rounds) * 100.0;
    p2PercentPaper = ((float)p2NumPaper / (float)rounds) * 100.0;
    p2PercentScissors = ((float)p2NumScissors / (float)rounds) * 100.0;
    
    if(p1Score == 0) {
        winPercentage = 0;
        winRatio = 0;
    }else if(p2Score == 0) {
        winPercentage = 100.0;
        winRatio = 1;
    }else {
        winPercentage = ((float)p1Score / ((float)p1Score + (float)p2Score)) * 100.0;
        winRatio = (float)p1Score / (float)p2Score;
    }
}

@end