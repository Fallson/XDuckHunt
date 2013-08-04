//
//  DHPilot.h
//  XDuckHunt
//
//  Created by Fallson on 8/3/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum Direction { LEFT=0, BOTTOM, RIGHT, UP, RANDOM, IN, OUT };

#pragma mark - DHPilotProtocol
@protocol DHPilotProtocol
-(id)initWithWinRect:(CGRect)rect andObjSz:(CGSize)sz;
-(void)update:(ccTime)dt;
-(void)setStartPos:(CGPoint)pos;
-(void)setEndPos:(CGPoint)pos;
-(void)setSpeedRatio:(float)speedRatio;
-(CGPoint)getPosition;
-(float)getDetpth;
-(enum Direction)getHorizationDirection;
@end

#pragma mark - DHDuckPilot
@interface DHDuckPilot : NSObject <DHPilotProtocol>
-(id)initWithWinRect:(CGRect)rect andObjSz:(CGSize)sz;
-(void)update:(ccTime) dt;
-(void)setStartPos:(CGPoint)pos;
-(void)setEndPos:(CGPoint)pos;
-(void)setSpeedRatio:(float)speedRatio;
-(CGPoint)getPosition;
-(float)getDetpth;
-(enum Direction)getHorizationDirection;
@end

#pragma mark - DHNormalDuckPilot
@interface DHDuckNormalPilot: DHDuckPilot
-(id)initWithWinRect:(CGRect)rect andObjSz:(CGSize)sz;
-(void)update:(ccTime) dt;
-(void)setSpeedRatio:(float)speedRatio;
-(enum Direction)getHorizationDirection;
@end

#pragma mark - DHDuckDeadPilot
@interface DHDuckDeadPilot: DHDuckPilot

@end

#pragma mark - DHDuckDeadPilot
@interface DHDuckFlyawayPilot: DHDuckPilot

@end