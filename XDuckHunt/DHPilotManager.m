//
//  DHPilotManager.m
//  XDuckHunt
//
//  Created by Fallson on 8/14/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHPilotManager.h"
#import "DHPilot.h"

@implementation DHPilotManager

static DHPilotManager *_sharedDHPilotManager=nil;

+(DHPilotManager *)sharedDHPilotManager
{
	if (!_sharedDHPilotManager)
		_sharedDHPilotManager = [[DHPilotManager alloc] init];
    
	return _sharedDHPilotManager;
}

+(id)alloc
{
	NSAssert(_sharedDHPilotManager == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}

-(id)init
{
	if( (self=[super init]) )
    {
	}
    
	return self;
}

-(DHDuckPilot*)createPilot: (enum PILOT_TYPE)pilot_type andWinRect:(CGRect)rect andObjSz:(CGSize)sz andGroupID:(int)idx
{
    DHDuckPilot* pilot = nil;
    switch(pilot_type)
    {
        case DUCK_NORMAL:
            pilot = [[DHDuckNormalPilot alloc]initWithWinRect:rect andObjSz:sz];
            break;
        case DUCK_DEAD:
            pilot = [[DHDuckDeadPilot alloc]initWithWinRect:rect andObjSz:sz];
            break;
        case DUCK_FLYAWAY:
            pilot = [[DHDuckFlyawayPilot alloc]initWithWinRect:rect andObjSz:sz];
            break;
        case DUCK_EIGHT:
            pilot = [[DHDuckEightPilot alloc]initWithWinRect:rect andObjSz:sz];
            break;
        case DUCK_EIGHT_GROUP:
            pilot = [[DHDuckEightGroupPilot alloc]initWithWinRect:rect andObjSz:sz andGroupID:idx];
            break;
        case DUCK_CIRCLE:
            pilot = [[DHDuckCirclePilot alloc]initWithWinRect:rect andObjSz:sz];
            break;
        case DUCK_CIRCLE_GROUP:
            pilot = [[DHDuckCircleGroupPilot alloc]initWithWinRect:rect andObjSz:sz andGroupID:idx];
            break;
        case DUCK_ELLIPSE:
            pilot = [[DHDuckEllipsePilot alloc]initWithWinRect:rect andObjSz:sz];
            break;
        case DUCK_ELLIPSE_GROUP:
            pilot = [[DHDuckEllipseGroupPilot alloc]initWithWinRect:rect andObjSz:sz andGroupID:idx];
            break;
        case DUCK_SIN:
            pilot = [[DHDuckSinPilot alloc]initWithWinRect:rect andObjSz:sz];
            break;
        case DUCK_SIN_GROUP:
            pilot = [[DHDuckSinGroupPilot alloc]initWithWinRect:rect andObjSz:sz andGroupID:idx];
            break;
        case DUCK_ILOVEU_I:
            pilot = [[DHDuckILoveU_IPilot alloc]initWithWinRect:rect andObjSz:sz andGroupID:idx];
            break;
        case DUCK_ILOVEU_L:
            pilot = [[DHDuckILoveU_LPilot alloc]initWithWinRect:rect andObjSz:sz andGroupID:idx];
            break;
        case DUCK_ILOVEU_U:
            pilot = [[DHDuckILoveU_UPilot alloc]initWithWinRect:rect andObjSz:sz andGroupID:idx];
            break;
    }
    
    return pilot;
}

@end
