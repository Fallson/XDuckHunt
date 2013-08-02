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


#define DUCK_SPRITE_NUM 3

#pragma mark - DHDuckPilot
@implementation DHDuckPilot

@end


#pragma mark - DHDuckObj

@implementation DHDuckObj
{
    CCSpriteBatchNode* _duck_spriteSheet;
    CCSprite* _duck;
    int _duck_idx;
    
    CGSize _winSz;
}

@synthesize duck_pilot = _duck_pilot;
@synthesize duck_state = _duck_state;


-(id)initWithWinSZ:(CGSize)sz
{
    if( (self=[super init]) )
    {
        self.duck_pilot = nil;
        self.duck_state = FLYING;
        
        _winSz = sz;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"duck_black_flying.plist"];
        _duck_spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"duck_black_flying.png"];
        
        _duck = [CCSprite spriteWithSpriteFrameName:@"duck_black_flying_1.png"];
        _duck.position = ccp(sz.width*0.5, sz.height*0.5);
        _duck.zOrder = 0;
        
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
            
            CGPoint cur = _duck.position;
            cur.x -= 10;
            if( cur.x < -_duck.contentSize.width/2 )
            {
                cur.x = _winSz.width + _duck.contentSize.width/2;
            }
            [_duck setPosition:cur];
        }
            break;
        case SHOT:
        {
            NSString* frame_name = [NSString stringWithFormat:@"duck_black_flying_4.png"];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [_duck setDisplayFrame:frame];
            self.duck_state = DEAD;
        }
            break;
        case DEAD:
        {
            NSString* frame_name = [NSString stringWithFormat:@"duck_black_flying_5.png"];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [_duck setDisplayFrame:frame];
            
            CGPoint cur = _duck.position;
            cur.y -= 10;
            if( cur.y < -_duck.contentSize.height/2 )
            {
                cur.y = -_duck.contentSize.height/2;
            }
            [_duck setPosition:cur];
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

