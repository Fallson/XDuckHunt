//
//  DHFreeModeGameLayer.m
//  XDuckHunt
//
//  Created by Fallson on 7/27/13.
//  Copyright Fallson 2013. All rights reserved.
//


// Import the interfaces
#import "DHFreeModeGameLayer.h"
#import "CCTouchDispatcher.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "DHBackGroundObj.h"
#import "DHDuckObj.h"
#import "DHPilot.h"
#import "DHConstons.h"
#import "DHGameChapter.h"
#import "DHFreeModePannelObj.h"
#import "DHDogObj.h"
#import "DHGameData.h"
#import "DHGameOverLayer.h"
#pragma mark - DHFreeModeGameLayer

// DHFreeModeGameLayer implementation
@implementation DHFreeModeGameLayer
{
    DHBackGroundObj* _bgObj;
    CGRect           _bgRect;
    
    DHGameChapter*   _gameChps;
    enum CHAPTER_LVL _cur_chp;
    CGRect           _duckRect;
    
    DHFreeModePannelObj* _pannel;
    CGRect            _pannelRect;
    
    DHDogObj*      _dogObj;
    CGRect         _dogRect;
    
    ccTime         _nextDuckTime;
    ccTime         _gameTime;
    int            _hit_count;
    int            _miss_count;
}

// Helper class method that creates a Scene with the DHFreeModeGameLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DHFreeModeGameLayer *layer = [DHFreeModeGameLayer node];
	
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
        [self initDog];
        [self initDucks];
        [self initPannel];
        
        _nextDuckTime = 0;
        _gameTime = 0;
        _hit_count = 0;
        _miss_count = 0;
        
        //
        [DHGameData sharedDHGameData].cur_game_mode = FREE_MODE;
        
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

-(void)initDog
{
    _dogRect = _bgRect;
    _dogRect.size.height *= 0.25;
    
    _dogObj = [[DHDogObj alloc] initWithWinRect:_dogRect];
    [_dogObj addtoScene: self];
}

-(void)initDucks
{
    _duckRect = _bgRect;
    _duckRect.origin.y += 0.25*_duckRect.size.height;
    _duckRect.size.height *= 0.75;
    _gameChps = [[DHGameChapter alloc] initWithWinRect:_duckRect];
    [_gameChps setGame_mode:FREE_MODE];
    _cur_chp = CHAPTER0;
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
    _pannel = [[DHFreeModePannelObj alloc] initWithWinRect:_pannelRect];
    [_pannel addtoScene:self];
}

#pragma mark - update part
-(void) update:(ccTime)dt
{
    [self updateBG:dt];
    [self updateDog:dt];
    
    if( _dogObj.dog_state == DOG_DISAPPEAR )
    {
        _gameTime += dt;
        [self updateDucks:dt];
        [self updatePannel:dt];
        
        if(FREEMODE_TOTAL_DUCK < _miss_count)
        {
            [self game_over];
        }
    }
}

-(void) updateBG:(ccTime)dt
{
    [_bgObj update:dt];
}

-(void) updateDog:(ccTime)dt
{
    [_dogObj update:dt];
}

-(void) updateDucks:(ccTime)dt
{
    bool need_release_ducks = true;
    for( int i = 0; i <= _cur_chp; i++ )
    {
        NSMutableArray* ducks = [_gameChps getDucks:i];
        for( DHDuckObj* duckObj in ducks )
        {
            [duckObj update:dt];
            
            if( duckObj.duck_living_time > DUCK_FLYAWAY_TIME && duckObj.duck_state == FLYING )
            {
                duckObj.duck_state = START_FLYAWAY;
                _miss_count++;
            }
            
            if( duckObj.duck_state == DISAPPEAR )
            {
                //do some free oprations on ducks
                //[duckObj release];
            }
            else
            {
                need_release_ducks = false;
            }
        }
    }
    
    if( _gameTime >= _nextDuckTime ) //time out and release ducks
    {
        _cur_chp++;
        _nextDuckTime += DUCK_FLYAWAY_TIME;
        if( _cur_chp >= CHAPTER_MAX )
        {
            [self game_over];
            return;
        }

        NSMutableArray* ducks = [_gameChps getDucks:_cur_chp];
        for( DHDuckObj* duckObj in ducks )
        {
            [duckObj addtoScene:self];
        }
    }
    else if( need_release_ducks )
    {
        _cur_chp++;
        _nextDuckTime = _gameTime + DUCK_FLYAWAY_TIME;
        if( _cur_chp >= CHAPTER_MAX )
        {
            [self game_over];
            return;
        }
        
        NSMutableArray* ducks = [_gameChps getDucks:_cur_chp];
        for( DHDuckObj* duckObj in ducks )
        {
            [duckObj addtoScene:self];
        }
    }
}

-(void)updatePannel:(ccTime)dt
{
    [_pannel setLeft_duck:FREEMODE_TOTAL_DUCK-_miss_count];
    [_pannel setHit_count:_hit_count];
    [_pannel setScore:_hit_count*100];
    [_pannel setHighest_score:[[DHGameData sharedDHGameData] getHighestScore:FREE_MODE]];
    [_pannel update:dt];
}

-(void)game_over
{
    [DHGameData sharedDHGameData].cur_game_score = _hit_count*100;
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[DHGameOverLayer scene] ]];    
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
            if( duckObj.duck_state == FLYING || duckObj.duck_state == FLYAWAY )
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
    [_dogObj release];
    
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
