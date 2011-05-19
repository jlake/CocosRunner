//
//  FreeDrawLayer.m
//  CocosRunner
//
//  Created by 欧 on 11/05/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FreeDrawLayer.h"
#import "MenuLayer.h"

@implementation FreeDrawLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	FreeDrawLayer *layer = [FreeDrawLayer node];
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
        
        touchPoints = [[NSMutableArray alloc] init];
        self.isTouchEnabled = YES;
	}
	return self;
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    [touchPoints addObject:NSStringFromCGPoint(location)];
    
    CGPoint prevLocation = [touch previousLocationInView:[touch view]];
    prevLocation = [[CCDirector sharedDirector] convertToGL:prevLocation];
    [touchPoints addObject:NSStringFromCGPoint(prevLocation)];
}

- (void)draw
{
    glEnable(GL_LINE_SMOOTH);
    
    glColor4f(1.0, 0.8, 0.2, 1.0);
    glLineWidth(2.0f);
    
    NSUInteger pointCount = [touchPoints count];
    for(int i=0; i<pointCount; i+=2) {
        CGPoint start = CGPointFromString([touchPoints objectAtIndex:i]);
        CGPoint end = CGPointFromString([touchPoints objectAtIndex:i+1]);
        ccDrawLine(start, end);
    }
}

- (void)dealloc
{
    [touchPoints release];
	[super dealloc];
}

@end
