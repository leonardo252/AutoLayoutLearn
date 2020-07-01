//
//  SwipingController.swift
//  AutoLayout
//
//  Created by Leonardo Gomes on 02/06/20.
//  Copyright © 2020 Leonardo Gomes. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    let pageColor: [UIColor] = [UIColor.red, UIColor.green, UIColor.blue, UIColor.black]
//    let imageNames = ["avengers", "black_panther", "joker", "player_one"]
//
//    let filmNames = ["Avengers", "Balck Panther", "Joker", "Ready Player One"]
    
    let pages = [
        Page(imageName: "avengers", filmName: "Avengers", storyline: "Nick Fury is the director of S.H.I.E.L.D., an international peace-keeping agency. The agency is a who's who of Marvel Super Heroes, with Iron Man, The Incredible Hulk, Thor, Captain America, Hawkeye and Black Widow. When global security is threatened by Loki and his cohorts, Nick Fury and his team will need all their powers to save the world from disaster which is formed by Loki and his team."),
        Page(imageName: "black_panther", filmName: "Balck Panther", storyline: "After the events of Captain America: Civil War, Prince T'Challa returns home to the reclusive, technologically advanced African nation of Wakanda to serve as his country's new king. However, T'Challa soon finds that he is challenged for the throne from factions within his own country. When two foes conspire to destroy Wakanda, the hero known as Black Panther must team up with C.I.A. agent Everett K. Ross and members of the Dora Milaje, Wakandan special forces, to prevent Wakanda from being dragged into a world war."),
        Page(imageName: "joker", filmName: "Joker", storyline: "Arthur Fleck works as a clown and is an aspiring stand-up comic. He has mental health issues, part of which involves uncontrollable laughter. Times are tough and, due to his issues and occupation, Arthur has an even worse time than most. Over time these issues bear down on him, shaping his actions, making him ultimately take on the persona he is more known as...Joker."),
        Page(imageName: "player_one", filmName: "Ready Player One", storyline: "In the year 2045, the real world is a harsh place. The only time Wade Watts (Tye Sheridan) truly feels alive is when he escapes to the OASIS, an immersive virtual universe where most of humanity spends their days. In the OASIS, you can go anywhere, do anything, be anyone-the only limits are your own imagination. The OASIS was created by the brilliant and eccentric James Halliday (Mark Rylance), who left his immense fortune and total control of the Oasis to the winner of a three-part contest he designed to find a worthy heir. When Wade conquers the first challenge of the reality-bending treasure hunt, he and his friends-aka the High Five-are hurled into a fantastical universe of discovery and danger to save the OASIS.")
    ]
    
    private let previusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = .gray
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtonControls()

        collectionView?.backgroundColor = .white
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView.isPagingEnabled = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            if self.pageControl.currentPage == 0 {
                self.collectionView.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            
            
        }) { (_) in
            
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        let indexPage = Int(x / view.frame.width)
        pageControl.currentPage = indexPage
        
        print(x, view.frame.width, x / view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Is important to make a cast to your type of cell, to use the variables inside
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
//        cell.backgroundColor = pageColor[indexPath.item]
//        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .blue
        
//        let imageName = imageNames[indexPath.item]
//        cell.posterImageView.image = UIImage(named: imageNames[indexPath.item])
//        cell.resumeTextView.text = filmNames[indexPath.item]
        
        let page = pages[indexPath.item]
//        cell.posterImageView.image = UIImage(named: page.imageName)
//        cell.resumeTextView.text = page.filmName
        cell.page = page
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
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
    
    @objc private func handleNext(){
        print("Trying to next")
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handlePrev(){
        print("Trying to prev")
        let prevIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevIndex, section: 0)
        pageControl.currentPage = prevIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
