//
//  ViewController.swift
//  YoutubeDesign
//
//  Created by Dastan Zhapay on 05.06.2021.
//

import UIKit
import SnapKit

class NavigationBar: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    private let trendingCellId = "cellId"
    let titles = ["Home", "Trending", "Subscriptions", "Accounts"]
    var videos: [Video]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarStyle()
        configureNav()
        configureCollectionView()
        setupMenuBar()
    
    }
    
    private func configureNav(){
        navigationItem.title = "Home"
        
        let share = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearch))
        let add = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(handleMoreIcon))
        navigationItem.rightBarButtonItems = [add, share]
    }
    
    @objc private func handleSearch(){
        //scrollToMenuIndex(menuIndex: 2)
    }
    
    func scrollToMenuIndex(menuIndex: Int){
//        let indexPathh = NSIndexPath(item: menuIndex, section: 0)
//        collectionView?.scrollToItem(at: indexPathh as IndexPath, at: .centeredHorizontally, animated: true)
        
        setTitleForIndex(index: Int(menuIndex))
    }
    
    private func setTitleForIndex(index: Int){
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index]) "
        }
    }
    
    lazy var settingLauncher: SettingLauncher = {
       let launcher = SettingLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc private func handleMoreIcon(){
        settingLauncher.showSettings()
    }
    
    func showControllerForSetting(setting: Setting){
        let justViewController = UIViewController()
        justViewController.navigationItem.title = setting.name
        justViewController.view.backgroundColor = .white
        setupNavBarStyle()
        navigationController?.pushViewController(justViewController, animated: true)
    }

    
    private func configureCollectionView(){
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView.isPagingEnabled = true
    }
    
    lazy var menuBar: MenuBar = {
       let menuBar = MenuBar()
        menuBar.homeController = self
        return menuBar
    }()
    
    let redView: UIView = {
       let view = UIView()
        view.backgroundColor = .navBarColor
        return view
    }()
    
    private func setupMenuBar(){
        navigationController?.hidesBarsOnSwipe = true
        
        view.addSubview(redView)
        view.addSubview(menuBar)
        
        constraintsMenubar()
    }
    
    private func constraintsMenubar(){
        menuBar.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(50)
        }
        
        redView.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.height.equalTo(50)
        }
    }

}

//MARK: CollectionView DataSource,Delegate
extension HomeController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 1 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: trendingCellId, for: indexPath)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 100)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeft?.constant = scrollView.contentOffset.x / 4
    }
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = (targetContentOffset.pointee.x) / view.frame.width
        let indexPathh = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPathh as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
        
        setTitleForIndex(index: Int(index))
    }
}

