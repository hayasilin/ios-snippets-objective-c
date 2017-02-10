//
//  ViewController.m
//  BLEPeripheral
//
//  Created by Kuan-Wei Lin on 1/13/17.
//  Copyright © 2017 Loungehall. All rights reserved.
//

#import "ViewController.h"

#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController () <CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@property (nonatomic, strong) NSMutableArray *characteristicsArray;

@property (nonatomic, strong) dispatch_queue_t queue;

@property (weak, nonatomic) IBOutlet UILabel *cc01SendOutDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *cc02ReceivedDataLabel;

@property (nonatomic, assign) BOOL isStopScaning;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.characteristicsArray = [NSMutableArray array];
    
    self.queue = dispatch_queue_create("TCLPillboxManagerQueue", NULL);
}

#pragma mark - CBPeripheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    switch (peripheral.state)
    {
        case CBManagerStatePoweredOn:
            NSLog(@"[藍芽電源開啟CBCentralManagerStatePoweredOn");
            break;
        case CBManagerStatePoweredOff:
            NSLog(@"藍芽電源關閉CBCentralManagerStatePoweredOff");
            
            [self showBluetoothOffAlertWithMessage:@"藍芽電源關閉CBCentralManagerStatePoweredOff"];
            
            return;
        case CBManagerStateUnknown:
            NSLog(@"藍芽狀態不明CBCentralManagerStateUnknown");
            [self showBluetoothOffAlertWithMessage:@"藍芽狀態不明CBCentralManagerStateUnknown"];
            return;
        case CBManagerStateResetting:
            NSLog(@"藍芽重設CBCentralManagerStateResetting");
            [self showBluetoothOffAlertWithMessage:@"藍芽重設CBCentralManagerStateResetting"];
            return;
        case CBManagerStateUnsupported:
            NSLog(@"此裝置不支援藍芽CBCentralManagerStateResetting");
            [self showBluetoothOffAlertWithMessage:@"此裝置不支援藍芽CBCentralManagerStateResetting"];
            return;
        case CBManagerStateUnauthorized:
            NSLog(@"此裝置不授權使用藍芽CBCentralManagerStateUnauthorized");
            [self showBluetoothOffAlertWithMessage:@"此裝置不授權使用藍芽CBCentralManagerStateUnauthorized"];
            return;
        default:
            break;
    }
    
//    peripheral.delegate = self;
    
    //設定Service
    CBMutableService *service = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:@"A001"] primary:YES];
    
    //設定2個characteristics
    CBMutableCharacteristic *characteristic;
    
    
    //第一個CC01提供訊息廣播
    characteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:@"CC01"] properties:CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
    [self.characteristicsArray addObject:characteristic];
    
    //第二種提供接收資料
    
    characteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:@"CC02"] properties:CBCharacteristicPropertyWrite value:nil permissions:CBAttributePermissionsWriteable];
    [self.characteristicsArray addObject:characteristic];
    
    //第三種
    characteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:@"CC03"] properties:CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
    [self.characteristicsArray addObject:characteristic];
    
    //將CC01 CC02登入到service中
    service.characteristics = self.characteristicsArray;
    
    //將service註冊到藍牙
    [self.peripheralManager addService:service];
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
    if (error)
    {
        NSLog(@"error = %@", [error localizedDescription]);
        [self showBluetoothOffAlertWithMessage:[error localizedDescription]];
    }
    
    //取得行動裝置的名字
    NSString *deviceName = [UIDevice currentDevice].name;
    
    //開始廣播，讓central看到這台裝置的device
    [peripheral startAdvertising:@{CBAdvertisementDataServiceUUIDsKey : @[service.UUID], CBAdvertisementDataLocalNameKey : deviceName}];
    
    //讓CC01這個characteristic每隔1秒鐘送個累加的數字過去
    NSLog(@"service.characteristics = %@", service.characteristics);
    if ([service.characteristics objectAtIndex:0])
    {
        dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_async(q, ^{
            
            int i = 0;
            while (true)
            {
                NSString *s = [[NSString alloc] initWithFormat:@"%d",i++];

                dispatch_async(dispatch_get_main_queue(), ^{
                    self.cc01SendOutDataLabel.text = s;
                });
                
                [self sendData:[s dataUsingEncoding:NSUTF8StringEncoding]];
                [NSThread sleepForTimeInterval:1.0];
                
                if (self.isStopScaning)
                {
                    break;
                }
            }
        });
    }
}

- (void)sendData:(NSData *)data
{
    //取得CC01這個characteristic
    CBMutableCharacteristic *characteristic = [self.characteristicsArray objectAtIndex:0];
    
    [self.peripheralManager updateValue:data forCharacteristic:characteristic onSubscribedCentrals:nil];
}

//當收到資料時會呼叫
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray<CBATTRequest *> *)requests
{
    NSLog(@"request = %@", requests);
    
    CBATTRequest *at = [requests objectAtIndex:0];
    
    NSString *str = [[NSString alloc] initWithData:at.value encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", str);
    
    self.cc02ReceivedDataLabel.text = str;
}

- (IBAction)startPeripheralManager:(id)sender
{
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:@{}];
}

- (IBAction)stopPeripheralManager:(id)sender
{
    [self.peripheralManager stopAdvertising];
    self.isStopScaning = YES;
}

#pragma mark - UIAlertController

- (void)showBluetoothOffAlertWithMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}


@end
