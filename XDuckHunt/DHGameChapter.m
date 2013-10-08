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

#define CREATE_DUCKS_IN_LOOP DHDuckObj* duck1 = [[DHDuckObj alloc] initWithWinRect:rect];\
                             duck1.duck_pilot = [[DHPilotManager sharedDHPilotManager] createPilot:ptypes[i] andWinRect:rect andObjSz:duck1.duck_size andGroupID:i];\
                             [duck1.duck_pilot setSpeedRatio:speeds[i]];\
                             [duck1 updatePos: [duck1.duck_pilot getPosition]];\
                             [ducks addObject:duck1];\

#define CREATE_DUCKS for( int i = 0; i < sizeof(ptypes)/sizeof(enum PILOT_TYPE); i++ ){\
                     CREATE_DUCKS_IN_LOOP}\
//
//#define CREATE_DUCKS for( int i = 0; i < sizeof(ptypes)/sizeof(enum PILOT_TYPE); i++ ){\
//    DHDuckObj* duck1 = [[DHDuckObj alloc] initWithWinRect:rect];\
//    duck1.duck_pilot = [[DHPilotManager sharedDHPilotManager] createPilot:ptypes[i] andWinRect:rect andObjSz:duck1.duck_size andGroupID:i];\
//    [duck1.duck_pilot setSpeedRatio:speeds[i]];\
//    [duck1 updatePos: [duck1.duck_pilot getPosition]];\
//    [ducks addObject:duck1];}\


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
        float speeds[] = {1.0, 1.0, 1.0};
        
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_NORMAL};
        float speeds[] = {1.0};
        
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
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_NORMAL, DUCK_SIN,
                                    DUCK_ELLIPSE};
        float speeds[] = {1.0, 1.0, 1.0, 1.0};
        
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_NORMAL};
        float speeds[] = {1.0, 1.0};
        
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
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_SIN,
                                    DUCK_NORMAL, DUCK_EIGHT};
        float speeds[] = {1.0, 1.0, 1.0, 1.0, 1.0};
        
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_NORMAL};
        float speeds[] = {1.0, 1.0, 1.0};
        
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
                                    DUCK_NORMAL, DUCK_EIGHT};
        float speeds[] = {1.0, 1.0, 1.0, 1.0, 1.0, 1.0};
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_ELLIPSE, DUCK_SIN,
                                    DUCK_NORMAL};
        float speeds[] = {1.0, 1.0, 1.0, 1.0};
        
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
                                    DUCK_NORMAL, DUCK_EIGHT};
        float speeds[] = {1.0, 1.2, 1.2, 1.2, 1.0, 1.0};
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_ELLIPSE, DUCK_SIN,
                                    DUCK_NORMAL};
        float speeds[] = {1.0, 1.2, 1.2, 1.0};
        
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
                                    DUCK_NORMAL, DUCK_NORMAL, DUCK_EIGHT};
        float speeds[] = {1.0, 1.2, 1.2, 1.0, 1.0, 1.2, 1.0};
        
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
                                    DUCK_NORMAL};
        float speeds[] = {1.0, 1.2, 1.2, 1.0, 1.0};
        
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
                                    DUCK_NORMAL, DUCK_NORMAL, DUCK_EIGHT, DUCK_SIN};
        float speeds[] = {1.0, 1.2, 1.2, 1.0, 1.0, 1.2, 1.2, 1.0};
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
                                    DUCK_NORMAL, DUCK_EIGHT};
        float speeds[] = {1.0, 1.2, 1.2, 1.0, 1.0, 1.2};
        
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
                                    DUCK_NORMAL, DUCK_NORMAL, DUCK_EIGHT, DUCK_SIN};
        float speeds[] = {1.2, 1.5, 1.5, 1.2, 1.0, 1.5, 1.5, 1.2};
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
                                    DUCK_NORMAL, DUCK_EIGHT};
        float speeds[] = {1.2, 1.5, 1.5, 1.2, 1.2, 1.5};
        
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
                                    DUCK_ELLIPSE};
        float speeds[] = {1.2, 1.5, 1.5, 1.2, 1.2, 1.5, 1.2, 1.2, 1.5};
        
        CREATE_DUCKS
    }
    else if( [DHGameData sharedDHGameData].cur_game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
                                    DUCK_NORMAL, DUCK_EIGHT, DUCK_CIRCLE};
        float speeds[] = {1.2, 1.5, 1.5, 1.2, 1.2, 1.5, 1.2};
        
        CREATE_DUCKS
    }
    else
    {
    }
}

#define LAST_CHP_DUCK_NUM 12
-(void)setDucks_Chapter10:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    enum PILOT_TYPE ptypes[LAST_CHP_DUCK_NUM];
    float speeds[LAST_CHP_DUCK_NUM];
    for( int i = 0; i < LAST_CHP_DUCK_NUM; i++ )
    {
        ptypes[i] = DUCK_NORMAL;
        speeds[i] = 1.5 + (float)(arc4random()%10)/(float)10.0;
        if( speeds[i] > 2.5 )
            speeds[i] = 2.5;
    }
    
    CREATE_DUCKS
}

#define FUNNY_CHP_DUCK_NUM 20
-(void)setDucks_ChapterFunny:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
//    enum PILOT_TYPE ptypes_candidates[] = {DUCK_EIGHT_GROUP, DUCK_CIRCLE_GROUP, DUCK_ELLIPSE_GROUP,
//                                           DUCK_SIN_GROUP, DUCK_ILOVEU_I, DUCK_ILOVEU_L, DUCK_ILOVEU_U};
        enum PILOT_TYPE ptypes_candidates[] = {DUCK_ILOVEU_I, DUCK_ILOVEU_L, DUCK_ILOVEU_U};
    
    enum PILOT_TYPE type = ptypes_candidates[arc4random()%(sizeof(ptypes_candidates)/sizeof(enum PILOT_TYPE))];
    
    switch(type)
    {
        case DUCK_EIGHT_GROUP:
        case DUCK_CIRCLE_GROUP:
        case DUCK_ELLIPSE_GROUP:
        case DUCK_SIN_GROUP:
        {
            enum PILOT_TYPE ptypes[FUNNY_CHP_DUCK_NUM];
            float speeds[FUNNY_CHP_DUCK_NUM];
            for( int i = 0; i < FUNNY_CHP_DUCK_NUM; i++ )
            {
                ptypes[i] = type;
                speeds[i] = 1.0;
            }
            
            CREATE_DUCKS
        }
            break;
        case DUCK_ILOVEU_I:
        case DUCK_ILOVEU_L:
        case DUCK_ILOVEU_U:
        {
            //I
            enum PILOT_TYPE ptypes[FUNNY_CHP_DUCK_NUM];
            float speeds[FUNNY_CHP_DUCK_NUM];
            for( int i = 0; i < 5; i++ )
            {
                ptypes[i] = DUCK_ILOVEU_I;
                speeds[i] = 1.0;
            }
            for( int i = 0; i < 5; i++ )
            {
                CREATE_DUCKS_IN_LOOP
            }
            
            //Love
            for( int i = 0; i < FUNNY_CHP_DUCK_NUM; i++ )
            {
                ptypes[i] = DUCK_ILOVEU_L;
                speeds[i] = 1.0;
            }
            for( int i = 0; i < FUNNY_CHP_DUCK_NUM; i++ )
            {
                CREATE_DUCKS_IN_LOOP
            }
            
            //U
            for( int i = 0; i < 11; i++ )
            {
                ptypes[i] = DUCK_ILOVEU_U;
                speeds[i] = 1.0;
            }
            for( int i = 0; i < 11; i++ )
            {
                CREATE_DUCKS_IN_LOOP
            }
        }
            break;
        
        default:
            break;
    }
}

-(NSMutableArray*)getDucks:(enum CHAPTER_LVL) lvl andWinRect:(CGRect)rect
{
    if( lvl < CHAPTER1 || lvl >= CHAPTER_MAX )
        return nil;
    
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
        @selector(setDucks_Chapter10:andWinRect:),
        @selector(setDucks_ChapterFunny:andWinRect:)};
    
    NSMutableArray* ducks = [NSMutableArray array];
    NSValue* rectValue = [NSValue valueWithCGRect:rect];
    [self performSelector:funs[(int)lvl] withObject:ducks withObject:rectValue];
    
    return ducks;
}

@end
