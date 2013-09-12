//
//  DHTimeModePannelObj.m
//  XDuckHunt
//
//  Created by Fallson on 8/15/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHTimeModePannelObj.h"
#import "DHLabel.h"
#import "ccTypes.h"


@interface DHTimeModePannelObj()
{
    CGRect _winRect;
}

@property (nonatomic, retain)DHLabel* highest_score_label;
@property (nonatomic, retain)DHLabel* score_label;
@property (nonatomic, retain)DHLabel* left_time_label;
@property (nonatomic, retain)DHLabel* hit_count_label;
@end

@implementation DHTimeModePannelObj

@synthesize highest_score = _highest_score;
@synthesize score = _score;
@synthesize left_time = _left_time;
@synthesize hit_count = _hit_count;

@synthesize highest_score_label = _highest_score_label;
@synthesize score_label = _score_label;
@synthesize left_time_label = _left_time_label;
@synthesize hit_count_label = _hit_count_label;

-(id) initWithWinRect: (CGRect)rect
{
	if( (self=[super init]) )
    {
        _winRect = rect;
        
        self.highest_score = 0;
        self.score = 0;
        self.left_time = 0;
        self.hit_count = 0;
        
        NSString* highest_score_str = [NSString stringWithFormat:@"highest score: %d", self.highest_score];
        self.highest_score_label = [DHLabel labelWithString:highest_score_str fontName:DHLABEL_FONT fontSize:24];
        self.highest_score_label.color=ccYELLOW;
        self.highest_score_label.position = ccp(_winRect.origin.x + 10, _winRect.origin.y + 0.5*_winRect.size.height);
        [self.highest_score_label setAnchorPoint: ccp(0, 0.5f)];

        
        NSString* score_str = [NSString stringWithFormat:@"current score: %d", self.score];
        self.score_label = [DHLabel labelWithString:score_str fontName:DHLABEL_FONT fontSize:24];
        self.score_label.color=ccYELLOW;
        self.score_label.position = ccp(_winRect.origin.x + 10, _winRect.origin.y);
        [self.score_label setAnchorPoint: ccp(0, 0.5f)];
        
        NSString* left_time_str = [NSString stringWithFormat:@"left time: %d", (int)self.left_time];
        self.left_time_label = [DHLabel labelWithString:left_time_str fontName:DHLABEL_FONT fontSize:24];
        self.left_time_label.color=ccYELLOW;
        self.left_time_label.position = ccp(_winRect.origin.x + 0.8*_winRect.size.width, _winRect.origin.y + 0.5*_winRect.size.height);
        [self.left_time_label setAnchorPoint: ccp(0, 0.5f)];
        
        NSString* hit_count_str = [NSString stringWithFormat:@"hit count: %d", self.hit_count];
        self.hit_count_label = [DHLabel labelWithString:hit_count_str fontName:DHLABEL_FONT fontSize:24];
        self.hit_count_label.color=ccYELLOW;
        self.hit_count_label.position = ccp(_winRect.origin.x + 0.8*_winRect.size.width, _winRect.origin.y);
        [self.hit_count_label setAnchorPoint: ccp(0, 0.5f)];
	}
    
	return self;
}

-(void)addtoScene: (CCLayer*)layer
{
    [layer addChild:self.highest_score_label];
    [layer addChild:self.score_label];
    [layer addChild:self.left_time_label];
    [layer addChild:self.hit_count_label];
}

-(void)update:(ccTime)dt
{
    NSString* highest_score_str = [NSString stringWithFormat:@"highest score: %d", self.highest_score];
    [self.highest_score_label setString:highest_score_str];
    
    NSString* score_str = [NSString stringWithFormat:@"current score: %d", self.score];
    [self.score_label setString:score_str];
    
    NSString* left_time_str = [NSString stringWithFormat:@"left time: %d", (int)self.left_time];
    [self.left_time_label setString:left_time_str];
    
    NSString* hit_count_str = [NSString stringWithFormat:@"hit count: %d", self.hit_count];
    [self.hit_count_label setString:hit_count_str];
}

@end
