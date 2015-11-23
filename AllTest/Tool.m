//
//  Tool.m
//  funnyplay
//
//  Created by cash on 15-3-20.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "Tool.h"
#import "LocationDetail.h"
#import "NearbyDetail.h"
#import "AreaPlayViewController.h"
#import "LoginViewController.h"
#import "RegViewController.h"
#import "ForgetPwdViewController.h"
#import "ResetPwdViewController.h"

#import <MBProgressHUD.h>

@implementation Tool

#pragma mark - 界面推送

+ (void)noticeLogin:(UIView *)view andDelegate:(id)delegate andTitle:(NSString *)title {
    
    UIActionSheet *loginSheet = [[UIActionSheet alloc] initWithTitle:title delegate:delegate cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"登录", nil];
    [loginSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

+ (void)pushLocationDetail:(Location *)loc andNavController:(UINavigationController *)navController {
    
    UITabBarController *tabBarCon = [[UITabBarController alloc] init];
    LocationDetail *locDetail = [[LocationDetail alloc] init];
    tabBarCon.viewControllers = [NSArray arrayWithObjects:locDetail, nil];
    tabBarCon.hidesBottomBarWhenPushed = YES;
    
    [navController pushViewController:tabBarCon animated:YES];
}

+ (void)pushNearbyDetail:(Nearby *)nearby andNavController:(UINavigationController *)navController {
    
    UITabBarController *tabBarCon = [[UITabBarController alloc] init];
    NearbyDetail *nearbyDetail = [[NearbyDetail alloc] init];
    tabBarCon.viewControllers = [NSArray arrayWithObjects:nearbyDetail, nil];
    tabBarCon.hidesBottomBarWhenPushed = YES;
    
    [navController pushViewController:tabBarCon animated:YES];
}

+ (void)pushAreaPlay:(id)sender andNavController:(UINavigationController *)navController {
    
//    UITabBarController *tabBarCon = [[UITabBarController alloc] init];
    AreaPlayViewController *areaPlayCon = [[AreaPlayViewController alloc] init];
    areaPlayCon.hidesBottomBarWhenPushed = YES;
//    tabBarCon.viewControllers = [NSArray arrayWithObjects:areaPlayCon, nil];
//    tabBarCon.hidesBottomBarWhenPushed = YES;
    
    [navController pushViewController:areaPlayCon animated:YES];
    
}

+ (void)pushLogin:(id)sender andNavController:(UINavigationController *)navController {
    
    LoginViewController *loginCon = [[LoginViewController alloc] init];
    loginCon.hidesBottomBarWhenPushed = YES;
    
    [navController pushViewController:loginCon animated:YES];
    
}

+ (void)pushRegUser:(id)sender andNavController:(UINavigationController *)navController {
    
    RegViewController *regCon = [[RegViewController alloc] init];
//    regCon.hidesBottomBarWhenPushed = YES;
    
    [navController pushViewController:regCon animated:YES];
    
}

+(void)pushforgetPwd:(id)sender andNavController:(UINavigationController *)navController {
    
    ForgetPwdViewController *forgetCon = [[ForgetPwdViewController alloc] init];
    
    [navController pushViewController:forgetCon animated:YES];
}

+(void)pushResetPwd:(id)sender andNavController:(UINavigationController *)navController {
    
    ResetPwdViewController *resetCon = [[ResetPwdViewController alloc] init];
    
    [navController pushViewController:resetCon animated:YES];
}


//HUD
+ (MBProgressHUD *)createHUD:(NSString *)text 
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    HUD.detailsLabelText = text;
    [window addSubview:HUD];
    [HUD show:YES];
    
    //[HUD addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:HUD action:@selector(hide:)]];
    
    return HUD;
}


#pragma mark - 信息处理

+ (NSString *)intervalSinceNow:(NSString *)dateStr
{
    NSDictionary *dic = [Tool timeIntervalArrayFromString:dateStr];
    //NSInteger years = [[dic objectForKey:kKeyYears] integerValue];
    NSInteger months = [[dic objectForKey:kKeyMonths] integerValue];
    NSInteger days = [[dic objectForKey:kKeyDays] integerValue];
    NSInteger hours = [[dic objectForKey:kKeyHours] integerValue];
    NSInteger minutes = [[dic objectForKey:kKeyMinutes] integerValue];
    
    if (minutes < 1) {
        return @"刚刚";
    } else if (minutes < 60) {
        return [NSString stringWithFormat:@"%ld分钟前", (long)minutes];
    } else if (hours < 24) {
        return [NSString stringWithFormat:@"%ld小时前", (long)hours];
    } else if (hours < 48 && days == 1) {
        return @"昨天";
    } else if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前", (long)days];
    } else if (days < 60) {
        return @"一个月前";
    } else if (months < 12) {
        return [NSString stringWithFormat:@"%ld个月前", (long)months];
    } else {
        NSArray *arr = [dateStr componentsSeparatedByString:@"T"];
        return arr[0];
    }
}

+ (NSDictionary *)timeIntervalArrayFromString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *compsPast = [calendar components:unitFlags fromDate:date];
    NSDateComponents *compsNow = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSInteger years = [compsNow year] - [compsPast year];
    NSInteger months = [compsNow month] - [compsPast month] + years * 12;
    NSInteger days = [compsNow day] - [compsPast day] + months * 30;
    NSInteger hours = [compsNow hour] - [compsPast hour] + days * 24;
    NSInteger minutes = [compsNow minute] - [compsPast minute] + hours * 60;
    
    return @{
             kKeyYears:  @(years),
             kKeyMonths: @(months),
             kKeyDays:   @(days),
             kKeyHours:  @(hours),
             kKeyMinutes:@(minutes)
             };
}

+ (NSString *)pubTime:(NSString *)dateStr {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *compsPast = [calendar components:unitFlags fromDate:date];
    NSDateComponents *compsNow = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSInteger years = [compsNow year] - [compsPast year];
    NSInteger months = [compsNow month] - [compsPast month] + years * 12;
    NSInteger days = [compsNow day] - [compsPast day] + months * 30;
    
    if ([compsNow year] == [compsPast year]) {
        
        if ([compsNow month] == [compsPast month]) {
            
            if ([compsNow day] == [compsPast day]) {
                
                return [NSString stringWithFormat:@"今天 %d:%d", [compsPast hour], [compsPast minute]];
                
            } else if (days == 1) {
                
                return [NSString stringWithFormat:@"昨天 %d:%d", [compsPast hour], [compsPast minute]];
                
            } else if (days == 2) {
                
                return [NSString stringWithFormat:@"前天 %d:%d", [compsPast hour], [compsPast minute]];
            }
            
        } else {
            
            return [NSString stringWithFormat:@"%d-%d", [compsPast month], [compsPast day]];
        }
        
    } else {
        
        return [NSString stringWithFormat:@"%d-%d-%d", [compsPast year], [compsPast month], [compsPast day]];
    }
    
    return nil;
}



@end








































































