//
//  DHBackGroundObj.m
//  XDuckHunt
//
//  Created by Fallson on 7/28/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHBackGroundObj.h"
#import "DHConstons.h"

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
    
    CGSize _winSz;
}

-(id) initWithWinSZ: (CGSize)sz
{
    //static int inited = 0; //we should use singleton
    
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
        _winSz = sz;
        
        _bg_sky = [CCSprite spriteWithFile: @"bg_sky.png"];
        [_bg_sky setScaleX:sz.width/_bg_sky.contentSize.width];
        [_bg_sky setScaleY:sz.height/_bg_sky.contentSize.height];
        _bg_sky.position = ccp( sz.width/2, sz.height/2 );
        _bg_sky.zOrder = -4;
        
        _bg_grass = [CCSprite spriteWithFile: @"bg_grass.png"];
        [_bg_grass setScaleX:sz.width/_bg_grass.contentSize.width];
        [_bg_grass setScaleY:sz.height/_bg_grass.contentSize.height];
        _bg_grass.position = ccp( sz.width/2, sz.height/2 );
        _bg_grass.zOrder = -2;
        
        _bg_tree = [CCSprite spriteWithFile: @"bg_tree.png"];
        [_bg_tree setScaleX:sz.width/_bg_tree.contentSize.width];
        [_bg_tree setScaleY:sz.height/_bg_tree.contentSize.height];
        _bg_tree.position = ccp( sz.width/2, sz.height/2 );
        _bg_tree.zOrder = 2;
        
        _bg_cloud = [CCSprite spriteWithFile: @"Cloud.png"];
        [_bg_cloud setScale:0.25];
        _bg_cloud.position = ccp( 0, sz.height*0.78 );
        _bg_cloud.zOrder = -3;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sky_smoke.plist"];
        _smoke_spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"sky_smoke.png"];
        _smoke = [CCSprite spriteWithSpriteFrameName:@"sky_smoke_1.png"];
        _smoke.position = ccp(sz.width*0.852, sz.height*0.621);
        [_smoke setScale:0.5];
        _smoke.zOrder = -3;
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
    static ccTime accDT = 0;
    accDT += dt;
    if( accDT < 0.5 )
        return;
    accDT = 0;
    
    _smoke_idx = (++_smoke_idx)%SMOKE_SPRITE_NUM;
    
    NSString* frame_name = [NSString stringWithFormat:@"sky_smoke_%i.png",_smoke_idx+1];
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                            spriteFrameByName:frame_name];
    [_smoke setDisplayFrame:frame];
    
    CGPoint cur = _bg_cloud.position;
    cur.x += CLOUD_MV_STEP;
    if( cur.x > _winSz.width + _bg_cloud.contentSize.width/2 )
    {
        cur.x = -_bg_cloud.contentSize.width/2;
    }
    _bg_cloud.position = cur;
    
}

@end
