//
//  PlayerAndControlViewController.m
//  Components3
//
//  Created by Kuan-Wei Lin on 9/4/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

@import AVKit;

#import "PlayerAndControlViewController.h"
#import <MediaPlayer/MPVolumeView.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerAndControlViewController ()

@property (strong, nonatomic) AVPlayerViewController *playViewController;
@property (strong, nonatomic) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (strong, nonatomic) AVPlayerItem *playerItem;

//Top view
@property (weak, nonatomic) IBOutlet UIView *playerViewHolder;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *muteIcon;
@property (weak, nonatomic) IBOutlet MPVolumeView *volumeView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

//Bottom view
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet UISlider *seekBar;

@end

@implementation PlayerAndControlViewController{
    bool uiHidden;
    bool isSeekBarDraging;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setControlViewBG];
    [self customizeVolumeBar];
    
    [self avPlayerControlStart];
    
    //3秒後隱藏UI
    [self performSelector:@selector(hideControl) withObject:nil afterDelay:3];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self rotate];
}

#pragma mark - Basic
- (void)avPlayerControlStart{
    [self showSpinner];
    
    //NSString *path = [[NSBundle mainBundle]pathForResource:@"emoji zone" ofType:@"mp4"];
    NSURL *netURL = [NSURL URLWithString:@"http://down.treney.com/mov/test.mp4"];
    
    //self.player = [[AVPlayer alloc]initWithURL:[NSURL fileURLWithPath:path]];
    //self.player = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://down.treney.com/mov/test.mp4"]];
    
    self.playerItem = [AVPlayerItem playerItemWithURL:netURL];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    //可以使用Observing的方法監控影片的狀態
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];

    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = [[UIScreen mainScreen]bounds];
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.playerViewHolder.layer insertSublayer:self.playerLayer below:self.topView.layer];
    [self.player play];
}

- (void)showSpinner
{
    self.activityIndicatorView.hidden = NO;
    [self.activityIndicatorView startAnimating];
    //[self.spinner.superview addSubview:self.spinner];
}
- (void)hideSpinner
{
    self.activityIndicatorView.hidden = YES;
    [self.activityIndicatorView stopAnimating];
}

- (void)setControlViewBG
{   //設上下兩個 view 的顏色
}

- (void)customizeVolumeBar
{
    //* simulator 看不到 *//
    self.volumeView.showsRouteButton = NO; //隱藏 右邊的airplay
    self.volumeView.backgroundColor = [UIColor clearColor];
    
    UISlider *volumeBar;
    for (UIView *subView in self.volumeView.subviews) {
        if ([NSStringFromClass(subView.classForCoder) isEqualToString:@"MPVolumeSlider"]) {
            volumeBar = (UISlider *)subView;
            break;
        }
    }
    
    //客製化 volume slider bar
    UIImage *minVolumeImg = [[UIImage imageNamed:@"bar_up"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    UIImage *maxVolumeImg = [[UIImage imageNamed:@"bar_down"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    UIImage *thumbImage = [self imageWithImage:[UIImage imageNamed:@"cpball2"] scaledToSize:CGSizeMake(23, 23)];
    
    [volumeBar setMinimumTrackImage:minVolumeImg  forState:UIControlStateNormal];
    [volumeBar setMaximumTrackImage:maxVolumeImg forState:UIControlStateNormal];
    [volumeBar setThumbImage:thumbImage forState:UIControlStateNormal];
    [volumeBar setThumbImage:thumbImage forState:UIControlStateHighlighted];
    
    [volumeBar addTarget:self action:@selector(volumeBarValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)rotate
{
    //iphone 旋轉
    //避免一開始就是這個方向導致的旋轉問題
    NSNumber *orientationUnknow = [NSNumber numberWithInt:UIDeviceOrientationUnknown];
    [[UIDevice currentDevice] setValue:orientationUnknow forKey:@"orientation"];
    NSNumber *orientationValue = [NSNumber numberWithInt:UIDeviceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:orientationValue forKey:@"orientation"];
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (IBAction)screenTouch:(UIButton *)sender {
    uiHidden = !uiHidden;
    self.topView.hidden = uiHidden;
    self.bottomView.hidden = uiHidden;
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(hideControl)
                                               object:nil];
    [self performSelector:@selector(hideControl) withObject:nil afterDelay:3];
}

- (void)hideControl
{
    uiHidden = YES;
    self.topView.hidden = uiHidden;
    self.bottomView.hidden = uiHidden;
}

- (void)volumeBarValueChanged:(UISlider *)sender
{
    NSLog(@"slider value = %f", sender.value);
    UISlider *slider = (UISlider *)sender;
    if (slider.value <= 0)
    {
        [self.muteIcon setImage:[UIImage imageNamed:@"cpmute"]];
    }
    else if (slider.value <= 0.33)
    {
        [self.muteIcon setImage:[UIImage imageNamed:@"cpvolume1"]];
    }
    else if (slider.value <= 0.66)
    {
        [self.muteIcon setImage:[UIImage imageNamed:@"cpvolume2"]];
    }
    else
    {
        [self.muteIcon setImage:[UIImage imageNamed:@"cpvolume3"]];
    }
}

#pragma mark - Monitoring the status of the video
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    NSLog(@"keyPath = %@", keyPath);//= status
    NSLog(@"object = %@", object);//= AVPlayerItem & AVURLAsset
    NSLog(@"change = %@", change);//= new = 1, kind = 1
    NSLog(@"context = %@", context);//nil
    
    AVPlayerItemStatus status = [change[@"new"] integerValue];
    switch (status) {
        case AVPlayerItemStatusUnknown: {
            NSLog(@"AVPlayer未知狀態");
            break;
        }
        case AVPlayerItemStatusReadyToPlay: {
            NSLog(@"AVPlayer準備好了");
            NSLog(@"影片總長度為：%f",CMTimeGetSeconds(self.player.currentItem.duration));
            
            [self hideSpinner];
            [self createSeekBar];
            [self MoviePlay];
            
            break;
        }
        case AVPlayerItemStatusFailed: {
            NSLog(@"AVPlayer加載失敗");
            break;
        }
    }
    
    NSLog(@"status:%@",change[@"new"]);//取得準備狀態
}

- (void)createSeekBar{
    //取得影片全部時間
    Float64 dur = CMTimeGetSeconds(self.player.currentItem.duration);
    //將UISlider的最大值設定成時間總長
    self.seekBar.maximumValue = dur;
    NSLog(@"max = %f", self.seekBar.maximumValue);
    self.seekBar.minimumValue = 0;
    NSLog(@"min = %f", self.seekBar.minimumValue);
}

- (IBAction)backward:(id)sender {
    Float64 dur = CMTimeGetSeconds([self.player currentTime]);
    Float64 forwardTime = dur-30;
    CMTime newTime = CMTimeMakeWithSeconds(forwardTime, self.player.currentTime.timescale);
    NSLog(@"newTime = %f", CMTimeGetSeconds(newTime));
    [self.player seekToTime:newTime];
    [self.player play];
}

- (IBAction)forward:(id)sender {
    Float64 dur = CMTimeGetSeconds([self.player currentTime]);
    Float64 forwardTime = dur+30;
    CMTime newTime = CMTimeMakeWithSeconds(forwardTime, self.player.currentTime.timescale);
    NSLog(@"newTime = %f", CMTimeGetSeconds(newTime));
    [self.player seekToTime:newTime];
    [self.player play];
}

- (IBAction)pause:(id)sender {
    [self.player pause];
}

- (IBAction)play:(id)sender {
    [self.player play];
}

- (IBAction)seekBarChange:(id)sender {
    CMTime newTime = CMTimeMakeWithSeconds(self.seekBar.value, self.player.currentTime.timescale);
    [self.player seekToTime:newTime];
    [self.player play];
}

id timeObserver;
-(void)MoviePlay
{
    //0.5秒おきにスライダーを更新する
    CMTime time = CMTimeMakeWithSeconds(0.5f, NSEC_PER_SEC);
    __block PlayerAndControlViewController *blockself = self; //ARCを使用している場合
    timeObserver = [self.player addPeriodicTimeObserverForInterval:time
                                                        queue:dispatch_get_main_queue()
                                                   usingBlock:^(CMTime time) {
                                                       Float64 sec = CMTimeGetSeconds(time);
                                                       [blockself upDateTimeSlider:sec];
                                                       //ARC不使用時は[self upDateTimeSlider:sec];
                                                   }];
}

-(void)upDateTimeSlider:(Float64)sec
{
    self.seekBar.value = sec;
    if (self.seekBar.value == self.seekBar.maximumValue) {
        self.seekBar.value = self.seekBar.minimumValue;
    }
}

- (IBAction)seekBarStart:(id)sender {
}

- (IBAction)seekBarEnd:(id)sender {
}


@end
