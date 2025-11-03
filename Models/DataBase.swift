import Foundation


struct TodoList: Codable, Identifiable{
    let id = UUID()
    var title: String
    var isCompleted = false
}
