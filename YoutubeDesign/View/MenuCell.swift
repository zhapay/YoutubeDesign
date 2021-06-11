//
//  MenuCell.swift
//  YoutubeDesign
//
//  Created by Dastan Zhapay on 06.06.2021.
//

import UIKit

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "selenagomez")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .menuTintColor
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    override var isHighlighted: Bool{
        didSet{
            imageView.tintColor = isHighlighted ? .white : UIColor.menuTintColor
        }
    }
    
    override var isSelected: Bool{
        didSet{
            imageView.tintColor = isSelected ? .white : .menuTintColor
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        
        contentView.addSubview(imageView)
        
        imageConstraints()
        
    }
    
    private func imageConstraints(){
        imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(28)
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
}
