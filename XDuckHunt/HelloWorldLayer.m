//
//  HelloWorldLayer.m
//  XDuckHunt
//
//  Created by Fallson on 7/27/13.
//  Copyright Fallson 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "CCTouchDispatcher.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "DHBackGroundObj.h"
#import "DHDuckObj.h"
#import "DHPilot.h"
#import "DHConstons.h"
#import "DHGameChapter.h"
#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer
{
    DHBackGroundObj* _bgObj;
    DHGameChapter* _gameChps;
    //DHDuckObj* duckObj;
}

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
        CGSize sz = [ [CCDirector sharedDirector] winSize];
        CGRect rect = {ccp(0,0), sz};
        
        _bgObj = [[DHBackGroundObj alloc] initWithWinRect: rect];
        [_bgObj addtoScene: self];
        
        CGRect rect1 = rect;
        rect1.origin.y += 0.25*rect1.size.height;
        rect1.size.height *= 0.75;
        _gameChps = [[DHGameChapter alloc] initWithWinRect:rect1];
        for( DHDuckObj* duckObj in [_gameChps getDucks:CHAPTER1])
        {
            [duckObj addtoScene: self];
        }
        /*
        duckObj = [[DHDuckObj alloc] initWithWinRect: rect1];
        DHDuckPilot* pilot = [[DHDuckEightPilot alloc] initWithWinRect:rect1 andObjSz:duckObj.duck_size];
        duckObj.duck_pilot = pilot;
        [duckObj addtoScene: self];
        */
        
        //[self schedule:@selector(nextFrame:)];
        [self scheduleUpdate];
        
        //self.isTouchEnabled = YES;
        [self setTouchEnabled:YES];
    }
	return self;
}

-(void) update:(ccTime)dt
{
    [_bgObj update:dt];
    
    for( DHDuckObj* duckObj in [_gameChps getDucks:CHAPTER1])
    {
        [duckObj update:dt];
        
        if( duckObj.duck_living_time > DUCK_FLYAWAY_TIME && duckObj.duck_state == FLYING )
        {
            duckObj.duck_state = START_FLYAWAY;
        }
    }
}

- (void) nextFrame:(ccTime)dt {
//    CGSize sz = [ [CCDirector sharedDirector] winSize];
//    seeker1.position = ccp( seeker1.position.x + 100*dt, seeker1.position.y );
//    //NSLog(@"rect: (%f, %f)", seeker1.textureRect.size.width, seeker1.textureRect.size.height);
//    if (seeker1.position.x > sz.width+seeker1.textureRect.size.width/20) {
//        seeker1.position = ccp( -seeker1.textureRect.size.width/20, seeker1.position.y );
//    }
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [self convertTouchToNodeSpace: touch];

    for( DHDuckObj* duckObj in [_gameChps getDucks:CHAPTER1])
    {
        if( duckObj.duck_state == FLYING )
        {
            bool duckHit = [duckObj hit: location];
            if( duckHit )
            {
                duckObj.duck_state = START_DEAD;
            }
        }
    }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
