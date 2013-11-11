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
#import <Social/Social.h>

#import "DHBackGroundObj.h"
#import "DHConstons.h"
#import "DHGameData.h"
#import "DHLabel.h"
#import "DHGameMenuLayer.h"
#import "DHIntroPannelObj.h"
#pragma mark - DHGameOverLayer


// DHGameOverLayer implementation
@implementation DHGameOverLayer
{
    DHBackGroundObj* _bgObj;
    CGRect           _bgRect;
    
    DHIntroPannelObj* _game_hitObj;
    CGRect            _game_hitRect;
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
    enum GAME_MODE cur_game_mode = [DHGameData sharedDHGameData].cur_game_mode;
    int cur_game_score = [DHGameData sharedDHGameData].cur_game_score;
    
    [[DHGameData sharedDHGameData] addScore: cur_game_score gameMode:cur_game_mode];
    
    NSString* str = [NSString stringWithFormat:@"Game Over\n Your Score : %d", cur_game_score];
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
//    NSString* return_str = [NSString stringWithFormat:@"Return"];
//    DHLabel* return_label = [DHLabel labelWithString:return_str fontName:DHLABEL_FONT fontSize:20];
//    return_label.color=ccBLUE;
//    return_label.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.4, _bgRect.origin.y + 0.3*_bgRect.size.height);
//    [return_label setAnchorPoint: ccp(0.5f, 0.5f)];
//    
//    CCMenuItem *menuitem_return = [CCMenuItemImage
//                                   itemWithNormalImage:@"MenuItem.png" selectedImage:@"MenuItem_pressed.png"
//                                   target:self selector:@selector(ReturnMenuPressed:)];
//    menuitem_return.scale *= CC_CONTENT_SCALE_FACTOR();
//    menuitem_return.position = return_label.position;
    
    //twitter
    CCMenuItem *menuitem_twitter = [CCMenuItemImage
                                   itemWithNormalImage:@"twitter.png" selectedImage:@"twitter.png"
                                   target:self selector:@selector(TwitterMenuPressed:)];
    menuitem_twitter.scale *= (0.25 * CC_CONTENT_SCALE_FACTOR());
    menuitem_twitter.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.4, _bgRect.origin.y + 0.3*_bgRect.size.height);
    
    //facebook
    CCMenuItem *menuitem_facebook = [CCMenuItemImage
                                    itemWithNormalImage:@"facebook.png" selectedImage:@"facebook.png"
                                    target:self selector:@selector(FacebookMenuPressed:)];
    menuitem_facebook.scale *= (0.25 * CC_CONTENT_SCALE_FACTOR());
    menuitem_facebook.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.5, _bgRect.origin.y + 0.3*_bgRect.size.height);
    
    //weibo
    CCMenuItem *menuitem_weibo = [CCMenuItemImage
                                    itemWithNormalImage:@"weibo.png" selectedImage:@"weibo.png"
                                    target:self selector:@selector(WeiboMenuPressed:)];
    menuitem_weibo.scale *= (0.25 * CC_CONTENT_SCALE_FACTOR());
    menuitem_weibo.position = ccp(_bgRect.origin.x + _bgRect.size.width*0.6, _bgRect.origin.y + 0.3*_bgRect.size.height);
    
    
    CCMenu* main_menu = [CCMenu menuWithItems:/*menuitem_return,*/ menuitem_twitter, menuitem_facebook, menuitem_weibo ,nil];
    main_menu.position = CGPointZero;
    [self addChild:main_menu];
//    [self addChild:return_label];
}

-(void)ReturnMenuPressed:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[DHGameMenuLayer scene] ]];
}

- (void)showUnavailableAlertForServiceType: (NSString *)selectedServiceType
{
    NSString *serviceName = @"";
    if (selectedServiceType == SLServiceTypeFacebook)
    {
        serviceName = @"Facebook";
    }
    else if (selectedServiceType == SLServiceTypeSinaWeibo)
    {
        serviceName = @"Sina Weibo";
    }
    else if (selectedServiceType == SLServiceTypeTwitter)
    {
        serviceName = @"Twitter";
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Account"
                              message:[NSString stringWithFormat:@"Please go to the device settings and add a %@ account in order to share through that service",serviceName]delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alertView show];
}

-(NSString*)getFullPath:(NSString*)path
{
    CCFileUtils *fileUtils = [CCFileUtils sharedFileUtils];
    path = [fileUtils standarizePath:path];
    ccResolutionType resolution;
    NSString *fullpath = [fileUtils fullPathForFilename:path resolutionType:&resolution];
    if( ! fullpath ) {
        CCLOG(@"cocos2d: Couldn't find file:%@", path);
        return nil;
    }
    return fullpath;
}

-(void)TwitterMenuPressed:(id)sender
{
    if( SYSTEM_VERSION_LESS_THAN(@"6.0") )
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Low Version"
                                                            message:[NSString stringWithFormat:@"This function can't work below ios 6.0"]delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alertView show];
        
        [self ReturnMenuPressed:nil];
        
        return;
    }
    
    enum GAME_MODE cur_game_mode = [DHGameData sharedDHGameData].cur_game_mode;
    int cur_game_score = [DHGameData sharedDHGameData].cur_game_score;
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        if( cur_game_mode == TIME_MODE )
            [tweetSheet setInitialText: [NSString stringWithFormat:@"Great work in game DuckHunt, you got %d in time mode! https://itunes.apple.com/us/app/duckhunt/id725538960?ls=1&mt=8", cur_game_score]];
        else if( cur_game_mode == FREE_MODE )
            [tweetSheet setInitialText: [NSString stringWithFormat:@"Great work in game DuckHunt, you got %d in free mode! https://itunes.apple.com/us/app/duckhunt/id725538960?ls=1&mt=8", cur_game_score]];
     
//        NSURL* url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/duckhunt/id725538960?ls=1&mt=8"];
//        BOOL ret = [tweetSheet addURL: url];
        
        NSString* fullpath = [self getFullPath:@"Icon.png"];
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:fullpath];
        [tweetSheet addImage:img];
        [img release];
        
        [[CCDirector sharedDirector] presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        [self showUnavailableAlertForServiceType: SLServiceTypeTwitter];
    }
    
    [self ReturnMenuPressed:nil];
}

-(void)FacebookMenuPressed:(id)sender
{
    if( SYSTEM_VERSION_LESS_THAN(@"6.0") )
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Low Version"
                                                            message:[NSString stringWithFormat:@"This function can't work below ios 6.0"]delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alertView show];
        
        [self ReturnMenuPressed:nil];
        
        return;
    }
    
    enum GAME_MODE cur_game_mode = [DHGameData sharedDHGameData].cur_game_mode;
    int cur_game_score = [DHGameData sharedDHGameData].cur_game_score;
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *facebookSheet = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeFacebook];
        if( cur_game_mode == TIME_MODE )
            [facebookSheet setInitialText: [NSString stringWithFormat:@"Great work in game DuckHunt, you got %d in time mode! https://itunes.apple.com/us/app/duckhunt/id725538960?ls=1&mt=8", cur_game_score]];
        else if( cur_game_mode == FREE_MODE )
            [facebookSheet setInitialText: [NSString stringWithFormat:@"Great work in game DuckHunt, you got %d in free mode! https://itunes.apple.com/us/app/duckhunt/id725538960?ls=1&mt=8", cur_game_score]];
        
        //        NSURL* url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/duckhunt/id725538960?ls=1&mt=8"];
        //        BOOL ret = [tweetSheet addURL: url];
        
        NSString* fullpath = [self getFullPath:@"Icon.png"];
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:fullpath];
        [facebookSheet addImage:img];
        [img release];
        
        [[CCDirector sharedDirector] presentViewController:facebookSheet animated:YES completion:nil];
    }
    else
    {
        [self showUnavailableAlertForServiceType: SLServiceTypeFacebook];
    }
    
    [self ReturnMenuPressed:nil];
}

-(void)WeiboMenuPressed:(id)sender
{
    if( SYSTEM_VERSION_LESS_THAN(@"6.0") )
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Low Version"
                                                            message:[NSString stringWithFormat:@"This function can't work below ios 6.0"]delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alertView show];
        
        [self ReturnMenuPressed:nil];
        
        return;
    }
    
    enum GAME_MODE cur_game_mode = [DHGameData sharedDHGameData].cur_game_mode;
    int cur_game_score = [DHGameData sharedDHGameData].cur_game_score;
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo])
    {
        SLComposeViewController *weiboSheet = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        if( cur_game_mode == TIME_MODE )
            [weiboSheet setInitialText: [NSString stringWithFormat:@"恭喜你在游戏-打鸭子中获得%d的高分! https://itunes.apple.com/us/app/duckhunt/id725538960?ls=1&mt=8", cur_game_score]];
        else if( cur_game_mode == FREE_MODE )
            [weiboSheet setInitialText: [NSString stringWithFormat:@"恭喜你在游戏-打鸭子中获得%d的高分! https://itunes.apple.com/us/app/duckhunt/id725538960?ls=1&mt=8", cur_game_score]];
        //[weiboSheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/duckhunt/id725538960?ls=1&mt=8"]];
        
        NSString* fullpath = [self getFullPath:@"Icon.png"];
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:fullpath];
        [weiboSheet addImage:img];
        [img release];
        [[CCDirector sharedDirector] presentViewController:weiboSheet animated:YES completion:nil];
    }
    else
    {
        [self showUnavailableAlertForServiceType: SLServiceTypeSinaWeibo];
    }
    
    [self ReturnMenuPressed:nil];
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
