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
#import "DHIntroPannelObj.h"
#import "SimpleAudioEngine.h"
#import "DHGameMenuLayer.h"
#pragma mark - DHFreeModeGameLayer

static int duck_scores[] = {100,100,100,200,400};

@interface DHFreeModeGameLayer()
@property (nonatomic,retain) NSMutableArray* ducks;
@end

// DHFreeModeGameLayer implementation
@implementation DHFreeModeGameLayer
{
    DHBackGroundObj* _bgObj;
    CGRect           _bgRect;
    
    enum CHAPTER_LVL _cur_chp;
    CGRect           _duckRect;
    
    DHFreeModePannelObj* _pannel;
    CGRect            _pannelRect;
    
    DHDogObj*      _dogObj;
    CGRect         _dogRect;
    
    DHIntroPannelObj* _introObj;
    CGRect            _introRect;
    
    ccTime         _nextDuckTime;
    ccTime         _gameTime;
    int            _hit_count;
    int            _miss_count;
    int            _gameScore;
    int            _gameBonus;
    int            _gameBonusLvl;
    
    bool           _game_over;
}
@synthesize ducks = _ducks;


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
        [DHGameData sharedDHGameData].cur_game_mode = FREE_MODE;
        
        [self initBG];
        [self initDog];
        [self initIntro];
        [self initDucks];
        [self initPannel];
        [self initPauseMenu];
        
        _nextDuckTime = 0;
        _gameTime = 0;
        _hit_count = 0;
        _miss_count = 0;
        _gameScore = 0;
        _gameBonus = 0;
        _gameBonusLvl = 1;
        
        _game_over = false;
        
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

-(void)initIntro
{
    _introRect = _bgRect;
    _introRect.origin.y +=0.25*_introRect.size.height;
    _introRect.size.height *= 0.75;
    
    _introObj = [[DHIntroPannelObj alloc] initWithWinRect:_introRect];
    [_introObj addtoScene:self];
}

-(void)initDucks
{
    _duckRect = _bgRect;
    _duckRect.origin.y += 0.25*_duckRect.size.height;
    _duckRect.size.height *= 0.75;
    
    _cur_chp = CHAPTER0;
    _ducks = [[NSMutableArray alloc] init];
}

-(void)initPannel
{
    _pannelRect = _bgRect;
    _pannelRect.origin.y += 0.9*_pannelRect.size.height;
    _pannelRect.size.height *= 0.1;
    _pannel = [[DHFreeModePannelObj alloc] initWithWinRect:_pannelRect];
    [_pannel addtoScene:self];
}

-(void)initPauseMenu
{
    CGRect rect = _bgRect;
    CCMenuItem *menuitem_pause = [CCMenuItemImage
                                  itemWithNormalImage:@"Pause.png" selectedImage:@"Pause.png"
                                  target:self selector:@selector(PauseMenuPressed:)];
    menuitem_pause.position = ccp(rect.origin.x + rect.size.width*0.85, rect.origin.y + rect.size.height*0.1);
    menuitem_pause.scale *= (0.5*CC_CONTENT_SCALE_FACTOR());
    
    CCMenu* main_menu = [CCMenu menuWithItems:menuitem_pause, nil];
    main_menu.position = CGPointZero;
    [self addChild:main_menu];
}

-(void)PauseMenuPressed:(id)sender
{
    [DHGameData sharedDHGameData].cur_game_pause = 1;
    //[[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:0.1 scene:[DHGameScoreListLayer scene] ]];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.1 scene:[DHGameMenuLayer scene] ]];
}

#pragma mark - update part
-(void) update:(ccTime)dt
{
    [self updateBG:dt];
    [self updateDog:dt];
    [self updateIntro:dt];
    [self updatePannel:dt];
    
    if( _dogObj.dog_state == DOG_DISAPPEAR )
    {
        [_introObj removeFromScene:self];
        
        _gameTime += dt;
        [self updateDucks:dt];

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

-(void) updateIntro:(ccTime)dt
{
    [_introObj update:dt];
}

-(void) updateDucks:(ccTime)dt
{
    bool need_release_ducks = true;
  
    NSMutableIndexSet* discardItems = [NSMutableIndexSet indexSet];
    NSUInteger index = 0;
    for( DHDuckObj* duckObj in _ducks )
    {
        [duckObj update:dt];
        
        if( duckObj.duck_living_time > DUCK_FLYAWAY_TIME && duckObj.duck_state == FLYING )
        {
            duckObj.duck_state = START_FLYAWAY;
            _miss_count++;
        }
        
        if( duckObj.duck_state == DISAPPEAR )
        {
            [discardItems addIndex:index];
            [duckObj removeFromScene:self];
        }
        else
        {
            need_release_ducks = false;
        }
        index++;
    }
    [_ducks removeObjectsAtIndexes:discardItems];

    
    if( _gameTime >= _nextDuckTime || need_release_ducks ) //time out and release ducks
    {
        if( _gameTime >= _nextDuckTime )
        {
            _nextDuckTime += DUCK_FLYAWAY_TIME;
        }
        else
        {
            _nextDuckTime = _gameTime + DUCK_FLYAWAY_TIME;
        }
        
        NSMutableArray* new_ducks = nil;
        if( _gameBonus )
        {
            _gameBonus = 0;
            new_ducks = [[DHGameChapter sharedDHGameChapter] getDucks:CHAPTER_FUNNY andWinRect:_duckRect];
        }
        else
        {
            _cur_chp++;
            if( _cur_chp >= CHAPTER_MAX )
            {
                _cur_chp = CHAPTER_MAX-2;
            }
            new_ducks = [[DHGameChapter sharedDHGameChapter] getDucks:_cur_chp andWinRect:_duckRect];
        }
        
        if( new_ducks != nil )
        {
            for( DHDuckObj* duckObj in new_ducks )
            {
                [duckObj addtoScene:self];
            }
            [_ducks addObjectsFromArray: new_ducks];
        }
    }
}

-(void)updatePannel:(ccTime)dt
{
    [_pannel setLeft_duck:FREEMODE_TOTAL_DUCK-_miss_count];
    [_pannel setHit_count:_hit_count];
    [_pannel setScore:_gameScore];
    [_pannel setHighest_score:[[DHGameData sharedDHGameData] getHighestScore:FREE_MODE]];
    [_pannel update:dt];
}

-(void)game_over
{
    if( _game_over )
        return;
    
    _game_over = true;
    [DHGameData sharedDHGameData].cur_game_score = _gameScore;
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
    if( [DHGameData sharedDHGameData].gameMusic == 1 )
        [[SimpleAudioEngine sharedEngine] playEffect:@"shoot.wav"];
    
	CGPoint location = [self convertTouchToNodeSpace: touch];
    [self touchDucks:location];
}

-(void)touchDucks:(CGPoint)location
{
    for( DHDuckObj* duckObj in _ducks)
    {
        if( duckObj.duck_state == FLYING || duckObj.duck_state == FLYAWAY )
        {
            bool duckHit = [duckObj hit: location];
            if( duckHit )
            {
                duckObj.duck_state = START_DEAD;
                _hit_count++;
                
                _gameScore += duck_scores[duckObj.duck_type];
                if( _gameScore > _gameBonusLvl * 5000 )
                {
                    _gameBonus = 1;
                    _gameBonusLvl++;
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
    [_ducks release];
    [_pannel release];
    [_dogObj release];
    [_introObj release];
    
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
