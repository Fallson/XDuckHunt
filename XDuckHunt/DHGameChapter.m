//
//  DHGameChapter.m
//  XDuckHunt
//
//  Created by Fallson on 8/5/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHGameChapter.h"
#import "DHDuckObj.h"
#import "DHPilotManager.h"
#import "DHPilot.h"
#import "DHGameData.h"


#define CREATE_DUCKS for( int i = 0; i < sizeof(ptypes)/sizeof(enum PILOT_TYPE); i++ ){\
    DHDuckObj* duck1 = [[DHDuckObj alloc] initWithWinRect:rect];\
    duck1.duck_pilot = [[DHPilotManager sharedDHPilotManager] createPilot:ptypes[i] andWinRect:rect andObjSz:duck1.duck_size];\
    [duck1 updatePos: [duck1.duck_pilot getPosition]];\
    [ducks addObject:duck1];}\


@implementation DHGameChapter

static DHGameChapter *_sharedDHGameChapter=nil;

+(DHGameChapter *)sharedDHGameChapter
{
	if (!_sharedDHGameChapter)
		_sharedDHGameChapter = [[DHGameChapter alloc] init];
    
	return _sharedDHGameChapter;
}

+(id)alloc
{
	NSAssert(_sharedDHGameChapter == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}

-(id)init
{
	if( (self=[super init]) )
    {
	}
    
	return self;
}

-(void)setDucks_Chapter1:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    if( [DHGameData sharedDHGameData].cur_game_mode == TIME_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_NORMAL, DUCK_NORMAL};
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_NORMAL};
        CREATE_DUCKS
    }
    else
    {
        
    }
}

-(void)setDucks_Chapter2:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    if( [DHGameData sharedDHGameData].cur_game_mode == TIME_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_NORMAL, DUCK_NORMAL, DUCK_SIN,
                                    DUCK_ELLIPSE};
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_NORMAL};
        CREATE_DUCKS
    }
    else
    {
    }
}

-(void)setDucks_Chapter3:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    if( [DHGameData sharedDHGameData].cur_game_mode == TIME_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
                                    DUCK_NORMAL, DUCK_NORMAL, DUCK_EIGHT};
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN};
        CREATE_DUCKS
    }
    else
    {
    }
}

-(void)setDucks_Chapter4:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    if( [DHGameData sharedDHGameData].cur_game_mode == TIME_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
                                    DUCK_NORMAL, DUCK_NORMAL, DUCK_EIGHT, DUCK_SIN,
                                    DUCK_ELLIPSE};
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
                                    DUCK_NORMAL, DUCK_EIGHT};
        CREATE_DUCKS
    }
    else
    {
    }
}

-(void)setDucks_Chapter5:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    if( [DHGameData sharedDHGameData].cur_game_mode == TIME_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
                                    DUCK_NORMAL, DUCK_NORMAL, DUCK_EIGHT, DUCK_SIN,
                                    DUCK_ELLIPSE, DUCK_CIRCLE, DUCK_ELLIPSE};
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
                                    DUCK_NORMAL, DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE};
        CREATE_DUCKS
    }
    else
    {
    }
}

-(void)setDucks_Chapter6:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    if( [DHGameData sharedDHGameData].cur_game_mode == TIME_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
            DUCK_NORMAL, DUCK_NORMAL, DUCK_EIGHT, DUCK_SIN,
            DUCK_ELLIPSE, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_NORMAL, DUCK_EIGHT};
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
            DUCK_NORMAL, DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_NORMAL, DUCK_EIGHT};
        CREATE_DUCKS
    }
    else
    {
    }
}

-(void)setDucks_Chapter7:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    if( [DHGameData sharedDHGameData].cur_game_mode == TIME_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
            DUCK_NORMAL, DUCK_NORMAL, DUCK_EIGHT, DUCK_SIN,
            DUCK_ELLIPSE, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_NORMAL, DUCK_EIGHT,
            DUCK_EIGHT, DUCK_SIN};
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
            DUCK_NORMAL, DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_NORMAL, DUCK_EIGHT,
            DUCK_EIGHT, DUCK_SIN};
        CREATE_DUCKS
    }
    else
    {
    }
}

-(void)setDucks_Chapter8:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    if( [DHGameData sharedDHGameData].cur_game_mode == TIME_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
            DUCK_NORMAL, DUCK_NORMAL, DUCK_EIGHT, DUCK_SIN,
            DUCK_ELLIPSE, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_NORMAL, DUCK_EIGHT,
            DUCK_EIGHT, DUCK_SIN, DUCK_EIGHT, DUCK_SIN};
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
            DUCK_NORMAL, DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_NORMAL, DUCK_EIGHT,
            DUCK_EIGHT, DUCK_SIN, DUCK_EIGHT, DUCK_SIN};
        CREATE_DUCKS
    }
    else
    {
    }
}

-(void)setDucks_Chapter9:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    if( [DHGameData sharedDHGameData].cur_game_mode == TIME_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
            DUCK_NORMAL, DUCK_NORMAL, DUCK_EIGHT, DUCK_SIN,
            DUCK_ELLIPSE, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_NORMAL, DUCK_EIGHT,
            DUCK_EIGHT, DUCK_SIN, DUCK_EIGHT, DUCK_SIN, DUCK_CIRCLE, DUCK_ELLIPSE};
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
            DUCK_NORMAL, DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_NORMAL, DUCK_EIGHT,
            DUCK_EIGHT, DUCK_SIN, DUCK_EIGHT, DUCK_SIN, DUCK_CIRCLE, DUCK_ELLIPSE};
        CREATE_DUCKS
    }
    else
    {
    }
}

-(void)setDucks_Chapter10:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    enum PILOT_TYPE ptypes[50];
    for( int i = 0; i < 50; i++ )
        ptypes[i] = DUCK_NORMAL;
    
    CREATE_DUCKS
}

-(NSMutableArray*)getDucks:(enum CHAPTER_LVL) lvl andWinRect:(CGRect)rect
{
    SEL funs[] = {
        @selector(setDucks_Chapter1:andWinRect:),
        @selector(setDucks_Chapter2:andWinRect:),
        @selector(setDucks_Chapter3:andWinRect:),
        @selector(setDucks_Chapter4:andWinRect:),
        @selector(setDucks_Chapter5:andWinRect:),
        @selector(setDucks_Chapter6:andWinRect:),
        @selector(setDucks_Chapter7:andWinRect:),
        @selector(setDucks_Chapter8:andWinRect:),
        @selector(setDucks_Chapter9:andWinRect:),
        @selector(setDucks_Chapter10:andWinRect:)};
    
    NSMutableArray* ducks = [NSMutableArray array];
    NSValue* rectValue = [NSValue valueWithCGRect:rect];
    [self performSelector:funs[(int)lvl] withObject:ducks withObject:rectValue];
    
    return ducks;
}

@end
