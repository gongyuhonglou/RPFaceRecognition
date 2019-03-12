//
//  ViewController.m
//  RPFaceRecognition
//
//  Created by rpweng on 2019/3/12.
//  Copyright © 2019 rpweng. All rights reserved.
//

#import "ViewController.h"
#import "RPCameraManager.h"

@interface ViewController ()<RPCameraManagerDelegate>
@property (strong, nonatomic) RPCameraManager *manager;
@property (strong, nonatomic) UIView *pickView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefault];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![self.manager.session isRunning]) {
        [self.manager.session startRunning];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.manager.session isRunning]) {
        [self.manager.session stopRunning];
    }
}

#pragma mark - Methods
- (UIView *)pickView {
    if (!_pickView) {
        _pickView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_pickView];
    }
    return _pickView;
}

- (void)setDefault {
    RPCameraManager *manager = [[RPCameraManager alloc] initWithParentView:self.pickView];
    manager.delegate = self;
    manager.canFaceRecognition = YES;
    [manager setFaceRecognitonCallBack:^(CGRect faceFrame) {
        NSLog(@"你的脸在%@",NSStringFromCGRect(faceFrame));
    }];
    self.manager = manager;
}
#pragma mark - FRCameraManagerDelegate
- (void)cameraDidFinishFocus {
    
}

- (void)cameraDidStareFocus {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
