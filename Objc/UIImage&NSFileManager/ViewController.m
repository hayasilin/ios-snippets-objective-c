//
//  ViewController.m
//  Component
//
//  Created by Kuan-Wei Lin on 8/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

static NSString * const imageUrlString = @"http://ingridwu.dmmdmcfatter.com/wp-content/uploads/2015/01/placeholder.png";

@interface ViewController ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *homePath = NSHomeDirectory();
    NSLog(@"homePath = %@", homePath);
    
    [self loadImageFromLocal];
    [self loadImageFromInternet];
}

- (void)loadImageFromLocal{
    UIImage *image = [UIImage imageNamed:@"placeholder.jpg"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50,50,200,200)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    [self.view addSubview:imageView];
}

- (void)loadImageFromInternet{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlString]]];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 300, 200, 200)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = image;
    [self.view addSubview:self.imageView];
}

- (IBAction)saveImageInDocument:(UIButton *)sender {
    
    NSString* path = [NSHomeDirectory() stringByAppendingString:@"/Documents/placeholder.png"];
    
    BOOL ok = [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    
    if (!ok)
    {
        NSLog(@"Error creating file %@", path);
    }
    else
    {
        NSFileHandle* myFileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
        [myFileHandle writeData:UIImagePNGRepresentation(self.imageView.image)];
        [myFileHandle closeFile];
    }
    
    [self getFileFromDocument];
}

- (void)getFileFromDocument{
    NSString* path = [NSHomeDirectory() stringByAppendingString:@"/Documents/placeholder.png"];
    
    NSFileHandle* myFileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    UIImage* loadedImage = [UIImage imageWithData:[myFileHandle readDataToEndOfFile]];
    
    NSLog(@"Document loadedImage = %@", loadedImage);
}

- (IBAction)saveImageInCache:(UIButton *)sender {
    //MARK: - Create a new folder in iOS App folder
    NSString *dataPath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/imageHolder"];
    
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
    }
    
    //Start save files
    NSString* path = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imageHolder/placeholder.png"];
    
    BOOL ok = [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    
    if (!ok)
    {
        NSLog(@"Error creating file %@", path);
    }
    else
    {
        NSFileHandle* myFileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
        [myFileHandle writeData:UIImagePNGRepresentation(self.imageView.image)];
        [myFileHandle closeFile];
    }
    
    [self getFileFromCache];
}

- (void)getFileFromCache{
    NSString* path = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/placeholder.png"];
    
    NSFileHandle* myFileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    UIImage* loadedImage = [UIImage imageWithData:[myFileHandle readDataToEndOfFile]];
    
    NSLog(@"Cache loadedImage = %@", loadedImage);
}



@end
