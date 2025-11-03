import Foundation
import Combine

class TodoListViewModel: ObservableObject {
    @Published var tasks: [TodoList] = []
    private var dataManager = DataManager()
    
    init() {
        loadTasks()
    }
    
    func loadTasks() {
        tasks = dataManager.loadTasks()
        // Если нет сохраненных данных, добавляем тестовые
        if tasks.isEmpty {
            tasks = [
                TodoList(title: "Добро пожаловать!"),
                TodoList(title: "Добавь свою первую задачу")
            ]
        }
    }
    
    func addTask(title: String) {
        let newTask = TodoList(title: title)
        tasks.append(newTask)
        dataManager.saveTasks(tasks)  // ← РАСКОММЕНТИРУЙ
    }
    
    func deleteTask(at index: Int) {
        tasks.remove(at: index)
        dataManager.saveTasks(tasks)  // ← РАСКОММЕНТИРУЙ
    }
    
    func toggleTask(task: TodoList) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            dataManager.saveTasks(tasks)  // ← РАСКОММЕНТИРУЙ
        }
    }
}
