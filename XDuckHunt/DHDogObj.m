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
#define DOG_MV_STEP    10

@interface DHDogObj()
{
    int _dog_idx;
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
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"dog.plist"];
        self.dog_spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"dog.png"];
        self.dog = [CCSprite spriteWithSpriteFrameName:@"dog_1.png"];
        self.dog.scale = 0.75;
        _dog_size.width = self.dog.contentSize.width * self.dog.scaleX;
        _dog_size.height = self.dog.contentSize.height * self.dog.scaleY;

        self.dog.position = ccp(0,_winRect.size.height/2);
        self.dog.zOrder = DOG_Z;
        [self.dog_spriteSheet addChild:self.dog];
        
        _dog_idx = 0;
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
    
    switch( self.dog_state )
    {
        case DOG_RUNNING:
        {
            ++_dog_idx;
            
            NSString* frame_name = [NSString stringWithFormat:@"dog_%d.png",_dog_idx+1];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [self.dog setDisplayFrame:frame];
            
            if( _dog_idx == 3 )
            {
                self.dog_state = DOG_SEEKING;
            }
        }
            break;
        case DOG_SEEKING:
        {
            ++_dog_idx;
            NSString* frame_name = [NSString stringWithFormat:@"dog_%d.png", _dog_idx+1];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [self.dog setDisplayFrame:frame];
            
            if( _dog_idx == 5 )
            {
                self.dog_state = DOG_RUNNING2;
                _dog_idx = 0;
            }
        }
            break;
        case DOG_RUNNING2:
        {
            ++_dog_idx;
            NSString* frame_name = [NSString stringWithFormat:@"dog_%d.png",_dog_idx];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [self.dog setDisplayFrame:frame];
            
            if( _dog_idx == 3 )
            {
                self.dog_state = DOG_JUMPING;
                _dog_idx = 5;
            }
        }
            break;
        case DOG_JUMPING:
        {
            ++_dog_idx;
            NSString* frame_name = [NSString stringWithFormat:@"dog_%d.png",_dog_idx+1];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                    spriteFrameByName:frame_name];
            [self.dog setDisplayFrame:frame];
            
            if(_dog_idx == 6)
            {
                //
            }
            else if(_dog_idx == 7)
            {
                CGPoint cur = self.dog.position;
                cur.y += _winRect.size.height/5;
                self.dog.position = cur;
            }
            else if(_dog_idx == 8)
            {
                CGPoint cur = self.dog.position;
                cur.y += _winRect.size.height/5;
                self.dog.position = cur;
                
                self.dog_state = DOG_DISAPPEAR;
            }
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

    CGPoint cur = self.dog.position;
    cur.x += DOG_MV_STEP;
    if( cur.x > _winRect.size.width + self.dog.contentSize.width/2 )
    {
        cur.x = -self.dog.contentSize.width/2;
    }
    self.dog.position = cur;
}

@end
