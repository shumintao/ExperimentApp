//
//  EXStyleHeadlineCell.m
//  ExperimentApp
//
//  Created by Facebook on 2017/11/7.
//  Copyright © 2017年 com.GDBank.Company. All rights reserved.
//

#import "EXStyleHeadlineCell.h"
#import "EXFontStyleModel.h"
#import "EXTitlePickerView.h"

@interface EXStyleHeadlineCell ()
@property(nonatomic,strong)UIView  *bgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *unfoldImageView;
@property(nonatomic,strong)UILabel *rightLabel;
@property(nonatomic,strong)CAShapeLayer *lineDashLayer;
@property(nonatomic,strong)EXTitlePickerView *titlePickerView;   //普通标题
@end
@implementation EXStyleHeadlineCell

+(id)CellWithTableView:(UITableView *)tableView{
    
    EXStyleHeadlineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EXStyleHeadlineCell class])];
    if (!cell) {
        cell = [[EXStyleHeadlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([EXStyleHeadlineCell class])];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self.contentView.layer addSublayer:self.lineDashLayer];
        [self.contentView addSubview:self.titlePickerView];
        [self.titlePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgView.mas_bottom);
            make.left.right.bottom.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

-(void)EX_initConfingViews{
     self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    self.titleLabel = [UILabel labelWithColor:BaseContenTextColor font:FontPingFangSC(15.0) alignment:NSTextAlignmentLeft];
    [self.bgView addSubview:self.titleLabel];
    self.unfoldImageView = [UIImageView new];
    self.unfoldImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.bgView addSubview:self.unfoldImageView];
    self.rightLabel = [UILabel labelWithColor:BaseContenTextColor font:FontPingFangSC(15.0) alignment:NSTextAlignmentLeft];
    self.rightLabel.hidden = YES;
    [self.bgView addSubview:self.rightLabel];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(Number(60.0));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Number(10));
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
    [self.unfoldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-Number(10));
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.unfoldImageView.mas_left).mas_offset(-Number(10.0));
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
}

-(void)InitDataWithModel:(EXFontStyleModel *)model{
    self.titleLabel.text = model.title;
    self.unfoldImageView.image = [UIImage imageNamed:model.unfoldImage];
    if (model.rightTitle) {
        self.rightLabel.hidden = NO;
        self.rightLabel.text = model.rightTitle;
    }
}

-(CAShapeLayer *)lineDashLayer{
    if (!_lineDashLayer) {
        _lineDashLayer = [CAShapeLayer layer];
        _lineDashLayer.fillColor = [UIColor clearColor].CGColor;
        _lineDashLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        _lineDashLayer.lineJoin = kCALineJoinRound;
        _lineDashLayer.lineDashPattern = @[@5, @2];
        _lineDashLayer.lineWidth = 1.f;
    }
    return _lineDashLayer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    _lineDashLayer.hidden = !selected;
    self.titlePickerView.hidden = !selected;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (!self.selected) {return;}
    
    CGRect layerFrame = rect;
    layerFrame.origin.x = Number(20.0f);
    layerFrame.origin.y = Number(60.0f);
    layerFrame.size.width -= Number(20.0f) * 2;
    layerFrame.size.height = Number(1.0f);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0.5f)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(layerFrame), 0.5f)];
    _lineDashLayer.path = path.CGPath;
    _lineDashLayer.frame = layerFrame;
}

-(EXTitlePickerView *)titlePickerView{
    if (!_titlePickerView) {
        _titlePickerView = [[EXTitlePickerView alloc]initWithFrame:CGRectZero withTitleItems:@[@"普通",@"小标题",@"中标题",@"大标题"] spacingBetweenEdge:Number(20)];
        _titlePickerView.hidden = YES;
    }
    return _titlePickerView;
}

@end
