//
//  DHGameChapter.h
//  XDuckHunt
//
//  Created by Fallson on 8/5/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>

enum CHAPTER_LVL{CHAPTER0=-1,CHAPTER1=0,CHAPTER2,CHAPTER3,CHAPTER4,CHAPTER5,
                 CHAPTER6, CHAPTER7, CHAPTER8, CHAPTER9, CHAPTER10, CHAPTER_MAX};
enum GAME_MODE{FREE_MODE=0, TIME_MODE};

@interface DHGameChapter : NSObject

@property (nonatomic, assign) enum GAME_MODE game_mode;
-(id)initWithWinRect: (CGRect)rect;
-(NSMutableArray*)getDucks:(enum CHAPTER_LVL) lvl;
@end
