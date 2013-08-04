//
//  DHDuckObj.m
//  XDuckHunt
//
//  Created by Fallson on 7/28/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHDuckObj.h"
#import "cocos2d.h"
#import "DHConstons.h"
#import "DHPilot.h"
#import "DHZDepth.h"

#define DUCK_SPRITE_NUM 3

#pragma mark - DHDuckObj

@implementation DHDuckObj
{
    CCSpriteBatchNode* _duck_spriteSheet;
    CCSprite* _duck;
    int _duck_idx;
    
    CGRect _winRect;
    CGSize _duckSz;
}

@synthesize duck_pilot = _duck_pilot;
@synthesize duck_state = _duck_state;


-(id)initWithWinRect:(CGRect)rect
{
    if( (self=[super init]) )
    {
        self.duck_state = FLYING;
        
        _winRect = rect;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"duck_black_flying.plist"];
        _duck_spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"duck_black_flying.png"];
        
        _duck = [CCSprite spriteWithSpriteFrameName:@"duck_black_flying_1.png"];
        _duck.scale = 0.75;
        _duckSz.width = _duck.contentSize.width * _duck.scaleX;
        _duckSz.height = _duck.contentSize.height * _duck.scaleY;
        self.duck_pilot = [[DHDuckNormalPilot alloc] initWithWinRect: rect andObjSz:_duckSz];
        
        _duck.position = [self.duck_pilot getPosition];
        _duck.zOrder = DUCK_Z;
        
        _duck_idx = 0;
        [_duck_spriteSheet addChild:_duck];
	}
	return self;
}

-(void)addtoScene:(CCLayer *)layer
{
    [layer addChild:_duck_spriteSheet];
}

-(void)update:(ccTime)dt
{
    static ccTime accDT = 0;
    accDT += dt;
    if( accDT < 0.1 )
        return;
    accDT = 0;
    
    switch( self.duck_state )
    {
        case FLYING:
        {
            _duck_idx = (++_duck_idx)%DUCK_SPRITE_NUM;
            
            NSString* frame_name = [NSString stringWithFormat:@"duck_black_flying_%d.png",_duck_idx+1];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [_duck setDisplayFrame:frame];
            
            [self.duck_pilot update:dt];
            [_duck setPosition:[self.duck_pilot getPosition]];
            [_duck setFlipX:[self.duck_pilot getHorizationDirection]==LEFT?true:false];
        }
            break;
        case SHOT:
        {
            NSString* frame_name = [NSString stringWithFormat:@"duck_black_flying_4.png"];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [_duck setDisplayFrame:frame];
            
            self.duck_state = DEAD;
            self.duck_pilot = [[DHDuckDeadPilot alloc] initWithWinRect: _winRect andObjSz:_duckSz];
            CGPoint cur_p = _duck.position;
            [self.duck_pilot setStartPos:cur_p];
            //NSLog(@"Dead startPos:(%f,%f)", cur_p.x, cur_p.y);
            cur_p.y = _winRect.origin.y - _duck.contentSize.height;
            [self.duck_pilot setEndPos:cur_p];
            [self.duck_pilot setSpeedRatio:10.0];
            //NSLog(@"Dead endPos:(%f,%f)", cur_p.x, cur_p.y);
        }
            break;
        case DEAD:
        {
            NSString* frame_name = [NSString stringWithFormat:@"duck_black_flying_5.png"];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [_duck setDisplayFrame:frame];
            
            [self.duck_pilot update:dt];
            [_duck setPosition:[self.duck_pilot getPosition]];
        }
            break;
        case FLYAWAY:
        {
            _duck_idx = (++_duck_idx)%DUCK_SPRITE_NUM;
            
            NSString* frame_name = [NSString stringWithFormat:@"duck_black_flying_%d.png",_duck_idx+1];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [_duck setDisplayFrame:frame];
            
            self.duck_state = FLYING;
            self.duck_pilot = [[DHDuckFlyawayPilot alloc] initWithWinRect: _winRect andObjSz:_duckSz];
            CGPoint cur_p = _duck.position;
            [self.duck_pilot setStartPos:cur_p];
            cur_p.y = _winRect.origin.y + _winRect.size.height + _duck.contentSize.height;
            [self.duck_pilot setEndPos:cur_p];
            [self.duck_pilot setSpeedRatio:10.0];
        }
            break;
        default:
            break;
    }
}

-(bool)hit:(CGPoint)pnt
{
    CGPoint cur = _duck.position;
    double dist = (cur.x - pnt.x)*(cur.x-pnt.x) + (cur.y-pnt.y)*(cur.y-pnt.y);
    if (  dist < HIT_RADIUS_POW )
    {
         NSLog(@"hit: cur(%f,%f) vs pnt(%f,%f) = dist(%f)", cur.x, cur.y, pnt.x, pnt.y, dist);
        return true;
    }
    else
    {
        NSLog(@"not-hit: cur(%f,%f) vs pnt(%f,%f) = dist(%f)", cur.x, cur.y, pnt.x, pnt.y, dist);
        return false;
    }
}

@end

