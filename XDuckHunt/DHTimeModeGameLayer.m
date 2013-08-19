//
//  DHTimeModeGameLayer.m
//  XDuckHunt
//
//  Created by Fallson on 7/27/13.
//  Copyright Fallson 2013. All rights reserved.
//


// Import the interfaces
#import "DHTimeModeGameLayer.h"
#import "CCTouchDispatcher.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "DHBackGroundObj.h"
#import "DHDuckObj.h"
#import "DHPilot.h"
#import "DHConstons.h"
#import "DHGameChapter.h"
#import "DHTimeModePannelObj.h"
#pragma mark - DHTimeModeGameLayer

// DHTimeModeGameLayer implementation
@implementation DHTimeModeGameLayer
{
    DHBackGroundObj* _bgObj;
    CGRect           _bgRect;
    
    DHGameChapter*   _gameChps;
    enum CHAPTER_LVL _cur_chp;
    CGRect           _duckRect;
    
    DHTimeModePannelObj* _pannel;
    CGRect            _pannelRect;
    
    ccTime         _gameTime;
    int            _hit_count;
}

// Helper class method that creates a Scene with the DHTimeModeGameLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DHTimeModeGameLayer *layer = [DHTimeModeGameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

#pragma mark - init part
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
        [self initBG];
        [self initDucks];
        [self initPannel];
        
        _gameTime = 0;
        _hit_count = 0;
        
        //[self schedule:@selector(nextFrame:)];
        [self scheduleUpdate];
        
        //self.isTouchEnabled = YES;
        [self setTouchEnabled:YES];
    }
	return self;
}

-(void)initBG
{
    CGSize sz = [ [CCDirector sharedDirector] winSize];
    CGPoint ori = ccp(0,0);
    _bgRect.origin = ori;
    _bgRect.size = sz;
    _bgObj = [[DHBackGroundObj alloc] initWithWinRect: _bgRect];
    [_bgObj addtoScene: self];
}

-(void)initDucks
{
    _duckRect = _bgRect;
    _duckRect.origin.y += 0.25*_duckRect.size.height;
    _duckRect.size.height *= 0.75;
    _gameChps = [[DHGameChapter alloc] initWithWinRect:_duckRect];
    _cur_chp = CHAPTER1;
    for( int i = 0; i <= _cur_chp; i++ )
    {
        NSMutableArray* ducks = [_gameChps getDucks:i];
        for( DHDuckObj* duckObj in ducks )
        {
            [duckObj addtoScene: self];
        }
    }
}

-(void)initPannel
{
    _pannelRect = _bgRect;
    _pannelRect.origin.y += 0.9*_pannelRect.size.height;
    _pannelRect.size.height *= 0.1;
    NSLog(@"_pannelRect(%f,%f) and (%f, %f)", _pannelRect.origin.x, _pannelRect.origin.y,
          _pannelRect.size.width, _pannelRect.size.height);
    _pannel = [[DHTimeModePannelObj alloc] initWithWinRect:_pannelRect];
    [_pannel addtoScene:self];
}

#pragma mark - update part
-(void) update:(ccTime)dt
{
    _gameTime += dt;
    
    [self updateBG:dt];
    [self updateDucks:dt withGameTime:_gameTime];
    [self updatePannel:dt];
}

-(void) updateBG:(ccTime)dt
{
    [_bgObj update:dt];
}

-(void) updateDucks:(ccTime)dt withGameTime: (ccTime)gt
{
    for( int i = 0; i <= _cur_chp; i++ )
    {
        NSMutableArray* ducks = [_gameChps getDucks:i];
        for( DHDuckObj* duckObj in ducks )
        {
            [duckObj update:dt];
            
            if( duckObj.duck_living_time > DUCK_FLYAWAY_TIME && duckObj.duck_state == FLYING )
            {
                duckObj.duck_state = START_FLYAWAY;
            }
            else if( duckObj.duck_state == DISAPPEAR )
            {
                //do some free oprations on ducks
                //not done yet
            }
        }
    }
    
    for( int i = 0; i < CHAPTER_MAX; i++ )
    {
        if( (i+1)*DUCK_FLYAWAY_TIME > gt )
        {
            if( i != _cur_chp)
            {
                _cur_chp = i;
                NSMutableArray* ducks = [_gameChps getDucks:_cur_chp];
                for( DHDuckObj* duckObj in ducks )
                {
                    [duckObj addtoScene:self];
                }
            }
            break;
        }
    }
}

-(void)updatePannel:(ccTime)dt
{
    [_pannel setLeft_time:_gameTime];
    [_pannel setHit_count:_hit_count];
    [_pannel setScore:_hit_count*100];
    [_pannel update:dt];
}

- (void) nextFrame:(ccTime)dt
{
//    CGSize sz = [ [CCDirector sharedDirector] winSize];
//    seeker1.position = ccp( seeker1.position.x + 100*dt, seeker1.position.y );
//    //NSLog(@"rect: (%f, %f)", seeker1.textureRect.size.width, seeker1.textureRect.size.height);
//    if (seeker1.position.x > sz.width+seeker1.textureRect.size.width/20) {
//        seeker1.position = ccp( -seeker1.textureRect.size.width/20, seeker1.position.y );
//    }
}

#pragma mark - touch part
-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [self convertTouchToNodeSpace: touch];

    [self touchDucks:location];
}

-(void)touchDucks:(CGPoint)location
{
    for( int i = 0; i <= _cur_chp; i++ )
    {
        NSMutableArray* ducks = [_gameChps getDucks:i];
        for( DHDuckObj* duckObj in ducks)
        {
            if( duckObj.duck_state == FLYING )
            {
                bool duckHit = [duckObj hit: location];
                if( duckHit )
                {
                    duckObj.duck_state = START_DEAD;
                    _hit_count++;
                }
            }
        }
    }
}

#pragma mark - dealloc part
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[_bgObj release];
    [_gameChps release];
    [_pannel release];
    
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
