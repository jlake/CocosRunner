//
//  AnimBearLayer.h
//  CocosRunner
//
//  Created by 欧 on 11/05/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "SimpleAudioEngine.h"

extern NSString * const SND_WALKING;

@interface AnimBearLayer : CCLayer {
    CGSize winSize;
    SimpleAudioEngine *audioEngine;
    
    CCSprite *bear;
    CCAction *walkAction;
    CCAction *moveAction;
    NSTimer *soundTimer;
    
    BOOL isMoving;
}

@property (nonatomic, retain) CCSprite *bear;
@property (nonatomic, retain) CCAction *walkAction;
@property (nonatomic, retain) CCAction *moveAction;
@property (nonatomic, assign) NSTimer *soundTimer;

+(CCScene *) scene;

@end
