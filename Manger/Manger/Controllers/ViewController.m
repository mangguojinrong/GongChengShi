//
//  ViewController.m
//  Manger
//
//  Created by Apple on 2016/12/6.
//  Copyright © 2016年 mgjr. All rights reserved.
//

#import "ViewController.h"
#import "WaterFlowLayout.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterFlowLayoutDelegate>

@end

@implementation ViewController

static NSString *const CellIdentifer = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    WaterFlowLayout *flowLayout = [[WaterFlowLayout alloc] init];
    flowLayout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifer];
    [self.view addSubview:collectionView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    label.text = @"";
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifer forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor orangeColor]];
    NSInteger tag = 10;
    UILabel *label = [cell.contentView viewWithTag:tag];
    if (!label) {
        label = [[UILabel alloc] init];
        [label setTag:tag];
        [cell.contentView addSubview:label];
    }
    
    [label setText:[NSString stringWithFormat:@"%zd",indexPath.item]];
    [label sizeToFit];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - water

- (CGFloat)waterFlowLayout:(WaterFlowLayout *)layout heightForItenAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth {
    return 100 + arc4random_uniform(150);
}

- (UIEdgeInsets)waterFlowLayoutEdgeInsets:(WaterFlowLayout *)layout {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (NSInteger)waterFlowLayoutColumnCount:(WaterFlowLayout *)layout {
    return 4;
}

- (CGFloat)waterFlowLayoutColumnSpacing:(WaterFlowLayout *)layout {
    return 4;
}

- (CGFloat)waterFlowLayoutRowSpacing:(WaterFlowLayout *)layout {
    return 15;
}

@end
