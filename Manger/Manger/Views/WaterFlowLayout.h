//
//  WaterFlowLayout.h
//  瀑布流
//
//  Created by Apple on 2016/11/30.
//  Copyright © 2016年 mgjr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFlowLayout;

@protocol WaterFlowLayoutDelegate <NSObject>

@required

- (CGFloat)waterFlowLayout:(WaterFlowLayout *)layout heightForItenAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth;
@optional
- (NSInteger)waterFlowLayoutColumnCount:(WaterFlowLayout *)layout;
- (CGFloat)waterFlowLayoutColumnSpacing:(WaterFlowLayout *)layout;
- (CGFloat)waterFlowLayoutRowSpacing:(WaterFlowLayout *)layout;
- (UIEdgeInsets)waterFlowLayoutEdgeInsets:(WaterFlowLayout *)layout;

@end

@interface WaterFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<WaterFlowLayoutDelegate> delegate;


@end
