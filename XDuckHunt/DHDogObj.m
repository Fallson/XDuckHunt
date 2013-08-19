//
//  DHDogObj.m
//  XDuckHunt
//
//  Created by Fallson on 8/18/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHDogObj.h"
#import "DHZDepth.h"

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
        self.dog_state = RUNNING;
        
        _winRect = rect;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"dog.plist"];
        self.dog_spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"dog.png"];
        self.dog = [CCSprite spriteWithSpriteFrameName:@"dog_1.png"];
        self.dog.scale = 0.75;
        _dog_size.width = self.dog.contentSize.width * self.dog.scaleX;
        _dog_size.height = self.dog.contentSize.height * self.dog.scaleY;

        self.dog.position = ccp(0,_winRect.size.height/8);
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
    
}

@end
