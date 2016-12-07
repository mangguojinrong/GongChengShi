//
//  WaterFlowLayout.m
//  瀑布流
//
//  Created by Apple on 2016/11/30.
//  Copyright © 2016年 mgjr. All rights reserved.
//

#import "WaterFlowLayout.h"

static NSInteger const DefautColumnCount = 5;
static CGFloat const DefautColumnSpacing = 10;
static CGFloat const DefautRowSpacing = 10;
static UIEdgeInsets const DefautEdgeInsets = {10,10,10,10};

@interface WaterFlowLayout ()

@property (nonatomic, strong) NSMutableArray *attrArray;
@property (nonatomic, strong) NSMutableArray *maxYArray;

- (NSInteger)columnCount;
- (CGFloat)columnSpacing;
- (CGFloat)rowSpacing;
- (UIEdgeInsets)edgeInsets;

@end

@implementation WaterFlowLayout

- (NSInteger)columnCount {
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutColumnCount:)]) {
        return [self.delegate waterFlowLayoutColumnCount:self];
    }
    return DefautColumnCount;
}
- (CGFloat)columnSpacing {
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutColumnCount:)]) {
        return [self.delegate waterFlowLayoutColumnSpacing:self];
    }
    return DefautColumnSpacing;
}
- (CGFloat)rowSpacing {
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutRowSpacing:)]) {
        return [self.delegate waterFlowLayoutRowSpacing:self];
    }
    return DefautRowSpacing;
}
- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutEdgeInsets:)]) {
        return [self.delegate waterFlowLayoutEdgeInsets:self];
    }
    return DefautEdgeInsets;
}

- (NSMutableArray *)maxYArray {
    if (!_maxYArray) {
        _maxYArray = [[NSMutableArray alloc] init];
    }
    return _maxYArray;
}

- (NSMutableArray *)attrArray {
    if (!_attrArray) {
        _attrArray = [[NSMutableArray alloc] init];
    }
    return _attrArray;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    [self.maxYArray removeAllObjects];
    [self.attrArray removeAllObjects];
    
    for (NSInteger i = 0; i < [self columnCount]; i++) {
        [self.maxYArray addObject:@([self edgeInsets].top)];
    }
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i< itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        [self.attrArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    return self.attrArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger __block minHeightColumn = 0;
    NSInteger __block minHeight = [self.maxYArray[minHeightColumn] floatValue];
    
    [self.maxYArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat columnHeight = [(NSNumber *)obj floatValue];
        if (minHeight > columnHeight) {
            minHeight = columnHeight;
            minHeightColumn = idx;
        }
    }];
    
    UIEdgeInsets edgeInsets = [self edgeInsets];
    
    CGFloat width = (CGRectGetWidth(self.collectionView.frame) - edgeInsets.left - edgeInsets.right - [self columnSpacing] * ([self columnCount] - 1)) / DefautColumnCount;
    CGFloat height = [self.delegate waterFlowLayout:self heightForItenAtIndex:indexPath.item itemWidth:width];
    CGFloat originX = DefautEdgeInsets.left + minHeightColumn * (width + DefautColumnSpacing);
    
    CGFloat originY = minHeight;
    if (originY != DefautEdgeInsets.top) {
        originY += DefautRowSpacing;
    }
    
    [attributes setFrame:CGRectMake(originX, originY, width, height)];
    self.maxYArray[minHeightColumn] = @(CGRectGetMaxY(attributes.frame));
    return attributes;
}

- (CGSize)collectionViewContentSize {
    
    NSInteger __block minHeight = 0;
    
    [self.maxYArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat columnHeight = [(NSNumber *)obj floatValue];
        if (minHeight < columnHeight) {
            minHeight = columnHeight;
            
        }
    }];
    return CGSizeMake(0, minHeight + [self edgeInsets].bottom);
}
@end
