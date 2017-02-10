//
//  ViewController.m
//  BLECentral
//
//  Created by Kuan-Wei Lin on 1/13/17.
//  Copyright © 2017 Loungehall. All rights reserved.
//

#import "ViewController.h"

#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController () <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral *connectPeripheral;

@property (nonatomic, strong) CBCharacteristic *writeCharacteristic002;
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic003;

@property (nonatomic, strong) dispatch_queue_t queue;

@property (weak, nonatomic) IBOutlet UILabel *cc01ReceivedDataLabel;
@property (weak, nonatomic) IBOutlet UITextField *cc02SendOutTextField;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.queue = dispatch_queue_create("TCLPillboxManagerQueue", NULL);
    
    self.cc02SendOutTextField.text = @"Hello world!";
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state)
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

    
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"Peripheral name = %@, uuid = %@, rssi = %@", peripheral.name, [peripheral.identifier UUIDString], RSSI);
    
    if ([peripheral.name isEqualToString:@"Kuan-Wei's iPhone 6S"])
    {
        self.connectPeripheral = peripheral;
        self.connectPeripheral.delegate = self;
        
        [central connectPeripheral:self.connectPeripheral options:nil];
        [central stopScan];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
//    NSArray *arr = [[NSArray alloc] initWithObjects:[CBUUID UUIDWithString:@"A001"], nil];
    //如果arr是nil，接下來的method會收到所有的service
    
    [peripheral discoverServices:nil];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    
    NSLog(@"all service = %@", peripheral.services);
    
    //列出所有的service
    for (CBService *service in peripheral.services)
    {
        //如果給nil，會收到所有的characteristic
        [self.connectPeripheral discoverCharacteristics:nil forService:service];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    
    for(CBCharacteristic *characteristic in service.characteristics)
    {
        NSLog(@"characteristic uuid = %@", characteristic.UUID.UUIDString);
    }
    
    //列出所有的characteristics
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        if ([characteristic.UUID.UUIDString isEqualToString:@"CC01"])
        {
            //CC01
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
        
        if ([characteristic.UUID.UUIDString isEqualToString:@"CC02"])
        {
            //CC02 是可以讓central寫資料到peripheral
            self.writeCharacteristic002 = characteristic;
            //如果要寫資料的話，呼叫
            
        }
        if ([characteristic.UUID.UUIDString isEqualToString:@"CC03"])
        {
            self.writeCharacteristic003 = characteristic;
            //如果要寫資料的話，呼叫
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"characteristic = %@", characteristic.UUID.UUIDString);
    
    //這裡收到CC01的notify資料
    NSString *str = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    
    NSLog(@"receive str = %@", str);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.cc01ReceivedDataLabel.text = str;
    });
    
}

- (void)sendData002:(NSData *)data
{
    //將資料寫入peripheral端的CC02
    [self.connectPeripheral writeValue:data forCharacteristic:self.writeCharacteristic002 type:CBCharacteristicWriteWithResponse];
}

- (void)sendData003:(NSData *)data
{
    //將資料寫入peripheral端的CC02
    [self.connectPeripheral writeValue:data forCharacteristic:self.writeCharacteristic003 type:CBCharacteristicWriteWithResponse];
}

- (void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray<CBService *> *)invalidatedServices
{
    for (CBService *service in invalidatedServices)
    {
        NSLog(@"invalidatedServices = %@", service.UUID.UUIDString);
    }
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


- (IBAction)startCentralManager:(id)sender
{
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:self.queue options:@{}];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)sendCC02Action:(id)sender
{
    [self sendData002:[self.cc02SendOutTextField.text dataUsingEncoding:NSUTF8StringEncoding]];
}

- (IBAction)sendCC03Action:(id)sender
{
    [self sendData003:[@"hahaha" dataUsingEncoding:NSUTF8StringEncoding]];
}


@end
