//
//  Singleton.h
//  ASingleModel
//
//  Created by Fancy on 16/2/17.
//  Copyright © 2016年 Fancy. All rights reserved.
//
//状态栏的高度
#define STATUS_BAR_HEIGHT 20
//NavBar的高度
#define NAVIGATION_BAR_HEIGHT 44
//状态栏 ＋  导航栏的 高度
//define STATUS_AND_NAVIGATION_HEIGHT (( STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))


//屏幕rect

#define SCREEN_RECT ([UIScreen mainScreen].bouds)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define CONTENT_HEIGHT ( SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)


//广告栏高度
#define BANNER_HEIGHT 215
#define STYLEPAGE_HEITHT 21
#define  SMALLTV_WIDTH
#define FOLLOW_HEIGHT 220;
#define SUBCHANNEL_HEIGHT 62


//屏幕分辨率

#define  SCREEN_RESOLUTION (SCREEN_WIDTH *SCREEN_HEIGHT* ([ UIScreen mainScreen].scale))


#define APathTemp    NSTemporaryDirectory()
#define APathDocument [NSServhPathForDiretor]

#import <Foundation/Foundation.h>

@interface Singleton : NSObject

+ (Singleton *)sharedManager;

@end
