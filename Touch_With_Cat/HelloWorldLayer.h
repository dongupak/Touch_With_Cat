//
//  HelloWorldLayer.h
//  Touch_With_Cat
//
//  Created by 51310 on 13. 5. 28..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "GameOver.h"
#import "SimpleAudioEngine.h"
// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CGSize winSize;
    
    CCNode *targetGroup;
    NSInteger life;
    
    NSInteger life2;
    
    CCSprite *target;
    
    CCSprite *cat;
    SimpleAudioEngine *sae1;
    CCLabelTTF *label;
    CCLabelTTF *lifelabel;
    CCMenu *pause;
    CCMenu *play;
    
    CCSprite *happy;
    CCSprite *sad;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
