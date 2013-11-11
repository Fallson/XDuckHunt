//
//  DHConstons.h
//  XDuckHunt
//
//  Created by Fallson on 8/2/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#ifndef XDuckHunt_DHConstons_h
#define XDuckHunt_DHConstons_h

enum GAME_MODE{FREE_MODE=0, TIME_MODE};

#define HIT_RADIUS     25
#define HIT_RADIUS_POW (HIT_RADIUS*HIT_RADIUS)
#define TIMEMODE_TOTAL_TIME 120
#define FREEMODE_TOTAL_DUCK 3
#define FREEMODE_CHAPTER_STEP 5
#define DUCK_FLYAWAY_TIME 13
#define BG_UPDATE_TIME   0.1
#define DUCK_UPDATE_TIME 0.1
#define DOG_UPDATE_TIME  0.1

#define PI  3.14159
#define EPS 0.00001
#define CURVE_RATIO 2

#define Groupfactor   5
#define MaxLineSteps  40
#define MaxCurveSteps 100

#pragma mark - ios version
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#endif
