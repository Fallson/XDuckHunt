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


#define CREATE_DUCKS for( int i = 0; i < sizeof(ptypes)/sizeof(enum PILOT_TYPE); i++ ){\
    DHDuckObj* duck1 = [[DHDuckObj alloc] initWithWinRect:_winRect];\
    duck1.duck_pilot = [[DHPilotManager sharedDHPilotManager] createPilot:ptypes[i] andWinRect:_winRect andObjSz:duck1.duck_size];\
    [duck1 updatePos: [duck1.duck_pilot getPosition]];\
    [ducks addObject:duck1];}\

@interface DHGameChapter()
@property(nonatomic, retain)NSMutableArray* chapters;
@end

@implementation DHGameChapter
{
    CGRect _winRect;
}
@synthesize game_mode = _game_mode;
@synthesize chapters = _chapters;


-(id)initWithWinRect: (CGRect)rect
{
    if( self = [super init] )
    {
        _winRect = rect;
         
        self.chapters = [[NSMutableArray alloc] init];
        for( int i = 0; i < CHAPTER_MAX; i++)
        {
            NSMutableArray* ducks = [[NSMutableArray alloc] init];
            [self.chapters addObject:ducks];
        }
        
        _game_mode = TIME_MODE;
    }
    
    return self;
}

-(void)setDucks_Chapter1:(NSMutableArray*)ducks
{
    if( self.game_mode == TIME_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_NORMAL, DUCK_NORMAL};
        CREATE_DUCKS
    }
    else if( self.game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_NORMAL};
        CREATE_DUCKS
    }
    else
    {
        
    }
}

-(void)setDucks_Chapter2:(NSMutableArray*)ducks
{
    if( self.game_mode == TIME_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_NORMAL, DUCK_NORMAL, DUCK_SIN, DUCK_ELLIPSE};
        CREATE_DUCKS
    }
    else if( self.game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_NORMAL};
        CREATE_DUCKS
    }
    else
    {
    }
}

-(void)setDucks_Chapter3:(NSMutableArray*)ducks
{
    if( self.game_mode == TIME_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN, DUCK_NORMAL, DUCK_NORMAL, DUCK_EIGHT};
        CREATE_DUCKS
    }
    else if( self.game_mode == FREE_MODE )
    {
        enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN};
        CREATE_DUCKS
    }
    else
    {
    }
}

-(void)setDucks_Chapter4:(NSMutableArray*)ducks
{
    if( self.game_mode == TIME_MODE )
    {
    }
    else if( self.game_mode == FREE_MODE )
    {
    }
    else
    {
    }
}

-(void)setDucks_Chapter5:(NSMutableArray*)ducks
{
    if( self.game_mode == TIME_MODE )
    {
    }
    else if( self.game_mode == FREE_MODE )
    {
    }
    else
    {
    }
}

-(void)setDucks_Chapter6:(NSMutableArray*)ducks
{
    if( self.game_mode == TIME_MODE )
    {
    }
    else if( self.game_mode == FREE_MODE )
    {
    }
    else
    {
    }
}

-(void)setDucks_Chapter7:(NSMutableArray*)ducks
{
    if( self.game_mode == TIME_MODE )
    {
    }
    else if( self.game_mode == FREE_MODE )
    {
    }
    else
    {
    }
}

-(void)setDucks_Chapter8:(NSMutableArray*)ducks
{
    if( self.game_mode == TIME_MODE )
    {
    }
    else if( self.game_mode == FREE_MODE )
    {
    }
    else
    {
    }
}

-(void)setDucks_Chapter9:(NSMutableArray*)ducks
{
    if( self.game_mode == TIME_MODE )
    {
    }
    else if( self.game_mode == FREE_MODE )
    {
    }
    else
    {
    }
}

-(void)setDucks_Chapter10:(NSMutableArray*)ducks
{
    if( self.game_mode == TIME_MODE )
    {
    }
    else if( self.game_mode == FREE_MODE )
    {
    }
    else
    {
    }
}

-(NSMutableArray*)getDucks:(enum CHAPTER_LVL) lvl
{
    SEL funs[] = {
        @selector(setDucks_Chapter1:),
        @selector(setDucks_Chapter2:),
        @selector(setDucks_Chapter3:),
        @selector(setDucks_Chapter4:),
        @selector(setDucks_Chapter5:),
        @selector(setDucks_Chapter6:),
        @selector(setDucks_Chapter7:),
        @selector(setDucks_Chapter8:),
        @selector(setDucks_Chapter9:),
        @selector(setDucks_Chapter10:)};
    
    NSMutableArray* ducks = [self.chapters objectAtIndex:(int)lvl];
    if( [ducks count] == 0 )
    {
        [self performSelector:funs[(int)lvl] withObject:ducks];
    }
    return ducks;
}

- (void) dealloc
{
    for( int i = 0; i < CHAPTER_MAX; i++)
    {
        NSMutableArray* ducks = [self.chapters objectAtIndex:i];
        [ducks release];
    }
    [self.chapters release];
    
	[super dealloc];
}

@end
