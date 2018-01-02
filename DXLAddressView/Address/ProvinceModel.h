//
//  ProvinceModel.h
//  DXLAddressView
//
//  Created by ding on 2017/12/29.
//  Copyright © 2017年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"
@interface ProvinceModel : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *code;

@property (nonatomic,strong) NSArray <CityModel *>*city;

+ (instancetype)showDataWith:(NSDictionary *)dict;
@end
