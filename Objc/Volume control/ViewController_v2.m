//
//  ViewController.m
//  Components
//
//  Created by Kuan-Wei Lin on 7/11/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

//In order to control volume of the iPhone, you have to import framework below
#import <MediaPlayer/MPMusicPlayerController.h>
#import <MediaPlayer/MPVolumeView.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (strong, nonatomic) NSNumber *originalVolume;
@property (nonatomic) BOOL isVolumeOn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //Create a MPVOlumeView which can adjust volue in the form of UISlider created by Apple
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    [volumeView setFrame:CGRectMake(130, 100, 166, 40)];
    [self.view addSubview:volumeView];
    
    //In order to make MPVolumeView work, it requires to initialize AVAudioPlayer and insert an actual audio file into the project. When it has done, the default volume indicator will no longer be shown when you adjust the volume and the MPVolumeView will act as volume indicator instead.
    AVAudioPlayer* audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Happy Birthday song.mp3"]] error:NULL];
    [audioPlayer prepareToPlay];
    [audioPlayer stop];

    //Volume change listener
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    
    //Get the current volume value取得目前手機音量值
    self.originalVolume = [NSNumber numberWithFloat:[MPMusicPlayerController applicationMusicPlayer].volume];
    NSLog(@"originalVOlume = %@", self.originalVolume);
    
    
    //MARK: - Other way to set iPhone volume, deprecated in iOS 7
    //AudioSessionInitialize(NULL, NULL, NULL, NULL);
}

- (IBAction)audioSwitch:(UIButton *)sender {
    
    NSString *strIsMute = @"";
    
    if (self.isVolumeOn) {
        strIsMute = @"0";
        self.isVolumeOn = NO;
    }else{
        strIsMute = @"1";
        self.isVolumeOn = YES;
    }
    
    if (strIsMute) {
        if ([strIsMute isEqualToString:@"1"]) {
            //設定成靜音
            [self setHardwareVolume:[NSNumber numberWithFloat:0.f]];
        } else {
            //設定成原本非靜音時的原始音量
            [self setHardwareVolume:self.originalVolume];
        }
    }
}

BOOL isCustomChangeVolume = NO;

-(void)setHardwareVolume:(NSNumber*)fVolume {
    
    if (![fVolume isEqualToNumber:[NSNumber numberWithFloat:[MPMusicPlayerController applicationMusicPlayer].volume]] ) {
        
        //此flag讓儲存的iPhone手機音量值不被修改
        isCustomChangeVolume = YES;
        
        //如果設定手機音量
        [MPMusicPlayerController applicationMusicPlayer].volume = [fVolume floatValue];
        NSLog(@"set volume = %f", [fVolume floatValue]);
    }else{
        //如果手機一開始就是靜音，使用者點開啟音量時，跑這個會幫使用者開啟音量，並將音量設定成中間值
        
        //此flag讓儲存的iPhone手機音量值不被修改
        isCustomChangeVolume = YES;
        //將音量值設定成中間的音量值
        [MPMusicPlayerController applicationMusicPlayer].volume = 0.5;
        NSLog(@"set volume = %f", [fVolume floatValue]);
    }
}

- (void)volumeChanged:(NSNotification *)notification {
    
    if ( !isCustomChangeVolume ) {
        //只有按iPhone的音量鍵才能改變originalVolume的值，其他方法不允許改值，以便紀錄有音量時的數值
        self.originalVolume = [NSNumber numberWithFloat:[[[notification userInfo] objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue]];
        NSLog(@"------ Volume ori ----- = %f", [self.originalVolume floatValue]);
    }
    //重新打開可以用iPhone音量鍵設定音量
    isCustomChangeVolume = NO;
}

- (IBAction)audioMax:(UIButton *)sender {
    
    MPMusicPlayerController *musicPlayerController = [MPMusicPlayerController applicationMusicPlayer];
    musicPlayerController.volume = 1.0;
}

- (IBAction)mute:(UIButton *)sender {
    
    MPMusicPlayerController *musicPlayerController = [MPMusicPlayerController applicationMusicPlayer];
    musicPlayerController.volume = 0;
}

//MARK: - Other way to set iPhone volume, deprecated in iOS 7
//-(BOOL)addHardKeyListener{
//    OSStatus s = AudioSessionAddPropertyListener(kAudioSessionProperty_CurrentHardwareOutputVolume, hardKeyListener, "kAudioSessionProperty_CurrentHardwareOutputVolume");
//    return s==kAudioSessionNoError;
//}
//
//void hardKeyListener(
//                     void                      *inClientData,
//                     AudioSessionPropertyID    inID,
//                     UInt32                    inDataSize,
//                     const void                *inData
//                     ){
//
//
//    if (inID != kAudioSessionProperty_CurrentHardwareOutputVolume) {
//        return;
//    }
//    NSLog(@"%s",inClientData);
//}

@end
