//
//  UITableView+CellLine.m
//  FGCellLineLength
//
//  Created by 段鹏飞 on 16/8/8.
//  Copyright © 2016年 SuperFG. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

- (void)addLineForCell:(UITableViewCell *)cell
             indexPath:(NSIndexPath *)indexPath
             leftSpace:(CGFloat)leftSpace
{
    [self addLineForCell:cell
               indexPath:indexPath
               leftSpace:leftSpace
              rightSpace:0
             sectionLine:YES];
}

- (void)addLineForCell:(UITableViewCell *)cell
             indexPath:(NSIndexPath *)indexPath
             leftSpace:(CGFloat)leftSpace
            rightSpace:(CGFloat)rightSpace
{
    [self addLineForCell:cell
               indexPath:indexPath
               leftSpace:leftSpace
              rightSpace:rightSpace
             sectionLine:YES];
}

- (void)addLineForCell:(UITableViewCell *)cell
              indexPath:(NSIndexPath *)indexPath
              leftSpace:(CGFloat)leftSpace
             rightSpace:(CGFloat)rightSpace
            sectionLine:(BOOL)hasSectionLine
{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGRect bounds = CGRectInset(cell.bounds, 0, 0);
    CGPathAddRect(pathRef, nil, bounds);
    layer.path = pathRef;
    CFRelease(pathRef);
    
    CGColorRef lineColor = UIColorFromRGB(0xdddddd).CGColor;
    CGColorRef sectionLineColor = lineColor;
    
    if (cell.backgroundColor) {
        //layer的填充色用cell原本的颜色
        layer.fillColor = cell.backgroundColor.CGColor;
    }else if (cell.backgroundView && cell.backgroundView.backgroundColor){
        layer.fillColor = cell.backgroundView.backgroundColor.CGColor;
    }else{
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    }

    if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //只有一个cell -- 加上长线和下长线
        if (hasSectionLine) {
            [self addLineWithlayer:layer lineUp:YES lineLong:NO color:sectionLineColor bounds:bounds leftSpace:0 rightSpace:0];
            [self addLineWithlayer:layer lineUp:NO lineLong:YES color:sectionLineColor bounds:bounds leftSpace:0 rightSpace:0];
        }
    } else if (indexPath.row == 0) {
        //第一个cell  -- 加上长线和下短线
        if (hasSectionLine) {
            [self addLineWithlayer:layer lineUp:YES lineLong:YES color:sectionLineColor bounds:bounds leftSpace:leftSpace rightSpace:rightSpace];
        }
        [self addLineWithlayer:layer lineUp:NO lineLong:NO color:sectionLineColor bounds:bounds leftSpace:leftSpace rightSpace:rightSpace];
    } else if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //最后一个cell -- 加下长线
        if (hasSectionLine) {
            [self addLineWithlayer:layer lineUp:NO lineLong:YES color:sectionLineColor bounds:bounds leftSpace:0 rightSpace:0];
        }
    } else {
        //中间的cell  -- 只加下短线
        [self addLineWithlayer:layer lineUp:NO lineLong:NO color:sectionLineColor bounds:bounds leftSpace:leftSpace rightSpace:rightSpace];
    }
//    UIView *testView = [[UIView alloc] initWithFrame:bounds];
//    [testView.layer insertSublayer:layer atIndex:0];
//    testView.backgroundColor = UIColor.clearColor;
//    cell.backgroundView = testView;
    [cell.layer insertSublayer:layer atIndex:0];
}

- (void)addLineForAllCell:(UITableViewCell *)cell
                 indexPath:(NSIndexPath *)indexPath
                 leftSpace:(CGFloat)leftSpace
                rightSpace:(CGFloat)rightSpace
              hasHeadLine:(BOOL)headLine
{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGRect bounds = CGRectInset(cell.bounds, 0, 0);
    CGPathAddRect(pathRef, nil, bounds);
    layer.path = pathRef;
    CFRelease(pathRef);
    
    CGColorRef lineColor = UIColorFromRGB(0xdddddd).CGColor;
    CGColorRef sectionLineColor = lineColor;
    
    if (cell.backgroundColor) {
        //layer的填充色用cell原本的颜色
        layer.fillColor = cell.backgroundColor.CGColor;
    }else if (cell.backgroundView && cell.backgroundView.backgroundColor){
        layer.fillColor = cell.backgroundView.backgroundColor.CGColor;
    }else{
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    }
    
    //除了第一个cell额外加上短线，全部加下短线
    if (indexPath.row == 0 && headLine) {
        [self addLineWithlayer:layer lineUp:YES lineLong:NO color:sectionLineColor bounds:bounds leftSpace:leftSpace rightSpace:rightSpace];
    }
    [self addLineWithlayer:layer lineUp:NO lineLong:NO color:sectionLineColor bounds:bounds leftSpace:leftSpace rightSpace:rightSpace];
    
    //    UIView *testView = [[UIView alloc] initWithFrame:bounds];
    //    [testView.layer insertSublayer:layer atIndex:0];
    //    testView.backgroundColor = UIColor.clearColor;
    //    cell.backgroundView = testView;
    [cell.layer insertSublayer:layer atIndex:0];
}

- (void)addLineWithlayer:(CALayer *)layer
                  lineUp:(BOOL)isUp
                lineLong:(BOOL)isLong
                   color:(CGColorRef)color
                  bounds:(CGRect)bounds
               leftSpace:(CGFloat)leftSpace
              rightSpace:(CGFloat)rightSpace
{
    CALayer *lineLayer = [[CALayer alloc] init];
    CGFloat lineHeight = (1.0f / [UIScreen mainScreen].scale);
    CGFloat left, right, top;
    
    if (isUp) {
        top = 0;
    }else{
        top = bounds.size.height - lineHeight;
    }
    
    if (isLong) {
        left = 0;
        right = 0;
    }else{
        left = leftSpace;
        right = rightSpace;
    }
    lineLayer.frame = CGRectMake(CGRectGetMinX(bounds) + left, top, bounds.size.width - left - right, lineHeight);
    lineLayer.backgroundColor = color;
    [layer addSublayer:lineLayer];
}

+ (instancetype)tableViewWithFrame:(CGRect)rect
                    tableViewStyle:(UITableViewStyle)style
                     registerClass:(NSArray *)ClassNames
                    delegateObject:(id)target
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:style];
    tableView.delegate = target;
    tableView.dataSource = target;
    for (NSString *name in ClassNames)
    {
        [tableView registerClass:NSClassFromString(name) forCellReuseIdentifier:name];
    }
    return tableView;
}
@end
