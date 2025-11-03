import Foundation

class DataManager {
    private let tasksKey = "savedTasks"
    
    func saveTasks(_ tasks: [TodoList]) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(tasks)
            UserDefaults.standard.set(encodedData, forKey: tasksKey)
            print("✅ Сохранено задач: \(tasks.count)")
        } catch {
            print("❌ Ошибка сохранения: \(error)")
        }
    }
    
    func loadTasks() -> [TodoList] {
        guard let data = UserDefaults.standard.data(forKey: tasksKey) else {
            print("📭 Нет сохраненных данных")
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            let tasks = try decoder.decode([TodoList].self, from: data)
            print("✅ Загружено задач: \(tasks.count)")
            return tasks
        } catch {
            print("❌ Ошибка загрузки: \(error)")
            return []
        }
    }
    
    func getTasks() -> [TodoList] {
        return loadTasks()
    }
}
