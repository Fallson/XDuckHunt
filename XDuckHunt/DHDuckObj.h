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

enum DUCK_STATE{FLYING=0, SHOT, DEAD, FLYAWAY};

@interface DHDuckObj : NSObject

@property(nonatomic, retain) DHDuckPilot* duck_pilot;
@property(nonatomic, assign) enum DUCK_STATE duck_state;
@property(nonatomic, readonly) CGSize duck_size;

-(id)initWithWinRect: (CGRect)rect;
-(void)addtoScene: (CCLayer*)layer;
-(void)update:(ccTime)dt;
-(bool)hit:(CGPoint)pnt;

@end
