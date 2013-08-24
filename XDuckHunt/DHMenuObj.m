//
//  DHMenuObj.m
//  XDuckHunt
//
//  Created by Fallson on 8/19/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHMenuObj.h"
#import "DHLabel.h"
#import "DHTimeModeGameLayer.h"
#import "DHFreeModeGameLayer.h"
#import "DHGameOptionLayer.h"
#import "DHGameScoreListLayer.h"

@interface DHMenuObj()
{
    CGRect _winRect;
}

@property(nonatomic, retain)CCMenu* main_menu;
//@property(nonatomic, retain)CCMenuItem* menuitem_freemode;
//@property(nonatomic, retain)CCMenuItem* menuitem_timemode;
//@property(nonatomic, retain)CCMenuItem* menuitem_option;
//@property(nonatomic, retain)CCMenuItem* menuitem_scorelist;
@property(nonatomic, retain) DHLabel* freemode_label;
@property(nonatomic, retain) DHLabel* timemode_label;
@property(nonatomic, retain) DHLabel* option_label;
@property(nonatomic, retain) DHLabel* scorelist_label;

@end

@implementation DHMenuObj
@synthesize main_menu=_main_menu;
//@synthesize menuitem_freemode=_menuitem_freemode;
//@synthesize menuitem_timemode=_menuitem_timemode;
//@synthesize menuitem_option=_menuitem_option;
//@synthesize menuitem_scorelist=_menuitem_scorelist;
@synthesize freemode_label=_freemode_label;
@synthesize timemode_label=_timemode_label;
@synthesize option_label=_option_label;
@synthesize scorelist_label=_scorelist_label;



-(id) initWithWinRect: (CGRect)rect
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
        _winRect = rect;
        CGSize sz = rect.size;
        CGPoint ori = rect.origin;
        
        CCMenuItem *menuitem_freemode = [CCMenuItemImage
                                         itemWithNormalImage:@"MenuItem.png" selectedImage:@"MenuItem_pressed.png"
                                         target:self selector:@selector(FreeModeMenuPressed:)];
        menuitem_freemode.position = ccp(ori.x + sz.width*0.2, ori.y + sz.height*0.8);
        NSString* freemode_str = [NSString stringWithFormat:@"Free Mode"];
        self.freemode_label = [DHLabel labelWithString:freemode_str fontName:DHLABEL_FONT fontSize:20];
        self.freemode_label.color=ccBLUE;
        self.freemode_label.position = menuitem_freemode.position;
        [self.freemode_label setAnchorPoint: ccp(0.5f, 0.5f)];
        
        
        CCMenuItem *menuitem_timemode = [CCMenuItemImage
                                         itemWithNormalImage:@"MenuItem.png" selectedImage:@"MenuItem_pressed.png"
                                         target:self selector:@selector(TimeModeMenuPressed:)];
        menuitem_timemode.position = ccp(ori.x + sz.width*0.35, ori.y + sz.height*0.6);
        NSString* timemode_str = [NSString stringWithFormat:@"Time Mode"];
        self.timemode_label = [DHLabel labelWithString:timemode_str fontName:DHLABEL_FONT fontSize:20];
        self.timemode_label.color=ccBLUE;
        self.timemode_label.position = menuitem_timemode.position;
        [self.timemode_label setAnchorPoint: ccp(0.5f, 0.5f)];
        
        CCMenuItem *menuitem_option = [CCMenuItemImage
                                       itemWithNormalImage:@"MenuItem.png" selectedImage:@"MenuItem_pressed.png"
                                       target:self selector:@selector(OptionMenuPressed:)];
        menuitem_option.position = ccp(ori.x + sz.width*0.6, ori.y + sz.height*0.6);
        NSString* option_str = [NSString stringWithFormat:@"Game Option"];
        self.option_label = [DHLabel labelWithString:option_str fontName:DHLABEL_FONT fontSize:20];
        self.option_label.color=ccBLUE;
        self.option_label.position = menuitem_option.position;
        [self.option_label setAnchorPoint: ccp(0.5f, 0.5f)];
        
        CCMenuItem *menuitem_scorelist = [CCMenuItemImage
                                          itemWithNormalImage:@"MenuItem.png" selectedImage:@"MenuItem_pressed.png"
                                          target:self selector:@selector(ScoreListMenuPressed:)];
        menuitem_scorelist.position = ccp(ori.x + sz.width*0.8, ori.y + sz.height*0.8);
        NSString* scorelist_str = [NSString stringWithFormat:@"Score List"];
        self.scorelist_label = [DHLabel labelWithString:scorelist_str fontName:DHLABEL_FONT fontSize:20];
        self.scorelist_label.color=ccBLUE;
        self.scorelist_label.position = menuitem_scorelist.position;
        [self.scorelist_label setAnchorPoint: ccp(0.5f, 0.5f)];
        
        _main_menu = [CCMenu menuWithItems:menuitem_freemode, menuitem_timemode, menuitem_option, menuitem_scorelist, nil];
        _main_menu.position = CGPointZero;
	}
	return self;
}

-(void)addtoScene: (CCLayer*)layer
{
    [layer addChild:self.main_menu];
    [layer addChild:self.freemode_label];
    [layer addChild:self.timemode_label];
    [layer addChild:self.option_label];
    [layer addChild:self.scorelist_label];
}

-(void)update:(ccTime)dt
{
}

-(void)FreeModeMenuPressed:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[DHFreeModeGameLayer scene] ]];
}

-(void)TimeModeMenuPressed:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[DHTimeModeGameLayer scene] ]];
}

-(void)OptionMenuPressed:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[DHGameOptionLayer scene] ]];
}

-(void)ScoreListMenuPressed:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[DHGameScoreListLayer scene] ]];
}

@end
