//
//  RoutineDataManager.swift
//  DailyRoutine
//
//  Created by minii on 2021/05/07.
//

import CoreData
import UIKit

class RoutineDataManager {
    // single ton
    static var shared = RoutineDataManager()
    
    /*
    1. NSManagedObjectContext를 가져온다.
    2. 먼저 Entity를 가져온다! 내가 어느 Entity에 저장해야하는지 알아야하니까..!!
    3. NSManagedObject를 만든다.
    4. NSManagedObject에 값을 세팅해준다.
    5. NSManagedObjectContext를 저장해준다.
    */
    
    func save(routine: RoutineInfo) {
        
        // 2. 먼저 Entity를 가져온다! 내가 어느 Entity에 저장해야하는지 알아야하니까..!!
        let entity = NSEntityDescription.entity(forEntityName: "Routine", in: self.context)
        
        if let entity = entity {
            // 3. NSManagedObject를 만든다.
            let routineObject = NSManagedObject(entity: entity, insertInto: self.context)
            // 4. NSManagedObject에 값을 세팅해준다.
            routineObject.setValue(routine.name, forKey: "name")
            routineObject.setValue(routine.totalcount, forKey: "totalcount")
            routineObject.setValue(routine.image, forKey: "image")
            routineObject.setValue(routine.color, forKey: "color")
            routineObject.setValue(routine.date, forKey: "date")
        }
        
        do {
            try self.context.save()
            print("save success!!")
        } catch {
            print("save error ...")
        }
    }
    
    func saveDateList(date: Date, datelist: [String]) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Routine")
        fetchRequest.predicate = NSPredicate(format: "date == %@", date as NSDate)
        
        do {
            let test = try self.context.fetch(fetchRequest)
            if test.count == 0 {
                print("no data? not found data?")
                return
            }
            let objectToUpdate = test[0] as! NSManagedObject
            objectToUpdate.setValue(datelist, forKey: "datelist")
            
            do {
                try self.context.save()
                print("save datelist success!!")
            } catch {
                print("error111 failed update ")
            }
            
        } catch {
            print("error222 failed update")
        }
    }
    
    // 날짜순으로 정렬해서 들고오기 기능 추가?
    func read() -> [Routine] {
        do {
            let result = try self.context.fetch(Routine.fetchRequest()) as [Routine]
            return result
        } catch {
            print("read error ...")
            return []
        }
    }
    
    func LoadCalendar() -> [CalendarInfo]? {
        do {
            let result = try self.context.fetch(Routine.fetchRequest()) as [Routine]
            var data: [CalendarInfo] = []
            for i in result {
                if let datelist = i.datelist {
                    data.append(CalendarInfo(color: i.color, datelist: datelist))
                }
            }
            
            if data.count == 0 {
                return nil
            } else {
                return data
            }
            
        } catch {
            print("read error ...")
            return nil
        }
    }
    
    // 같은날짜로 검색해서 업데이트
    func update(date: Date, routine: RoutineInfo) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Routine")
        fetchRequest.predicate = NSPredicate(format: "date == %@", date as NSDate)
        
        do {
            let test = try self.context.fetch(fetchRequest)
            if test.count == 0 {
                print("no data? not found data?")
                return
            }
            let objectToUpdate = test[0] as! NSManagedObject
            objectToUpdate.setValue(routine.name, forKey: "name")
            objectToUpdate.setValue(routine.totalcount, forKey: "totalcount")
            objectToUpdate.setValue(routine.image, forKey: "image")
            objectToUpdate.setValue(routine.color, forKey: "color")
            // 다시 현재날짜로 저장
            objectToUpdate.setValue(routine.date, forKey: "date")
            objectToUpdate.setValue(nil, forKey: "datelist")
            
            do {
                try self.context.save()
                print("update success!!")
            } catch {
                print("error111 failed update ")
            }
            
        } catch {
            print("error222 failed update")
        }
    }
    
    // 같은 날짜로 검색한후 삭제
    func delete(date: Date) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Routine")
        fetchRequest.predicate = NSPredicate(format: "date == %@", date as NSDate)
        
        do {
            let test = try self.context.fetch(fetchRequest)
            if test.count == 0 {
                print("no data? not foud data?")
                return
            }
            let objectToDelete = test[0] as! NSManagedObject
            self.context.delete(objectToDelete)
            try self.context.save()
            print("delete success!!")
            
        } catch {
            print("error... failed delete")
            
        }
    }
    
    // data 개수 반환
    func count() -> Int? {
        do {
            let count = try self.context.count(for: Routine.fetchRequest())
            return count
        } catch {
            return nil
        }
    }
    
    // CoreData 설정
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "RoutineModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // 1. NSManagedObjectContext를 가져온다.
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
}
