//
//  HowtoLayer.m
//  Touch_With_Cat
//
//  Created by 51310 on 13. 6. 7..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "HowtoLayer.h"

@implementation HowtoLayer

- (id) init {
    if((self = [super init])) {
        CCSprite *bgSprite = [CCSprite spriteWithFile:@"Howto.png"];
       [bgSprite setAnchorPoint:CGPointZero];
       [bgSprite setPosition:CGPointZero];
       [self addChild:bgSprite z:0 tag:kTagHowtoBackground];
        
       CCMenuItem *closeMenuItem = [CCMenuItemImage itemWithNormalImage:@"backBtn.png"
                                                          selectedImage:@"backBtns.png"                                                                  target:self
                                                                selector:@selector(closeMenuCallback:)];
//        CCMenuItem *closeMenuItem = [CCMenuItemFont itemWithString:@"goMenu"
//                                                                  target:self
//                                                                selector:@selector(closeMenuCallback:)];
        CCMenu *menu = [CCMenu menuWithItems:closeMenuItem, nil];
        menu.position = CGPointMake(300, 430);
        [self addChild:menu z:3 tag:kTagHowtoMenu];
    }
    return self;
}

- (void) closeMenuCallback: (id) sender
{
    //  장면에서 빠져나올적에는 iAD를 removeChild 시키자
    [SceneManager goMenu];
}

@end