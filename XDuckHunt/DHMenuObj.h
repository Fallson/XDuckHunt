//
//  DHMenuObj.h
//  XDuckHunt
//
//  Created by Fallson on 8/19/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DHMenuObj : NSObject

-(id) initWithWinRect: (CGRect)rect;
-(void)addtoScene: (CCLayer*)layer;
-(void)update:(ccTime)dt;
@end
