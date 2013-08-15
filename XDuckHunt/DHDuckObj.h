//
//  DHDuckObj.h
//  XDuckHunt
//
//  Created by Fallson on 7/28/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class DHDuckPilot;

enum DUCK_STATE{FLYING=0, START_DEAD, DEAD, START_FLYAWAY, FLYAWAY, DISAPPEAR};

@interface DHDuckObj : NSObject
{
    DHDuckPilot* _duck_pilot;
    enum DUCK_STATE _duck_state;
    CGSize _duck_size;
    ccTime _duck_living_time;
}
@property(nonatomic, retain) DHDuckPilot* duck_pilot;
@property(nonatomic, assign) enum DUCK_STATE duck_state;
@property(nonatomic, assign) CGSize duck_size;
@property(nonatomic, assign) ccTime duck_living_time;

-(id)initWithWinRect: (CGRect)rect;
-(void)addtoScene: (CCLayer*)layer;
-(void)update:(ccTime)dt;
-(bool)hit:(CGPoint)pnt;

@end
