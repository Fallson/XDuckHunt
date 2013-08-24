//
//  DHFreeModePannelObj.m
//  XDuckHunt
//
//  Created by Fallson on 8/15/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHFreeModePannelObj.h"
#import "DHLabel.h"
#import "ccTypes.h"

@interface DHFreeModePannelObj()
{
    CGRect _winRect;
}

@property (nonatomic, retain)DHLabel* score_label;
@property (nonatomic, retain)DHLabel* left_duck_label;
@property (nonatomic, retain)DHLabel* hit_count_label;
@end

@implementation DHFreeModePannelObj

@synthesize score = _score;
@synthesize left_duck = _left_duck;
@synthesize hit_count = _hit_count;

@synthesize score_label = _score_label;
@synthesize left_duck_label = _left_duck_label;
@synthesize hit_count_label = _hit_count_label;

-(id) initWithWinRect: (CGRect)rect
{
	if( (self=[super init]) )
    {
        _winRect = rect;
        
        self.score = 0;
        self.left_duck = 0;
        self.hit_count = 0;
        
        NSString* score_str = [NSString stringWithFormat:@"score: %d", self.score];
        self.score_label = [DHLabel labelWithString:score_str fontName:DHLABEL_FONT fontSize:24];
        self.score_label.color=ccORANGE;
        self.score_label.position = ccp(_winRect.origin.x + 10, _winRect.origin.y + 0.5*_winRect.size.height);
        [self.score_label setAnchorPoint: ccp(0, 0.5f)];
        
        NSString* left_duck_str = [NSString stringWithFormat:@"left duck: %d", (int)self.left_duck];
        self.left_duck_label = [DHLabel labelWithString:left_duck_str fontName:DHLABEL_FONT fontSize:24];
        self.left_duck_label.color=ccORANGE;
        self.left_duck_label.position = ccp(_winRect.origin.x + 0.8*_winRect.size.width, _winRect.origin.y + 0.5*_winRect.size.height);
        [self.left_duck_label setAnchorPoint: ccp(0, 0.5f)];
        
        NSString* hit_count_str = [NSString stringWithFormat:@"hit count: %d", self.hit_count];
        self.hit_count_label = [DHLabel labelWithString:hit_count_str fontName:DHLABEL_FONT fontSize:24];
        self.hit_count_label.color=ccORANGE;
        self.hit_count_label.position = ccp(_winRect.origin.x + 0.8*_winRect.size.width, _winRect.origin.y);
        [self.hit_count_label setAnchorPoint: ccp(0, 0.5f)];
	}
    
	return self;
}

-(void)addtoScene: (CCLayer*)layer
{
    [layer addChild:self.score_label];
    [layer addChild:self.left_duck_label];
    [layer addChild:self.hit_count_label];
}

-(void)update:(ccTime)dt
{
    NSString* score_str = [NSString stringWithFormat:@"score: %d", self.score];
    [self.score_label setString:score_str];
    
    NSString* left_duck_str = [NSString stringWithFormat:@"left duck: %d", (int)self.left_duck];
    [self.left_duck_label setString:left_duck_str];
    
    NSString* hit_count_str = [NSString stringWithFormat:@"hit count: %d", self.hit_count];
    [self.hit_count_label setString:hit_count_str];
}

@end
