//
//  DXLAddressPickView.m
//  DXLAddressView
//
//  Created by ding on 2017/12/29.
//  Copyright © 2017年 ding. All rights reserved.
//

#import "DXLAddressPickView.h"
#import <Foundation/Foundation.h>
#import "ProvinceModel.h"
#import "CityModel.h"
#import "AreaModel.h"


@interface DXLAddressPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) UIPickerView *pickerView;

@property (nonatomic,strong) UIButton *cancelBtn;

@property (nonatomic,strong) UIButton *DetermineBtn;

@property (nonatomic,strong) UILabel *addressLb;

@property (nonatomic,strong) UIView *darkView;

@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UIBezierPath *bezierPath;

@property (nonatomic,strong) CAShapeLayer *shapeLayer;

@property (nonatomic,strong) NSMutableArray *shengArray;

@property (nonatomic,assign) NSInteger selectRowWithProvince; //选中的省份对应的下标

@property (nonatomic,assign) NSInteger selectRowWithCity; //选中的市级对应的下标

@property (nonatomic,assign) NSInteger selectRowWithTown; //选中的县级对应的下标

@end

@implementation DXLAddressPickView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, kWidth, kHeight+300);
        
       
        NSArray *array  =[self JsonObject:@"address.json"];
        
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ProvinceModel *model = [ProvinceModel showDataWith:obj];
            [self.shengArray addObject:model];
        }];
        self.selectRowWithProvince = 0;
        self.selectRowWithCity = 0;
        self.selectRowWithTown = 0;
        
        [self initGesture];
        
    }
    return self;
}
- (void)show{
    [self initView];
}
- (void)initView{
    [self showInView:[[UIApplication sharedApplication].windows lastObject]];
    
    [self addSubview:self.darkView];
    [self addSubview:self.backView];
    [self.backView addSubview:self.cancelBtn];
    [self.backView addSubview:self.DetermineBtn];
    [self.backView addSubview:self.addressLb];
    [self.backView addSubview:self.pickerView];
//    
//    [self bezierPath];
//    [self shapeLayer];
}
- (void)initGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
}
- (void)showInView:(UIView *)view{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, -250, kWidth, kHeight+300);
    }completion:^(BOOL finished) {
        
    }];
    [view addSubview:self];
}
- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame =CGRectMake(0, 0, kWidth, kHeight+300);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
//返回选择器有几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
//返回每组有几行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger integer = 0;
    if (component == 0) {
        integer = self.shengArray.count;
    }else if (component == 1){
        ProvinceModel *model = self.shengArray[self.selectRowWithProvince];
        integer = model.city.count;
    }else if (component == 2)
    {
        ProvinceModel *model = self.shengArray[self.selectRowWithProvince];
        CityModel *cityModel = model.city[self.selectRowWithCity];
        integer = cityModel.area.count;
    }
    return integer;
}
//返回第component列第row行的内容(标题)
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:{
            ProvinceModel *model = self.shengArray[row];
            return model.name;
        }
            break;
        case 1:{
            ProvinceModel *model = self.shengArray[self.selectRowWithProvince];
            CityModel *citymodel = model.city[row];
            return citymodel.name;
        }
            break;
        case 2:
        {
            ProvinceModel *model = self.shengArray[self.selectRowWithProvince];
            CityModel *citymodel = model.city[self.selectRowWithCity];
            AreaModel *teanmodel = citymodel.area[row];
            return teanmodel.name;
        }
            break;
        default:
            break;
    }
    return nil;
}
//设置row字体，颜色
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.backgroundColor = [UIColor clearColor];
        pickerLabel.font = [UIFont systemFontOfSize:16.0];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
//选中第component第row的时候调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.selectRowWithProvince = row;
        self.selectRowWithCity = 0;
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }else if (component==1)
    {
        self.selectRowWithCity = row;
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }else{
        self.selectRowWithTown = row;
    }
}
- (id)JsonObject:(NSString *)jsonStr{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:jsonStr ofType:nil];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSError *error;
    id JsonObject= [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    return JsonObject;
}
- (UIView *)darkView
{
    if (!_darkView) {
        _darkView = [[UIView alloc] init];
        _darkView.frame = self.frame;
        _darkView.backgroundColor = [UIColor blackColor];
        _darkView.alpha = 0.3;
    }
    return _darkView;
    
}
- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.frame = CGRectMake(0, kHeight, kWidth, 250);
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
- (UIBezierPath *)bezierPath
{
    if (!_bezierPath) {
        _bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.backView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    }
    return _bezierPath;
}
- (CAShapeLayer *)shapeLayer{
    if(!_shapeLayer){
        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.frame = _backView.bounds;
        _shapeLayer.path = _bezierPath.CGPath;
        _backView.layer.mask = _shapeLayer;
    }
    return _shapeLayer;
}
- (UIPickerView *)pickerView{
    if(!_pickerView)
    {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.frame = CGRectMake(0, 50, kWidth, 200);
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor =[UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1];
    }
    return _pickerView;
}
- (UIButton *)cancelBtn
{
    if(!_cancelBtn){
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelBtn.frame = CGRectMake(0, 0, 50, 50);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UIButton *)DetermineBtn
{
    if (!_DetermineBtn) {
        _DetermineBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _DetermineBtn.frame = CGRectMake(kWidth-50, 0, 50, 50);
        [_DetermineBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_DetermineBtn addTarget:self action:@selector(determineBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _DetermineBtn;
}
- (UILabel *)addressLb
{
    if (!_addressLb) {
        _addressLb = [[UILabel alloc] init];
        _addressLb.frame = CGRectMake(50, 0, kWidth-100, 50);
        _addressLb.textAlignment = NSTextAlignmentCenter;
        _addressLb.font = [UIFont systemFontOfSize:16.0];
    }
    return _addressLb;
}
- (void)determineBtnAction:(UIButton *)button
{
    NSInteger shengRow = [_pickerView selectedRowInComponent:0];
    NSInteger shiRow = [_pickerView selectedRowInComponent:1];
    NSInteger xianRow = [_pickerView selectedRowInComponent:2];
    
    ProvinceModel *provincemodel = self.shengArray[shengRow];
    CityModel *cityModel = provincemodel.city[shiRow];
    AreaModel *areaModel = cityModel.area[xianRow];
    if (self.determineBtnBlock) {
        self.determineBtnBlock(provincemodel.code, cityModel.code, areaModel.code, provincemodel.name, cityModel.name, areaModel.name, areaModel.postCode);
    }
    [self dismiss];
}
- (NSMutableArray *)shengArray
{
    if (!_shengArray) {
        _shengArray = [[NSMutableArray alloc] init];
    }
    return _shengArray;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
