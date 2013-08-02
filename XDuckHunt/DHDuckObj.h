//
//  DHDuckObj.h
//  XDuckHunt
//
//  Created by Fallson on 7/28/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DHDuckPilot: NSObject

@end

enum DUCK_STATE{FLYING=0, SHOT, DEAD};

@interface DHDuckObj : NSObject
{
    DHDuckPilot* _duck_pilot;
    enum DUCK_STATE _duck_state;
}

@property(nonatomic, retain) DHDuckPilot* duck_pilot;
@property(nonatomic, assign) enum DUCK_STATE duck_state;

-(id)initWithWinSZ: (CGSize)sz;
-(void)addtoScene: (CCLayer*)layer;
-(void)update:(ccTime)dt;
-(bool)hit:(CGPoint)pnt;

@end
