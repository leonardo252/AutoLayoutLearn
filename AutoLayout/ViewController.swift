//
//  ViewController.swift
//  AutoLayout
//
//  Created by Leonardo Gomes on 02/06/20.
//  Copyright © 2020 Leonardo Gomes. All rights reserved.
//

import UIKit

extension UIColor {
    static var mainPink = UIColor(displayP3Red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

class ViewController: UIViewController {
    
    //{} is refered to clousure, or anon. function
    let posterImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "black_panther"))
        // This enable AutoLayout for imageVIew
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let resumeTextView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Black Panther", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        let resume: String = "\n\nAfter the events of Captain America: Civil War, Prince T'Challa returns home to the reclusive, technologically advanced African nation of Wakanda to serve as his country's new king. However, T'Challa soon finds that he is challenged for the throne from factions within his own country. When two foes conspire to destroy Wakanda, the hero known as Black Panther must team up with C.I.A. agent Everett K. Ross and members of the Dora Milaje, Wakandan special forces, to prevent Wakanda from being dragged into a world war."
        attributedText.append(NSAttributedString(string: resume, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))

        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let previusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = .gray
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(resumeTextView)

        setupButtonControls()
        
        setupLayout()
 
    }
    
    fileprivate func setupButtonControls() {
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previusButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
//        bottomControlsStackView.axis = .vertical
        
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    private func setupLayout() {
        
        let topPosterContainerView = UIView()
//        topPosterContainerView.backgroundColor = .clear
        view.addSubview(topPosterContainerView)
//        topPosterContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        //Enable AutoLayout
        topPosterContainerView.translatesAutoresizingMaskIntoConstraints = false
        topPosterContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topPosterContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topPosterContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topPosterContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    
        topPosterContainerView.addSubview(posterImageView)
    
        
        posterImageView.centerXAnchor.constraint(equalTo: topPosterContainerView.centerXAnchor).isActive = true
        posterImageView.centerYAnchor.constraint(equalTo: topPosterContainerView.centerYAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: topPosterContainerView.heightAnchor, multiplier: 0.88).isActive = true
        
        resumeTextView.topAnchor.constraint(equalTo: topPosterContainerView.bottomAnchor).isActive = true
        resumeTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resumeTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24).isActive = true
        resumeTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24).isActive = true
        resumeTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }


}

//    private func setupBackground() {
//
//        let backView = UIView()
//
//        let imgBack = blur(posterImageView.image!)
//
//        let backgroundImage = UIImageView(image: imgBack)
//        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
//        backgroundImage.contentMode = .scaleAspectFill
//        backgroundImage.alpha = 0.3
//
//        backView.addSubview(backgroundImage)
//
//        let blackView = UIView()
//        blackView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
//        blackView.backgroundColor = .black
//        blackView.alpha = 0.4
//
//        backView.addSubview(blackView)
//
//        addSubview(backView)
//
//        backgroundImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        backgroundImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        backgroundImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1.2).isActive = true
//        backgroundImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.2).isActive = true
//
//
//    }
