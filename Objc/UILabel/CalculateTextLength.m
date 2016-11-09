//
//  ViewController.m
//  LabelTest
//
//  Created by Kuan-Wei on 2016/10/27.
//  Copyright © 2016年 TaiwanMobile. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *text = @"Hello World!";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = text;
    label.numberOfLines = 3;
    label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:label];
    
    CGFloat fontSize = label.font.pointSize;

    CGSize textSize = [label.text sizeWithAttributes:@{NSFontAttributeName:[label font]}];
    NSLog(@"textSize = %@", NSStringFromCGSize(textSize));
    
    CGRect textRect = [text boundingRectWithSize:label.frame.size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]}
                                         context:nil];
    NSLog(@"textRect = %@", NSStringFromCGRect(textRect));
    NSLog(@"length = %li", [text length]);
    
    NSString *chinese = @"哈囉世界！";
    
    UILabel *chineseLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 220, 100, 100)];
    chineseLabel.text = chinese;
    chineseLabel.numberOfLines = 3;
    chineseLabel.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:chineseLabel];
    
    CGFloat chineseFontSize = chineseLabel.font.pointSize;
    
    [self.view addSubview:label];
    
    CGSize chineseTextSize = [chineseLabel.text sizeWithAttributes:@{NSFontAttributeName:[label font]}];
    NSLog(@"chinese textSize = %@", NSStringFromCGSize(chineseTextSize));
    
    CGRect chineseTextRect = [chinese boundingRectWithSize:label.frame.size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]}
                                         context:nil];
    NSLog(@"chinese textRect = %@", NSStringFromCGRect(chineseTextRect));
    NSLog(@"chinese length = %li", [chinese length]);
    
    //Different ways of calculating text length
    NSString *text = @"Hello World!";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = text;
    label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:label];
    
    CGFloat fontSize = label.font.pointSize;
    
    CGSize textSize = [label.text sizeWithAttributes:@{NSFontAttributeName:[label font]}];
    
    CGRect textRect = [text boundingRectWithSize:label.frame.size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]}
                                         context:nil];

}

@end
