//
//  DHIntroPannelObj.m
//  XDuckHunt
//
//  Created by Fallson on 8/15/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHIntroPannelObj.h"
#import "DHLabel.h"
#import "ccTypes.h"
#import "DHScore.h"

@interface DHIntroPannelObj()
{
    CGRect _winRect;
}

@property (nonatomic, retain) CCSprite* duck;
@property (nonatomic, retain) CCSprite* bird;
@property (nonatomic, retain) CCSprite* parrot;
@property (nonatomic, retain) DHLabel* duck_label;
@property (nonatomic, retain) DHLabel* bird_label;
@property (nonatomic, retain) DHLabel* parrot_label;
@end

@implementation DHIntroPannelObj
@synthesize duck_num = _duck_num;
@synthesize bird_num = _bird_num;
@synthesize parrot_num = _parrot_num;

@synthesize duck = _duck;
@synthesize bird = _bird;
@synthesize parrot = _parrot;
@synthesize duck_label = _duck_label;
@synthesize bird_label = _bird_label;
@synthesize parrot_label = _parrot_label;


-(id) initWithWinRect: (CGRect)rect andDuckNum:(int)dn andBirdNum:(int)bn andPirrotNum:(int)pn;
{
	if( (self=[super init]) )
    {
        _winRect = rect;
        
        self.duck_num = dn;
        self.bird_num = bn;
        self.parrot_num = pn;
        
        self.duck = [CCSprite spriteWithFile:@"duck.png"];
        self.duck.scale *= 0.4*CC_CONTENT_SCALE_FACTOR();
        self.duck.position = ccp(_winRect.origin.x + _winRect.size.width*0.4, _winRect.origin.y + _winRect.size.height*0.7);
        [self.duck setAnchorPoint:ccp(0.5f, 0.5f)];
        
        NSString* duck_str = [NSString stringWithFormat:@" X %d = %d", self.duck_num, self.duck_num * [DHScore GetScoreByType:BLACK_DUCK]];
        self.duck_label = [DHLabel labelWithString:duck_str fontName:DHLABEL_FONT fontSize:24];
        self.duck_label.color = ccDH;
        self.duck_label.position = ccp(_winRect.origin.x + _winRect.size.width*0.5, _winRect.origin.y + _winRect.size.height*0.7);
        [self.duck_label setAnchorPoint: ccp(0, 0.5f)];
        
        
        self.bird = [CCSprite spriteWithFile:@"bird.png"];
        self.bird.scale *= 0.4*CC_CONTENT_SCALE_FACTOR();
        self.bird.position = ccp(_winRect.origin.x + _winRect.size.width*0.4, _winRect.origin.y + _winRect.size.height*0.6);
        [self.bird setAnchorPoint:ccp(0.5f, 0.5f)];
        
        NSString* bird_str = [NSString stringWithFormat:@" X %d = %d", self.bird_num, self.bird_num * [DHScore GetScoreByType:BIRD_DUCK]];
        self.bird_label = [DHLabel labelWithString:bird_str fontName:DHLABEL_FONT fontSize:24];
        self.bird_label.color = ccDH;
        self.bird_label.position = ccp(_winRect.origin.x + _winRect.size.width*0.5, _winRect.origin.y + _winRect.size.height*0.6);
        [self.bird_label setAnchorPoint: ccp(0, 0.5f)];
        
        self.parrot = [CCSprite spriteWithFile:@"parrot.png"];
        self.parrot.scale *= 0.4*CC_CONTENT_SCALE_FACTOR();
        self.parrot.position = ccp(_winRect.origin.x + _winRect.size.width*0.4, _winRect.origin.y + _winRect.size.height*0.5);
        [self.parrot setAnchorPoint:ccp(0.5f, 0.5f)];
        
        NSString* parrot_str = [NSString stringWithFormat:@" X %d = %d", self.parrot_num, self.parrot_num * [DHScore GetScoreByType:PARROT_DUCK]];
        self.parrot_label = [DHLabel labelWithString:parrot_str fontName:DHLABEL_FONT fontSize:24];
        self.parrot_label.color = ccDH;
        self.parrot_label.position = ccp(_winRect.origin.x + _winRect.size.width*0.5, _winRect.origin.y + _winRect.size.height*0.5);
        [self.parrot_label setAnchorPoint: ccp(0, 0.5f)];
	}
    
	return self;
}

-(id) initWithWinRect: (CGRect)rect
{
    return [self initWithWinRect:rect andDuckNum:1 andBirdNum:1 andPirrotNum:1];
}

-(void)addtoScene: (CCLayer*)layer
{
    [layer addChild:self.duck];
    [layer addChild:self.duck_label];
    [layer addChild:self.bird];
    [layer addChild:self.bird_label];
    [layer addChild:self.parrot];
    [layer addChild:self.parrot_label];
}

-(void)removeFromScene:(CCLayer *)layer
{
    [layer removeChild:self.duck];
    [layer removeChild:self.duck_label];
    [layer removeChild:self.bird];
    [layer removeChild:self.bird_label];
    [layer removeChild:self.parrot];
    [layer removeChild:self.parrot_label];
}

-(void)update:(ccTime)dt
{
}

@end
