//
//  DHGameOptionLayer.m
//  XDuckHunt
//
//  Created by Fallson on 7/27/13.
//  Copyright Fallson 2013. All rights reserved.
//


// Import the interfaces
#import "DHGameOptionLayer.h"
#import "CCTouchDispatcher.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "DHBackGroundObj.h"
#import "DHConstons.h"
#import "DHGameData.h"
#import "DHLabel.h"
#import "DHGameMenuLayer.h"
#import "SimpleAudioEngine.h"
#pragma mark - DHGameOptionLayer

@interface DHGameOptionLayer()
@property (nonatomic, retain) CCMenuItem* mi_bgMusicOn;
@property (nonatomic, retain) CCMenuItem* mi_bgMusicOff;
@property (nonatomic, retain) CCMenuItem* mi_gameMusicOn;
@property (nonatomic, retain) CCMenuItem* mi_gameMusicOff;
@end

// DHGameOptionLayer implementation
@implementation DHGameOptionLayer
{
    DHBackGroundObj* _bgObj;
    CGRect           _bgRect;
}

@synthesize mi_bgMusicOn = _mi_bgMusicOn;
@synthesize mi_bgMusicOff = _mi_bgMusicOff;
@synthesize mi_gameMusicOn = _mi_gameMusicOn;
@synthesize mi_gameMusicOff = _mi_gameMusicOff;

// Helper class method that creates a Scene with the DHGameOptionLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DHGameOptionLayer *layer = [DHGameOptionLayer node];
	
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
        [self initOption];
        [self initMenu];
        
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

-(void)initOption
{
    //bgMusic part
    CCMenuItemToggle* mi_bgMusic = nil;
    _mi_bgMusicOn = [CCMenuItemImage itemWithNormalImage:@"checkbox_checked" selectedImage:@"checkbox_checked" target:nil selector:nil];
    _mi_bgMusicOff = [CCMenuItemImage itemWithNormalImage:@"checkbox_unchecked" selectedImage:@"checkbox_unchecked" target:nil selector:nil];
    if( [DHGameData sharedDHGameData].bgMusic == 1 )
    {
        mi_bgMusic = [CCMenuItemToggle itemWithTarget:self selector:@selector(bgMusicPressed:) items:_mi_bgMusicOn, _mi_bgMusicOff, nil];
    }
    else
    {
        mi_bgMusic = [CCMenuItemToggle itemWithTarget:self selector:@selector(bgMusicPressed:) items:_mi_bgMusicOff, _mi_bgMusicOn, nil];
    }
    mi_bgMusic.scale *= CC_CONTENT_SCALE_FACTOR();
    mi_bgMusic.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.3, _bgRect.origin.y + 0.7*_bgRect.size.height);
    
    NSString* bgMusic_str = [NSString stringWithFormat:@"    BackGround Sound"];
    DHLabel* bgMusic_label = [DHLabel labelWithString:bgMusic_str fontName:DHLABEL_FONT fontSize:24];
    bgMusic_label.color=ccYELLOW;
    bgMusic_label.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.3, _bgRect.origin.y + 0.7*_bgRect.size.height);
    [bgMusic_label setAnchorPoint: ccp(0, 0.5f)];
    
    //gameMusic part
    CCMenuItemToggle* mi_gameMusic = nil;
    _mi_gameMusicOn = [CCMenuItemImage itemWithNormalImage:@"checkbox_checked" selectedImage:@"checkbox_checked" target:nil selector:nil];
    _mi_gameMusicOff = [CCMenuItemImage itemWithNormalImage:@"checkbox_checked" selectedImage:@"checkbox_checked" target:nil selector:nil];
    if( [DHGameData sharedDHGameData].gameMusic == 1 )
    {
        mi_gameMusic = [CCMenuItemToggle itemWithTarget:self selector:@selector(gameMusicPressed:) items:_mi_gameMusicOn, _mi_gameMusicOff, nil];
    }
    else
    {
        mi_gameMusic = [CCMenuItemToggle itemWithTarget:self selector:@selector(gameMusicPressed:) items:_mi_gameMusicOff, _mi_gameMusicOn, nil];
    }
    mi_bgMusic.scale *= CC_CONTENT_SCALE_FACTOR();
    mi_bgMusic.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.3, _bgRect.origin.y + 0.5*_bgRect.size.height);
   
    NSString* gameMusic_str = [NSString stringWithFormat:@"    Game Sound"];
    DHLabel* gameMusic_label = [DHLabel labelWithString:gameMusic_str fontName:DHLABEL_FONT fontSize:24];
    gameMusic_label.color=ccYELLOW;
    gameMusic_label.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.3, _bgRect.origin.y + 0.5*_bgRect.size.height);
    [gameMusic_label setAnchorPoint: ccp(0, 0.5f)];
    
    CCMenu* main_menu = [CCMenu menuWithItems:mi_bgMusic, mi_gameMusic, nil];
    main_menu.position = CGPointZero;
    [self addChild:main_menu];
    [self addChild:bgMusic_label];
    [self addChild:gameMusic_label];
}

-(void)bgMusicPressed:(id)sender
{
    CCMenuItemToggle* toggleItem = (CCMenuItemToggle*)sender;
    
    if( toggleItem.selectedItem == _mi_bgMusicOn )
    {
        [[DHGameData sharedDHGameData] addBGMusic:1];
        
        if( [SimpleAudioEngine sharedEngine].isBackgroundMusicPlaying )
        {}
        else
        {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"gameMusic.mp3"];
        }
    }
    else if( toggleItem.selectedItem == _mi_bgMusicOff )
    {
        [[DHGameData sharedDHGameData] addBGMusic:0];
        
        if( [SimpleAudioEngine sharedEngine].isBackgroundMusicPlaying )
        {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        }
        else
        {}
    }
}

-(void)gameMusicPressed:(id)sender
{
    CCMenuItemToggle* toggleItem = (CCMenuItemToggle*)sender;
    
    if( toggleItem.selectedItem == _mi_gameMusicOn )
    {
        [[DHGameData sharedDHGameData] addGameMusic:1];
    }
    else if( toggleItem.selectedItem == _mi_gameMusicOff )
    {
        [[DHGameData sharedDHGameData] addGameMusic:0];
    }
}


-(void)initMenu
{
    NSString* return_str = [NSString stringWithFormat:@"Return"];
    DHLabel* return_label = [DHLabel labelWithString:return_str fontName:DHLABEL_FONT fontSize:20];
    return_label.color=ccBLUE;
    return_label.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.5, _bgRect.origin.y + 0.3*_bgRect.size.height);
    [return_label setAnchorPoint: ccp(0.5f, 0.5f)];
    
    CCMenuItem *menuitem_return = [CCMenuItemImage
                                   itemWithNormalImage:@"MenuItem.png" selectedImage:@"MenuItem_pressed.png"
                                   target:self selector:@selector(ReturnMenuPressed:)];
    menuitem_return.scale *= CC_CONTENT_SCALE_FACTOR();
    menuitem_return.position = return_label.position;
    
    CCMenu* main_menu = [CCMenu menuWithItems:menuitem_return, nil];
    main_menu.position = CGPointZero;
    [self addChild:main_menu];
    [self addChild:return_label];
}

-(void)ReturnMenuPressed:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[DHGameMenuLayer scene] ]];
}

#pragma mark - update part
-(void) update:(ccTime)dt
{
    [self updateBG:dt];
}

-(void) updateBG:(ccTime)dt
{
    [_bgObj update:dt];
}

#pragma mark - dealloc part
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[_bgObj release];
    
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
