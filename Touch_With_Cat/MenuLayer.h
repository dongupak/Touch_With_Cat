//
//  MenuLayer.h
//  menu_2
//
//  Created by 51310 on 13. 6. 5..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"
#import "SimpleAudioEngine.h"
@interface MenuLayer : CCLayer {
    
    
    CGSize winSize;
    
    CCMenuItem *startMenuItem;
    CCMenuItem *howtoMenuItem;
    
    CCMenuItem *gameCenterMenuItem;
    CCMenuItem *creditMenuItem;
    SimpleAudioEngine *sae;
}

+(CCScene *) scene;


@property (nonatomic, retain) CCMenuItem *startMenuItem;
@property (nonatomic, retain) CCMenuItem *howtoMenuItem;

@property (nonatomic, retain) CCMenuItem *gameCenterMenuItem;
@property (nonatomic, retain) CCMenuItem *creditMenuItem;

- (void) setBackgroundAndTitles;
- (void) goCreditScene: (id) sender;
- (void) howtoMenuCallback: (id) sender;
- (void) newGameMenuCallback: (id) sender;
- (void) goRanking: (id) sender;

@end
