//
//  SMVennDiagramView.m
//  VennDiagram
//
//  Created by Zakk Hoyt on 3/17/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "SMVennDiagramView.h"
#import "SMVennObject.h"

@interface SMVennDiagramView ()
@property (nonatomic, strong) NSMutableArray *vennObjects;
@property (nonatomic, strong) SMVennObject *vennObject;
@end

@implementation SMVennDiagramView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _vennObjects = [@[]mutableCopy];
    }
    return self;
}


#pragma mark - UIResponder touch events.
// If we don't override these methods, the responder chain will end up at our
// touch screen input
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = touchesArray[0];
    self.vennObject = [SMVennObject new];
    self.vennObject.pointBegin = [touch locationInView:self];
    [self.vennObjects addObject:self.vennObject];
    [self setNeedsDisplay];
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = touchesArray[0];
    self.vennObject.pointEnd = [touch locationInView:self];
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = touchesArray[0];
    self.vennObject.pointEnd = [touch locationInView:self];
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{        
    for(NSUInteger index = 0; index < self.vennObjects.count; index++){
        NSLog(@"drawing index %d", index);
        SMVennObject* vo = [self.vennObjects objectAtIndex:index];
        [self drawVennObject:vo context:UIGraphicsGetCurrentContext()];
    }
}

-(void)drawVennObject:(SMVennObject*)vo context:(CGContextRef)cgContext{
    if((vo.pointBegin.x == 0 && vo.pointBegin.y == 0) ||
       (vo.pointEnd.x == 0 && vo.pointEnd.y == 0)){
        return;
    }
    
    CGContextBeginPath(cgContext);
    CGContextSetLineWidth(cgContext, 2.0f);
    
    // Convert UIColor to raw values
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [vo.color getRed:&red green:&green blue:&blue alpha:&alpha];
    alpha = 1.0;
    CGFloat color[4] = {red, green, blue, alpha};
    
    
    CGContextSetBlendMode(cgContext, kCGBlendModeScreen);
    
    CGRect r = CGRectMake(MIN(vo.pointBegin.x, vo.pointEnd.x),
                          MIN(vo.pointBegin.y, vo.pointEnd.y),
                          fabs(vo.pointBegin.x - vo.pointEnd.x),
                          fabs(vo.pointBegin.y - vo.pointEnd.y));
    
    // Draw ellipse
    CGContextSetFillColor(cgContext, color);
    CGContextFillEllipseInRect(cgContext, r);
    
    // Draw outline of ellipse
    CGContextSetStrokeColor(cgContext, color);
    CGContextStrokeEllipseInRect(cgContext, r);
    
}
@end
