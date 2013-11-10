//
//  DHFloatingScoreObj.h
//  XDuckHunt
//
//  Created by Fallson on 11/9/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DHFloatingScoreObj : NSObject
@property (nonatomic, assign)bool visible;

-(id)initWithWinRect: (CGRect)rect andPos:(CGPoint)pos andScore:(int)score;
-(void)addtoScene: (CCLayer*)layer;
-(void)removeFromScene: (CCLayer*)layer;
-(void)updatePos:(CGPoint)pos;
-(void)update:(ccTime)dt;

@end
