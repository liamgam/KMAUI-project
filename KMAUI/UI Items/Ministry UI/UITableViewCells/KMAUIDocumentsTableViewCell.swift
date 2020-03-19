//
//  KMAUIDocumentsTableViewCell.swift
//  KMAUI
//
//  Created by Stanislav Rastvorov on 19.03.2020.
//  Copyright © 2020 Stanislav Rastvorov. All rights reserved.
//

import UIKit

public class KMAUIDocumentsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Variables
    public static let id = "KMAUIDocumentsTableViewCell"

    override public func awakeFromNib() {
        super.awakeFromNib()
        
        // No selection  required
        selectionStyle = .none
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
