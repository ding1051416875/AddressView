//
//  CityModel.h
//  DXLAddressView
//
//  Created by ding on 2017/12/29.
//  Copyright © 2017年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AreaModel.h"

@interface CityModel : NSObject
@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong)  NSString *code;

@property (nonatomic,strong) NSArray <AreaModel *>*area;

+ (instancetype)showCityDataWith:(NSDictionary *)dict;
@end
