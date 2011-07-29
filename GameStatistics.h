//
//  GameStatistics.h
//  Jankenpon
//
//  Created by Clayton on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameStatistics : NSObject {
@public
    int p1Score;
    int p2Score;
    int p1NumRock;
    int p1NumPaper;
    int p1NumScissors;
    int p2NumRock;
    int p2NumPaper;
    int p2NumScissors;
    float p1PercentRock;
    float p1PercentPaper;
    float p1PercentScissors;
    float p2PercentRock;
    float p2PercentPaper;
    float p2PercentScissors;
    float winPercentage;
    float winRatio;
    NSTimeInterval elapsedTime;
@private
    NSDate *startDate;
    NSDate *endDate;
}

@property(nonatomic, assign) int p1Score;
@property(nonatomic, assign) int p2Score;
@property(nonatomic, assign) int p1NumRock;
@property(nonatomic, assign) int p1NumPaper;
@property(nonatomic, assign) int p1NumScissors;
@property(nonatomic, assign) int p2NumRock;
@property(nonatomic, assign) int p2NumPaper;
@property(nonatomic, assign) int p2NumScissors;
@property(nonatomic, assign) float p1PercentRock;
@property(nonatomic, assign) float p1PercentPaper;
@property(nonatomic, assign) float p1PercentScissors;
@property(nonatomic, assign) float p2PercentRock;
@property(nonatomic, assign) float p2PercentPaper;
@property(nonatomic, assign) float p2PercentScissors;
@property(nonatomic, assign) float winPercentage;
@property(nonatomic, assign) float winRatio;
@property(nonatomic, assign) NSTimeInterval elapsedTime;
@property(nonatomic, retain) NSDate *startDate;
@property(nonatomic, retain) NSDate *endDate;

-(void)initStats;
-(void)setStartDate;
-(void)setEndDate;
-(void)calculateStatistics:(int)rounds;

@end
