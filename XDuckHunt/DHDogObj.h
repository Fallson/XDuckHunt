//
//  DHDogObj.h
//  XDuckHunt
//
//  Created by Fallson on 8/18/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum DOG_STATE{DOG_RUNNING=0, DOG_SEEKING, DOG_RUNNING2, DOG_JUMPING, DOG_DISAPPEAR};

@interface DHDogObj : NSObject

@property(nonatomic, assign) enum DOG_STATE dog_state;
@property(nonatomic, assign) CGSize dog_size;

-(id)initWithWinRect: (CGRect)rect;
-(void)addtoScene: (CCLayer*)layer;
-(void)update:(ccTime)dt;
@end
