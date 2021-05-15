//
//  AddView.swift
//  DailyRoutine
//
//  Created by minii on 2021/04/30.
//

import UIKit

class AddView: UIScrollView {
    // MARK:- 입력필드들 설정
    
    let contentView: UIView =  {
        let contentView = UIView()
        return contentView
    }()
    
    // 루틴이름 라벨
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "루틴이름"
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    // 루틴이름입력 텍스트필드
    let nameField: UITextField = {
        let nameField = UITextField()
        // 자동 텍스트 수정
        nameField.autocorrectionType = .no
        nameField.layer.borderWidth = 1
        nameField.layer.cornerRadius = 12
        nameField.layer.borderColor = UIColor.lightGray.cgColor
        nameField.backgroundColor = .white
        nameField.placeholder = "이름을 입력하세요..."
        nameField.addLeftPadding()
        return nameField
    }()
    
    // 루틴이미지 라벨
    let imageLabel: UILabel = {
        let imageLabel = UILabel()
        imageLabel.text = "이미지 선택"
        imageLabel.textColor = .black
        imageLabel.textAlignment = .center
        return imageLabel
    }()
    
    // 루틴이미지 선택
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.badge.plus")
        return imageView
    }()
    
    // 루틴색상 라벨
    let colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.text = "색상 선택"
        colorLabel.textColor = .black
        colorLabel.textAlignment = .center
        return colorLabel
    }()
    
    // 루틴색상 선택
    let colorButton: UIButton = {
        let colorButton = UIButton()
        colorButton.backgroundColor = .white
        colorButton.layer.borderWidth = 2
        colorButton.layer.borderColor = UIColor.black.cgColor
        return colorButton
    }()
    
    // 루틴횟수 라벨
    let routineCountLabel: UILabel = {
        let routineCountLabel = UILabel()
        routineCountLabel.text = "루틴횟수"
        routineCountLabel.textColor = .black
        routineCountLabel.textAlignment = .center
        return routineCountLabel
    }()
    
//     루틴 횟수
    let routineCountTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = .white
        // 커서 제거
        textField.tintColor = .clear
        textField.placeholder = "목표 횟수를 입력하세요..."
        textField.addLeftPadding()
        return textField
    }()

    // View 레이아웃 설정
    func set() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        nameField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -100).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        routineCountLabel.translatesAutoresizingMaskIntoConstraints = false
        routineCountLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        routineCountLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20).isActive = true
        routineCountLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        routineCountLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        routineCountTextField.translatesAutoresizingMaskIntoConstraints = false
        routineCountTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        routineCountTextField.topAnchor.constraint(equalTo: routineCountLabel.bottomAnchor, constant: 10).isActive = true
        routineCountTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -100).isActive = true
        routineCountTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        imageLabel.topAnchor.constraint(equalTo: routineCountTextField.bottomAnchor, constant: 30).isActive = true
        imageLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        imageLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 10).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.topAnchor.constraint(equalTo: routineCountTextField.bottomAnchor, constant: 30).isActive = true
        colorLabel.centerXAnchor.constraint(equalTo: colorButton.centerXAnchor).isActive = true
        colorLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        colorLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 10).isActive = true
        colorButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 20).isActive = true
        colorButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        colorButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        // coloButton 원으로 만들기
        colorButton.clipsToBounds = true
        colorButton.layer.cornerRadius = 50
        
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameField)
        contentView.addSubview(routineCountLabel)
        contentView.addSubview(routineCountTextField)
        contentView.addSubview(imageLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(colorLabel)
        contentView.addSubview(colorButton)
        
        set()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- extension 들..

// UIView frame 편리하게 접근하기
extension UIView {
    public var width: CGFloat {
        return self.frame.size.width
    }
    public var height: CGFloat {
        return self.frame.size.height
    }
    public var top: CGFloat {
        return self.frame.origin.y
    }
    public var bottom: CGFloat{
        return self.frame.size.height + self.frame.origin.y
    }
    public var left: CGFloat {
        return self.frame.origin.x
    }
    public var right: CGFloat{
        return self.frame.size.width + self.frame.origin.x
    }
}

// left padding 효과
extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
