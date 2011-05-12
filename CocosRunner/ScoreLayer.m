//
//  ScoreLayer.m
//  CocosRunner
//
//  Created by 欧 on 11/05/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScoreLayer.h"


@implementation ScoreLayer

//+(CCScene *) scene
//{
//	CCScene *scene = [CCScene node];
//	ScoreLayer *layer = [ScoreLayer node];
//	[scene addChild: layer];
//	
//	return scene;
//}

-(id) init
{
	if((self=[super init])) {
        winSize = [[CCDirector sharedDirector] winSize];
        label = [CCLabelTTF labelWithString:@"0" fontName:@"Verdana-Bold" fontSize:18.0];
        label.color = ccc3(255, 0, 0);
        
        [self addChild:label];
        [self updateLabelPosition];
	}
	return self;
}

- (void)updateScore:(int)score
{
    [label setString:[NSString stringWithFormat:@"%d", score]];
    [self updateLabelPosition];
}

- (void)updateLabelPosition
{
    int margin = 10;
    label.position = ccp(winSize.width - (label.contentSize.width / 2) - margin, (label.contentSize.height / 2) + margin);
}


- (void) dealloc
{
	[super dealloc];
}
@end
