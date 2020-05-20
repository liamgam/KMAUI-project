//
//  KMAUILotteryTableViewCell.swift
//  KMAUI
//
//  Created by Stanislav Rastvorov on 11.03.2020.
//  Copyright © 2020 Stanislav Rastvorov. All rights reserved.
//

import UIKit
import Kingfisher

public class KMAUILandCaseTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet public weak var bgView: KMAUIRoundedCornersView!
    @IBOutlet public weak var bgViewLeft: NSLayoutConstraint!
    @IBOutlet public weak var bgViewRight: NSLayoutConstraint!
    @IBOutlet public weak var bgViewTop: NSLayoutConstraint!
    @IBOutlet public weak var bgViewBottom: NSLayoutConstraint!
    @IBOutlet public weak var isActiveImageView: UIImageView!
    @IBOutlet public weak var lotteryNameLabel: KMAUIBoldTextLabel!
    @IBOutlet public weak var lotteryNameLabelLeft: NSLayoutConstraint!
    @IBOutlet public weak var rowsStackView: UIStackView!
    @IBOutlet public weak var statusView: UIView!
    @IBOutlet public weak var statusViewWidth: NSLayoutConstraint! // default: 7
    @IBOutlet public weak var statusViewRight: NSLayoutConstraint! // default: 6
    @IBOutlet public weak var statusLabel: KMAUIRegularTextLabel!
    @IBOutlet public weak var statusLabelHeight: NSLayoutConstraint!
    @IBOutlet public weak var statusLabelBottom: NSLayoutConstraint!
    
    // MARK: - Variables
    public var landCase = KMAUILandCaseStruct()
    public var isFirst = false
    public var highlightActive = false
    public var noBg = false
    public var isActive = false {
        didSet {
            setupCell()
        }
    }

    // MARK: - Variables
    public static let id = "KMAUILandCaseTableViewCell"
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        // Background view
        backgroundColor = KMAUIConstants.shared.KMAUIMainBgColor
        
        // bgView shadow
        bgView.layer.shadowOffset = CGSize(width: 0, height: 8)
        bgView.layer.shadowRadius = 8
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        
        // Fonts
        lotteryNameLabel.font = KMAUIConstants.shared.KMAUIBoldFont.withSize(20)
        
        // isActive imageView
        isActiveImageView.image = KMAUIConstants.shared.disclosureArrow.withRenderingMode(.alwaysTemplate)
        isActiveImageView.layer.cornerRadius = 4
        isActiveImageView.clipsToBounds = true
        
        // Default state - disabled
        isActiveImageView.tintColor = KMAUIConstants.shared.KMAUIGreyLineColor
        isActiveImageView.backgroundColor = KMAUIConstants.shared.KMAProgressGray
        
        // Status view
        statusView.layer.cornerRadius = 3.5
        statusView.clipsToBounds = true
        
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
        if noBg {
            isActiveImageView.tintColor = KMAUIConstants.shared.KMAUIGreyLineColor
            isActiveImageView.backgroundColor = UIColor.clear
            
            if highlight {
                bgView.backgroundColor = KMAUIConstants.shared.KMAUIMainBgColorReverse
            } else {
                bgView.backgroundColor = KMAUIConstants.shared.KMAUIViewBgColorReverse
            }
        } else if highlight {
            bgView.backgroundColor = KMAUIConstants.shared.KMAUIMainBgColor
            
            if highlightActive {
                isActiveImageView.tintColor = UIColor.white
                isActiveImageView.backgroundColor = KMAUIConstants.shared.KMAUIBlueDarkColor
            }
        } else {
            bgView.backgroundColor = KMAUIConstants.shared.KMAUIViewBgColor
            
            if highlightActive {
                isActiveImageView.tintColor = KMAUIConstants.shared.KMAUIGreyLineColor
                isActiveImageView.backgroundColor = KMAUIConstants.shared.KMAProgressGray
            }
        }
    }
    
    public func setupCell() {
        // Top offset
        if isFirst {
            bgViewTop.constant = 8
        } else {
            bgViewTop.constant = 0
        }
        
        // Is active status
        if isActive {
            isActiveImageView.tintColor = UIColor.white
            isActiveImageView.backgroundColor = KMAUIConstants.shared.KMAUIBlueDarkColor
        } else {
            isActiveImageView.tintColor = KMAUIConstants.shared.KMAUIGreyLineColor
            isActiveImageView.backgroundColor = KMAUIConstants.shared.KMAProgressGray
        }
        
        // Lottery status
        statusLabel.text = landCase.courtStatus.capitalized
        statusView.backgroundColor = KMAUIUtilities.shared.getColor(status: landCase.courtStatus)
        
        statusView.alpha = 1
        statusViewWidth.constant = 7
        statusViewRight.constant = 6
        
        statusLabel.font = KMAUIConstants.shared.KMAUIRegularFont
        statusLabel.textColor = KMAUIConstants.shared.KMAUITextColor
        statusLabel.backgroundColor = UIColor.clear
        statusLabel.layer.borderWidth = 0
        
        // Land case number
        lotteryNameLabel.text = "Case #\(landCase.caseNumber)"
        
        // Setup stack view
        setupStackView()
    }
    
    /**
     Show the stackView
     */
    
    public func setupStackView() {
        // Remove subviews
        for subview in rowsStackView.subviews {
            rowsStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        var rows = [KMAUIRowData]()
        rows.append(KMAUIRowData(rowName: "Citizen", rowValue: landCase.citizen.fullName))
        rows.append(KMAUIRowData(rowName: "Judge", rowValue: landCase.judge.fullName))
        
        // Prepare the rows
        for (index, row) in rows.enumerated() {
            let itemView = UIStackView()
            itemView.axis = .horizontal
            itemView.distribution = UIStackView.Distribution.fill
            itemView.alignment = UIStackView.Alignment.fill
            itemView.spacing = 4
            
            // Row name label
            let rowNameLabel = KMAUIRegularTextLabel()
            rowNameLabel.font = KMAUIConstants.shared.KMAUIRegularFont.withSize(16)
            rowNameLabel.textAlignment = .left
            rowNameLabel.text = row.rowName
            rowNameLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
            itemView.addArrangedSubview(rowNameLabel)
            
            // Row value label
            let rowValueLabel = KMAUIBoldTextLabel()
            rowValueLabel.font = KMAUIConstants.shared.KMAUIBoldFont.withSize(16)
            rowValueLabel.textAlignment = .right
            rowValueLabel.text = row.rowValue
            rowValueLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: .horizontal)
            itemView.addArrangedSubview(rowValueLabel)
            
            rowsStackView.addArrangedSubview(itemView)
            itemView.leadingAnchor.constraint(equalTo: rowsStackView.leadingAnchor, constant: 0).isActive = true
            
            if index < rows.count - 1 {
                // Line view
                let lineView = UIView()
                lineView.backgroundColor = KMAUIConstants.shared.KMAUIGreyLineColor.withAlphaComponent(0.2)
                lineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
                rowsStackView.addArrangedSubview(lineView)
                lineView.leadingAnchor.constraint(equalTo: rowsStackView.leadingAnchor, constant: 0).isActive = true
                lineView.trailingAnchor.constraint(equalTo: rowsStackView.trailingAnchor, constant: 0).isActive = true
            }
        }
        rowsStackView.alpha = 1
    }
}
