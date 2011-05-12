//
//  ScoreLayer.h
//  CocosRunner
//
//  Created by 欧 on 11/05/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface ScoreLayer : CCLayer {
@private
    CCLabelTTF *label;
    
    CGSize winSize;
}

//+(CCScene *) scene;

- (void)updateScore:(int)score;
- (void)updateLabelPosition;

@end
