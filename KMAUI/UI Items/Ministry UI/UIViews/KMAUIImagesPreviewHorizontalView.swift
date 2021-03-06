//
//  KMAUIImagesPreviewHorizontalView.swift
//  KMAUI
//
//  Created by Stanislav Rastvorov on 29.04.2020.
//  Copyright © 2020 Stanislav Rastvorov. All rights reserved.
//

import UIKit
import QuickLook

public class KMAUIImagesPreviewHorizontalView: UIView {

    // MARK: - IBOutlets
    @IBOutlet public var contentView: UIView!
    // Buttons
    @IBOutlet public weak var singleImageButton: UIButton!
    @IBOutlet public weak var twoOneImageButton: UIButton!
    @IBOutlet public weak var twoTwoImageButton: UIButton!
    @IBOutlet public weak var threeOneImageButton: UIButton!
    @IBOutlet public weak var threeTwoImageButton: UIButton!
    @IBOutlet public weak var threeThreeImageButton: UIButton!
    @IBOutlet public weak var threeThreeBgView: UIView!
    @IBOutlet public weak var threeThreeBgImageButton: UIButton!
    
    // MARK: - Variables
    public var subLand = KMAUISubLandStruct() {
        didSet {
            setupImages()
        }
    }
    public var viewAttachmentsAction: ((Bool) -> Void)?
    public lazy var previewItem = NSURL()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: KMAUIImagesPreviewHorizontalView.self)
        bundle.loadNibNamed("KMAUIImagesPreviewHorizontalView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    // MARK: - Setup view
    
    /**
     Setup images
     */
    
    public func setupImages() {
        // Hide all buttons
        singleImageButton.alpha = 0
        twoOneImageButton.alpha = 0
        twoTwoImageButton.alpha = 0
        threeOneImageButton.alpha = 0
        threeTwoImageButton.alpha = 0
        threeThreeImageButton.alpha = 0
        threeThreeBgView.alpha = 0
        threeThreeBgImageButton.alpha = 0
        // Review attachments
        threeThreeBgImageButton.layer.cornerRadius = 8
        threeThreeBgImageButton.clipsToBounds = true
        threeThreeBgImageButton.titleLabel?.font = KMAUIConstants.shared.KMAUIBoldFont.withSize(22)
        threeThreeBgImageButton.setTitleColor(KMAUIConstants.shared.KMAUIViewBgColorReverse, for: .normal)
        threeThreeBgView.layer.cornerRadius = 8
        threeThreeBgView.clipsToBounds = true
        threeThreeBgView.backgroundColor = KMAUIConstants.shared.KMAUITextColor
        // Bottom action buttons
        if !subLand.subLandImagesArray.isEmpty {
            // Show the correct image for each view
            if subLand.subLandImagesArray.count == 1 {
                // One large image
                showImage(button: singleImageButton, index: 0)
            } else if subLand.subLandImagesArray.count == 2 {
                // Two same size images
                showImage(button: twoOneImageButton, index: 0)
                showImage(button: twoTwoImageButton, index: 1)
            } else {
                // Three images or more
                showImage(button: threeOneImageButton, index: 0)
                showImage(button: threeTwoImageButton, index: 1)
                showImage(button: threeThreeImageButton, index: 2)
                
                if subLand.subLandImagesArray.count > 3 {
                    threeThreeBgImageButton.alpha = 1.0
                    threeThreeBgView.alpha = 0.5
                    threeThreeBgImageButton.setTitle("+\(subLand.subLandImagesArray.count - 3)", for: .normal)
                }
            }
        }
    }
    
    /**
     Download and show image
     */
    
    public func showImage(button: UIButton, index: Int) {
        let document = subLand.subLandImagesArray[index]
        button.alpha = 1
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        
        if let previewURL = URL(string: document.previewURL) {
            button.imageView?.kf.indicatorType = .activity
            button.kf.setImage(with: previewURL, for: .normal)
            button.imageView?.kf.indicatorType = .activity
            button.imageView?.contentMode = .scaleAspectFill
            
            button.kf.setImage(with: previewURL, for: .normal) { (result) in
                switch result {
                case .success(let value):
                    button.setImage(value.image.withRenderingMode(.alwaysOriginal), for: .normal)
                case .failure(let error):
                    print(error.localizedDescription) // The error happens
                }
            }
        }
    }
    
    // MARK: - IBActions
        
    @IBAction func singleImageButtonPressed(_ sender: Any) {
        previewImages(index: 0)
    }
    
    @IBAction func twoOneImageButtonPressed(_ sender: Any) {
        previewImages(index: 0)
    }
    
    @IBAction func twoTwoImageButtonPressed(_ sender: Any) {
        previewImages(index: 1)
    }
    
    @IBAction func threeOneImageButtonPressed(_ sender: Any) {
        previewImages(index: 0)
    }
    
    @IBAction func threeTwoImageButtonPressed(_ sender: Any) {
        previewImages(index: 1)
    }
    
    @IBAction func threeThreeImageButtonPressed(_ sender: Any) {
        previewImages(index: 2)
    }
    
    @IBAction public func viewAttachmentsButtonPressed(_ sender: Any) {
        viewAttachmentsAction?(true)
    }
    
    // MARK: - Documents preview
    
    public func previewImages(index: Int) {
        let document = subLand.subLandImagesArray[index]
        
        KMAUIUtilities.shared.quicklookPreview(urlString: document.fileURL, fileName: document.name, uniqueId: document.objectId) { (previewItemValue) in
            self.previewItem = previewItemValue
            // Display file
            let previewController = QLPreviewController()
            previewController.dataSource = self
            KMAUIUtilities.shared.displayAlert(viewController: previewController)
        }
    }
}

// MARK: - QLPreviewController Datasource

extension KMAUIImagesPreviewHorizontalView: QLPreviewControllerDataSource {
    
    public func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    public func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return previewItem as QLPreviewItem
    }
}

