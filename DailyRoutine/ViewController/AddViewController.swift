//
//  AddViewController.swift
//  DailyRoutine
//
//  Created by minii on 2021/04/03.
//

import UIKit

class AddViewController: UIViewController {
    
    let addView = AddView()
    
    let pickerNumber: Array<Int> = {
        var number = [Int]()
        number.append(contentsOf: stride(from: 1, through: 100, by: 1))
        return number
    }()
    
    // MARK:- viewDidLoad 부분
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(addView)
        addView.frame = view.bounds
        //     scrollView 세로길이 동적 구하기
        //     UIView 구성요소들 추가될때마다 넣어주기..
        addView.contentView.bottomAnchor.constraint(equalTo: addView.colorButton.bottomAnchor, constant: 1000).isActive = true
        
        // '추가하기' 이름의 버튼 오른쪽 네비게이션버튼으로 할당, 탭 제스쳐 넣기
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가하기", style: .done, target: self, action: #selector(didTapaddButton))
        
        // colorButton 탭 제스쳐 추가
        addView.colorButton.isUserInteractionEnabled = true
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(didTapcolorButton))
        gesture1.numberOfTapsRequired = 1
        addView.colorButton.addGestureRecognizer(gesture1)
        
        // imageView 탭 제스쳐 추가
        addView.imageView.isUserInteractionEnabled = true
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(didTapRoutineImage))
        gesture2.numberOfTapsRequired = 1
        addView.imageView.addGestureRecognizer(gesture2)
        
        // routineCount에 pickerView 띄우기
        createPickerView()
        dismissPickerView()
        
        // 리턴키 누를시 delegate 설정, 키보드내리기
        addView.nameField.delegate = self
    }
    
    // 이미지 눌렀을때 photopicker 호출
    @objc func didTapRoutineImage() {
        presentPicActionSheet()
    }
    
    // 색상버튼 눌렀을때 colorpicker 호출
    @objc func didTapcolorButton() {
        presentPicker()
    }
    
    // addButton 누르기, addViewModel의 createRoutine 호출
    @objc func didTapaddButton() {
        createRoutine()
    }
}

// MARK:- extension들 ..

// imageView 이미지 변경하기
extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentPicActionSheet() {
        // actionSheet 보여줌 사진고르기, 사직찍기 기능추가
        let actionSheet = UIAlertController(title: "루틴 사진 고르기", message: "사진을 골라주세요!", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "사진찍기", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "사진 고르기", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true)
    }
    
    // 카메라 호출 함수
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    // 사진 라이브러리에서 고르기
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    // 선택한 이미지 imageView에 업데이트
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        addView.imageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// colorButton 색상변경
extension AddViewController: UIColorPickerViewControllerDelegate {
    func presentPicker() {
        let vc = UIColorPickerViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        addView.colorButton.backgroundColor = viewController.selectedColor
    }
}

// 추가하기 버튼 누를때..
extension AddViewController {
    func createRoutine() {
        // 키보드 내리기
        addView.nameField.resignFirstResponder()
        addView.routineCountTextField.resignFirstResponder()
        
        guard let name = addView.nameField.text,
              let count = addView.routineCountTextField.text,
              let image = addView.imageView.image,
              let color = addView.colorButton.backgroundColor,
              !name.isEmpty,
              !count.isEmpty
        else {
            alertRegisterError()
            return
        }
        
        guard let isintcount = Int(count) else {
            print("is not int...")
            return
        }
        
        let addroutineinfo = RoutineInfo(name: name, totalcount: isintcount, image: image.pngData()!, color: color.encode()!)
        
        RoutineDataManager.shared.save(routine: addroutineinfo)
        print("save routine!!!")
        reset()
        NotificationCenter.default.post(name: .add, object: addroutineinfo.date)
        alertRegistered()
    }
    
    func reset() {
        addView.nameField.text = ""
        addView.imageView.image = UIImage(systemName: "person.badge.plus")
        addView.colorButton.backgroundColor = .white
        addView.routineCountTextField.text = ""
    }
    
    func alertRegisterError() {
        let alert = UIAlertController(title: "빈칸을 모두 채워주세요...", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "돌아가기", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func alertRegistered() {
        let alert = UIAlertController(title: "저장되었습니다!", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "돌아가기", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// pickerview 설정
extension AddViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerNumber.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerNumber[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        addView.routineCountTextField.text = String(pickerNumber[row])
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        addView.routineCountTextField.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        let button = UIBarButtonItem(title: "선택하기", style: .plain, target: self, action: #selector(self.dismissPicker))
        let rightbutton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([rightbutton, button], animated: true)
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        addView.routineCountTextField.inputAccessoryView = toolBar
    }
    
    // pickerView 끄기
    @objc func dismissPicker() {
        addView.routineCountTextField.resignFirstResponder()
    }
}

// 엔터키 누를시 키보드 내리기
extension AddViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == addView.nameField {
            addView.nameField.resignFirstResponder()
        }
        return true
    }
}
