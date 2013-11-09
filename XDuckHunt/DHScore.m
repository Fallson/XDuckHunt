//
//  DHScore.m
//  XDuckHunt
//
//  Created by Fallson on 11/9/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHScore.h"

@implementation DHScore
+(int)GetScoreByType:(enum DUCK_TYPE) type
{
    static int duck_scores[] = {100,100,100,200,400,4000};
    
    if( (int)type >= sizeof(duck_scores)/sizeof(int) )
        return 100;
    
    return duck_scores[(int)type];
}
@end
