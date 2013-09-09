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

@property(nonatomic, assign)enum GAME_MODE cur_game_mode;
@property(nonatomic, assign)int cur_game_score;
@property(nonatomic, retain)NSMutableArray* timemode_scores;
@property(nonatomic, retain)NSMutableArray* freemode_scores;

+(DHGameData *)sharedDHGameData;
-(int)getHighestScore:(enum GAME_MODE)game_mode;
-(void)addScore:(int)sc gameMode:(enum GAME_MODE)game_mode;

@end
