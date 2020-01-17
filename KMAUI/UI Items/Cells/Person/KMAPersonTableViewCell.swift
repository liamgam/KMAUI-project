//
//  KMAPersonTableViewCell.swift
//  KMAUI
//
//  Created by Stanislav Rastvorov on 06.01.2020.
//  Copyright © 2020 Stanislav Rastvorov. All rights reserved.
//

import UIKit
import Parse
import Kingfisher

public class KMAPersonTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet public weak var bgView: KMAUIRoundedCornersView!
    @IBOutlet public weak var profileImageView: UIImageView!
    @IBOutlet public weak var usernameLabel: KMAUITitleLabel!
    @IBOutlet public weak var fullNameLabel: KMAUITextLabel!
    @IBOutlet public weak var rightArrowImageView: UIImageView!
    @IBOutlet public weak var rightArrowImageViewWidth: NSLayoutConstraint!
    @IBOutlet public weak var rightArrowImageViewRight: NSLayoutConstraint!
    @IBOutlet public weak var activityView: UIActivityIndicatorView!
    
    // MARK: - Variables
    public var person = KMAPerson()
    public var status = ""
    public var search = ""
    public var canHighlight = true
    
    // MARK: - Cell methods
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        // Set the profileImageView
        profileImageView.tintColor = KMAUIConstants.shared.KMATextGrayColor
        profileImageView.layer.borderColor = KMAUIConstants.shared.KMATextGrayColor.cgColor
        profileImageView.layer.borderWidth = KMAUIConstants.shared.KMABorderWidthLight
        profileImageView.layer.cornerRadius = KMAUIConstants.shared.KMACornerRadius
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.kf.indicatorType = .activity
        
        // Right arrow image view
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
        if highlight, status == "person", canHighlight {
            bgView.backgroundColor = KMAUIConstants.shared.KMABrightBlueColor
            profileImageView.tintColor = UIColor.white
            usernameLabel.textColor = UIColor.white
            fullNameLabel.textColor = UIColor.white
            usernameLabel.text = person.username.formatUsername()
            fullNameLabel.text = person.fullName
            rightArrowImageView.tintColor = UIColor.white
        } else {
            bgView.backgroundColor = KMAUIConstants.shared.KMABackColor
            profileImageView.tintColor = KMAUIConstants.shared.KMATextGrayColor
            usernameLabel.textColor = KMAUIConstants.shared.KMATitleColor
            fullNameLabel.textColor = KMAUIConstants.shared.KMATextGrayColor
            
            if status == "no results" {
                usernameLabel.text = "No matching people"
                fullNameLabel.text = ""
            } else if status.starts(with: "loading") {
                usernameLabel.text = "Loading people..."

                if status.contains("profile") {
                    usernameLabel.text = "Loading profile..."
                }
                
                fullNameLabel.text = ""
            } else {
                usernameLabel.attributedText = KMAUIUtilities.shared.attributedText(text: person.username.formatUsername(), search: search, fontSize: usernameLabel.font.pointSize)
                fullNameLabel.attributedText = KMAUIUtilities.shared.attributedText(text: person.fullName, search: search, fontSize: fullNameLabel.font.pointSize)
            }
            
            rightArrowImageView.tintColor = KMAUIConstants.shared.KMATextGrayColor
        }
    }
    
    /**
     Setup cell
     */
    
    public func setupCell() {
        if canHighlight {
            rightArrowImageView.alpha = 1
            rightArrowImageViewWidth.constant = 22
            rightArrowImageViewRight.constant = 8
        } else {
            rightArrowImageView.alpha = 0
            rightArrowImageViewWidth.constant = 0
            rightArrowImageViewRight.constant = 0
        }
        
        if status == "person" {
            usernameLabel.attributedText = KMAUIUtilities.shared.attributedText(text: person.username.formatUsername(), search: search, fontSize: usernameLabel.font.pointSize)
            
            fullNameLabel.attributedText = KMAUIUtilities.shared.attributedText(text: person.fullName, search: search, fontSize: fullNameLabel.font.pointSize)
            
            profileImageView.image = KMAUIConstants.shared.profileTabIcon.withRenderingMode(.alwaysTemplate)
            
            if let url = URL(string: person.profileImage) {
                profileImageView.kf.setImage(with: url)
            }
            
            activityView.alpha = 0
            profileImageView.alpha = 1
            activityView.alpha = 0
        } else if status.starts(with: "loading") {
            usernameLabel.text = "Loading people..."
            
            if status.contains("profile") {
                usernameLabel.text = "Loading profile..."
            }
            
            fullNameLabel.text = ""
            activityView.startAnimating()
            activityView.alpha = 1
            profileImageView.alpha = 0
            activityView.alpha = 1
        } else if status == "no results" {
            usernameLabel.text = "No matching people"
            fullNameLabel.text = ""
            activityView.alpha = 0
            profileImageView.image = KMAUIConstants.shared.profileTabIcon.withRenderingMode(.alwaysTemplate)
            profileImageView.alpha = 1
            activityView.alpha = 0
        }
    }
}
