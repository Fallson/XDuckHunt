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
@synthesize duck = _duck;
@synthesize bird = _bird;
@synthesize parrot = _parrot;
@synthesize duck_label = _duck_label;
@synthesize bird_label = _bird_label;
@synthesize parrot_label = _parrot_label;

-(id) initWithWinRect: (CGRect)rect
{
	if( (self=[super init]) )
    {
        _winRect = rect;
        
        self.duck = [CCSprite spriteWithFile:@"duck.png"];
        self.duck.scale *= 0.5*CC_CONTENT_SCALE_FACTOR();
        self.duck.position = ccp(_winRect.origin.x + _winRect.size.width*0.4, _winRect.origin.y + _winRect.size.height*0.6);
        [self.duck setAnchorPoint:ccp(0.5f, 0.5f)];
        
        NSString* duck_str = [NSString stringWithFormat:@" X 1 = 100"];
        self.duck_label = [DHLabel labelWithString:duck_str fontName:DHLABEL_FONT fontSize:28];
        self.duck_label.color = ccYELLOW;
        self.duck_label.position = ccp(_winRect.origin.x + _winRect.size.width*0.5, _winRect.origin.y + _winRect.size.height*0.6);
        [self.duck_label setAnchorPoint: ccp(0, 0.5f)];


        self.bird = [CCSprite spriteWithFile:@"bird.png"];
        self.bird.scale *= 0.5*CC_CONTENT_SCALE_FACTOR();
        self.bird.position = ccp(_winRect.origin.x + _winRect.size.width*0.4, _winRect.origin.y + _winRect.size.height*0.45);
        [self.bird setAnchorPoint:ccp(0.5f, 0.5f)];
        
        NSString* bird_str = [NSString stringWithFormat:@" X 1 = 200"];
        self.bird_label = [DHLabel labelWithString:bird_str fontName:DHLABEL_FONT fontSize:28];
        self.bird_label.color = ccYELLOW;
        self.bird_label.position = ccp(_winRect.origin.x + _winRect.size.width*0.5, _winRect.origin.y + _winRect.size.height*0.45);
        [self.bird_label setAnchorPoint: ccp(0, 0.5f)];
        
        self.parrot = [CCSprite spriteWithFile:@"parrot.png"];
        self.parrot.scale *= 0.5*CC_CONTENT_SCALE_FACTOR();
        self.parrot.position = ccp(_winRect.origin.x + _winRect.size.width*0.4, _winRect.origin.y + _winRect.size.height*0.3);
        [self.parrot setAnchorPoint:ccp(0.5f, 0.5f)];
        
        NSString* parrot_str = [NSString stringWithFormat:@" X 1 = 400"];
        self.parrot_label = [DHLabel labelWithString:parrot_str fontName:DHLABEL_FONT fontSize:28];
        self.parrot_label.color = ccYELLOW;
        self.parrot_label.position = ccp(_winRect.origin.x + _winRect.size.width*0.5, _winRect.origin.y + _winRect.size.height*0.3);
        [self.parrot_label setAnchorPoint: ccp(0, 0.5f)];
	}
    
	return self;
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
