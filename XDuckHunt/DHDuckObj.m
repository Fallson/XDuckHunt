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
#import "DHPilotManager.h"
#import "DHPilot.h"
#import "DHZDepth.h"

#define DUCK_SPRITE_NUM 3

#pragma mark - DHDuckObj

@interface DHDuckObj()
{
    CCSpriteBatchNode* _duck_spriteSheet;
    CCSprite* _duck;
    
    int _duck_idx;
    ccTime _accDT;
    CGRect _winRect;
}
@property(nonatomic, retain) CCSpriteBatchNode* duck_spriteSheet;
@property(nonatomic, retain) CCSprite* duck;
@end

@implementation DHDuckObj

@synthesize duck_pilot = _duck_pilot;
@synthesize duck_state = _duck_state;
@synthesize duck_size = _duck_size;
@synthesize duck_living_time = _duck_living_time;

@synthesize duck_spriteSheet = _duck_spriteSheet;
@synthesize duck = _duck;


-(id)initWithWinRect:(CGRect)rect
{
    if( (self=[super init]) )
    {
        self.duck_state = FLYING;
        
        _winRect = rect;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"duck_black_flying.plist"];
        self.duck_spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"duck_black_flying.png"];
        self.duck = [CCSprite spriteWithSpriteFrameName:@"duck_black_flying_1.png"];
        self.duck.scale = 0.75;
        _duck_size.width = self.duck.contentSize.width * self.duck.scaleX;
        _duck_size.height = self.duck.contentSize.height * self.duck.scaleY;
        self.duck_pilot = [[DHPilotManager sharedDHPilotManager] createPilot:DUCK_NORMAL andWinRect:_winRect andObjSz:_duck_size];
        
        self.duck.position = [self.duck_pilot getPosition];
        self.duck.zOrder = DUCK_Z;
        [self.duck_spriteSheet addChild:self.duck];
        
        _duck_idx = 0;
        _duck_living_time = 0;
        _accDT = 0;
	}
	return self;
}

-(void)addtoScene:(CCLayer *)layer
{
    //NSLog(@"duck_spritesheet:%d",(int)self.duck_spriteSheet);
    [layer addChild:self.duck_spriteSheet];
}

-(int) PntInRect:(CGPoint)pnt andRect:(CGRect)rect
{
    if( pnt.x < rect.origin.x )
        return 0;
    else if( pnt.x > (rect.origin.x + rect.size.width) )
        return 0;
    else if( pnt.y < rect.origin.y )
        return 0;
    else if(pnt.y > (rect.origin.y + rect.size.height))
        return 0;
    else
        return 1;
}

-(void)update:(ccTime)dt
{
    _accDT += dt;
    if( _accDT < 0.1 )
        return;
    _duck_living_time += _accDT;
    _accDT = 0;
    
    switch( self.duck_state )
    {
        case FLYAWAY:
        case FLYING:
        {
            _duck_idx = (++_duck_idx)%DUCK_SPRITE_NUM;
            
            NSString* frame_name = [NSString stringWithFormat:@"duck_black_flying_%d.png",_duck_idx+1];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [self.duck setDisplayFrame:frame];
            
            [self.duck_pilot update:dt];
            [self.duck setPosition:[self.duck_pilot getPosition]];
            [self.duck setFlipX:[self.duck_pilot getHorizationDirection]==LEFT?true:false];
        }
            break;
        case START_DEAD:
        {
            NSString* frame_name = [NSString stringWithFormat:@"duck_black_flying_4.png"];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [self.duck setDisplayFrame:frame];
            
            self.duck_state = DEAD;
            self.duck_pilot =[[DHPilotManager sharedDHPilotManager] createPilot:DUCK_DEAD andWinRect:_winRect andObjSz:_duck_size];
            
            CGPoint cur_p = self.duck.position;
            [self.duck_pilot setStartPos:cur_p];
            cur_p.y = _winRect.origin.y - self.duck_size.height;
            [self.duck_pilot setEndPos:cur_p];
            [self.duck_pilot setSpeedRatio:2.0];
        }
            break;
        case DEAD:
        {
            NSString* frame_name = [NSString stringWithFormat:@"duck_black_flying_5.png"];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [self.duck setDisplayFrame:frame];
            
            [self.duck_pilot update:dt];
            [self.duck setPosition:[self.duck_pilot getPosition]];
        }
            break;
        case START_FLYAWAY:
        {
            _duck_idx = (++_duck_idx)%DUCK_SPRITE_NUM;
            
            NSString* frame_name = [NSString stringWithFormat:@"duck_black_flying_%d.png",_duck_idx+1];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [self.duck setDisplayFrame:frame];
            
            self.duck_state = FLYAWAY;
            self.duck_pilot = [[DHPilotManager sharedDHPilotManager] createPilot:DUCK_FLYAWAY andWinRect:_winRect andObjSz:_duck_size];

            CGPoint cur_p = self.duck.position;
            [self.duck_pilot setStartPos:cur_p];
            cur_p.y = _winRect.origin.y + _winRect.size.height + self.duck_size.height;
            [self.duck_pilot setEndPos:cur_p];
            [self.duck_pilot setSpeedRatio:2.0];
        }
            break;
        default:
            break;
    }
    
    CGRect rect = {{_winRect.origin.x - self.duck_size.width, _winRect.origin.y - self.duck_size.height},
                   {_winRect.size.width + self.duck_size.width*2, _winRect.size.height + self.duck_size.height*2}};
    if( [self PntInRect: self.duck.position andRect: rect] == 0 )
    {
        self.duck_state = DISAPPEAR;
    }
}

-(bool)hit:(CGPoint)pnt
{
    CGPoint cur = self.duck.position;
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

-(void)dealloc
{
    [super dealloc];
}
@end

