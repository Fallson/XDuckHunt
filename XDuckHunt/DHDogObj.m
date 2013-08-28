//
//  DHDogObj.m
//  XDuckHunt
//
//  Created by Fallson on 8/18/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHDogObj.h"
#import "DHZDepth.h"
#import "DHConstons.h"

#define DOG_SPRITE_NUM 4
#define DOG_MV_STEP    5
#define DOG_RUNNING_ROUND 5

@interface DHDogObj()
{
    int _dog_idx;
    int _dog_running_round;
    ccTime _accDT;
    CGRect _winRect;
}
@property(nonatomic, retain) CCSpriteBatchNode* dog_spriteSheet;
@property(nonatomic, retain) CCSprite* dog;
@end

@implementation DHDogObj

@synthesize dog_state = _dog_state;
@synthesize dog_size = _dog_size;

@synthesize dog_spriteSheet = _dog_spriteSheet;
@synthesize dog = _dog;

-(id)initWithWinRect: (CGRect)rect
{
    if( (self=[super init]) )
    {
        self.dog_state = DOG_RUNNING;
        
        _winRect = rect;
        NSLog(@"dog rect is: (%f,%f), (%f,%f)", rect.origin.x, rect.origin.y,
              rect.size.width, rect.size.height);
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"dog.plist"];
        self.dog_spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"dog.png"];
        self.dog = [CCSprite spriteWithSpriteFrameName:@"dog_1.png"];
        self.dog.scale = 0.75;
        _dog_size.width = self.dog.contentSize.width * self.dog.scaleX;
        _dog_size.height = self.dog.contentSize.height * self.dog.scaleY;

        self.dog.position = ccp(_dog_size.width,_winRect.size.height/2);
        self.dog.zOrder = DOG_Z;
        [self.dog_spriteSheet addChild:self.dog];
        self.dog_spriteSheet.zOrder = DOG_Z;
        
        _dog_idx = 0;
        _dog_running_round = 0;
        _accDT = 0;
	}
	return self;
}

-(void)addtoScene: (CCLayer*)layer
{
    [layer addChild: self.dog_spriteSheet];
}

-(void)update:(ccTime)dt
{
    _accDT += dt;
    if( _accDT < DOG_UPDATE_TIME )
        return;
    _accDT = 0;
    
    bool need_x_mv = false;
    switch( self.dog_state )
    {
        case DOG_RUNNING:
        {
            NSString* frame_name = [NSString stringWithFormat:@"dog_%d.png", ++_dog_idx];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [self.dog setDisplayFrame:frame];
            
            if( _dog_idx == 4 )
            {
                ++_dog_running_round;
                
                if( _dog_running_round >= DOG_RUNNING_ROUND )
                {
                    self.dog_state = DOG_SEEKING;
                    _dog_running_round = 0;
                    _dog_idx = 4;
                }
                else
                {
                    _dog_idx = 0;
                }
            }
            need_x_mv = true;
        }
            break;
        case DOG_SEEKING:
        {
            NSString* frame_name = [NSString stringWithFormat:@"dog_%d.png", ++_dog_idx];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [self.dog setDisplayFrame:frame];
            
            if( _dog_idx == 6 )
            {
                _dog_running_round++;
                
                if( _dog_running_round >= DOG_RUNNING_ROUND )
                {
                    self.dog_state = DOG_RUNNING2;
                    _dog_running_round = 0;
                    _dog_idx = 0;
                }
                else
                {
                    _dog_idx = 4;
                }
            }
        }
            break;
        case DOG_RUNNING2:
        {
            NSString* frame_name = [NSString stringWithFormat:@"dog_%d.png",++_dog_idx];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [self.dog setDisplayFrame:frame];
            
            if( _dog_idx == 4 )
            {
                _dog_running_round++;
                
                if( _dog_running_round >= DOG_RUNNING_ROUND )
                {
                    self.dog_state = DOG_FOUND;
                    _dog_running_round = 0;
                    _dog_idx = 6;
                }
                else
                {
                    _dog_idx = 0;
                }
            }
            need_x_mv = true;
        }
            break;
        case DOG_FOUND:
        {
            NSString* frame_name = [NSString stringWithFormat:@"dog_%d.png",++_dog_idx];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [self.dog setDisplayFrame:frame];
            
            _dog_running_round++;
            if( _dog_running_round >= DOG_RUNNING_ROUND/2 )
            {
                self.dog_state = DOG_JUMPING_UP;
                _dog_running_round = 0;
                _dog_idx = 7;
            }
            else
            {
                _dog_idx = 6;
            }
        }
            break;
        case DOG_JUMPING_UP:
        {
            NSString* frame_name = [NSString stringWithFormat:@"dog_%d.png",++_dog_idx];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [self.dog setDisplayFrame:frame];
            
            _dog_running_round++;
            if( _dog_running_round >= DOG_RUNNING_ROUND/2 )
            {
                self.dog_state = DOG_JUMPING_DOWN;
                _dog_running_round = 0;
                _dog_idx = 8;
            }
            else
            {
                CGPoint cur = self.dog.position;
                cur.y += _winRect.size.height*0.9;
                self.dog.position = cur;
                
                _dog_idx = 7;
            }
            need_x_mv = true;
        }
            break;
        case DOG_JUMPING_DOWN:
        {
            NSString* frame_name = [NSString stringWithFormat:@"dog_%d.png",++_dog_idx];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [self.dog setDisplayFrame:frame];
            
            _dog_running_round++;
            if( _dog_running_round >= DOG_RUNNING_ROUND/5 )
            {
                self.dog_state = DOG_DISAPPEAR;
                _dog_running_round = 0;
                _dog_idx = 0;
            }
            else
            {
                CGPoint cur = self.dog.position;
                cur.y -= _winRect.size.height*0.25;
                self.dog.position = cur;
                self.dog.zOrder = BG_GRASS_Z - 1;
                
                _dog_idx = 8;
            }
            need_x_mv = true;
        }
            break;
        case DOG_DISAPPEAR:
        {
            self.dog.visible = FALSE;
        }
            break;
        default:
            break;
    }

    if( need_x_mv )
    {
        CGPoint cur = self.dog.position;
        cur.x += DOG_MV_STEP;
        if( cur.x > _winRect.size.width + self.dog.contentSize.width/2 )
        {
            cur.x = -self.dog.contentSize.width/2;
        }
        self.dog.position = cur;
    }
}

@end
