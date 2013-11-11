//
//  DHFreeModeContinueLayer.m
//  XDuckHunt
//
//  Created by Fallson on 7/27/13.
//  Copyright Fallson 2013. All rights reserved.
//


// Import the interfaces
#import "DHFreeModeContinueLayer.h"
#import "CCTouchDispatcher.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "DHBackGroundObj.h"
#import "DHConstons.h"
#import "DHGameData.h"
#import "DHLabel.h"
#import "DHGameMenuLayer.h"
#import "DHIntroPannelObj.h"
#pragma mark - DHFreeModeContinueLayer


// DHFreeModeContinueLayer implementation
@implementation DHFreeModeContinueLayer
{
    DHBackGroundObj* _bgObj;
    CGRect           _bgRect;
    
    DHIntroPannelObj* _game_hitObj;
    CGRect            _game_hitRect;
}

// Helper class method that creates a Scene with the DHFreeModeContinueLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DHFreeModeContinueLayer *layer = [DHFreeModeContinueLayer node];
	
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
        [self initScores];
        [self initHits];
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
    _bgObj = [[DHBackGroundObj alloc] initWithWinRect: _bgRect andDucks:true];
    [_bgObj addtoScene: self];
}

-(void)initScores
{
    int cur_game_score = [DHGameData sharedDHGameData].cur_game_score;
    int hit_num = [DHGameData sharedDHGameData].cur_game_hit.duck_hit +
    [DHGameData sharedDHGameData].cur_game_hit.bird_hit +
    [DHGameData sharedDHGameData].cur_game_hit.parrot_hit;
    int miss_num = [DHGameData sharedDHGameData].cur_game_miss;
    
    NSString* str = [NSString stringWithFormat:@"Chapter Over\n Current Score : %d and Hit Rate: %d%%", cur_game_score, hit_num*100/(hit_num+miss_num)];
    DHLabel* lable = [DHLabel labelWithString:str fontName:DHLABEL_FONT fontSize:24];
    lable.color = ccDH;
    lable.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.5, _bgRect.origin.y + 0.9*_bgRect.size.height);
    [lable setAnchorPoint: ccp(0.5f, 0.5f)];
    [self addChild:lable];
}

-(void)initHits
{
    _game_hitRect = _bgRect;
    _game_hitRect.origin.y +=0.25*_game_hitRect.size.height;
    _game_hitRect.size.height *= 0.65;
    
    _game_hitObj = [[DHIntroPannelObj alloc] initWithWinRect:_game_hitRect
                                                  andDuckNum:[DHGameData sharedDHGameData].cur_game_hit.duck_hit
                                                  andBirdNum:[DHGameData sharedDHGameData].cur_game_hit.bird_hit
                                                andPirrotNum:[DHGameData sharedDHGameData].cur_game_hit.parrot_hit];
    [_game_hitObj addtoScene:self];
}

-(void)initMenu
{
    NSString* return_str = [NSString stringWithFormat:@"Next Chapter"];
    DHLabel* return_label = [DHLabel labelWithString:return_str fontName:DHLABEL_FONT fontSize:20];
    return_label.color=ccBLUE;
    return_label.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.5, _bgRect.origin.y + 0.3*_bgRect.size.height);
    [return_label setAnchorPoint: ccp(0.5f, 0.5f)];
    
    CCMenuItem *menuitem_return = [CCMenuItemImage
                                   itemWithNormalImage:@"MenuItem.png" selectedImage:@"MenuItem_pressed.png"
                                   target:self selector:@selector(ReturnMenuPressed:)];
    menuitem_return.scale *= CC_CONTENT_SCALE_FACTOR();
    menuitem_return.position = return_label.position;
    
    CCMenu* main_menu = [CCMenu menuWithItems:menuitem_return,nil];
    main_menu.position = CGPointZero;
    [self addChild:main_menu];
    [self addChild:return_label];
}

-(void)ReturnMenuPressed:(id)sender
{
    [[CCDirector sharedDirector] popScene];
}

#pragma mark - update part
-(void) update:(ccTime)dt
{
    [self updateBG:dt];
    [self updateHits:dt];
}

-(void) updateBG:(ccTime)dt
{
    [_bgObj update:dt];
}

-(void) updateHits:(ccTime)dt
{
    [_game_hitObj update:dt];
}

#pragma mark - dealloc part
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[_bgObj release];
    [_game_hitObj release];
    
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
