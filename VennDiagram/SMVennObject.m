//
//  SMVennObject.m
//  VennDiagram
//
//  Created by Zakk Hoyt on 3/17/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "SMVennObject.h"

@implementation SMVennObject
-(id)init{
    self = [super init];
    if(self){
        _color = [self randomColor];
    }
    return self;
}


-(UIColor*)randomColor{
    static int index = 0;
    
    //int r = arc4random() % 9;
    switch(index++){
        case 0:
            return [UIColor redColor];
            break;
        case 1:
            return [UIColor greenColor];
            break;
        case 2:
            return [UIColor blueColor];
            break;
        case 3:
            return [UIColor blackColor];
            break;
        case 4:
            return [UIColor whiteColor];
            break;
        case 5:
            return [UIColor orangeColor];
            break;
        case 6:
            return [UIColor purpleColor];
            break;
        case 7:
            return [UIColor brownColor];
            break;
        case 8:
            return [UIColor lightGrayColor];
            index = 0;
            break;
        default:
            break;
    }
    
    return [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
}


@end
