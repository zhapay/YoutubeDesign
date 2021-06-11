//
//  VideoCell.swift
//  YoutubeDesign
//
//  Created by Dastan Zhapay on 06.06.2021.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    func setupViews(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BaseCell {
    
    var video: Video?{
        didSet{
            guard let title = video?.title else {return}
            
            titleLabel.text = title
            setupThumbnailImage()
            setupProfileImage()
//            thumbNailImageView.image = UIImage(named: (video?.thumbnailImageName)!)
            
//            if let profileImage = video?.channel?.profileImageName{
//                userImageView.image = UIImage(named: profileImage)
//            }
            if let subtitleText = video?.channel?.name, let numberOfViews = video?.numberOfViews{
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let subttle = "\(subtitleText) - \(String(describing: numberFormatter.string(from: numberOfViews)!)) - 2 years ago"
                subtitleTextView.text = subttle
            }
        }
    }
    
    private func setupProfileImage(){
        if let profileImageUrl = video?.channel?.profileImageName{
            userImageView.loadImagesUsingUrl(urlString: profileImageUrl)
        }
    }
    
    private func setupThumbnailImage(){
        if let thumbnailImageUrl = video?.thumbnailImageName{
            thumbNailImageView.loadImagesUsingUrl(urlString: thumbnailImageUrl)
        }
    }
    
    let thumbNailImageView: CustomImageView = {
       let image = CustomImageView()
        image.image = UIImage(named: "selenagomez")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let seperatorView: UIView = {
       let view = UIView()
        view.backgroundColor = .seperatorLineColor
        return view
    }()
    
    let userImageView: CustomImageView = {
       let image = CustomImageView()
        image.image = UIImage(named: "camillacabello")
        image.layer.cornerRadius = 22
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Selena Gomez - Lose You To Love Me"
        return label
    }()
    
    let subtitleTextView: UITextView = {
       let textView = UITextView()
        textView.text = "TaylorSwiftVEVO - 1,123,456,000 views - 2 years"
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)
        textView.textColor = .gray
        return textView
    }()
    
    override func setupViews(){
        
        contentView.addSubview(thumbNailImageView)
        contentView.addSubview(seperatorView)
        contentView.addSubview(userImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleTextView)
        
        setupConstraints()

    }
    
    private func setupConstraints(){
        thumbNailImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(userImageView.snp.top).offset(-8)
            
        }
        seperatorView.snp.makeConstraints { (make) in
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(1.5)
            make.top.equalTo(contentView.snp.bottom)
        }
        userImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(44)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
            make.left.equalTo(thumbNailImageView.snp.left)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userImageView.snp.top)
            make.right.equalTo(thumbNailImageView.snp.right)
            make.left.equalTo(userImageView.snp.right).offset(8)
            make.height.equalTo(20)
        }
        
        subtitleTextView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(titleLabel.snp.right)
            make.height.equalTo(titleLabel.snp.height)
            make.bottom.equalTo(userImageView.snp.bottom)
        }
    }
    
}


