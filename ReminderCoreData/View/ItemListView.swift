//
//  ItemListView.swift
//  ReminderCoreData
//
//  Created by KANISHK VIJAYWARGIYA on 04/12/21.
//

import SwiftUI

struct ItemListView: View {
    @EnvironmentObject private var viewModel: ReminderViewModel
    @State private var showAddItem = false
    private var _category: Category
    
    init(category: Category) {
        self._category = category
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            List {
                ForEach(viewModel.items, id: \.id) { item in
                    ItemCell(itemCellVM: ItemCellViewModel(viewModel: viewModel, item: item))
                }
                .onDelete(perform: self.removeRow)
                
                if showAddItem {
                    ItemCell(itemCellVM: ItemCellViewModel(viewModel: viewModel, item: viewModel.newItem()))
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            HStack {
                Button(action: {showAddItem.toggle()}) {
                    if showAddItem {
                        Button(action: {showAddItem.toggle()}) {
                            Text("Done")
                        }
                        .padding()
                    } else {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                            
                            Text("New Item")
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationBarTitle(_category.name)
        .onAppear {
            viewModel.category = _category
        }
    }
    
    private func removeRow(at offsets: IndexSet) {
        for offset in offsets {
            let item = viewModel.items[offset]
            viewModel.deleteItem(item)
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(category: Category())
    }
}
