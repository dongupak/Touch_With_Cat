//
//  HelloWorldLayer.m
//  Touch_With_Cat
//
//  Created by 51310 on 13. 5. 28..
//  Copyright __민주민주민주민주__ 2013년. All rights reserved.
//

#import "HelloWorldLayer.h"
#import "AppDelegate.h"

#define FRONT_CLOUD_SIZE 563
#define BACK_CLOUD_SIZE  509
#define FRONT_CLOUD_TOP  450
#define BACK_CLOUD_TOP   450

#pragma mark - HelloWorldLayer
@implementation HelloWorldLayer
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
		winSize = [CCDirector sharedDirector].winSize;
        self.isTouchEnabled = YES;
        sae1 = [SimpleAudioEngine sharedEngine];
        [sae1 playBackgroundMusic:@"cocori.mp3" loop:YES];

        life2 = 10;
        
        targetGroup = [CCNode node];
        [self addChild:targetGroup z:100];
        
        [self createCloudWithSize:FRONT_CLOUD_SIZE top:FRONT_CLOUD_TOP fileName:@"cloud_front.png" interval:15 z:2];
        [self createCloudWithSize:BACK_CLOUD_SIZE  top:BACK_CLOUD_TOP  fileName:@"cloud_back.png"  interval:30 z:1];
        
        [self background];
        
        //고양이
        [self createCat];
        
        //Target생성
        [self schedule:@selector(createTarget:) interval:1.0];
        
        //스코어
        [self scoreSystem];
        [self LifeSystem];
        
        //배경음악
        
        CCMenuItem *pmenu = [CCMenuItemImage itemWithNormalImage:@"pause1.png"
                                                   selectedImage:@"pause1 2.png"
                                                          target:self
                                                        selector:@selector(doClick1)];
        pause = [CCMenu menuWithItems:pmenu, nil];
        [pause alignItemsVertically];
        pause.position = ccp(winSize.width-15, winSize.height-15);
        pause.opacity = 150;
        [self addChild:pause z:2100];
        
        sad = [CCSprite spriteWithFile:@"Cat_Sad1.png"];
        sad.position = ccp(winSize.width/2-20, winSize.height*3/5);
        [self addChild:sad z:165];

        happy = [CCSprite spriteWithFile:@"Cat_happy.png"];
        happy.position = ccp(winSize.width/2-20, winSize.height*3/5);
        [self addChild:happy z:160];

        sad.opacity=0;
        happy.opacity=0;
    }
	return self;
}

-(void)background{
    CCSprite *BackGround = [CCSprite spriteWithFile:@"Background.png"];
    BackGround.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:BackGround];
}
- (void)doClick1
{
    [self removeChild:pause cleanup:YES];
    [[CCDirector sharedDirector] pause];
    
    CCMenuItem *pmenu = [CCMenuItemImage itemWithNormalImage:@"play1.png"
                                               selectedImage:@"play1 2.png"
                                                      target:self
                                                    selector:@selector(doClick2)];
    play = [CCMenu menuWithItems:pmenu, nil];
    [play alignItemsVertically];
    play.position = ccp(winSize.width-15, winSize.height-15);
    play.opacity = 200;
    [self addChild:play z:2100];
    

}
- (void) nomal
{
    cat.opacity = 255;
    happy.opacity = 0;
    sad.opacity = 0;
}
- (void)doClick2
{
    [self removeChild:play cleanup:YES];
    [[CCDirector sharedDirector] resume];
    CCMenuItem *pmenu = [CCMenuItemImage itemWithNormalImage:@"pause1.png"
                                               selectedImage:@"pause1 2.png"
                                                      target:self
                                                    selector:@selector(doClick1)];
    pause = [CCMenu menuWithItems:pmenu, nil];
    [pause alignItemsVertically];
    pause.position = ccp(winSize.width-15, winSize.height-15);
    pause.opacity = 150;
    [self addChild:pause z:2100];

}

-(AppController *)delegate{
    return (AppController *)[[UIApplication sharedApplication] delegate];
}
//점수
-(void)scoreSystem{
    
    AppController *delegate = [self delegate];
    delegate.score = 0;
    
    label = [CCLabelTTF labelWithString:@"0" fontName:@"Arial" fontSize:30];
    label.color = ccBLACK;
    label.anchorPoint = ccp(0.0,1.0);
    label.position = ccp(0, winSize.height);
    [self addChild:label];
}

-(void)LifeSystem{
    life = 3;
    lifelabel = [CCLabelTTF labelWithString:@"life : 3" fontName:@"Arial" fontSize:25];
    lifelabel.color = ccBLACK;
    lifelabel.anchorPoint = ccp(1.0,0.0);
    lifelabel.position = ccp(winSize.width, 0);
    [self addChild:lifelabel];
}

-(void)createTarget:(ccTime)dt
{
    
    //스프라이트 추가
    target = nil;
    
    int spriteRandom = arc4random() % 5;
    switch (spriteRandom) {
        case 0:
            target = [CCSprite spriteWithFile:@"T1.png"];
            target.tag = 1;
            break;
        case 1:
            target = [CCSprite spriteWithFile:@"T2.png"];
            target.tag = 2;
            break;
        case 2:
            target = [CCSprite spriteWithFile:@"T3.png"];
            target.tag = 3;
            break;
        case 3:
            target = [CCSprite spriteWithFile:@"T4.png"];
            target.tag = 4;
            break;
        case 4:
            target = [CCSprite spriteWithFile:@"T5.png"];
            target.tag = 5;
            break;
        default:
            break;
    }
    
    //스프라이트가 생성되는 위치 랜덤으로
    int minX = target.contentSize.width/2;
    int maxX = winSize.width - target.contentSize.width/2;
    int rangeX = maxX - minX;
    int actualX = (arc4random() % rangeX) + minX;
    
    target.position = ccp(actualX, -100);
    [targetGroup addChild:target];
    
    //테이블위에 놓여지는 스프라이트 위치를 랜덤으로
    int x_tableMin = winSize.width*2/5;
    int x_tableMax = winSize.width*4/5;
    int x_tableRange = x_tableMax - x_tableMin;
    int x_tableActual = (arc4random() % x_tableRange) + x_tableMin;
    
    int y_tableMin = winSize.height/2 - 60;
    int y_tableMax = winSize.height/2 - 30;
    int y_tableRange = y_tableMax - y_tableMin;
    int y_tableActual = (arc4random() % y_tableRange) + y_tableMin;
    
    //스프라이트 액션 -> 이동,회전,삭제
    id actionMove = [CCMoveTo actionWithDuration:1 position:ccp(x_tableActual, y_tableActual)];
    id actionRotate = [CCRotateBy actionWithDuration:1 angle:1440];
    id actionTotal = [CCSpawn actions:actionMove, actionRotate, nil];
    id actionseq = [CCSequence actions:actionTotal,[CCCallFuncN actionWithTarget:self selector:@selector(hand)], nil];
    [target runAction:actionseq];
    
    [target runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.2],
                                          [CCCallFuncN actionWithTarget:self
                                                               selector:@selector(removeTarget:)], nil]];
}

//스프라이트 삭제
-(void)removeTarget:(id)sender{
    CCSprite *tmp = sender;
    AppController *delegate = [self delegate];
    
    //점수가 0점일 경우
    if (delegate.score==0) {
        delegate.score = 0;
        
        if (life2 == 0) {
            NSLog(@"GameOver..");
            
            [self performSelector:@selector(End:) withObject:nil afterDelay:0];
        }
        else {
            life2 -= 1;
        }
    }

    else {
        
        if (life2 == 0) {
            NSLog(@"GameOver..");
            
            [self performSelector:@selector(End:) withObject:nil afterDelay:0];
        }
        else {
            life2 -= 1;
        }
        
        //실뭉치 놓쳤을때 점수 감소. - 고양이소리
        if (tmp.tag == 4) {
            
            delegate.score -= 1;
            NSString *temp = [NSString stringWithFormat:@"%d", delegate.score];
            [label setString:temp];
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"catSound1.mp3"];}
        
        //똥 놓쳤을때 아무 변화없다
        else if (tmp.tag == 5) {
            
        }
        else { //생선 놓쳤을때 점수 감소
            [[SimpleAudioEngine sharedEngine] playEffect:@"catSound2.mp3"];
        }
    }
    
    
    [targetGroup removeChild:tmp cleanup:YES];
}

-(void)createCat //고양이 이미지 만듬
{
    cat = [[CCSprite alloc] initWithFile:@"Cat_Normal.png"];
    cat.position = ccp(winSize.width/2-20, winSize.height*3/5);
    [self addChild:cat z:150];

}


//구름
- (void)createCloudWithSize:(int)imgSize top:(int)imgTop fileName:(NSString*)fileName interval:(int)interval z:(int)z {
    id enterRight	= [CCMoveTo actionWithDuration:interval position:ccp(0, imgTop)];
    id enterRight2	= [CCMoveTo actionWithDuration:interval position:ccp(0, imgTop)];
    id exitLeft		= [CCMoveTo actionWithDuration:interval position:ccp(-imgSize, imgTop)];
    id exitLeft2	= [CCMoveTo actionWithDuration:interval position:ccp(-imgSize, imgTop)];
    id reset		= [CCMoveTo actionWithDuration:0  position:ccp( imgSize, imgTop)];
    id reset2		= [CCMoveTo actionWithDuration:0  position:ccp( imgSize, imgTop)];
    id seq1			= [CCSequence actions: exitLeft, reset, enterRight, nil];
    id seq2			= [CCSequence actions: enterRight2, exitLeft2, reset2, nil];
    
    CCSprite *spCloud1 = [CCSprite spriteWithFile:fileName];
    [spCloud1 setAnchorPoint:ccp(0,1)];
    [spCloud1.texture setAliasTexParameters];
    [spCloud1 setPosition:ccp(0, imgTop)];
    [spCloud1 runAction:[CCRepeatForever actionWithAction:seq1]];
    [self addChild:spCloud1 z:z ];
    
    CCSprite *spCloud2 = [CCSprite spriteWithFile:fileName];
    [spCloud2 setAnchorPoint:ccp(0,1)];
    [spCloud2.texture setAliasTexParameters];
    [spCloud2 setPosition:ccp(imgSize, imgTop)];
    [spCloud2 runAction:[CCRepeatForever actionWithAction:seq2]];
    [self addChild:spCloud2 z:z ];
}

-(void)hand
{
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Cat_leftAnimation.plist"];
    NSMutableArray *animFrames = [NSMutableArray array];
    
    for (int i = 1; i < 10; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Cat_rightHands_0%d.png",i]];
        [animFrames addObject:frame];
    }
    
    
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.02f];
    CCAnimate *animate = [CCAnimate actionWithAnimation:animation];

    [cat runAction:animate];
    

}
-(void)onEnter
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super onEnter];
}
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [touch locationInView:[touch view]];
    CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
    
    AppController *delegate = [self delegate];
    
    for (target in [targetGroup children]) {
        if (CGRectContainsPoint(target.boundingBox, convertedLocation)) {
            
            life2 = 10;
            
            if (target.tag == 5) {
                //똥,점수 변동 없음
                //라이프가 감소한다
                if (life == 1) {
                    life = life - 1;
                    
                    NSString *temp = [NSString stringWithFormat:@"Life : %d", life];
                    [lifelabel setString:temp];
                    
                    NSLog(@"GameOver..");
                    
                    [self performSelector:@selector(End:) withObject:nil afterDelay:0];
                }
                
                else{
                    
                    life = life - 1;
                    NSLog(@"Life-1");
                    
                    NSString *temp = [NSString stringWithFormat:@"Life : %d", life];
                    [lifelabel setString:temp];
                    happy.opacity=255;
                    cat.opacity = 0;
                    [self performSelector:@selector(nomal) withObject:self afterDelay:0.3];
                }
            }
            else if (target.tag == 4) {
                //실, 15점 점수 추가
                delegate.score += 15;
                sad.opacity=255;
                cat.opacity = 0;
                [self performSelector:@selector(nomal) withObject:self afterDelay:0.3];
            }
            else {
                delegate.score += 10;
                sad.opacity = 255;
                cat.opacity = 0;
                [self performSelector:@selector(nomal) withObject:self afterDelay:0.3];
            }
            
            [targetGroup removeChild:target cleanup:YES];
            
            NSString *temp = [NSString stringWithFormat:@"%d", delegate.score];
            [label setString:temp];
            
        }
    }
    
return TRUE;
}

-(void)End:(id)sender {
    CCSprite *sprite = (CCSprite *)sender;
    [self removeChild:sprite cleanup:YES];
    
    
    CCScene *scene = [CCTransitionProgressRadialCCW transitionWithDuration:2 scene:[GameOver scene]];
    [[CCDirector sharedDirector] replaceScene:scene];
}

                    

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
