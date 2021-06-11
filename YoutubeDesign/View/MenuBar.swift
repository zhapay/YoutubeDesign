//
//  MenuBar.swift
//  YoutubeDesign
//
//  Created by Dastan Zhapay on 06.06.2021.
//

import UIKit
import SnapKit

class MenuBar: UIView{
    
    private let cellId = "cellId"
    var homeController: HomeController?
    var imageNames = ["home", "subscription", "trending", "account"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout )
        cv.backgroundColor = .navBarColor
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let horizontalBarView: UIView = {
       let view = UIView()
        view.backgroundColor = .horizontalBarViewColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        addSubview(horizontalBarView)
        
        configureCollectionView()
        //setupHorizontalBar()
        setupContraintsForHorizontalBar()
    }
    
//    private func setupHorizontalBar(){
//        let horizontalBarView = UIView()
//        horizontalBarView.backgroundColor = .horizontalBarViewColor
//        addSubview(horizontalBarView)
//        setupContraintsForHorizontalBar()
//    }
    
    var horizontalBarLeft: NSLayoutConstraint?
    
    private func setupContraintsForHorizontalBar(){
        horizontalBarView.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right)
            make.height.equalTo(5)
            make.bottom.equalTo(self.snp.bottom)
        }
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarLeft = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeft?.isActive = true
        
    }
    
    private func configureCollectionView(){
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        let selectedIndex = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndex as IndexPath, animated: false, scrollPosition: .top)
        collectionViewConstraints()
    }
    
    private func collectionViewConstraints(){
        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: UICollectionView DataSource, Delegate

extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = .menuTintColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let x = CGFloat(indexPath.item) * frame.width / 4
        horizontalBarLeft?.constant = x

        UIView.animate(withDuration: 0.70, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
        
        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
}
