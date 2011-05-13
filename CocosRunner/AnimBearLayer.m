//
//  AnimBearLayer.m
//  CocosRunner
//
//  Created by 欧 on 11/05/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AnimBearLayer.h"
#import "MenuLayer.h"

NSString * const SND_WALKING = @"move.caf";

@implementation AnimBearLayer

@synthesize bear;
@synthesize walkAction;
@synthesize moveAction;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	AnimBearLayer *layer = [AnimBearLayer node];
	[scene addChild: layer];
	
	return scene;
}

-(void) setupGameMenu
{
    CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"<<Menu" fontName:@"Marker Felt" fontSize:20];
    label1.color = ccc3(0, 0, 255);
	CCMenuItemImage * menuItem1 = [CCMenuItemLabel itemWithLabel:label1
                                                          target:self
                                                        selector:@selector(loadMenuScene:)]; 
	CCMenu *menu = [CCMenu menuWithItems:menuItem1, nil];
    int margin = 5;
    menu.position = ccp(label1.contentSize.width/2 + margin, winSize.height - label1.contentSize.height/2 - margin);
	[menu alignItemsHorizontally];
    
	[self addChild:menu];
}

- (void) loadMenuScene: (CCMenuItem  *) menuItem 
{
    [[CCDirector sharedDirector] replaceScene: [MenuLayer scene]];
}

-(id) init
{
	if((self=[super init])) {
        winSize = [[CCDirector sharedDirector] winSize];
        [self setupGameMenu];

        audioEngine = [SimpleAudioEngine sharedEngine];
        [audioEngine preloadEffect:SND_WALKING];
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"AnimBear.plist"];
        
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"AnimBear.png"];
        [self addChild:spriteSheet];
        
        NSMutableArray *walkAnimFrames = [NSMutableArray array];
        for (int i = 1; i <= 8; ++i) {
            [walkAnimFrames addObject:[frameCache spriteFrameByName:[NSString stringWithFormat:@"bear%d.png", i]]];
        }
        
        CCAnimation *walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:0.1f];
        self.bear = [CCSprite spriteWithSpriteFrameName:@"bear1.png"];
        bear.position = ccp(winSize.width/2, winSize.height/2);
        self.walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
        //[bear runAction:walkAction];
        [spriteSheet addChild:bear];
        
        self.isTouchEnabled = YES;
	}
	return self;
}


- (void)registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView:[touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    
    float moveSpeed = 480.0 / 3.0;
    CGPoint moveDiff = ccpSub(touchLocation, bear.position);
    float moveDuration = ccpLength(moveDiff) / moveSpeed;
    bear.flipX = (moveDiff.x >= 0);
    NSLog(@"moveDuration=%f bear.flipX=%d", moveDuration, bear.flipX);
    
    //if(moveAction != NULL) {
        [bear stopAction:moveAction];
    //}
    if (!isMoving) {
        [bear runAction:walkAction];
    }
    
    self.moveAction = [CCSequence actions:
                  [CCMoveTo actionWithDuration:moveDuration position:touchLocation],
                  [CCCallFunc actionWithTarget:self selector:@selector(bearMoveEnded)],
                  nil];
    
    
    [bear runAction:moveAction];
    isMoving = TRUE;
    
    [audioEngine playEffect:SND_WALKING];
    soundTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(playerMoveSound:) userInfo:nil repeats:YES];
}

-(void)playerMoveSound:(NSTimer*)timer
{
    if(isMoving) {
        movingSoundId = [audioEngine playEffect:SND_WALKING];
    }
    [timer invalidate];
}

- (void)bearMoveEnded
{
    [bear stopAction:walkAction];
    isMoving = FALSE;
}

- (void) dealloc
{
    bear = nil;
    walkAction = nil;
    moveAction = nil;
    
	[super dealloc];
}

@end
