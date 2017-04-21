//
//  ViewController.m
//  PageControl
//
//  Created by Kuan-Wei on 2017/3/20.
//  Copyright © 2017年 TaiwanMobile. All rights reserved.
//

#import "ViewController.h"
#import "NSData+AES.h"
#import "NSString+URLEncode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *password = @"accountId=648293;1492653994898";
    
    NSString *key = @"T7M0BN0a3FLGeezw";
    NSString *iv = @"QBmAvwx3zyIMrR1T";
    
    //開始AES加密
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [passwordData AES128EncryptedDataWithKey:key iv:iv];
    
    //印出加密後的文字
    NSString *encryptedString = [encryptedData base64EncodedStringWithOptions:0];
    NSLog(@"encryptedString = %@", encryptedString);
    
    //開始AES解密
    NSData *decryptedData = [encryptedData AES128DecryptedDataWithKey:key iv:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    NSLog(@"pass = %@", decryptedString);
    
    //使用客製化的NSString url encoding，可以完美的做Url encoding，原生的方法基本上都會漏掉符號
    NSString *word = @"gp41TaDeimvThX8f096u73nGgM/zukm9+I3VKLobQkg=";
    NSString *encodeWord = [word urlencode];
    NSLog(@"encodeWord = %@", encodeWord);
    
    //原生的Encoding方法1
    NSString *fullAddressURL = @"http://www.zillow.com/webservice/Get+DeepSearchResults.htm?zws-id=<X1_8xo7s>&address=ave&citystatezip=Seattle";
    fullAddressURL = [fullAddressURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //舊的Encodingz方法，已deprecated
    //fullAddressURL = [fullAddressURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"fullAddressURL: %@",fullAddressURL);
    
    //原生的Encoding方法2
//    NSString *unescaped = @"http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=<X1_8xo7s>&address=ave&citystatezip=Seattle";
//    NSString *escapedString = [unescaped stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
//    NSLog(@"escapedString: %@", escapedString);
    
    
}




@end
