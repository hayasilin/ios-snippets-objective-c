//
//  ViewController.m
//  TTTLabel
//
//  Created by Kuan-Wei on 2016/10/21.
//  Copyright © 2016年 TaiwanMobile. All rights reserved.
//

#import "ViewController.h"
#import "TTTAttributedLabel.h"

@interface ViewController () <TTTAttributedLabelDelegate>

@property (nonatomic, strong) TTTAttributedLabel *label;

@property (nonatomic, strong) NSDictionary<NSString *, id> *attributes;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _attributes = @{
                    (id)kCTForegroundColorAttributeName : (id)[UIColor orangeColor].CGColor,
                    NSFontAttributeName : [UIFont systemFontOfSize:14],
                    NSKernAttributeName : [NSNull null],
                    (id)kTTTBackgroundFillColorAttributeName : (id)[UIColor clearColor].CGColor
                    };
    
    UILabel *prefixLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 100, 50, 50)];
    prefixLabel.text = @"類型:";
    //prefixLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    prefixLabel.font = [UIFont systemFontOfSize:13];
    
    [self.view addSubview:prefixLabel];
    
    NSString *text = @"動畫動畫動畫動畫動畫動畫動畫動畫動畫動畫";
    
    _label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(100, 102, 100, 100)];
    _label.delegate = self;
    _label.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    _label.numberOfLines = 0;
    _label.backgroundColor = [UIColor blueColor];
    
    
    NSAttributedString *attString = [[NSAttributedString alloc]
                                     initWithString:text                                                                    attributes:_attributes];
    
    NSMutableDictionary *linkAttributes = [NSMutableDictionary dictionary];
    [linkAttributes setValue:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    [linkAttributes setValue:(__bridge id)[UIColor orangeColor].CGColor forKey:(NSString *)kCTForegroundColorAttributeName];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    [linkAttributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    _label.linkAttributes = linkAttributes;

    
    [self.view addSubview:_label];
    
    _label.text = attString;
    
    NSUInteger length = [text length];
    [_label addLinkToURL:[NSURL URLWithString:text] withRange:NSMakeRange(0, length)];
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    NSLog(@"url = %@", [url absoluteString]);
}

@end
