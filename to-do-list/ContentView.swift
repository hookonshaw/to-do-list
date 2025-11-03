import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TodoListViewModel()
    @State private var showingAddAlert = false
    @State private var newTaskTitle = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) { task in
                    HStack {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(task.isCompleted ? .green : .gray)
                            .imageScale(.large)
                        
                        Text(task.title)
                            .strikethrough(task.isCompleted, color: .gray)
                            .foregroundColor(task.isCompleted ? .gray : .primary)
                        
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.toggleTask(task: task)
                    }
                }
                .onDelete(perform: { indexSet in
                    if let index = indexSet.first {
                        viewModel.deleteTask(at: index)
                    }
                })
            }
            .navigationTitle("Мои задачи")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddAlert = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("Новая задача", isPresented: $showingAddAlert) {
                TextField("Введите задачу", text: $newTaskTitle)
                Button("Добавить") {
                    if !newTaskTitle.trimmingCharacters(in: .whitespaces).isEmpty {
                        viewModel.addTask(title: newTaskTitle)
                        newTaskTitle = ""
                    }
                }
                Button("Отмена", role: .cancel) {
                    newTaskTitle = ""
                }
            } message: {
                Text("Добавьте новую задачу в список")
            }
        }
        .onAppear {
            viewModel.loadTasks()
        }
    }
}



#Preview {
    ContentView()
}
