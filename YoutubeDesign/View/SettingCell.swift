//
//  SettingCell.swift
//  YoutubeDesign
//
//  Created by Dastan Zhapay on 07.06.2021.
//

import UIKit
import SnapKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLaabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting: Setting?{
        didSet{
            nameLaabel.text = setting?.name
            
            if let imageName = setting?.imageName{
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    let nameLaabel: UILabel = {
       let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let iconImageView: UIImageView = {
       let imgv = UIImageView()
        //imgv.image = UIImage(named: "account")
        imgv.contentMode = .scaleAspectFill
        return imgv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubview(nameLaabel)
        contentView.addSubview(iconImageView)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        nameLaabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(8)
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(8)
            make.height.width.equalTo(30)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
}
