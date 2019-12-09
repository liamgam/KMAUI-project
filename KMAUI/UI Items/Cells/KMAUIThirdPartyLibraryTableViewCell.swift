//
//  KMAUIThirdPartyLibraryTableViewCell.swift
//  KMAUI
//
//  Created by Stanislav Rastvorov on 09.12.2019.
//  Copyright © 2019 Stanislav Rastvorov. All rights reserved.
//

import UIKit

/// This class represents the UI for the third party library cell
public class KMAUIThirdPartyLibraryTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet public weak var bgView: UIView!
    @IBOutlet public weak var logoImageView: UIImageView!
    @IBOutlet public weak var nameLabel: KMAUITitleLabel!
    @IBOutlet public weak var descriptionLabel: KMAUITextLabel!
    @IBOutlet public weak var checkboxImageView: UIImageView!
    
    // MARK: - Variables
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
