//
//  DHGameMenuLayer.m
//  XDuckHunt
//
//  Created by Fallson on 7/27/13.
//  Copyright Fallson 2013. All rights reserved.
//


// Import the interfaces
#import "DHGameMenuLayer.h"
#import "CCTouchDispatcher.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "DHBackGroundObj.h"
#import "DHMenuObj.h"
#import "DHGameData.h"
#pragma mark - DHGameMenuLayer

// DHGameMenuLayer implementation
@implementation DHGameMenuLayer
{
    DHBackGroundObj* _bgObj;
    CGRect           _bgRect;

    //menus
    DHMenuObj*       _menuObj;
    CGRect           _menuRect;
}

// Helper class method that creates a Scene with the DHGameMenuLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DHGameMenuLayer *layer = [DHGameMenuLayer node];
	
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
        [self initMenu];
        [self initContinueMenu];
        
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

-(void)initMenu
{
    _menuRect = _bgRect;
    _menuObj = [[DHMenuObj alloc] initWithWinRect:_menuRect];
    [_menuObj addtoScene: self];
}

-(void)initContinueMenu
{
    if( [DHGameData sharedDHGameData].cur_game_pause == 1 )
    {
        CGRect rect = _bgRect;
        CCMenuItem *menuitem_con = [CCMenuItemImage
                                    itemWithNormalImage:@"continue.png" selectedImage:@"continue.png"
                                    target:self selector:@selector(ContinueMenuPressed:)];
        menuitem_con.position = ccp(rect.origin.x + rect.size.width*0.85, rect.origin.y + rect.size.height*0.1);
        menuitem_con.scale *= (0.5*CC_CONTENT_SCALE_FACTOR());
        
        CCMenu* main_menu = [CCMenu menuWithItems:menuitem_con, nil];
        main_menu.position = CGPointZero;
        [self addChild:main_menu];
    }
}

-(void)ContinueMenuPressed:(id)sender
{
    if( [DHGameData sharedDHGameData].cur_game_pause == 1 )
    {
        [DHGameData sharedDHGameData].cur_game_pause = 0;
        [[CCDirector sharedDirector] popScene];
    }
}

#pragma mark - update part
-(void) update:(ccTime)dt
{
    [self updateBG:dt];
    [self updateMenu:dt];
}

-(void) updateBG:(ccTime)dt
{
    [_bgObj update:dt];
}

-(void)updateMenu:(ccTime)dt
{
    [_menuObj update:dt];
}

#pragma mark - touch part

#pragma mark - dealloc part
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[_bgObj release];
    [_menuObj release];
    
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
