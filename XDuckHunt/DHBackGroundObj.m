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

@implementation DHBackGroundObj
{
    CCSprite* _bg_sky;
    CCSprite* _bg_grass;
    CCSprite* _bg_tree;
    CCSprite* _bg_cloud;
    
    
    CCSpriteBatchNode* _smoke_spriteSheet;
    CCSprite* _smoke;
    int _smoke_idx;
    
    ccTime _accDT;
    
    CGRect _winRect;
}

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
        
        _bg_sky = [CCSprite spriteWithFile: @"bg_sky.png"];
        float scale_r = sz.height/_bg_sky.contentSize.height;
//        NSLog(@"sz(%f,%f) and sky(%f,%f), scale_r is: %f", sz.width, sz.height,
//              _bg_sky.contentSize.width, _bg_sky.contentSize.height ,scale_r);
        _bg_sky.scale = scale_r;
        _bg_sky.position = ccp( ori.x + sz.width/2, ori.y + sz.height/2 );
        _bg_sky.zOrder = BG_SKY_Z;
        
        _bg_grass = [CCSprite spriteWithFile: @"bg_grass.png"];
        _bg_grass.scaleX = sz.width/_bg_grass.contentSize.width;
        _bg_grass.scaleY = sz.height/_bg_grass.contentSize.height;
        _bg_grass.position = ccp( ori.x + sz.width/2, ori.y + sz.height/2 );
        _bg_grass.zOrder = BG_GRASS_Z;
        
        _bg_tree = [CCSprite spriteWithFile: @"bg_tree.png"];
        _bg_tree.scaleX = sz.width/_bg_tree.contentSize.width;
        _bg_tree.scaleY = sz.height/_bg_tree.contentSize.height;
        _bg_tree.position = ccp( ori.x + sz.width/2, ori.y + sz.height/2 );
        _bg_tree.zOrder = BG_TREE_Z;
        
        _bg_cloud = [CCSprite spriteWithFile: @"Cloud.png"];
        _bg_cloud.scale = 0.25;
        _bg_cloud.position = ccp( ori.x, ori.y + sz.height*0.78 );
        _bg_cloud.zOrder = BG_CLOUD_Z;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sky_smoke.plist"];
        _smoke_spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"sky_smoke.png"];
        _smoke = [CCSprite spriteWithSpriteFrameName:@"sky_smoke_1.png"];
        _smoke.position = ccp(ori.x + sz.width*0.969, ori.y + sz.height*0.621);
        _smoke.scale = 0.5;
        _smoke.zOrder = BG_SMOKE_Z;
        _smoke_idx = 0;
        [_smoke_spriteSheet addChild:_smoke];
        
	}
	return self;
}

-(void)addtoScene: (CCLayer*)layer
{
    [layer addChild:_bg_sky];
    [layer addChild:_bg_grass];
    [layer addChild:_bg_tree];
    [layer addChild:_bg_cloud];
    
    [layer addChild:_smoke_spriteSheet];
}

-(void)update:(ccTime)dt
{
    _accDT += dt;
    if( _accDT < 0.5 )
        return;
    _accDT = 0;
    
    //smoke animation
    _smoke_idx = (++_smoke_idx)%SMOKE_SPRITE_NUM;
    
    NSString* frame_name = [NSString stringWithFormat:@"sky_smoke_%i.png",_smoke_idx+1];
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                            spriteFrameByName:frame_name];
    [_smoke setDisplayFrame:frame];
    
    //cloud animation
    CGPoint cur = _bg_cloud.position;
    cur.x += CLOUD_MV_STEP;
    if( cur.x > _winRect.size.width + _bg_cloud.contentSize.width/2 )
    {
        cur.x = -_bg_cloud.contentSize.width/2;
    }
    _bg_cloud.position = cur;
    
}

@end
