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
@synthesize bgMusic = _bgMusic;
@synthesize gameMusic = _gameMusic;
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
        [self loadMusics];
        self.cur_game_mode = TIME_MODE;
        self.cur_game_score = 0;
	}
    
	return self;
}

#pragma mark - score part
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
    
    while( [s count] > 5 )
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
            return [[self.timemode_scores objectAtIndex:0] intValue];
    }
    else if( game_mode == FREE_MODE )
    {
        if( [self.freemode_scores count] > 0 )
            return [[self.freemode_scores objectAtIndex:0] intValue];
    }
    
    return 0;
}

#pragma mark - sound part
-(void)loadMusics
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
    if( [settings objectForKey:@"bgMusic"] == nil )
    {
        self.bgMusic = 1;
    }
    else
    {
        self.bgMusic = [[settings objectForKey:@"bgMusic"] intValue];
    }
    
    if( [settings objectForKey:@"gameMusic"] == nil )
    {
        self.gameMusic = 1;
    }
    else
    {
        self.gameMusic = [[settings objectForKey:@"gameMusic"] intValue];
    }
}

-(void)addBGMusic:(int)v
{
    self.bgMusic = v;
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setObject: [NSNumber numberWithInt:v] forKey:@"bgMusic"];
    [settings synchronize];
}

-(void)addGameMusic:(int)v
{
    self.gameMusic = v;
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setObject: [NSNumber numberWithInt:v] forKey:@"gameMusic"];
    [settings synchronize];
}

@end
