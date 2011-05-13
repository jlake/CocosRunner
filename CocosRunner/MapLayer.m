//
//  MapLayer.m
//  CocosRunner
//
//  Created by 欧 on 11/05/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapLayer.h"

NSString * const SND_BACKGROUND = @"backMusic.mp3";
NSString * const SND_MOVE = @"move.caf";
NSString * const SND_HIT = @"hit.caf";
NSString * const SND_PICKUP = @"pickup.caf";

@implementation MapLayer

@synthesize tileMap;
@synthesize background;
@synthesize foreground;
@synthesize meta;
@synthesize player;

@synthesize score;
@synthesize scoreLayer;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];

	MapLayer *mapLayer = [MapLayer node];
	[scene addChild:mapLayer];

	mapLayer.scoreLayer = [ScoreLayer node];
	[scene addChild:mapLayer.scoreLayer];
    
	return scene;
}

-(id) init
{
	if((self=[super init])) {
        audioEngine = [SimpleAudioEngine sharedEngine];
        
        [audioEngine preloadEffect:SND_MOVE];
        [audioEngine preloadEffect:SND_HIT];
        [audioEngine preloadEffect:SND_PICKUP];
        [audioEngine playBackgroundMusic:SND_BACKGROUND];
        
		tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"TileMap2.tmx"];
        background = [tileMap layerNamed:@"Background"];
        foreground = [tileMap layerNamed:@"Foreground"];
        meta = [tileMap layerNamed:@"Meta"];
        meta.visible = NO;
        
        [self addChild:tileMap z:-1];
        
        winSize = [[CCDirector sharedDirector] winSize];
        
        mapSize.width = tileMap.mapSize.width * tileMap.tileSize.width;
        mapSize.height = tileMap.mapSize.height * tileMap.tileSize.height;
        
        CCTMXObjectGroup *objects = [tileMap objectGroupNamed:@"Objects"];
        NSAssert(objects != nil, @"'Objects' object group not found");
        NSMutableDictionary *spawnPoint = [objects objectNamed:@"SpawnPoint"];
        NSAssert(spawnPoint != nil, @"SpawnPoint object not found");
        
        player = [CCSprite spriteWithFile:@"Player.png"];
        player.position = ccp([[spawnPoint valueForKey:@"x"] intValue], [[spawnPoint valueForKey:@"y"] intValue]);
        
        [self addChild:player];
        [self setViewpointCenter:player.position];
        
        self.isTouchEnabled = YES;
	}
	return self;
}

- (void)setViewpointCenter:(CGPoint)position
{
    int x = MAX(position.x, winSize.width/ 2);
    int y = MAX(position.y, winSize.height/ 2);
    
    x = MIN(x, (mapSize.width - winSize.width / 2));
    y = MIN(y, (mapSize.height - winSize.height / 2));
    
    CGPoint acturalPosition = ccp(x, y);
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, acturalPosition);
    self.position = viewPoint;
}

- (void)setPlayerPosition:(CGPoint)position
{
    CGPoint tileCoord = [self tileCoordForPosition:position];
    int tileGid = [meta tileGIDAt:tileCoord];
    if (tileGid) {
        NSDictionary *properties = [tileMap propertiesForGID:tileGid];
        if (properties) {
            NSString *collision = [properties valueForKey:@"Collidable"];
            if (collision && [collision compare:@"True"] == NSOrderedSame) {
                [audioEngine playEffect:SND_HIT];
                return;
            }
            NSString *collectable = [properties valueForKey:@"Collectable"];
            if (collectable && [collectable compare:@"True"] == NSOrderedSame) {
                [audioEngine playEffect:SND_PICKUP];
                [meta removeTileAt:tileCoord];
                [foreground removeTileAt:tileCoord];
                score++;
                [scoreLayer updateScore:score];
            }
        }
    }
    [audioEngine playEffect:SND_MOVE];
    player.position = position;
}

- (CGPoint)tileCoordForPosition:(CGPoint)position
{
    int x = position.x / tileMap.tileSize.width;
    int y = ((tileMap.mapSize.height * tileMap.tileSize.height) - position.y) / tileMap.tileSize.height;
    return ccp(x, y);
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
    
    CGPoint playerPos = player.position;
    CGPoint diff = ccpSub(touchLocation, playerPos);
    if(abs(diff.x) > abs(diff.y)) {
        playerPos.x += (diff.x > 0) ? tileMap.tileSize.width : -tileMap.tileSize.width;
    } else {
        playerPos.y += (diff.y > 0) ? tileMap.tileSize.height : -tileMap.tileSize.height;
    }
    if(playerPos.x < 0 || playerPos.y < 0 || playerPos.x > mapSize.width || playerPos.x > mapSize.height) {
        return;
    }
    [self setPlayerPosition:playerPos];
    [self setViewpointCenter:player.position];
}

- (void) dealloc
{
    tileMap = nil;
    background = nil;
    player = nil;
    scoreLayer = nil;
    
	[super dealloc];
}

@end
