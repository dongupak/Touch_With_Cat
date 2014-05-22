//
//  GameOver.m
//  Touch_With_Cat
//
//  Created by 51310 on 13. 5. 29..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "GameOver.h"
#import "SceneManager.h"
#import "AppDelegate.h"

@implementation GameOver

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    GameOver *layer = [GameOver node];
    [scene addChild:layer];
    
    return scene;
}

-(AppController *)delegate{
    return (AppController *)[[UIApplication sharedApplication] delegate];
}

-(id) init
{
    if( (self=[super init]) ) {
        
        winSize = [CCDirector sharedDirector].winSize;
        
        AppController *delegate = [self delegate];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", delegate.score] fontName:@"Arial" fontSize:80];
        label.position = ccp(winSize.width/2, winSize.height/3 -30);
        label.color = ccWHITE;
        [self addChild:label];
        
        CCMenuItemImage *HI = [CCMenuItemImage itemWithNormalImage:@"Back.png" selectedImage:@"Back_click.png" target:self selector:@selector(gomenu)];
        
        CCMenu *tmp2 = [CCMenu menuWithItems:HI, nil];
        tmp2.position = ccp(winSize.width / 2, winSize.height / 2 -200);
        [self addChild:tmp2];
        
        // 배경 이미지를 표시하기 위해 Sprite를 이용합니다.
        CCSprite *bgSprite = [CCSprite spriteWithFile:@"Gameover1.png"];
        bgSprite.anchorPoint = CGPointZero;
        [bgSprite setPosition: ccp(0 , 0)];
        [self addChild:bgSprite z:-10];
        
        
    }
    
    return self;
}

//- (void) setBackgroundAndTitles
//{
//
//    
//}

- (void) gomenu
{
    [SceneManager goMenu];
}

@end
