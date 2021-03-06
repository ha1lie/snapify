#import "SNPAnimatedTitleView.h"

//CREDITS FOR THIS CELL TO LACERTOSUS: 
//DISCORD: Bezerk#4824
//GITHUB: LacertosusRepo
//TWITTER: @LacertosusDeus

@implementation SNPAnimatedTitleView {
  UILabel *_titleLabel;
  NSLayoutConstraint *_yConstraint;
  CGFloat _minimumOffsetRequired;
}

  -(instancetype)initWithTitle:(NSString *)title minimumScrollOffsetRequired:(CGFloat)minimumOffset {
    if([super init]) {
      self.superview.clipsToBounds = YES;

    BOOL isDarkMode = false;
    if (@available(iOS 13, *)) {
        isDarkMode = self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
    }
      
      _titleLabel = [[UILabel alloc] init];
      _titleLabel.text = title;
      _titleLabel.textAlignment = NSTextAlignmentCenter;
      _titleLabel.textColor = isDarkMode ? [UIColor whiteColor] : [UIColor blackColor];
      _titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightHeavy];
      _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
      [_titleLabel sizeToFit];

      [self addSubview:_titleLabel];

      [NSLayoutConstraint activateConstraints:@[
        [self.widthAnchor constraintEqualToAnchor:_titleLabel.widthAnchor],
        [self.heightAnchor constraintEqualToAnchor:_titleLabel.heightAnchor],

        [_titleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        _yConstraint = [_titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:100],
      ]];

      _minimumOffsetRequired = minimumOffset;
    }

    return self;
  }

  -(void)adjustLabelPositionToScrollOffset:(CGFloat)offset {
    CGFloat adjustment = 100 - (offset - _minimumOffsetRequired);
    if(offset >= _minimumOffsetRequired) {
      if(adjustment <= 0) {
        _yConstraint.constant = 0;
      } else {
        _yConstraint.constant = adjustment;
      }

    } else {
      _yConstraint.constant = -100;
    }
  }

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    BOOL isDarkMode = false;
    if (@available(iOS 13, *)) {
        isDarkMode = self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
    }
    if (_titleLabel) {
        _titleLabel.textColor = isDarkMode ? [UIColor whiteColor] : [UIColor blackColor];
    }
}
@end