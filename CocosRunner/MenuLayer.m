//
//  MenuLayer.m
//  cocosShooter
//
//  Created by 欧 on 11/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "MapLayer.h"
#import "AnimBearLayer.h"
#import "FreeDrawLayer.h"

@implementation MenuLayer

+ (id)scene
{
    CCScene *scene = [CCScene node];
    MenuLayer *layer = [MenuLayer node];
    [scene addChild:layer];
    return scene;
}

- (id)init
{
	if((self=[super initWithColor:ccc4(64, 128, 255, 255)])) {
        [self setupMainMenu];
	}
	return self;
}

-(void)setupMainMenu
{
    NSString *menuFont = @"Marker Felt";
    
    CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"Walking On Map" fontName:menuFont fontSize:32];
	CCMenuItemImage * menuItem1 = [CCMenuItemLabel itemWithLabel:label1
                                                          target:self
                                                        selector:@selector(loadMapScene:)]; 
    
    CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Bear Animation" fontName:menuFont fontSize:32];
	CCMenuItemImage * menuItem2 = [CCMenuItemLabel itemWithLabel:label2
                                                          target:self
                                                        selector:@selector(loadBearScene:)]; 
    
    
    CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"Draw Line" fontName:menuFont fontSize:32];
	CCMenuItemImage * menuItem3 = [CCMenuItemLabel itemWithLabel:label3
                                                          target:self
                                                        selector:@selector(loadLineScene:)]; 

	CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
    
	[myMenu alignItemsVertically];
    
	[self addChild:myMenu];
}

- (void) loadMapScene: (CCMenuItem  *) menuItem 
{
	[[CCDirector sharedDirector] replaceScene: [MapLayer scene]];
}

- (void) loadBearScene: (CCMenuItem  *) menuItem 
{
	[[CCDirector sharedDirector] replaceScene: [AnimBearLayer scene]];
}

- (void) loadLineScene: (CCMenuItem  *) menuItem 
{
	[[CCDirector sharedDirector] replaceScene: [FreeDrawLayer scene]];
}

- (void) dealloc
{
	[super dealloc];
}

@end
