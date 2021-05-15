//
//  HomeViewController.swift
//  DailyRoutine
//
//  Created by minii on 2021/04/02.
//

import UIKit

class HomeViewController: UIViewController {
    
    var routineList: [Routine] = {
        let routineList = RoutineDataManager.shared.read()
        return routineList
    }()
    
    // noti의 object로 데이터 받아오기
    // 루틴횟수증가는 간단하게 딕셔너리로 로컬변수에만 저장
    var countUpDic = [Date : Int]()
    
    // 편집모드 활성화
    var editmode: Bool = false
    
    // dateformatter 설정
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "DailyRoutine"
        view.backgroundColor = .white
        
        view.addSubview(homeCollectionView)

        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self

        homeCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        setupCollectionConstraints()
        
        // NotificationCenter에 관찰자 추가
        NotificationCenter.default.addObserver(self, selector: #selector(addReloadView), name: .add, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteReloadView), name: .delete, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateReloadView), name: .update, object: nil)
        
        // 편집모드 기능 추가
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "편집모드", style: .plain, target: self, action: #selector(didTapEditButton))
        
        // 딕셔너리로 간단하게 루틴카운트 세기
        setUpDic()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
    }
    
    // 딕셔너리 초기화
    func setUpDic() {
        for i in routineList {
            countUpDic[i.date] = 0
        }
    }
    
    // 딕셔너리 삭제
    // 루틴 저장한 날짜를 키값으로 사용
    func deleteDic(date: Date) {
        for (key, value) in countUpDic {
            if key == date {
                countUpDic.removeValue(forKey: key)
            }
        }
    }

    // 딕셔너리 값추가
    func insertDic(date: Date) {
        countUpDic[date] = 0
    }

    // 딕셔너리 수정
    func updateDic(oldDate: Date, newDate: Date) {
        deleteDic(date: oldDate)
        insertDic(date: newDate)
    }
    
    // 루틴 추가되었을때
    @objc func addReloadView(_ notification : NSNotification) {
        self.routineList = RoutineDataManager.shared.read()
        let data = notification.object as! Date
        insertDic(date: data)
        self.homeCollectionView.reloadData()
    }
    
    // 루틴 삭제되었을때
    @objc func deleteReloadView(_ notification : NSNotification) {
        self.routineList = RoutineDataManager.shared.read()
        let data = notification.object as! Date
        deleteDic(date: data)
        self.homeCollectionView.reloadData()
    }
    
    // 루틴 수정되었을때
    @objc func updateReloadView(_ notification : NSNotification) {
        self.routineList = RoutineDataManager.shared.read()
        let dateList = notification.object as! [Date]
        
        if dateList.count != 2 {
            return
        }
        
        updateDic(oldDate: dateList[0], newDate: dateList[1])
        self.homeCollectionView.reloadData()
    }
    
    // 편집모드 버튼 누를시
    @objc func didTapEditButton() {
        self.editmode = true
        self.title = "항목선택"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(didTapCanCelButton))
    }

    // 편집모드를 취소할때(취소버튼 누를시)
    @objc func didTapCanCelButton() {
        self.editmode = false
        self.title = "DailyRoutine"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "편집모드", style: .plain, target: self, action: #selector(didTapEditButton))
    }
    
    let homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    func setupCollectionConstraints() {
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        homeCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        homeCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        homeCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        homeCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

// 콜렉션뷰 셀 개수, 데이터 설정
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routineList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        let name = routineList[indexPath.row].name
        let count = String(routineList[indexPath.row].totalcount)
        let color = UIColor.color(data: routineList[indexPath.row].color)
        let image = UIImage(data: routineList[indexPath.row].image)
        
        guard let countup = countUpDic[routineList[indexPath.row].date] else {
            return cell
        }
        
        cell.name.text = name
        cell.count.text = "\(countup) / \(count)"
        cell.layer.borderColor = color!.cgColor
        cell.image.image = image
        
        return cell
    }
}

// 셀사이즈, 간격, 너비
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    // 셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 20 - 40)/2, height: (view.frame.width - 20 - 40)/2)
    }
    
    // 셀 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // 셀 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // 셀 위,아래,등등 너비
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}


// 셀 터치시
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 편집모드일때
        if editmode {
            
            let rootVC = DetailViewController()
            
            rootVC.returnRoutine = {
                return self.routineList[indexPath.row]
            }
            
            let navVc = UINavigationController(rootViewController: rootVC)
            present(navVc, animated: true)
            
        // 일반모드일때
        } else {
            
            let key = routineList[indexPath.row].date
            let totalcount = routineList[indexPath.row].totalcount
            
            // 루틴 추가된 날짜를 키값으로 맞는 카운트 변수를 찾아서 +1을 해줌
            if let countup = countUpDic[key] {
                countUpDic[key] = countup + 1
            }
            
            if let countup = countUpDic[key], countup == totalcount  {
                let alert = UIAlertController(title: "축하합니다!", message: "루틴횟수를 모두 채우셨습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "돌아가기", style: .cancel, handler: { _ in
                    self.countUpDic[key] = 0
                    self.homeCollectionView.reloadData()
                }))
                present(alert, animated: true, completion: nil)
                
                // 루틴횟수를 모두 채우면 현재시간을 "yyyy-MM-dd"로 변환하고
                // datelist를 불러와서 Set으로 중복제거후 Array로 변환하여 값 다시 저장
                var datelist = routineList[indexPath.row].datelist ?? []
                datelist.append(dateFormatter.string(from: Date()))
                let setdatelist: Set = Set(datelist)
                datelist = Array(setdatelist)
                
                print(datelist)
                
                RoutineDataManager.shared.saveDateList(date: key, datelist: datelist)
                
                NotificationCenter.default.post(name: .loadcalendar, object: nil)
            }
            
            self.homeCollectionView.reloadData()
            
            
        }
    }
}

// Notification 이름 설정
extension Notification.Name {
    static let add = Notification.Name("Add")
    static let update = Notification.Name("update")
    static let delete = Notification.Name("delete")
    static let loadcalendar = Notification.Name("loadcalendar")
}
