//
//  DHFloatingScoreObj.m
//  XDuckHunt
//
//  Created by Fallson on 11/9/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHFloatingScoreObj.h"
#import "DHLabel.h"

#define SCORE_MV_STEP    2
#define MAX_MV_CNT       10

@interface DHFloatingScoreObj()
{
    int _update_cnt;
}
@property(nonatomic, retain)DHLabel* score_label;
@end

@implementation DHFloatingScoreObj
@synthesize visible = _visible;

@synthesize score_label=_score_label;

-(id)initWithWinRect: (CGRect)rect andPos:(CGPoint)pos andScore:(int)score
{
    if( (self=[super init]) )
    {
        _update_cnt = 0;
        self.visible = true;
        
        NSString* score_str = [NSString stringWithFormat:@"+%d", score];
        self.score_label = [DHLabel labelWithString:score_str fontName:DHLABEL_FONT fontSize:20];
        self.score_label.color = ccORANGE;
        self.score_label.position = pos;
        [self.score_label setAnchorPoint: ccp(0.5f, 0.0f)];
	}
	return self;
}

-(void)addtoScene: (CCLayer*)layer
{
    [layer addChild:self.score_label];
}

-(void)removeFromScene: (CCLayer*)layer
{
    [layer removeChild:self.score_label];
}

-(void)updatePos:(CGPoint)pos
{
    self.score_label.position = pos;
}

-(void)update:(ccTime)dt
{
    CGPoint pos = self.score_label.position;
    pos.y += SCORE_MV_STEP;
    self.score_label.position = pos;
    
    _update_cnt++;
    if( _update_cnt > MAX_MV_CNT )
    {
        self.visible = false;
    }
}


@end
