//
//  ScoreLayer.m
//  CocosRunner
//
//  Created by 欧 on 11/05/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScoreLayer.h"
#import "MenuLayer.h"

@implementation ScoreLayer

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
                                   
-(id) init
{
	if((self=[super init])) {
        winSize = [[CCDirector sharedDirector] winSize];
        label = [CCLabelTTF labelWithString:@"0" fontName:@"Verdana-Bold" fontSize:18.0];
        label.color = ccc3(255, 0, 0);
        
        [self addChild:label];
        [self updateLabelPosition];
        
        [self setupGameMenu];
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

- (void) loadMenuScene: (CCMenuItem  *) menuItem 
{
    [[CCDirector sharedDirector] replaceScene: [MenuLayer scene]];
}

- (void) dealloc
{
	[super dealloc];
}
@end
