//
//  ContentView.swift
//  To-Do List App
//
//  Created by Ishaaq Ahmed on 19/10/2024.
//

import SwiftUI

struct CheckboxItem :Hashable{
    var title: String
    var isChecked: Bool
    
}

struct ContentView: View {
    @State var list: [CheckboxItem] = []
    @State private var isAddingItem: Bool = false
    @State var item: String = ""
    @State var isChecked: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView{
            Form{
                Section (header: Text("Add a New Task, testing")){
                    Button("New item", systemImage: "plus.circle"){
                        isAddingItem = true
                        isTextFieldFocused = true
                    }
                    
                    
                    if (isAddingItem){
                        TextField("Type a new item", text: $item)
                            .padding()
                            .focused($isTextFieldFocused)
                            .onSubmit{addNewItem()}
                            .onChange(of: item, initial: true) { oldValue, newValue in
                                if (!newValue.isEmpty && !isAddingItem){
                                    addNewItem()
                                }
                            }
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("Add a item") {
                                        addNewItem()
                                    }
                                }
                            }
                    }
                    
                }
                if (!list.isEmpty){
                    Section(header: Text("Displaying Items")){
                        ForEach($list, id: \.self){ item in
                            HStack{
                                Toggle(isOn: item.isChecked) {
                                    Text(item.wrappedValue.title)
                                }
                                //Text(item.title)
                            }
                        }
                    }
                }
                
                
                Section(header: Text("Completed Items")){
                    Button("Clear Completed", action: removeCompletedItems)
                        .foregroundColor(.red)
                    
                }
                
            }
            .navigationTitle("Checkbox List")
        }
        
        
    }
    
    private func addNewItem() {
        isAddingItem = false
        list.append(CheckboxItem(title: item, isChecked: false))
        if let lastItem = list.last {
            print("Item: \(lastItem.title)")
        }
        item = ""
    }
    private func removeCompletedItems() {
        list.removeAll { $0.isChecked }
    }
    private func removeCompleteditem(){
        list.removeAll { $0.isChecked }
        print(list)
    }
}

#Preview {
    ContentView()
}
