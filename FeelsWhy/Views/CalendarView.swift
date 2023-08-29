//
//  ContentView.swift
//  FeelsWhy
//
//  Created by Yisak on 2023/08/19.
//

import SwiftUI
import FSCalendar
import CoreData
import Combine


struct CalendarView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: FeelsWhy.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \FeelsWhy.selectedDate, ascending: false) ])
    var items: FetchedResults<FeelsWhy>
    
    // Added a @State var to track the selected date by user
    
    @State public var selectedDate: String = ""
    @State private var navigate = false
    
    var body: some View {
        NavigationStack {
            CalendarViewRepresentable(selectedDate: $selectedDate)
                .padding(50)
                .onChange(of: selectedDate) { newValue in
                    navigate = true
                }
                .navigationDestination(isPresented: $navigate) {
                    AddDiaryView(selectedDate: $selectedDate)
                }
        }
    }
    
//    private func addItem() {
//        withAnimation {
////            offsets.map { items[$0] }.forEach(viewContext.insert)
//            let newItem = FeelsWhy(context: viewContext)
//            newItem.self.selectedDate = ""
//            newItem.self.txt = ""
//            newItem.self.diarytxt = ""
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
    
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//            
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}


struct CalendarViewRepresentable: UIViewRepresentable {
    typealias UIViewType = FSCalendar

    // Creating a object of FSCalendar to track across the view
    fileprivate var calendar = FSCalendar()
    // Getting selectedDate as a Binding so that we can update it as
    // user changes their selection
    @Binding var selectedDate: String

    func makeUIView(context: Context) -> FSCalendar {
        // Setting delegate and dateSource of calendar to the
        // values we get from Coordinator
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.locale = Locale(identifier: "en")
        // returning the intialized calendar
        calendar.appearance.headerMinimumDissolvedAlpha = 0.13
        calendar.appearance.headerTitleFont = .systemFont(
            ofSize: 28,
            weight: .bold)
        calendar.appearance.headerTitleColor = .darkGray
        calendar.appearance.headerDateFormat = "MMMM"
        calendar.scrollDirection = .horizontal
        calendar.scope = .month
        calendar.clipsToBounds = false

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
            
            let myDateFormatter = DateFormatter()
            myDateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = myDateFormatter.string(from: date)
            parent.selectedDate = dateString
        }
    }
}



//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
