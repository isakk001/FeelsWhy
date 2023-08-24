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
//    @Binding var selectedDate: Date
    @State var showEmoji = false
    
    var body: some View {
        VStack {
            Text("How do you feel today?")
                .foregroundColor(Color("darkBlue"))
                .font(.title2)
            Text("Add emoji to express your feeling")
                .foregroundColor(Color("lightBlue"))
                .font(.caption)
            SelectEmojiView()
            QuestionView(title: "Why?", subtitle: "Why did you feel that way? What happened?")
            QuestionView(title: "Why?", subtitle: "Why did this situation evoke such feelings in you?")
            QuestionView(title: "How?", subtitle: "How would you process this feeling/situation?")
        }
        .onChange(of: FeelsWhy(context: context), perform: { _ in
                if context.hasChanges {
                    try? context.save()
                }
            })
        .padding(.bottom, -10)
        .ignoresSafeArea(.all)
    }
    
    private func saveDiary(txt: String, diarytxt: String, selectedDate: Date = Date()) {

        let diary = FeelsWhy(context: context)
        diary.txt = txt
        diary.diarytxt = diarytxt
        diary.selectedDate = selectedDate

        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}


struct SelectEmojiView: View {
    @State var txt = ""
    @State var show = false
    
    var body: some View {
        
        Button {
            self.show.toggle()
        } label: {
            if self.txt != "" {
                TextField("", text: self.$txt)
                    .font(Font.system(size: UIScreen.main.bounds.height / 7))
            } else {
                Image(systemName: "smiley")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("lightBlue"))
            }
        }
        .clipShape(Circle())
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 7)
        .padding()
        .padding(.bottom, 20)
        .sheet(isPresented: $show) {
            EmojiPopUpView(show: $show, txt: $txt)
                .presentationDetents([.medium])
        }
    }
}

struct QuestionView: View {
    
    @State var diarytxt = ""
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack {
            Divider()
                .padding(.trailing, 200)
                .padding(.leading, -20)
                .bold()
            HStack {
                Text(title)
                    .font(.title3)
                    .padding(.trailing, -3)
                    .foregroundColor(Color("darkBlue"))
                Text(subtitle)
                    .font(.caption2)
                    .foregroundColor(Color("lightBlue"))
            }
            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
            .padding(.leading, 10)
            
            TextField("write here", text: self.$diarytxt, axis: .vertical)
                .font(.caption)
                .padding(.leading, 5)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6, alignment: .topLeading)
    }
}


struct AddDiaryView_Previews: PreviewProvider {
    static var previews: some View {
        AddDiaryView()
    }
}
