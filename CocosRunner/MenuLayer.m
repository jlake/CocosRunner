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
    //   CCMenuItemImage * menuItem = [CCMenuItemImage itemFromNormalImage:@"MenuItem.png"
    //                                                         selectedImage:@"MenuItem_on.png"
    //                                                                target:self
    //                                                              selector:@selector(showGuide:)]; 
    
    CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"Walking On Map" fontName:@"Marker Felt" fontSize:32];
	CCMenuItemImage * menuItem1 = [CCMenuItemLabel itemWithLabel:label1
                                                          target:self
                                                        selector:@selector(loadMapScene:)]; 
    
    CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Bear Animation" fontName:@"Marker Felt" fontSize:32];
	CCMenuItemImage * menuItem2 = [CCMenuItemLabel itemWithLabel:label2
                                                          target:self
                                                        selector:@selector(loadBearScene:)]; 
    
	CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, nil];
    
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

- (void) dealloc
{
	[super dealloc];
}

@end
