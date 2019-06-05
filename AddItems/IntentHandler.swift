//
//  IntentHandler.swift
//  AddItems
//
//  Created by Jelisha De La Cruz on 5/6/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Intents

let sharedUserDefaults = UserDefaults(suiteName: "group.com.UTS.GroceryList.Shared")

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        
        return self
    }
    
    func createTasks(fromTitles taskTitles: [String]) -> [INTask] {
        var tasks : [INTask] = []
        tasks = taskTitles.map {
            taskTitle -> INTask in
            let task = INTask(title: INSpeakableString(spokenPhrase: taskTitle),
                              status: .notCompleted,
                              taskType: .completable,
                              spatialEventTrigger: nil,
                              temporalEventTrigger: nil,
                              createdDateComponents: nil,
                              modifiedDateComponents: nil,
                              identifier: nil)
            return task
        }
        return tasks
    }
    
}

extension IntentHandler : INAddTasksIntentHandling {
    
    public func handle(intent: INAddTasksIntent, completion: @escaping (INAddTasksIntentResponse) -> Void) {
       
//        let taskList = intent.targetTaskList
        guard var currentGroceryList = sharedUserDefaults?.stringArray(forKey: "groceryList") else { return }
        
        //apend current grocery list with the task titles string array
        //update user defaults with new array
        
//        var tasks : [INTask] = []
        if let taskTitles = intent.taskTitles {
            let taskTitlesStrings = taskTitles.map {
                taskTitle -> String in
                return taskTitle.spokenPhrase
            }
//            tasks = createTasks(fromTitles: taskTitlesStrings)
//            AddingHelper.sharedInstance.add(items: taskTitlesStrings)
            currentGroceryList += taskTitlesStrings
            
            sharedUserDefaults?.set(currentGroceryList, forKey: "groceryList")
        }
        
        let response = INAddTasksIntentResponse(code: .success, userActivity: nil)
        response.modifiedTaskList = intent.targetTaskList
        completion(response)
    }
}