//
//  DHGameSplashLayer.m
//  XDuckHunt
//
//  Created by Fallson on 7/27/13.
//  Copyright Fallson 2013. All rights reserved.
//


// Import the interfaces
#import "DHGameSplashLayer.h"
#import "DHGameMenuLayer.h"
#import "SimpleAudioEngine.h"

#pragma mark - DHGameSplashLayer

// HelloWorldLayer implementation
@implementation DHGameSplashLayer

// Helper class method that creates a Scene with the DHGameSplashLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DHGameSplashLayer *layer = [DHGameSplashLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(id) init
{
	if( (self=[super init])) {

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			//background = [CCSprite spriteWithFile:@"Default.png"];
			//background.rotation = 90;
		} else {
			//background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
        background = [CCSprite spriteWithFile:@"SplashScreen.png"];
		background.position = ccp(size.width/2, size.height/2);
        background.scale *= CC_CONTENT_SCALE_FACTOR();
        
		// add the label as a child to this Layer
		[self addChild: background];
        
        //preload sound
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"gameMusic.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"dog.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"duck_live.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"duck_dead.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"shoot.wav"];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[DHGameMenuLayer scene] ]];
}
@end
