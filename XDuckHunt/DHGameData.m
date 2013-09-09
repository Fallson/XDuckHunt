//
//  DHGameData.m
//  XDuckHunt
//
//  Created by Fallson on 9/6/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHGameData.h"

@implementation DHGameData
@synthesize cur_game_score = _cur_game_score;
@synthesize cur_game_mode = _cur_game_mode;
@synthesize timemode_scores = _timemode_scores;
@synthesize freemode_scores = _freemode_scores;

static DHGameData *_sharedDHGameData=nil;

+(DHGameData *)sharedDHGameData
{
	if (!_sharedDHGameData)
		_sharedDHGameData = [[DHGameData alloc] init];
    
	return _sharedDHGameData;
}

+(id)alloc
{
	NSAssert(_sharedDHGameData == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}

-(id)init
{
	if( (self=[super init]) )
    {
        [self loadScores];
        self.cur_game_mode = TIME_MODE;
        self.cur_game_score = 0;
	}
    
	return self;
}

-(void)loadScores
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    self.timemode_scores = [settings objectForKey:@"timemode_scores"];
    self.freemode_scores = [settings objectForKey:@"freemode_scores"];
}

-(void)saveScores:(enum GAME_MODE)game_mode
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    if( game_mode == TIME_MODE )
        [settings setObject: self.timemode_scores forKey:@"timemode_scores"];
    else if( game_mode == FREE_MODE )
        [settings setObject: self.freemode_scores forKey:@"freemode_scores"];
    [settings synchronize];
}

-(void)addScore:(int)sc gameMode:(enum GAME_MODE)game_mode
{
    NSMutableArray* s = nil;
    if( game_mode == TIME_MODE )
        s = self.timemode_scores;
    else if( game_mode == FREE_MODE)
        s = self.freemode_scores;
    
    [s addObject:sc];
    [s sortUsingComparator:
    ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;}
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;}
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    while( [s count] > 10 )
    {
        [s removeLastObject];
    }
    
    [self saveScores:game_mode];
}

-(int)getHighestScore:(enum GAME_MODE)game_mode
{
    if( game_mode == TIME_MODE )
    {
        if( [self.timemode_scores count] > 0 )
            return [self.timemode_scores objectAtIndex:0];
    }
    else if( game_mode == FREE_MODE )
    {
        if( [self.freemode_scores count] > 0 )
            return [self.freemode_scores objectAtIndex:0];
    }
    
    return 0;
}

@end
