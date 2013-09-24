//
//  DHGameScoreListLayer.m
//  XDuckHunt
//
//  Created by Fallson on 7/27/13.
//  Copyright Fallson 2013. All rights reserved.
//


// Import the interfaces
#import "DHGameScoreListLayer.h"

#import "DHBackGroundObj.h"
#import "DHConstons.h"
#import "DHGameData.h"
#import "DHLabel.h"
#import "DHGameMenuLayer.h"
#pragma mark - DHGameScoreListLayer
@implementation DHGameScoreListLayer
{
    DHBackGroundObj* _bgObj;
    CGRect           _bgRect;
}

// Helper class method that creates a Scene with the DHGameScoreListLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DHGameScoreListLayer *layer = [DHGameScoreListLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
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
    NSString* freemode_str = [NSString stringWithFormat:@"Free Mode : "];
    DHLabel* freemode_lable = [DHLabel labelWithString:freemode_str fontName:DHLABEL_FONT fontSize:24];
    freemode_lable.color = ccYELLOW;
    freemode_lable.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.5, _bgRect.origin.y + 0.9*_bgRect.size.height);
    [freemode_lable setAnchorPoint: ccp(0.5f, 0.5f)];
    [self addChild:freemode_lable];
    
    NSMutableArray* scores = [DHGameData sharedDHGameData].freemode_scores;
    for( int i = 0; i < [scores count]; i++ )
    {
        int s = [[scores objectAtIndex:i] intValue];
        NSString* score_str = [NSString stringWithFormat:@"%d", s];
        DHLabel* score_label = [DHLabel labelWithString:score_str fontName:DHLABEL_FONT fontSize:18];
        score_label.color = ccYELLOW;
        score_label.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.5, _bgRect.origin.y + (0.85-0.03*i)*_bgRect.size.height);
        [score_label setAnchorPoint: ccp(0.5f, 0.5f)];
        [self addChild:score_label];
        
        //left alignment
        //[label setAnchorPoint: ccp(0, 0.5f)];
        // right alignment
        //[label setAnchorPoint: ccp(1, 0.5f)];
        // center aligment (default)
        //[label setAnchorPoint: ccp(0.5f, 0.5f)];
    }
    
    NSString* timemode_str = [NSString stringWithFormat:@"Time Mode : "];
    DHLabel* timemode_lable = [DHLabel labelWithString:timemode_str fontName:DHLABEL_FONT fontSize:24];
    timemode_lable.color = ccYELLOW;
    timemode_lable.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.5, _bgRect.origin.y + 0.6*_bgRect.size.height);
    [timemode_lable setAnchorPoint: ccp(0.5f, 0.5f)];
    [self addChild:timemode_lable];
    
    scores = [DHGameData sharedDHGameData].timemode_scores;
    for( int i = 0; i < [scores count]; i++ )
    {
        int s = [[scores objectAtIndex:i] intValue];
        NSString* score_str = [NSString stringWithFormat:@"%d", s];
        DHLabel* score_label = [DHLabel labelWithString:score_str fontName:DHLABEL_FONT fontSize:18];
        score_label.color = ccYELLOW;
        score_label.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.5, _bgRect.origin.y + (0.55-0.03*i)*_bgRect.size.height);
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
