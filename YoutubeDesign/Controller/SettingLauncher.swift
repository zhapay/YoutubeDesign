//
//  SettingLauncher.swift
//  YoutubeDesign
//
//  Created by Dastan Zhapay on 06.06.2021.
//

import UIKit
import SnapKit

class SettingLauncher: NSObject {
    
    private let cellId = "cellId"
    let blackView = UIView()
    let cellHeight: CGFloat = 50
    var homeController: HomeController?
    
    
    var setting = [Setting(name: "Settings", imageName: "settings"),
                   Setting(name: "Terms and privacy", imageName: "terms"),
                   Setting(name: "Feedback", imageName: "feedback"),
                   Setting(name: "Help", imageName: "help"),
                   Setting(name: "Switch account", imageName: "account"),
                   Setting(name: "Cancel", imageName: "cancel")
    ]
    
    
    let collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    override init() {
        super.init()
        
        configureCollectionView()
        
    }
    
    private func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func showSettings(){
        if let window = UIApplication.shared.keyWindow{
        
            blackView.backgroundColor = .windowGrayColor
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(setting.count) * 50
            let y = window.frame.height - 300
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
          
            self.blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss(setting:))))
        }
    }
    
    @objc private func handleDismiss(setting: Setting){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow{
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        } completion: { (completed: Bool) in
            if setting.name != "" && setting.name != "Cancel"{
                self.homeController?.showControllerForSetting(setting: setting)
            }

        }
    }
    
}

//MARK: CV Delegate, DataSource
extension SettingLauncher: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return setting.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        let selectedIndex = setting[indexPath.item]
        cell.setting = selectedIndex
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedIndex = self.setting[indexPath.item]
        handleDismiss(setting: selectedIndex)

    }
    
}
