//
//  SecondhandCell.m
//  FleaMarket
//
//  Created by tom555cat on 16/3/28.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import "SecondhandCell.h"
#import "Help.h"

@interface SecondhandCell ()

// 头像
@property (nonatomic, weak) UIImageView *iconImageView;
// 名字
@property (nonatomic, weak) UILabel *nameLabel;
// 性别
@property (nonatomic, weak) UIImageView *sexImageView;
// 价格
@property (nonatomic, weak) UILabel *priceLabel;
// 描述
@property (nonatomic, weak) UILabel *descriptionLabel;
// 配图
@property (nonatomic, weak) UIView *pictureImageView;
// 配图
@property (nonatomic, weak) UIImageView *picture1;
@property (nonatomic, weak) UIImageView *picture2;
@property (nonatomic, weak) UIImageView *picture3;
// 学校
@property (nonatomic, weak) UILabel *schoolLabel;
//地址
@property (nonatomic, weak) UILabel *locationLabel;
// 发布时间
@property (nonatomic, weak) UILabel *publishTimeLabel;
// 分隔线
@property (nonatomic, weak) UIView *partLine;
// cell间隔
@property (nonatomic, weak) UIView *cellPart;

@end

@implementation SecondhandCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSLog(@"%s",__func__);
        // 头像
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImageView];
        self.iconImageView = iconImageView;
        
        // 名字
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = HTNameFont;   // 调整
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 性别
        UIImageView *sexImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:sexImageView];
        self.sexImageView = sexImageView;
        
        // 发布时间
        UILabel *publishTimeLabel = [[UILabel alloc] init];
        publishTimeLabel.font = HTNameFont;
        [self.contentView addSubview:publishTimeLabel];
        self.publishTimeLabel = publishTimeLabel;
        
        // 学校
        UILabel *schoolLabel = [[UILabel alloc] init];
        schoolLabel.font = HTNameFont;
        [self.contentView addSubview:schoolLabel];
        self.schoolLabel = schoolLabel;
        
        // 描述
        UILabel *descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.font = HTTextFont;
        descriptionLabel.numberOfLines = 2;
        [self.contentView addSubview:descriptionLabel];
        self.descriptionLabel = descriptionLabel;
        
        // 配图
        UIView *pictureImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:pictureImageView];
        self.pictureImageView = pictureImageView;
        
        UIImageView *picture1 = [[UIImageView alloc] init];
        [self.contentView addSubview:picture1];
        self.picture1 = picture1;
        
        UIImageView *picture2 = [[UIImageView alloc] init];
        [self.contentView addSubview:picture2];
        self.picture2 = picture2;
        
        UIImageView *picture3 = [[UIImageView alloc] init];
        [self.contentView addSubview:picture3];
        self.picture3 = picture3;
        
        // 分隔线
        UIView *partLine = [[UIView alloc] init];
        partLine.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0];
        [self.contentView addSubview:partLine];
        self.partLine = partLine;
        
        // 地址
        UILabel *locationLabel = [[UILabel alloc] init];
        locationLabel.font = HTTextFont;
        [self.contentView addSubview:locationLabel];
        self.locationLabel = locationLabel;
        
        // 价格
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.font = HTTextFont;
        [self.contentView addSubview:priceLabel];
        self.priceLabel = priceLabel;
        
        // cell间隔
        UIView *cellPart = [[UIView alloc] init];
        cellPart.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:cellPart];
        self.cellPart = cellPart;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _iconImageView.frame = _frameModel.iconFrame;
    _nameLabel.frame = _frameModel.nameFrame;
    _priceLabel.frame = _frameModel.priceFrame;
    _descriptionLabel.frame = _frameModel.descriptionFrame;
    _pictureImageView.frame = _frameModel.pictureFrame;
    _locationLabel.frame = _frameModel.locationFrame;
    _schoolLabel.frame = _frameModel.schoolFrame;
    _publishTimeLabel.frame = _frameModel.publishTimeFrame;
    _sexImageView.frame = _frameModel.sexFrame;
    _partLine.frame = _frameModel.partLineFrame;
    _cellPart.frame = _frameModel.cellPartFrame;
    
    _picture1.frame = _frameModel.picture1Frame;
    _picture2.frame = _frameModel.picture2Frame;
    _picture3.frame = _frameModel.picture3Frame;
}

- (void)setModel:(SecondhandVO *)model
{
    _model = model;
    _nameLabel.text = model.userName;
    
    // 调整VO，添加用户头像字符串
    _iconImageView.image = [UIImage imageNamed:model.userIconImage];
    _priceLabel.text = [NSString stringWithFormat:@"%ld", model.nowPrice];
    _descriptionLabel.text = model.productName;
    
    _locationLabel.text = model.location;
    _schoolLabel.text = model.school;
    _publishTimeLabel.text = model.publishTime;
    _sexImageView.image = [UIImage imageNamed:model.sex];
    
    // 处理model中的pictureArray
    if ([model.pictureArray count] >= 3) {
        _picture1.image = [UIImage imageNamed:model.pictureArray[0]];
        _picture2.image = [UIImage imageNamed:model.pictureArray[1]];
        _picture3.image = [UIImage imageNamed:model.pictureArray[2]];
    }
    
    if ([model.pictureArray count] == 2) {
        _picture1.image = [UIImage imageNamed:model.pictureArray[0]];
        _picture2.image = [UIImage imageNamed:model.pictureArray[1]];
    }
    
    if ([model.pictureArray count] == 1) {
        _picture1.image = [UIImage imageNamed:model.pictureArray[0]];
    }

    
}

@end
