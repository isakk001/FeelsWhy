//
//  ContentView.swift
//  FeelsWhy
//
//  Created by Yisak on 2023/08/19.
//

import SwiftUI
import UIKit
import FSCalendar
import CoreData


struct CalendarView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // Added a @State var to track the selected date by user
    @State var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            // Passing the selectedDate as Binding
            CalendarViewRepresentable(selectedDate: $selectedDate)
                .padding(.vertical, 25)
        }
        .padding(50)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct CalendarViewRepresentable: UIViewRepresentable {
    typealias UIViewType = FSCalendar
    
    // Creating a object of FSCalendar to track across the view
    fileprivate var calendar = FSCalendar()
    // Getting selectedDate as a Binding so that we can update it as
    // user changes their selection
    @Binding var selectedDate: Date

    func makeUIView(context: Context) -> FSCalendar {
        // Setting delegate and dateSource of calendar to the
        // values we get from Coordinator
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        // returning the intialized calendar
        calendar.appearance.headerTitleFont = .systemFont(
            ofSize: 30,
            weight: .black)
        calendar.appearance.headerTitleColor = .darkGray
        calendar.appearance.headerDateFormat = "MMMM"
        calendar.scrollDirection = .horizontal
        calendar.scope = .month
        
        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        var parent: CalendarViewRepresentable

        init(_ parent: CalendarViewRepresentable) {
            self.parent = parent
        }
        // Implementing the didSelect method of FSCalendar
        // this is fired with the new date when user selects a new date
        // in the Calendar UI, we are setting our selectedDate Binding
        // var to this new date when this is triggered
        func calendar(_ calendar: FSCalendar,
                      didSelect date: Date,
                      at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
        }
    }
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
