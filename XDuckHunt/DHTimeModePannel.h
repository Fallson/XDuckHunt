//
//  DHTimeModePannel.h
//  XDuckHunt
//
//  Created by Fallson on 8/15/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DHTimeModePannel : NSObject
{
    int _score;
    ccTime _left_time;
    int _hit_count;
}

-(id) initWithWinRect: (CGRect)rect;
-(void)addtoScene: (CCLayer*)layer;
-(void)update:(ccTime)dt;

@property (nonatomic, assign)int score;
@property (nonatomic, assign)ccTime left_time;
@property (nonatomic, assign)int hit_count;
@end
