//
//  CreditLayer.m
//  Touch_With_Cat
//
//  Created by 51310 on 13. 6. 7..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "CreditLayer.h"
#import "SceneManager.h"
@implementation CreditLayer
- (void) setBackgroundAndTitles
{
    // 배경 이미지를 표시하기 위해 Sprite를 이용합니다.
//    CCSprite *bgSprite = [CCSprite spriteWithFile:@"만든이.png"];
//    bgSprite.anchorPoint = CGPointZero;
//    [bgSprite setPosition: ccp(0, 0)];
//    [self addChild:bgSprite z:0 tag:kTagCreditBackground];
}

- (id) init {
    if( (self=[super init]) ) {
        [self setBackgroundAndTitles];
        
//        CCMenuItem *close = [CCMenuItemImage itemWithNormalImage:@"btn_back.png" selectedImage:@"btn_back_s" target:self selector:@selector(goBack)];
        CCMenuItem *close = [CCMenuItemFont itemWithString:@"goMenu" target:self selector:@selector(goBack)];
        
        CCMenu *menu = [CCMenu menuWithItems:close, nil];
        menu.position = ccp(160, 50);
        [self addChild:menu];
    }
    
    return self;
}

-(void)goBack
{
    [SceneManager goMenu];
}


@end