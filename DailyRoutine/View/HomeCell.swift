//
//  HomeView.swift
//  DailyRoutine
//
//  Created by minii on 2021/05/03.
//

import UIKit

// 커스텀셀
class CustomCell: UICollectionViewCell {
    
    var name: UILabel = {
        let name = UILabel()
        name.text = "test"
        name.textColor = .black
        name.textAlignment = .center
        return name
    }()
    
    var count: UILabel = {
        let count = UILabel()
        count.text = "1"
        count.textColor = .black
        count.textAlignment = .center
        return count
    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "plus.circle")
        return image
    }()
    
    func setLayot() {
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 7
        self.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = .white
        
        let lay = contentView.height/6
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -(lay)).isActive = true
        image.heightAnchor.constraint(equalToConstant: 50).isActive = true
        image.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: lay).isActive = true
        name.heightAnchor.constraint(equalToConstant: 20).isActive = true
        name.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        count.translatesAutoresizingMaskIntoConstraints = false
        count.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        count.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: lay*2).isActive = true
        count.heightAnchor.constraint(equalToConstant: 20).isActive = true
        count.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(image)
        contentView.addSubview(name)
        contentView.addSubview(count)
        
        setLayot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
