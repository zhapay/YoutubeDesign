//
//  Extension+UINavigationBar.swift
//  YoutubeDesign
//
//  Created by Dastan Zhapay on 06.06.2021.
//

import UIKit

extension UIViewController{
    
    func setupNavBarStyle(){
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = .white
        navigationItem.titleView = titleLabel
        
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = .navBarColor
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
        

        
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    
}
