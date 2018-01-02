//
//  AreaModel.h
//  DXLAddressView
//
//  Created by ding on 2017/12/29.
//  Copyright © 2017年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *postCode;
+ (instancetype)showAreaDataWith:(NSDictionary *)dict;
@end
