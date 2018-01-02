//
//  ViewController.m
//  DXLAddressView
//
//  Created by ding on 2017/12/29.
//  Copyright © 2017年 ding. All rights reserved.
//

#import "ViewController.h"
#import "DXLAddressPickView.h"
@interface ViewController (){
    DXLAddressPickView *_pickerView;
  
}
@property (nonatomic,strong) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    textfield.placeholder = @"";
    textfield.layer.borderColor = [UIColor blackColor].CGColor;
    textfield.layer.borderWidth = 1.0f;
    [self.view addSubview:textfield];
    _textField = textfield;

    [self.view endEditing:YES];
 

    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self pickerView];
    
    [_pickerView show];
    
    __weak typeof(self) weakSelf = self;
    _pickerView.determineBtnBlock = ^(NSString *shengId, NSString *shiId, NSString *xianId, NSString *shengName, NSString *shiName, NSString *xianName, NSString *postCode) {
        weakSelf.textField.text = [NSString stringWithFormat:@"%@ %@ %@",shengName,shiName,xianName];
    };
}

- (DXLAddressPickView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[DXLAddressPickView alloc] init];
    }
    return _pickerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
