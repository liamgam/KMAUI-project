//
//  KMAUISubLandTitleTableViewCell.swift
//  KMAUI
//
//  Created by Stanislav Rastvorov on 08.04.2020.
//  Copyright © 2020 Stanislav Rastvorov. All rights reserved.
//

import UIKit

public class KMAUISubLandTitleTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet public weak var statusLabel: KMAUIBoldTextLabel!
    @IBOutlet public weak var titleLabel: KMAUIBoldTextLabel!
    @IBOutlet public weak var infoLabel: KMAUIRegularTextLabel!
    
    // MARK: - Variables
    public static let id = "KMAUISubLandTitleTableViewCell"
    public var subLand = KMAUISubLandStruct() {
        didSet {
            setupCell()
        }
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        
        // Status label
        statusLabel.layer.cornerRadius = 6
        statusLabel.clipsToBounds = true
        statusLabel.textColor = UIColor.white
        statusLabel.font = KMAUIConstants.shared.KMAUIBoldFont.withSize(12)
        
        // Label adjustments
        titleLabel.font = KMAUIConstants.shared.KMAUIBoldFont.withSize(28)
        titleLabel.textColor = UIColor.white
        infoLabel.font = KMAUIConstants.shared.KMAUIRegularFont.withSize(16)
        infoLabel.textColor = UIColor.white
        
        // No selection required
        selectionStyle = .none
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupCell() {
        if subLand.subLandType.isEmpty {
            statusLabel.text = ""
            statusLabel.alpha = 0
            titleLabel.text = ""
            infoLabel.text = ""
        } else {
            statusLabel.alpha = 1
            
            if subLand.status.isEmpty {
                statusLabel.text = subLand.subLandType.addGaps()
                statusLabel.backgroundColor = KMAUIUtilities.shared.getColor(subLandType: subLand.subLandType)
                statusLabel.textColor = KMAUIUtilities.shared.getTextColor(subLandType: subLand.subLandType)
            } else {
                statusLabel.text = subLand.status.lowercased().addGaps()
                statusLabel.backgroundColor = KMAUIUtilities.shared.subLandColor(status: subLand.status)
                statusLabel.textColor = UIColor.white
            }
            
            if KMAUIConstants.shared.nonLivingTypes.contains(subLand.subLandType) {
                titleLabel.text = subLand.subLandId
            } else {
                titleLabel.text = "Land ID \(subLand.subLandId)"
            }
            
            if subLand.regionName.isEmpty {
                infoLabel.text = ""
            } else {
                infoLabel.text = "\(subLand.regionName) Region"
            }
        }
    }
}
