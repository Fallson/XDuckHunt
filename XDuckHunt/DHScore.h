//
//  DHScore.h
//  XDuckHunt
//
//  Created by Fallson on 11/9/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHDuckObj.h"

@interface DHScore : NSObject

+(int)GetScoreByType:(enum DUCK_TYPE) type;
@end
