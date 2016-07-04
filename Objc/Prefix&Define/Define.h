//
//  Define.h
//  Component
//
//  Created by Kuan-Wei Lin on 7/4/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#ifndef Define_h
#define Define_h


#endif /* Define_h */

#ifdef ISPRODUCTION
    #define HOST_NAME @"http://agent.myproject.com.tw/"
    #define ENVIRONMENT @"Porduction"
#elif ISPORTALS1
    #define HOST_NAME @"http://portals1.myproject.com.tw/"
    #define ENVIRONMENT @"Develop"
#elif ISPORTALS2
    #define HOST_NAME @"http://portals2.myproject.com.tw/"
    #define ENVIRONMENT @"Staging"
#endif

/*! SDK version */
#define SDK_VERSION @"1.0.0"

/*! MANUFACTURER */
#define MANUFACTURER @"Apple"

/*! Time interval */
#define API_FAIL_RETRY_INTERVAL 1
#define API_FAIL_RETRY_TIME 3

/*! APP name */
#define APP_NAME [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]]

#define BUNDLE_NAME [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]]

//正式Production 清除NSLog版本
#ifdef ISPRODUCTION
#define NSLog(format, ...)
#else
#define NSLog(format, ...) NSLog(format, ## __VA_ARGS__)
#endif

//判斷是否在iOS 8.1以上
#define BSDKOSVersionIsAtLeastiOS_8_2 (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_8_1)










