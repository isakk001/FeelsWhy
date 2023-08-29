//
//  AddDiaryView.swift
//  FeelsWhy
//
//  Created by Yisak on 2023/08/20.
//

import SwiftUI
import Combine
import CoreData


struct AddDiaryView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(
        entity: FeelsWhy.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \FeelsWhy.selectedDate, ascending: false) ])
    var items: FetchedResults<FeelsWhy>
    
    // 일기가 날짜 별로 저장되어야 함 -> 바인딩 어케 하지
    @Binding var selectedDate: String
    @State var txt: String = ""
    @State var whyText1: String = ""
    @State var whyText2: String = ""
    @State var howText: String = ""
    @State var diaryData: DiaryData = DiaryData()
    
//    init(selectedDate: Binding<String>) {
//            _selectedDate = selectedDate
//            // 해당 날짜에 해당하는 데이터를 불러와 diaryData에 설정하는 코드를 추가
//            let fetchRequest: NSFetchRequest<FeelsWhy> = FeelsWhy.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "selectedDate == %@", selectedDate.wrappedValue)
//
//            if let diary = try? context.fetch(fetchRequest).first {
//                diaryData = DiaryData(
//                    txt: diary.txt,
//                    whyText1: diary.whyText1,
//                    whyText2: diary.whyText2,
//                    howText: diary.howText
//                )
//            }
//        }
    
    
    var body: some View {
        VStack {
            Text("How do you feel today?")
                .foregroundColor(Color("darkBlue"))
                .font(.title2)
            Text("Add emoji to express your feeling")
                .foregroundColor(Color("lightBlue"))
                .font(.caption)
            SelectEmojiView(txt: $txt)
            QuestionView(diarytxt: whyText1, title: "Why?", subtitle: "Why did you feel that way? What happened?")
            QuestionView(diarytxt: whyText2, title: "Why?", subtitle: "Why did this situation evoke such feelings in you?")
            QuestionView(diarytxt: howText, title: "How?", subtitle: "Hobw would you process this feeling/situation?")
            
//            NavigationLink {
//                CalendarView()
//            } label: {
//                Image(systemName: "checkmark.circle.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 20)
//                    .foregroundColor(Color("lightBlue"))
//            }
//            .onTapGesture {
//                print("onTapGesture")
//                // Tap했을 때 적은 게 저장되어야 함
//                saveDiary(txt: $txt, diarytxt: $diarytxt)
//            }
            Button {
//                saveDiary(txt: txt, whyText1: whyText1, whyText2: whyText2, howText: howText, selectedDate: selectedDate)
                saveDiary(diaryData: diaryData)
            } label: {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 20)
                    .foregroundColor(Color("lightBlue"))
            }
            .onChange(of: FeelsWhy(context: context), perform: { _ in
                if context.hasChanges {
                    try? context.save()
                }
            })
            .ignoresSafeArea(.all)
        }
        .navigationTitle("\(selectedDate)")
    }
    
//    private func saveDiary(txt: String, whyText1: String, whyText2: String, howText: String, selectedDate: String) {
    private func saveDiary(diaryData: DiaryData) {
        
        let diary = FeelsWhy(context: context)
        diary.txt = diaryData.txt
        diary.whyText1 = diaryData.whyText1
        diary.whyText2 = diaryData.whyText2
        diary.howText = diaryData.howText
        diary.selectedDate = selectedDate
        
        do {
            dismiss()
            try context.save()
            print(context)
        } catch {
            print(error)
        }
    }
}

struct DiaryData {
    var txt: String = ""
    var whyText1: String = ""
    var whyText2: String = ""
    var howText: String = ""
}


//struct AddDiaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDiaryView()
//    }
//}
