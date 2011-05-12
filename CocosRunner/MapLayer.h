//
//  MapLayer.h
//  CocosRunner
//
//  Created by 欧 on 11/05/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "ScoreLayer.h"
#import "SimpleAudioEngine.h"

extern NSString * const SND_MOVE;
extern NSString * const SND_HIT;
extern NSString * const SND_PICKUP;
extern NSString * const SND_BACKGROUND;

@interface MapLayer : CCLayer {
@private

    CGSize winSize;
    CGSize mapSize;
    SimpleAudioEngine *audioEngine;
    
    CCTMXTiledMap *tileMap;
    CCTMXLayer *background;
    CCTMXLayer *foreground;
    CCTMXLayer *meta;
    CCSprite *player;

    int score;
    ScoreLayer *scoreLayer;
}

@property (nonatomic, retain) CCTMXTiledMap *tileMap;
@property (nonatomic, retain) CCTMXLayer *background;
@property (nonatomic, retain) CCTMXLayer *foreground;
@property (nonatomic, retain) CCTMXLayer *meta;
@property (nonatomic, retain) CCSprite *player;

@property (nonatomic, assign) int score;
@property (nonatomic, retain) ScoreLayer *scoreLayer;

+(CCScene *) scene;

- (void)setViewpointCenter:(CGPoint)position;
- (void)setPlayerPosition:(CGPoint)position;
- (CGPoint)tileCoordForPosition:(CGPoint)position;

@end
