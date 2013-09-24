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
    
    if( [settings objectForKey:@"timemode_scores"] == nil )
    {
        self.timemode_scores = [NSMutableArray array];
    }
    else
    {
        self.timemode_scores = [NSMutableArray arrayWithArray: [settings objectForKey:@"timemode_scores"]];
    }
    
    if( [settings objectForKey:@"freemode_scores"] == nil )
    {
        self.freemode_scores = [NSMutableArray array];
    }
    else
    {
        self.freemode_scores = [NSMutableArray arrayWithArray:[settings objectForKey:@"freemode_scores"]];
    }
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
    if( sc == 0 )
        return;
    
    NSMutableArray* s = nil;
    if( game_mode == TIME_MODE )
        s = self.timemode_scores;
    else if( game_mode == FREE_MODE)
        s = self.freemode_scores;
    
    int i = 0;
    for( ; i < [s count]; i++ )
    {
        if( [[s objectAtIndex:i] intValue] <= sc )
        {
            break;
        }
    }
    [s insertObject:[NSNumber numberWithInt:sc] atIndex:i];
    
    NSLog(@"1.addScore scorelist count:%@", s);
    
    while( [s count] > 5 )
    {
        [s removeLastObject];
    }
    
    NSLog(@"2.addScore scorelist count:%@", s);
    
    [self saveScores:game_mode];
}

-(int)getHighestScore:(enum GAME_MODE)game_mode
{
    if( game_mode == TIME_MODE )
    {
        if( [self.timemode_scores count] > 0 )
            return [[self.timemode_scores objectAtIndex:0] intValue];
    }
    else if( game_mode == FREE_MODE )
    {
        if( [self.freemode_scores count] > 0 )
            return [[self.freemode_scores objectAtIndex:0] intValue];
    }
    
    return 0;
}

@end
