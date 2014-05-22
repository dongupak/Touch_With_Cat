//
//  MenuLayer.m
//  menu_2
//
//  Created by 51310 on 13. 6. 5..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"

@implementation MenuLayer

enum {
    kTagBackground = 9000,
    kTagGameCharacter,
    kTagGameTitle,
    kTagMenu
};

@synthesize startMenuItem, howtoMenuItem;
@synthesize creditMenuItem, gameCenterMenuItem;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuLayer *layer = [MenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) setBackgroundAndTitles
{
    // 배경 이미지를 표시하기 위해 Sprite를 이용합니다.
    CCSprite *bgSprite = [CCSprite spriteWithFile:@"MainBack1.png"];
    bgSprite.anchorPoint = CGPointZero;
    [bgSprite setPosition: ccp(0 , 0)];
    [self addChild:bgSprite z:0 tag:kTagBackground];
    
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
        winSize = [CCDirector sharedDirector].winSize;
        sae = [SimpleAudioEngine sharedEngine];
        [sae playBackgroundMusic:@"adorable.mp3" loop:YES];
        [self setBackgroundAndTitles];
     
        CCSprite *title = [CCSprite spriteWithFile:@"MainLogo.png"];
        title.position = ccp(winSize.width/2, winSize.height*7/9);
        [self addChild:title];
        
        
        self.startMenuItem = [CCMenuItemImage itemWithNormalImage:@"start_n.png" selectedImage:@"start_click.png" target:self selector:@selector(newGameMenuCallback:)];
        
        
        self.howtoMenuItem = [CCMenuItemImage itemWithNormalImage:@"howto_n.png"
                                                    selectedImage:@"howto_click.png"
                                                           target:self
                                                         selector:@selector(howtoMenuCallback:)];
        
//        self.creditMenuItem = [CCMenuItemImage itemWithNormalImage:@"btn_ranking.png"
//                                                     selectedImage:@"btn_ranking_s.png"
//                                                            target:self
//                                                          selector:@selector(goCreditScene:)];
//       
        self.creditMenuItem.position = ccp(300, 300);

               
        CCMenu *menu = [CCMenu menuWithItems:
                        self.startMenuItem,
                        self.howtoMenuItem,
                        self.creditMenuItem,
                        nil];
        [menu alignItemsVertically];
        menu.position = ccp(160, 100);
        
        [self addChild:menu z:2100 tag:kTagMenu];

        
        
	}
	return self;
}

-(void) newGameMenuCallback: (id) sender {
    [SceneManager goGame];
    [sae playBackgroundMusic:@"cocori.mp3" loop:YES];
}

-(void) howtoMenuCallback: (id) sender {
    [SceneManager goHowto];
}

-(void) goCreditScene: (id) sender {
    [SceneManager goCredit];
}

@end
