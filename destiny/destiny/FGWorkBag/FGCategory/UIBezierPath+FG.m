//
//  UIBezierPath+FG.m
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import "UIBezierPath+FG.h"

@implementation UIBezierPath (FG)




void getPointsFromBezier(void *info, const CGPathElement *element);
NSArray *pointsFromBezierPath(UIBezierPath *bpath);

#define VALUE(_INDEX_) [NSValue valueWithCGPoint:points[_INDEX_]]
#define POINT(_INDEX_) [(NSValue *)[points objectAtIndex:_INDEX_] CGPointValue]

/*首先要获取线里面的所有点*/
void getPointsFromBezier(void *info, const CGPathElement *element) {
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    CGPathElementType type = element->type;
    CGPoint *points = element->points;
    if (type != kCGPathElementCloseSubpath) {
        [bezierPoints addObject:VALUE(0)];
        if ((type != kCGPathElementAddLineToPoint) && (type != kCGPathElementMoveToPoint))
            [bezierPoints addObject:VALUE(1)];
    }
    if (type == kCGPathElementAddCurveToPoint) [bezierPoints addObject:VALUE(2)];
}

NSArray *pointsFromBezierPath(UIBezierPath *bpath) {
    NSMutableArray *points = [NSMutableArray array];
    CGPathApply(bpath.CGPath, (__bridge void *)points, getPointsFromBezier);
    return points;
}

- (UIBezierPath *)setBzezierPathWithGranularity:(NSInteger)granularity;
{
    NSMutableArray *points = [pointsFromBezierPath(self) mutableCopy];
    if (points.count < 4) return [self copy];
    [points insertObject:[points objectAtIndex:0] atIndex:0];
    [points addObject:[points lastObject]];
    UIBezierPath *smoothedPath = [self copy];
    [smoothedPath removeAllPoints];
    [smoothedPath moveToPoint:POINT(0)];
    
    for (NSUInteger index = 1; index < points.count - 2; index++) {
        CGPoint p0 = POINT(index - 1);
        CGPoint p1 = POINT(index);
        CGPoint p2 = POINT(index + 1);
        CGPoint p3 = POINT(index + 2);
#pragma mark - Fengur:最重要是对这里的理解和修改,可按照需求修改此算法
        if (((p2.y - p1.y) != 0)) {
            for (int i = 1; i < granularity; i++) {
                float t = (float)i * (1.0f / (float)granularity);
                float tt = t * t;
                float ttt = tt * t;
                
                CGPoint pi;
                pi.x = 0.5 * (2 * p1.x + (p2.x - p0.x) * t +
                              (2 * p0.x - 5 * p1.x + 4 * p2.x - p3.x) * tt +
                              (3 * p1.x - p0.x - 3 * p2.x + p3.x) * ttt);
                pi.y = 0.5 * (2 * p1.y + (p2.y - p0.y) * t +
                              (2 * p0.y - 5 * p1.y + 4 * p2.y - p3.y) * tt +
                              (3 * p1.y - p0.y - 3 * p2.y + p3.y) * ttt);
                [smoothedPath addLineToPoint:pi];
            }
        }
        [smoothedPath addLineToPoint:p2];
    }
    [smoothedPath addLineToPoint:POINT(points.count - 1)];
    
    return smoothedPath;
}


@end
