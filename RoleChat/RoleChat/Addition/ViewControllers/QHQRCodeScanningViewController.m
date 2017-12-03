//
//  QHQRCodeScanningViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/2.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHQRCodeScanningViewController.h"
#import <SGQRCode/SGQRCodeScanningView.h>

@interface QHQRCodeScanningViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) SGQRCodeScanningView *scanningView;
/// 会话对象
@property (nonatomic, strong) AVCaptureSession *session;
/// 图层类
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation QHQRCodeScanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setupUI {
    
    [self.view addSubview:self.scanningView];
    [self setupSGQRCodeScanning];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 48, 44)];
    [backBtn setImage:IMAGENAMED(@"back") forState:(UIControlStateNormal)];
    [self.view addSubview:backBtn];
    ButtonAddTarget(backBtn, goback)
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, 100, 20.5)];
    title.font = FONT(16);
    title.text = QHLocalizedString(@"扫一扫", nil);
    title.textAlignment = NSTextAlignmentCenter;
    title.centerX = SCREEN_WIDTH*0.5;
    title.textColor = WhiteColor;
    [self.view addSubview:title];
}

- (SGQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [[SGQRCodeScanningView alloc] initWithFrame:self.view.bounds];
        _scanningView.scanningImageName = @"ScanLine";
        _scanningView.cornerColor = MainColor;
        [self.view.layer addSublayer:_scanningView.layer];
        
    }
    return _scanningView;
}

- (void)goback {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)removeScanningView {
    [self.scanningView removeTimer];
    self.scanningView = nil;
}


- (void)setupSGQRCodeScanning {
    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    // 4、设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
    // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）
    output.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    
    // 5、初始化链接对象（会话对象）
    self.session = [[AVCaptureSession alloc] init];
    // 高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    // 5.1 添加会话输入
    [_session addInput:input];
    
    // 5.2 添加会话输出
    [_session addOutput:output];
    
    // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.view.layer.bounds;
    
    // 8、将图层插入当前视图
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    // 9、启动会话
    [_session startRunning];
}
#pragma mark - - - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    // 0、扫描成功之后的提示音
//    [self SG_playSoundEffect:@"SGQRCode.bundle/sound.caf"];
    
    // 1、如果扫描完成，停止会话
    [self.session stopRunning];
    
    // 2、删除预览图层
    //[self.previewLayer removeFromSuperlayer];
    
    // 3、设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        // 在此发通知，告诉子类二维码数据
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SGQRCodeInformationFromeScanning" object:obj.stringValue];
    }
}

/** 播放音效文件 */
- (void)SG_playSoundEffect:(NSString *)name {
    // 获取音效
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    
    // 1、获得系统声音ID
    SystemSoundID soundID = 0;
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    // 2、播放音频
    AudioServicesPlaySystemSound(soundID); // 播放音效
}

void soundCompleteCallback(SystemSoundID soundID, void *clientData){
    //SGQRCodeLog(@"播放完成...");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self removeScanningView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
