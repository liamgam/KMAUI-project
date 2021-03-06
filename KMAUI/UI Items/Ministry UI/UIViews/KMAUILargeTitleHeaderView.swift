//
//  KMAUILargeTitleHeaderView.swift
//  KMAUI
//
//  Created by Stanislav Rastvorov on 12.03.2020.
//  Copyright © 2020 Stanislav Rastvorov. All rights reserved.
//

import UIKit

public class KMAUILargeTitleHeaderView: UIView {
    // MARK: - IBoutlets
    @IBOutlet public var contentView: UIView!
    @IBOutlet public weak var bgView: UIView!
    @IBOutlet public weak var headerLabel: UILabel!
    @IBOutlet public weak var headerLabelLeft: NSLayoutConstraint!
    @IBOutlet public weak var headerLabelRight: NSLayoutConstraint!
    
    // MARK: - Variables
    public var sideOffsets = true
    public var headerTitle = "" {
        didSet {
            setupHeader()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public func setupHeader() {
        // Fill the data to display
        headerLabel.text = headerTitle
        headerLabel.font = KMAUIConstants.shared.KMAUIBoldFont.withSize(20)
        // Setup side offsets
        if sideOffsets {
            headerLabelLeft.constant = 40
            headerLabelRight.constant = 40
            contentView.backgroundColor = KMAUIConstants.shared.KMAUIMainBgColor
            bgView.alpha = 1
        } else {
            headerLabelLeft.constant = 30
            headerLabelRight.constant = 30
            contentView.backgroundColor = KMAUIConstants.shared.KMAUIViewBgColor
            bgView.alpha = 0
        }
    }
    
    private func commonInit() {
        let bundle = Bundle(for: KMAUILargeTitleHeaderView.self)
        bundle.loadNibNamed("KMAUILargeTitleHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
