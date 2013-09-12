//
//  DHGameOverLayer.m
//  XDuckHunt
//
//  Created by Fallson on 7/27/13.
//  Copyright Fallson 2013. All rights reserved.
//


// Import the interfaces
#import "DHGameOverLayer.h"
#import "CCTouchDispatcher.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "DHBackGroundObj.h"
#import "DHConstons.h"
#import "DHGameData.h"
#import "DHLabel.h"
#import "DHGameMenuLayer.h"
#pragma mark - DHGameOverLayer


// DHGameOverLayer implementation
@implementation DHGameOverLayer
{
    DHBackGroundObj* _bgObj;
    CGRect           _bgRect;
}

// Helper class method that creates a Scene with the DHGameOverLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DHGameOverLayer *layer = [DHGameOverLayer node];
	
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

-(void)initScores
{
    enum GAME_MODE cur_game_mode = [DHGameData sharedDHGameData].cur_game_mode;
    int cur_game_score = [DHGameData sharedDHGameData].cur_game_score;
    
    [[DHGameData sharedDHGameData] addScore: cur_game_score gameMode:cur_game_mode];
    
    
    NSMutableArray* scores = nil;
    if( cur_game_mode == TIME_MODE )
    {
        scores = [DHGameData sharedDHGameData].timemode_scores;
    }
    else if( cur_game_mode == FREE_MODE )
    {
        scores = [DHGameData sharedDHGameData].freemode_scores;
    }
    
    NSString* str = [NSString stringWithFormat:@"Game Over : %d", cur_game_score];
    DHLabel* lable = [DHLabel labelWithString:str fontName:DHLABEL_FONT fontSize:24];
    lable.color = ccYELLOW;
    lable.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.5, _bgRect.origin.y + 0.9*_bgRect.size.height);
    [lable setAnchorPoint: ccp(0.5f, 0.5f)];
    [self addChild:lable];
    
    for( int i = 0; i < [scores count]; i++ )
    {
        int s = [scores objectAtIndex:i];
        NSString* score_str = [NSString stringWithFormat:@"%d", s];
        DHLabel* score_label = [DHLabel labelWithString:score_str fontName:DHLABEL_FONT fontSize:24];
        if( s == cur_game_score )
            score_label.color = ccRED;
        else
            score_label.color = ccYELLOW;
        score_label.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.5, _bgRect.origin.y + (0.8-0.05*i)*_bgRect.size.height);
        [score_label setAnchorPoint: ccp(0.5f, 0.5f)];
        [self addChild:score_label];
        
        //left alignment
        //[label setAnchorPoint: ccp(0, 0.5f)];
        // right alignment
        //[label setAnchorPoint: ccp(1, 0.5f)];
        // center aligment (default)
        //[label setAnchorPoint: ccp(0.5f, 0.5f)];
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
