//
//  KMAPoliceTableViewCell.swift
//  KMAUI
//
//  Created by Stanislav Rastvorov on 28.12.2019.
//  Copyright © 2019 Stanislav Rastvorov. All rights reserved.
//

import UIKit

public class KMAPoliceTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet public weak var bgView: KMAUIRoundedCornersView!
    @IBOutlet public weak var logoImageView: UIImageView!
    @IBOutlet public weak var headerLabel: KMAUITitleLabel!
    @IBOutlet public weak var infoLabel: KMAUITextLabel!
    @IBOutlet public weak var rightArrowImageView: UIImageView!
    
    // MARK: - Variables
    public var policeObject = KMAPoliceNeighbourhood()
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        // Setup the right arrow
        KMAUIUtilities.shared.setupArrow(imageView: rightArrowImageView)
        
        // No selection required
        selectionStyle = .none
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        setupColors(highlight: selected)
        
    }
    
    override public func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        setupColors(highlight: highlighted)
    }
    
    public func setupColors(highlight: Bool) {
        if highlight {
            bgView.backgroundColor = KMAUIConstants.shared.KMABrightBlueColor
            headerLabel.textColor = UIColor.white
            infoLabel.textColor = UIColor.white
            rightArrowImageView.tintColor = UIColor.white
        } else {
            bgView.backgroundColor = KMAUIConstants.shared.KMABackColor
            headerLabel.textColor = KMAUIConstants.shared.KMATitleColor
            infoLabel.textColor = KMAUIConstants.shared.KMATextColor
            rightArrowImageView.tintColor = KMAUIConstants.shared.KMATextGrayColor
        }
    }
    
    /**
     Setup Cell
     */
    
    public func setupCell() {
        headerLabel.text = "\(policeObject.forceId) Police"
    }
}