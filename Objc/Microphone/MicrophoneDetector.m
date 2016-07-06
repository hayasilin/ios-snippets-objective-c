//
//  MicrophoneDetector.m
//  201606_Flashligh&Blow_POC
//
//  Created by Kuan-Wei on 2016/6/20.
//  Copyright © 2016年 Kuan-Wei. All rights reserved.
//

#import "MicrophoneDetector.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface MicrophoneDetector () <AVAudioRecorderDelegate>

//AVAudioSession
@property (strong, nonatomic) AVAudioSession *audioSession;
//AVAudioRecorder
@property (strong, nonatomic) AVAudioRecorder *recorder;

//低頻率聲音數值
@property (nonatomic) double lowPassResults;
//瞬間最大聲音數值
@property (nonatomic) double maxLowPassResults;
//設定每秒偵測時間
@property (weak, nonatomic) NSTimer *timer;

@end

@implementation MicrophoneDetector

+ (instancetype)defaultDetector {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - 確認麥克風使用權限
- (void)checkMicrophonePermission{
    self.audioSession = [AVAudioSession sharedInstance];
    [self.audioSession requestRecordPermission:^(BOOL granted) {
        if (granted) {
            self.isGranted = YES;
            self.permissionStatusString = @"192";
            NSLog(@"允許使用麥克風");
        }else{
            self.isGranted = NO;
            self.permissionStatusString = @"128";
            NSLog(@"不允許使用麥克風");
        }
    }];
    
    //Another way
    switch ([self.audioSession recordPermission]) {
        case AVAudioSessionRecordPermissionGranted:
            NSLog(@"granted");
            break;
        case AVAudioSessionRecordPermissionDenied:
            NSLog(@"Denied");
            break;
        case AVAudioSessionRecordPermissionUndetermined:
            NSLog(@"undetermined");
            // This is the initial state before a user has made any choice
            // You can use this spot to request permission here if you want
            break;
        default:
            break;
    }
}

#pragma mark - 麥克風音量偵測
- (void)startSoundDetector{
    //開始偵測聲音
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                              [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                              [NSNumber numberWithInt: 0],                         AVNumberOfChannelsKey,
                              [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
                              nil];
    NSError *error;
    NSError *micError;
    [self.audioSession setActive:YES error:&micError];
    [self.audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    
    if (self.recorder) {
        self.recorder.delegate = self;
        [self.recorder prepareToRecord];
        self.recorder.meteringEnabled = TRUE;
        [self.recorder record];
        if (self.timer == nil) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(levelTimerCallback) userInfo: nil repeats: YES];
        }
    } else {
        NSLog(@"micError = %@", micError.description);// mic error message
    }
}

- (void)startSoundDetectorWithSecond:(float)second{
    //開始偵測聲音
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                              [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                              [NSNumber numberWithInt: 0],                         AVNumberOfChannelsKey,
                              [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
                              nil];
    NSError *error;
    NSError *micError;
    [self.audioSession setActive:YES error:&micError];
    [self.audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    
    if (self.recorder) {
        self.recorder.delegate = self;
        [self.recorder prepareToRecord];
        self.recorder.meteringEnabled = TRUE;
        [self.recorder record];
        if (self.timer == nil) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(levelTimerCallback) userInfo: nil repeats: YES];
        }
    } else {
        NSLog(@"micError= %@", micError.description);// mic error message
    }
    
    //設定幾秒後關閉聲音偵測
    [self performSelector:@selector(closeSoundDetector) withObject:nil afterDelay:second];
}

- (void)levelTimerCallback {
    [self.recorder updateMeters];
    
    //averagePowerForChannel及peakPowerForChannel回傳從0db～-160db之間，0db為最大能量，-160db為最小
    NSLog(@"平均：%f 波峰：%f",[self.recorder averagePowerForChannel:0],[self.recorder peakPowerForChannel:0]);
    
    //偵測吹氣聲方法，因需求更新所以保留但不使用
    const double ALPHA = 0.05;
    double peakPowerForChannel = pow(10, (0.05 * [self.recorder peakPowerForChannel:0]));
    _lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * _lowPassResults;
    NSLog(@"lowPass = %f", _lowPassResults);
    
    if (_lowPassResults > _maxLowPassResults) {
        _maxLowPassResults = _lowPassResults;
    }
    
    //超過0.35才算偵測到吹氣聲
    if (_lowPassResults > 0.35) {
        NSLog(@"Mic blow detected");
    }else{
        
    }
    
    //TODO: - 計算分貝數 - 方法1
    float avg = [self.recorder averagePowerForChannel:0];
    //比如把-60作為最低分貝
    float minValue = -60;
    //把60作為獲取分配的範圍
    float range = 60;
    //把100作為輸出分貝的範圍
    float outRange = 100;
    //確保在最小值範圍內
    if (avg < minValue){
        avg = minValue;
    }
    //計算分貝數
    float decibels = (avg + range) / range * outRange;
    self.currentDecibel = (int)roundf(decibels);
    NSLog(@"分貝數 = %i", self.currentDecibel);
    
    //將分貝最大值更新
    if (self.currentDecibel > self.maxDecibel) {
        self.maxDecibel = self.currentDecibel;
    }

    //TODO: - 計算分貝數 - 方法2
    float level;                // The linear 0.0 .. 1.0 value we need.
    float minDecibels = -80.0f; // Or use -60dB, which I measured in a silent room.
    float avgDecibels = [_recorder averagePowerForChannel:0];
    
    if (avgDecibels < minDecibels){
        level = 0.0f;
    }else if (avgDecibels >= 0.0f){
        level = 1.0f;
    }else{
        float   root            = 2.0f;
        float   minAmp          = powf(10.0f, 0.05f * minDecibels);
        float   inverseAmpRange = 1.0f / (1.0f - minAmp);
        float   amp             = powf(10.0f, 0.05f * avgDecibels);
        float   adjAmp          = (amp - minAmp) * inverseAmpRange;
        level = powf(adjAmp, 1.0f / root);
    }
    NSLog(@"分貝平均值 %f", level * 120);
}

- (void)closeSoundDetector {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    [self.recorder stop];
    self.recorder = nil;
    [self.audioSession setActive:NO error:nil];
    NSLog(@"麥克風關閉");
}

@end
