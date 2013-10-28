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
#import "DHConstons.h"

@interface DHFreeModePannelObj()
{
    CGRect _winRect;
}

@property (nonatomic, retain)DHLabel* highest_score_label;
@property (nonatomic, retain)DHLabel* score_label;
@property (nonatomic, retain)DHLabel* left_duck_label;
@property (nonatomic, retain)DHLabel* hit_count_label;
@property (nonatomic, retain)NSMutableArray* left_duck_sprites;
@end

@implementation DHFreeModePannelObj
@synthesize highest_score = _highest_score;
@synthesize score = _score;
@synthesize left_duck = _left_duck;
@synthesize hit_count = _hit_count;

@synthesize highest_score_label = _highest_score_label;
@synthesize score_label = _score_label;
@synthesize left_duck_label = _left_duck_label;
@synthesize hit_count_label = _hit_count_label;
@synthesize left_duck_sprites = _left_duck_sprites;

-(id) initWithWinRect: (CGRect)rect
{
	if( (self=[super init]) )
    {
        _winRect = rect;
        
        self.highest_score = 0;
        self.score = 0;
        self.left_duck = 0;
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
        

        NSString* left_duck_str = [NSString stringWithFormat:@"left duck:"];
        self.left_duck_label = [DHLabel labelWithString:left_duck_str fontName:DHLABEL_FONT fontSize:24];
        self.left_duck_label.color=ccYELLOW;
        self.left_duck_label.position = ccp(_winRect.origin.x + 0.8*_winRect.size.width, _winRect.origin.y + 0.5*_winRect.size.height);
        [self.left_duck_label setAnchorPoint: ccp(0, 0.5f)];
        
        NSString* hit_count_str = [NSString stringWithFormat:@"hit count:   %d", self.hit_count];
        self.hit_count_label = [DHLabel labelWithString:hit_count_str fontName:DHLABEL_FONT fontSize:24];
        self.hit_count_label.color=ccYELLOW;
        self.hit_count_label.position = ccp(_winRect.origin.x + 0.8*_winRect.size.width, _winRect.origin.y);
        [self.hit_count_label setAnchorPoint: ccp(0, 0.5f)];
        
        [self initLeftDuckSprites: ccp(_winRect.origin.x + 0.8*_winRect.size.width + self.left_duck_label.contentSize.width,
                                       _winRect.origin.y + 0.5*_winRect.size.height)];
	}
    
	return self;
}

-(void)initLeftDuckSprites: (CGPoint)pos
{
    self.left_duck_sprites = [[NSMutableArray alloc] init];
    for( int i = 0; i < FREEMODE_TOTAL_DUCK; i++ )
    {
        CCSprite* sprite1 = [CCSprite spriteWithFile:@"duck_icon.png"];
        sprite1.scale *= (0.2 * CC_CONTENT_SCALE_FACTOR());
        sprite1.position = ccp(pos.x + i*sprite1.contentSize.width*sprite1.scale + 10, pos.y);
        sprite1.anchorPoint = ccp(0.0f, 0.5f);
        [self.left_duck_sprites addObject:sprite1];
    }
}

-(void)addtoScene: (CCLayer*)layer
{
    [layer addChild:self.highest_score_label];
    [layer addChild:self.score_label];
    [layer addChild:self.left_duck_label];
    [layer addChild:self.hit_count_label];
    
    for(CCSprite* sprite1 in self.left_duck_sprites)
    {
        [layer addChild:sprite1];
    }
}

-(void)update:(ccTime)dt
{
    NSString* highest_score_str = [NSString stringWithFormat:@"highest score: %d", self.highest_score];
    [self.highest_score_label setString:highest_score_str];
    
    NSString* score_str = [NSString stringWithFormat:@"current score: %d", self.score];
    [self.score_label setString:score_str];
    
    NSString* left_duck_str = [NSString stringWithFormat:@"left duck:"];
    [self.left_duck_label setString:left_duck_str];
    [self updateLeftDuckSprites];
    
    NSString* hit_count_str = [NSString stringWithFormat:@"hit count:   %d", self.hit_count];
    [self.hit_count_label setString:hit_count_str];
}

-(void)updateLeftDuckSprites
{
    static int last_left_duck = FREEMODE_TOTAL_DUCK;
    
    if( last_left_duck != self.left_duck )
    {
        int i = self.left_duck;
        for( ;i < FREEMODE_TOTAL_DUCK; i++ )
        {
            CCTexture2D *texture1 = [[CCTextureCache sharedTextureCache] addImage:@"duck_icon_gray.png"];
            
            CCSprite* sprite1 = [self.left_duck_sprites objectAtIndex:i];
            [sprite1 setTexture:texture1];
        }
        last_left_duck = self.left_duck;
    }
}

- (void) dealloc
{
    [self.left_duck_sprites release];
    
    // don't forget to call "super dealloc"
	[super dealloc];
}
@end
