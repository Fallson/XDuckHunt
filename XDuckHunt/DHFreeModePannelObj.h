//
//  DHFreeModePannelObj.h
//  XDuckHunt
//
//  Created by Fallson on 8/15/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DHFreeModePannelObj : NSObject

-(id) initWithWinRect: (CGRect)rect;
-(void)addtoScene: (CCLayer*)layer;
-(void)update:(ccTime)dt;

@property (nonatomic, assign)int score;
@property (nonatomic, assign)int left_duck;
@property (nonatomic, assign)int hit_count;
@end
