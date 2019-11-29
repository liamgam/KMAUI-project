//
//  KMATitleLabel.swift
//  KMA EYES CITIZENS
//
//  Created by Stanislav Rastvorov on 8/28/19.
//  Copyright © 2019 Stanislav Rastvorov. All rights reserved.
//

import UIKit

/// The title label, used for example 

public class KMAUITitleLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        textColor = KMAUIConstants.shared.KMATextColor
        numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        textColor = KMAUIConstants.shared.KMATextColor
        numberOfLines = 0
    }
}
