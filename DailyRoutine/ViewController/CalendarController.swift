//
//  GraphViewController.swift
//  DailyRoutine
//
//  Created by minii on 2021/04/05.
//

import UIKit
import FSCalendar

class CalendarController: UIViewController {
    
    var calendar = FSCalendar()

    let dateFormatter = DateFormatter()
    
    // 달력에 표시할 날짜와 그 루틴에 맞는 UIColor로 구성됨
    var calendarList: [CalendarInfo]? = {
        let calendarList = RoutineDataManager.shared.LoadCalendar()
        return calendarList
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Calendar"
        
        calendar.frame = CGRect(x: 10, y: 100, width: view.frame.width - 20, height: 400)
        calendar.delegate = self
        calendar.dataSource = self
            
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        view.addSubview(calendar)
        view.backgroundColor = .white
        
        // 캘린더 기본 색상 지정
        calendar.appearance.titleSelectionColor = .black
        calendar.appearance.subtitleSelectionColor = .black
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.subtitleTodayColor = .black
        calendar.appearance.eventDefaultColor = .white
        calendar.appearance.todayColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadCalendarData), name: .loadcalendar, object: nil)
        
//        테스트 버튼 추가
//        createButton()
    }
    
    @objc func loadCalendarData() {
        self.calendarList = RoutineDataManager.shared.LoadCalendar()
        calendar.reloadData()
    }
    
    // calendarList에서 date만 뽑아내오기
    func onlydatelist() -> [String]? {
        var alldatelist = Set<String>()
        if let calendarList = calendarList {
            for i in calendarList {
                for j in i.datelist {
                    alldatelist.insert(j)
                }
            }
            let onlydatelist = Array(alldatelist)
            return onlydatelist
        } else {
            return nil
        }
    }
    
    // calendarList에서 color만 뽑아내오기
    func onlycolorlist() -> [UIColor]? {
        var allcolorlist = Set<UIColor>()
        if let calendarList = calendarList {
            for i in calendarList {
                guard let color = UIColor.color(data: i.color) else {
                    print("nocolor..")
                    return nil
                }
                allcolorlist.insert(color)
            }
            let onlycolorlist = Array(allcolorlist)
            return onlycolorlist
        } else {
            return nil
        }
    }
    
//    // 테스트 버튼 추가하기
//    func createButton() {
//        let button = UIButton()
//        self.view.addSubview(button)
//
//        button.setTitle("새로고침", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.backgroundColor = .link
//
//        button.frame = CGRect(x: 50, y: calendar.bottom + 30, width: 100, height: 30)
//
//        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//    }
//
//    @objc func didTapButton() {
//        calendarList = RoutineDataManager.shared.LoadCalendar()
//        self.calendar.reloadData()
//        print(calendarList)
//    }
    
}

extension CalendarController: FSCalendarDelegateAppearance, FSCalendarDelegate, FSCalendarDataSource {
    // 맞는 날짜에 표시할 Color 배열형태로 리턴
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        
        let key = self.dateFormatter.string(from: date)
        //
        if let datelist = onlydatelist(),
           let color = onlycolorlist() {
            
            if datelist.contains(key) {
                return color
            }
        }
        return nil
    }
    
    // 표시할 컬러 갯수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if let calendarList = calendarList {
            return calendarList.count
        } else {
            return 0
        }
    }
}
