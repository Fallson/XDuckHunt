//
//  DHGameData.h
//  XDuckHunt
//
//  Created by Fallson on 9/6/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHConstons.h"

@interface DHGameData : NSObject

@property(nonatomic, retain)NSMutableArray* timemode_scores;
@property(nonatomic, retain)NSMutableArray* freemode_scores;

-(void)addScore:(int)sc gameMode:(enum GAME_MODE)game_mode;

@end
