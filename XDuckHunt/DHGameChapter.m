//
//  DHGameChapter.m
//  XDuckHunt
//
//  Created by Fallson on 8/5/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHGameChapter.h"
#import "DHDuckObj.h"
#import "DHPilot.h"

@implementation DHGameChapter
{
    NSMutableArray * _chapters;
    
    CGRect _winRect;
}

-(id)initWithWinRect: (CGRect)rect
{
    if( self = [super init] )
    {
        _winRect = rect;
        
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
        
        _chapters = [[NSMutableArray alloc] init];
        
        for( int i = 0; i < CHAPTER_MAX; i++)
        {
            NSMutableArray* ducks = [[NSMutableArray alloc] init];
            [self performSelector:funs[i] withObject:ducks];
            
            [_chapters addObject:ducks];
        }
    }
    
    return self;
}

-(void)setDucks_Chapter1:(NSMutableArray*)ducks
{
    DHDuckObj* duck1 = [[DHDuckObj alloc] initWithWinRect:_winRect];
    DHDuckPilot* pilot1 = [[DHDuckEightPilot alloc] initWithWinRect:_winRect andObjSz:duck1.duck_size];
    duck1.duck_pilot = pilot1;
    [ducks addObject:duck1];
    
    DHDuckObj* duck2 = [[DHDuckObj alloc] initWithWinRect:_winRect];
    DHDuckPilot* pilot2 = [[DHDuckNormalPilot alloc] initWithWinRect:_winRect andObjSz:duck2.duck_size];
    duck2.duck_pilot = pilot2;
    [ducks addObject:duck2];
    
   /*
    DHDuckObj* duck3 = [[DHDuckObj alloc] initWithWinRect:_winRect];
    DHDuckPilot* pilot3 = [[DHDuckNormalPilot alloc] initWithWinRect:_winRect andObjSz:duck3.duck_size];
    duck3.duck_pilot = pilot3;
    [ducks addObject:duck3];
     */
}

-(void)setDucks_Chapter2:(NSMutableArray*)ducks
{
    //
}

-(void)setDucks_Chapter3:(NSMutableArray*)ducks
{
    //
}

-(void)setDucks_Chapter4:(NSMutableArray*)ducks
{
    //
}

-(void)setDucks_Chapter5:(NSMutableArray*)ducks
{
    //
}

-(void)setDucks_Chapter6:(NSMutableArray*)ducks
{
    //
}

-(void)setDucks_Chapter7:(NSMutableArray*)ducks
{
    //
}

-(void)setDucks_Chapter8:(NSMutableArray*)ducks
{
    //
}

-(void)setDucks_Chapter9:(NSMutableArray*)ducks
{
    //
}

-(void)setDucks_Chapter10:(NSMutableArray*)ducks
{
    //
}

-(NSMutableArray*)getDucks:(enum Chapter_lvl) lvl
{
    return [_chapters objectAtIndex:(int)lvl];
}

- (void) dealloc
{
	[super dealloc];
}

@end
