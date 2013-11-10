//
//  DHIntroPannelObj.h
//  XDuckHunt
//
//  Created by Fallson on 8/15/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DHIntroPannelObj : NSObject
@property (nonatomic,assign)int duck_num;
@property (nonatomic,assign)int bird_num;
@property (nonatomic,assign)int parrot_num;

-(id) initWithWinRect: (CGRect)rect;
-(id) initWithWinRect: (CGRect)rect andDuckNum:(int)dn andBirdNum:(int)bn andPirrotNum:(int)pn;
-(void)addtoScene: (CCLayer*)layer;
-(void)removeFromScene: (CCLayer*)layer;
-(void)update:(ccTime)dt;

@end
