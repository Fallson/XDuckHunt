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
@protected
    int _cur_lineStep;
    int _max_lineSteps;
    
    CGPoint _startPos;
    CGPoint _endPos;
    float   _speedRatio;
    CGPoint _position;
    float   _depth;
    
    CGRect  _bbox;
    CGSize  _objSz;
}

-(CGPoint)centerPnt:(CGRect)rect
{
    CGPoint cp =  {rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height/2};
    return cp;
}

-(id)initWithWinRect:(CGRect)rect andObjSz:(CGSize)sz
{
    if( (self=[super init]) )
    {
        CGRect t_bbox = {{rect.origin.x + sz.width/2, rect.origin.y + sz.height/2},
            {rect.size.width - sz.width, rect.size.height - sz.height}};
        
        _bbox = t_bbox;
        _objSz = sz;
        
        _startPos = ccp(arc4random()%((int)_bbox.size.width) + _bbox.origin.x,
                        _bbox.origin.y);
        
        
        int r = min(_bbox.size.width, _bbox.size.height);
        r /= (CURVE_RATIO * 2);
        _endPos = [self centerPnt:_bbox];
        //NSLog(@"r is %d, and _endPos(%f,%f)", r, _endPos.x, _endPos.y);
        _endPos.x += ((int)(arc4random()%(2*r))-r);
        _endPos.y += ((int)(arc4random()%(2*r))-r);
       
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
    if (_cur_lineStep <= 0)
    {
        _cur_lineStep++;
    }
    else if (_cur_lineStep <= _max_lineSteps)
    {
        if( fabs(_endPos.x - _startPos.x) < EPS )
        {
            double dy = (_endPos.y - _startPos.y)/_max_lineSteps;
            _position.y = (float)(_startPos.y + dy * _cur_lineStep);
        }
        else
        {
            double k = (_endPos.y - _startPos.y) / (_endPos.x - _startPos.x);
            double dx = (double)((_endPos.x - _startPos.x) / _max_lineSteps);
            _position.x = (float)(_startPos.x + dx * _cur_lineStep);
            _position.y = (float)(_startPos.y + k * dx * _cur_lineStep);
        }
        _cur_lineStep++;
    }
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
    if( speedRatio < 0 )
        return;
    
    _speedRatio = speedRatio;
    _max_lineSteps = MaxLineSteps/_speedRatio;
}

-(CGPoint)getPosition
{
    return _position;
}

-(float)getDetpth
{
    return _depth;
}

-(enum Direction)getHorizationDirection
{
    return _startPos.x > _endPos.x? LEFT:RIGHT;
}

-(bool)inCurve
{
    return _cur_lineStep > _max_lineSteps ? true : false;
}

@end

#pragma mark - DHDuckNormalPilot

#define DUCK_STEP_DIST 1
@implementation DHDuckNormalPilot
{
    float _step_dist;
    enum Direction _cur_hor_dir;
    enum Direction _cur_ver_dir;
}

-(id)initWithWinRect:(CGRect)rect andObjSz:(CGSize)sz
{
    if( self = [super initWithWinRect:rect andObjSz:sz] )
    {
        _step_dist = DUCK_STEP_DIST;
        _cur_hor_dir = arc4random()%2 == 0? LEFT:RIGHT;
        _cur_ver_dir = arc4random()%2 == 0? BOTTOM:UP;
    }
    return self;
}

-(void)setSpeedRatio:(float)speedRatio
{
    if( speedRatio < 0 )
        return;
    
    _speedRatio = speedRatio;
    
    _step_dist = DUCK_STEP_DIST*speedRatio;
}

-(int) PntInRect:(CGPoint)pnt andRect:(CGRect)rect
{
    if( pnt.x < rect.origin.x )
        return LEFT;
    else if( pnt.x > (rect.origin.x + rect.size.width) )
        return RIGHT;
    else if( pnt.y < rect.origin.y )
        return BOTTOM;
    else if(pnt.y > (rect.origin.y + rect.size.height))
        return UP;
    else
        return -1;
}

-(void)update:(ccTime) dt
{
    static int min_factor = 3;
    static int max_factor = 8;
   
    //LEFT=0, BOTTOM, RIGHT, UP
    CGPoint d[] = {{-_step_dist, 0},
        {0,-_step_dist},
        {_step_dist,0},
        {0,_step_dist}};
    
    CGPoint p = ccp(_position.x + d[_cur_hor_dir].x * (arc4random()%(max_factor-min_factor+1) + min_factor),
                    _position.y + d[_cur_ver_dir].y * (arc4random()%(max_factor-min_factor+1) + min_factor));
    int ret = [self PntInRect:p andRect:_bbox];
    if( ret != -1 )
    {
        switch( ret )
        {
            case LEFT:
                _cur_hor_dir = RIGHT;
                break;
            case RIGHT:
                _cur_hor_dir = LEFT;
                break;
            case BOTTOM:
                _cur_ver_dir = UP;
                break;
            case UP:
                _cur_ver_dir = BOTTOM;
                break;
        }
        
        p = ccp(_position.x + d[_cur_hor_dir].x * (arc4random()%(max_factor-min_factor+1) + min_factor),
                _position.y + d[_cur_ver_dir].y * (arc4random()%(max_factor-min_factor+1) + min_factor));
        
    }
    _position = p;
}

-(enum Direction)getHorizationDirection
{
    return _cur_hor_dir;
}
@end

#pragma mark - DHDuckDeadPilot
@implementation DHDuckDeadPilot

@end

#pragma mark - DHDuckFlyawayPilot
@implementation DHDuckFlyawayPilot

@end

#pragma mark - DHDuckEightPilot
@implementation DHDuckEightPilot
{
    double _cur_angle;
    double _delta_angle;
    
    CGPoint _centerPos;
}

-(id)initWithWinRect:(CGRect)rect andObjSz:(CGSize)sz
{
    if( self = [super initWithWinRect: rect andObjSz:sz] )
    {
        _cur_angle = 0.0;
        _delta_angle = 2 * PI / MaxCurveSteps;
        
        _centerPos = _endPos;
        
//        NSLog(@"_startPos(%f,%f)...._endPos(%f,%f)...._centerPos(%f,%f)",
//              _startPos.x, _startPos.y, _endPos.x, _endPos.y, _centerPos.x, _centerPos.y);
    }
    return self;
}

-(void)update:(ccTime)dt
{
    if ([super inCurve])
    {
        _cur_angle += _delta_angle;
        if (_cur_angle > 2 * PI)
        {
            _cur_angle = 0.0;
        }
        
        float a = min(_bbox.size.width, _bbox.size.height);
        a /= CURVE_RATIO;
        
        _position.x = _centerPos.x + (float)(a * sin(_cur_angle));
        _position.y = _centerPos.y + (float)(a * cos(_cur_angle) * sin(_cur_angle));
    }
    else
    {
        [super update:dt];
    }
    
    //NSLog(@"position(%f,%f)", _position.x, _position.y);
}

-(void)setSpeedRatio:(float)speedRatio
{
    [super setSpeedRatio:speedRatio];
    
    _delta_angle = (2 * PI / MaxCurveSteps) * speedRatio;

}

-(enum Direction)getHorizationDirection
{
    if ([super inCurve])
    {
        if (_cur_angle >= 0 && _cur_angle < PI * 0.5)
        {
            return RIGHT;
        }
        else if (_cur_angle >= PI * 0.5 && _cur_angle < PI * 1.5)
        {
            return LEFT;
        }
        else
        {
            return RIGHT;
        }
    }
    else
    {
        return [super getHorizationDirection];
    }
}

@end

#pragma mark - DHDuckCirclePilot
@implementation DHDuckCirclePilot
-(id)initWithWinRect:(CGRect)rect andObjSz:(CGSize)sz
{
    return self;
}
@end

#pragma mark - DHDuckEllipsePilot
@implementation DHDuckEllipsePilot
-(id)initWithWinRect:(CGRect)rect andObjSz:(CGSize)sz
{
    return self;
}
@end

#pragma mark - DHDuckSinPilot
@implementation DHDuckSinPilot
-(id)initWithWinRect:(CGRect)rect andObjSz:(CGSize)sz
{
    return self;
}
@end