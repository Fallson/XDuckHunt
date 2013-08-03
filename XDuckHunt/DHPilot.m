//
//  DHPilot.m
//  XDuckHunt
//
//  Created by Fallson on 8/3/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHPilot.h"
#import "DHConstons.h"

#pragma mark - DHDuckPilot
@implementation DHDuckPilot
{
    int _cur_lineStep;
    int _max_lineSteps;
    
    CGPoint _startPos;
    CGPoint _endPos;
    float   _speedRatio;
    CGPoint _position;
    float   _depth;
    CGRect  _bbox;
}

-(id)initWithWinRect:(CGRect)rect
{
    if( (self=[super init]) )
    {
        _bbox = rect;
        
        _startPos = ccp(CCRANDOM_0_1()* _bbox.size.width + _bbox.origin.x,
                        _bbox.origin.y);
        _endPos = ccp(CCRANDOM_0_1()* _bbox.size.width + _bbox.origin.x,
                          CCRANDOM_0_1()* _bbox.size.height + _bbox.origin.y);
        _speedRatio = 1.0;
        _position = _startPos;
        _depth = 0.0;
        
        _cur_lineStep = 0;
        _max_lineSteps = MaxLineSteps;
	}
	return self;
}

-(void)update:(ccTime) dt
{
    
}

-(void)setStartPos:(CGPoint)pos
{
    _startPos = pos;
    _position = _startPos;
}

-(void)setEndPos:(CGPoint)pos
{
    _endPos = pos;
}

-(void)setSpeedRatio:(float)speedRatio
{
    if( speedRatio > 2.0 || speedRatio < 0.5 )
        return;
    
    _speedRatio = speedRatio;
    _max_lineSteps = MaxLineSteps/_speedRatio;
}

-(CGPoint)getPosition
{
    return _position;
}

-(enum Direction)getHorizationDirection
{
    return _startPos.x > _endPos.x? LEFT:RIGHT;
}

@end


#pragma mark - DHNormalDuckPilot
@implementation DHDuckNormalPilot

@end

#pragma mark - DHDuckDeadPilot
@implementation DHDuckDeadPilot

@end