//
//  DHPilotManager.h
//  XDuckHunt
//
//  Created by Fallson on 8/14/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DHDuckPilot;

enum PILOT_TYPE{DUCK_NORMAL=0, DUCK_DEAD, DUCK_FLYAWAY,
                DUCK_EIGHT, DUCK_EIGHT_GROUP,
                DUCK_CIRCLE, DUCK_CIRCLE_GROUP,
                DUCK_ELLIPSE, DUCK_ELLIPSE_GROUP,
                DUCK_SIN, DUCK_SIN_GROUP,
                DUCK_ILOVEU_I, DUCK_ILOVEU_L, DUCK_ILOVEU_U};

@interface DHPilotManager : NSObject
+(DHPilotManager *)sharedDHPilotManager;
-(DHDuckPilot*)createPilot: (enum PILOT_TYPE)pilot_type andWinRect:(CGRect)rect andObjSz:(CGSize)sz andGroupID:(int)idx;
@end
