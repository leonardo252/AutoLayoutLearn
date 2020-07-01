//
//  PageCell.swift
//  AutoLayout
//
//  Created by Leonardo Gomes on 03/06/20.
//  Copyright © 2020 Leonardo Gomes. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
        
    var page: Page? {
        didSet {
            
            guard let unwrappedPage = page else {return}
            
            posterImageView.image = UIImage(named: unwrappedPage.imageName)
            
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.filmName, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            
            attributedText.append(NSAttributedString(string: "\n\n\(unwrappedPage.storyline)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
            
            resumeTextView.attributedText = attributedText
            resumeTextView.textAlignment = .center
        }
    }
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "avengers"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let resumeTextView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = true
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        
        setupLayout()
    }
    
    
    private func setupLayout() {
        
        let topPosterContainerView = UIView()
        addSubview(topPosterContainerView)
        topPosterContainerView.translatesAutoresizingMaskIntoConstraints = false
        topPosterContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        topPosterContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topPosterContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topPosterContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        topPosterContainerView.addSubview(posterImageView)
        
        
        posterImageView.centerXAnchor.constraint(equalTo: topPosterContainerView.centerXAnchor).isActive = true
        posterImageView.centerYAnchor.constraint(equalTo: topPosterContainerView.centerYAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: topPosterContainerView.heightAnchor, multiplier: 0.88).isActive = true
        
        addSubview(resumeTextView)
        resumeTextView.backgroundColor = .clear
        resumeTextView.topAnchor.constraint(equalTo: topPosterContainerView.bottomAnchor).isActive = true
        resumeTextView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        resumeTextView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 28).isActive = true
        resumeTextView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -28).isActive = true
        resumeTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    
    func blur(_ image: UIImage) -> UIImage? {
        
        
        guard let cgImage = image.cgImage else { return nil }
        let ciImage = CIImage(cgImage: cgImage)
        
        guard let filter = CIFilter(name: "CIGaussianBlur") else { return nil }
        filter.setDefaults()
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(9, forKey: kCIInputRadiusKey)
        
        guard let outputCIImage = filter.outputImage else { return nil }
        let outputImage = UIImage(ciImage: outputCIImage)
        return outputImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
