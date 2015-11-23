//
//  Tool.h
//  funnyplay
//
//  Created by cash on 15-3-20.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColor+Util.h"
#import "UIView+Util.h"

static NSString * const kKeyYears = @"years";
static NSString * const kKeyMonths = @"months";
static NSString * const kKeyDays = @"days";
static NSString * const kKeyHours = @"hours";
static NSString * const kKeyMinutes = @"minutes";

@class Location;
@class Nearby;

@class MBProgressHUD;

@interface Tool : NSObject


+ (void)noticeLogin:(UIView *)view andDelegate:(id)delegate andTitle:(NSString *)title;

+ (void)pushLocationDetail:(Location *)loc andNavController:(UINavigationController *)navController;
+ (void)pushNearbyDetail:(Nearby *)nearby andNavController:(UINavigationController *)navController;
+ (void)pushAreaPlay:(id)sender andNavController:(UINavigationController *)navController;
+ (void)pushLogin:(id)sender andNavController:(UINavigationController *)navController;
+ (void)pushRegUser:(id)sender andNavController:(UINavigationController *)navController;
+ (void)pushforgetPwd:(id)sender andNavController:(UINavigationController *)navController;
+ (void)pushResetPwd:(id)sender andNavController:(UINavigationController *)navController;


+ (MBProgressHUD *)createHUD:(NSString *)text;

+ (NSString *)intervalSinceNow:(NSString *)dateStr;
+ (NSString *)pubTime:(NSString *)dateStr;
+ (NSDictionary *)timeIntervalArrayFromString:(NSString *)dateStr;

@end
