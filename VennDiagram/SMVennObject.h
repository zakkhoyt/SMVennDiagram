//
//  SMVennObject.h
//  VennDiagram
//
//  Created by Zakk Hoyt on 3/17/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMVennObject : NSObject
@property (nonatomic) CGPoint pointBegin;
@property (nonatomic) CGPoint pointEnd;
@property (nonatomic, strong) UIColor* color;
@end
