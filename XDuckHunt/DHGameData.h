//
//  DHGameData.h
//  XDuckHunt
//
//  Created by Fallson on 9/6/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHConstons.h"

typedef struct GameHit_
{
    int duck_hit;
    int bird_hit;
    int parrot_hit;
}GameHit;

@interface DHGameData : NSObject

@property(nonatomic, assign)enum GAME_MODE cur_game_mode;
@property(nonatomic, assign)int cur_game_score;
@property(nonatomic, assign)GameHit cur_game_hit;
@property(nonatomic, assign)int cur_game_miss;
@property(nonatomic, assign)int cur_game_pause;

@property(nonatomic, assign)int bgMusic;//BackGround Sound
@property(nonatomic, assign)int gameMusic;//Game Sound
@property(nonatomic, retain)NSMutableArray* timemode_scores;
@property(nonatomic, retain)NSMutableArray* freemode_scores;

+(DHGameData *)sharedDHGameData;
-(int)getHighestScore:(enum GAME_MODE)game_mode;
-(void)addScore:(int)sc gameMode:(enum GAME_MODE)game_mode;
-(void)addBGMusic:(int)v;
-(void)addGameMusic:(int)v;

@end
