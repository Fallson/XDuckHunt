//
//  DHBackGroundObj.m
//  XDuckHunt
//
//  Created by Fallson on 7/28/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHBackGroundObj.h"
#import "DHConstons.h"
#import "DHZDepth.h"

#define CLOUD_MV_STEP    5
#define SMOKE_SPRITE_NUM 5

@interface DHBackGroundObj()
{
    int _smoke_idx;
    ccTime _accDT;
    CGRect _winRect;
}

@property(nonatomic, retain)CCSprite* bg_sky;
@property(nonatomic, retain)CCSprite* bg_grass;
@property(nonatomic, retain)CCSprite* bg_tree;
@property(nonatomic, retain)CCSprite* bg_cloud;
@property(nonatomic, retain)CCSpriteBatchNode* smoke_spriteSheet;
@property(nonatomic, retain)CCSprite* smoke;

@end
@implementation DHBackGroundObj

@synthesize bg_sky=_bg_sky;
@synthesize bg_grass=_bg_grass;
@synthesize bg_tree=_bg_tree;
@synthesize bg_cloud=_bg_cloud;
@synthesize smoke_spriteSheet=_smoke_spriteSheet;
@synthesize smoke=_smoke;


-(id) initWithWinRect: (CGRect)rect
{
    //static int inited = 0; //we should use singleton
    
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
        _winRect = rect;
        CGSize sz = rect.size;
        CGPoint ori = rect.origin;
        
        self.bg_sky = [CCSprite spriteWithFile: @"bg_sky.png"];
        float scale_r = sz.height/self.bg_sky.contentSize.height;
//        NSLog(@"sz(%f,%f) and sky(%f,%f), scale_r is: %f", sz.width, sz.height,
//              _bg_sky.contentSize.width, _bg_sky.contentSize.height ,scale_r);
        self.bg_sky.scale = scale_r;
        self.bg_sky.position = ccp( ori.x + sz.width/2, ori.y + sz.height/2 );
        self.bg_sky.zOrder = BG_SKY_Z;
        
        self.bg_grass = [CCSprite spriteWithFile: @"bg_grass.png"];
        self.bg_grass.scaleX = sz.width/self.bg_grass.contentSize.width;
        self.bg_grass.scaleY = sz.height/self.bg_grass.contentSize.height;
        self.bg_grass.position = ccp( ori.x + sz.width/2, ori.y + sz.height/2 );
        self.bg_grass.zOrder = BG_GRASS_Z;
        
        self.bg_tree = [CCSprite spriteWithFile: @"bg_tree.png"];
        self.bg_tree.scaleX = sz.width/self.bg_tree.contentSize.width;
        self.bg_tree.scaleY = sz.height/self.bg_tree.contentSize.height;
        self.bg_tree.position = ccp( ori.x + sz.width/2, ori.y + sz.height/2 );
        self.bg_tree.zOrder = BG_TREE_Z;
        
        self.bg_cloud = [CCSprite spriteWithFile: @"Cloud.png"];
        self.bg_cloud.scale = 0.25;
        self.bg_cloud.position = ccp( ori.x, ori.y + sz.height*0.78 );
        self.bg_cloud.zOrder = BG_CLOUD_Z;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sky_smoke.plist"];
        self.smoke_spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"sky_smoke.png"];
        self.smoke = [CCSprite spriteWithSpriteFrameName:@"sky_smoke_1.png"];
        self.smoke.position = ccp(ori.x + sz.width*0.969, ori.y + sz.height*0.621);
        self.smoke.scale = 0.5;
        self.smoke.zOrder = BG_SMOKE_Z;
        _smoke_idx = 0;
        [self.smoke_spriteSheet addChild:self.smoke];
        
	}
	return self;
}

-(void)addtoScene: (CCLayer*)layer
{
    [layer addChild:self.bg_sky];
    [layer addChild:self.bg_grass];
    [layer addChild:self.bg_tree];
    [layer addChild:self.bg_cloud];
    
    [layer addChild:self.smoke_spriteSheet];
}

-(void)update:(ccTime)dt
{
    _accDT += dt;
    if( _accDT < BG_UPDATE_TIME )
        return;
    _accDT = 0;
    
    //smoke animation
    _smoke_idx = (++_smoke_idx)%SMOKE_SPRITE_NUM;
    
    NSString* frame_name = [NSString stringWithFormat:@"sky_smoke_%i.png",_smoke_idx+1];
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                            spriteFrameByName:frame_name];
    [self.smoke setDisplayFrame:frame];
    
    //cloud animation
    CGPoint cur = self.bg_cloud.position;
    cur.x += CLOUD_MV_STEP;
    if( cur.x > _winRect.size.width + self.bg_cloud.contentSize.width/2 )
    {
        cur.x = -self.bg_cloud.contentSize.width/2;
    }
    self.bg_cloud.position = cur;
    
}

@end
