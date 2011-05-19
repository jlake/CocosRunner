//
//  FreeDrawLayer.h
//  CocosRunner
//
//  Created by 欧 on 11/05/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface FreeDrawLayer : CCLayer {
@protected
    CGSize winSize;
@private
    NSMutableArray *touchPoints;
}

+(CCScene *) scene;

@end
