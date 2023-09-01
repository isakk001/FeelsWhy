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
    /*
     @State var txt: String = ""
     @State var whyText1: String = ""
     @State var whyText2: String = ""
     @State var howText: String = ""
     */
    
    @Binding var selectedDate: String
    @StateObject var diaryData: DiaryDataModel = DiaryDataModel()
    
    
    var body: some View {
        VStack {
            Text("How do you feel today?")
                .foregroundColor(Color("darkBlue"))
                .font(.title2)
            Text("Add emoji to express your feeling")
                .foregroundColor(Color("lightBlue"))
                .font(.caption)
            SelectEmojiView(emoji: $diaryData.emoji)
            QuestionView(diarytxt: $diaryData.whyText1, title: "Why?", subtitle: "Why did you feel that way? What happened?")
            QuestionView(diarytxt: $diaryData.whyText2, title: "Why?", subtitle: "Why did this situation evoke such feelings in you?")
            QuestionView(diarytxt: $diaryData.howText, title: "How?", subtitle: "Hobw would you process this feeling/situation?")
            
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
//        .onAppear {
////            print("onAppear 시작")
//            var dictionary: [String : DiaryData] = [:]
////            print("for문 시작")
//            for item in self.items {
////                print("for문 내부")
//                var tempDairyData: DiaryData = DiaryData()
////                print("\(item.selectedDate)")
////                print("\(item.txt)")
////                print("\(item.whyText1)")
////                print("\(item.whyText2)")
////                print("\(item.howText)")
////                print("for문 데이터 저장")
//                tempDairyData.txt = item.txt
//                tempDairyData.whyText1 = item.whyText1
//                tempDairyData.whyText2 = item.whyText2
//                tempDairyData.howText = item.howText
////                print("for문 데이터 dictionary에 저장")
//                dictionary[item.selectedDate] = tempDairyData
//            }
//            print("for문 끝")
//            @StateObject var data: DiaryData = DiaryData()
//            var result = dictionary[selectedDate]
//            print("result 결과")
//            print(result?.txt ?? "")
//            print(result?.whyText1 ?? "")
//            print(result?.whyText2 ?? "")
//            print(result?.howText ?? "")
//        }
    }
    
//    private func saveDiary(txt: String, whyText1: String, whyText2: String, howText: String, selectedDate: String) {
    private func saveDiary(diaryData: DiaryDataModel) {
        
        let diary = FeelsWhy(context: context)
        
         diary.emoji = diaryData.emoji
         diary.whyText1 = diaryData.whyText1
         diary.whyText2 = diaryData.whyText2
         diary.howText = diaryData.howText
         diary.selectedDate = selectedDate
        
        
        do {
//            dismiss()
            try context.save()
            print(context)
            dismiss()
        } catch {
            print(error)
        }
    }
}

class DiaryDataModel: ObservableObject {
    @Published var emoji: String = ""
    @Published var whyText1: String = ""
    @Published var whyText2: String = ""
    @Published var howText: String = ""
}


//struct AddDiaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDiaryView()
//    }
//}
