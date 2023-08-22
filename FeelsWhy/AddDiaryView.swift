//
//  AddDiaryView.swift
//  FeelsWhy
//
//  Created by Yisak on 2023/08/20.
//

import SwiftUI
import Combine

struct AddDiaryView: View {
    @Binding var selectedDate: Date
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
            //            Button {
            //                self.showEmoji.toggle()
            //            } label: {
            //                Image(systemName: "plus.circle.fill")
            //                    .resizable()
            //                    .scaledToFit()
            //                    .frame(height: 120)
            //                    .foregroundColor(.gray)
            //                    .opacity(0.3)
            //            }
            //            .sheet(isPresented: $showEmoji) { EmojiPopUpView().offset(y: (UIApplication.shared.windows.first?.safeAreaInsets.bottom)!) }
            //            .presentationDetents([.fraction(0.5), .medium, .large])
            //            .padding(.vertical, 30)
            QuestionView(title: "Why?", subtitle: "Why did you feel that way? What happened?")
            QuestionView(title: "Why?", subtitle: "Why did this situation evoke such feelings in you?")
            QuestionView(title: "How?", subtitle: "How would you process this feeling/situation?")
        }
        .padding(.bottom, -10)
        .ignoresSafeArea(.all)
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
        //        .frame(height: geometry.size.height * 0.3)
        //                    EmojiPopUpView(show: $show, txt: $txt)
        //                .offset(y: self.show ? (UIApplication.shared.windows.first?.safeAreaInsets.bottom)! : UIScreen.main.bounds.height)
        //        .onAppear {
        //            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: .main) {
        //                (_) in
        //                self.show = false
        //            }
        //        }
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
//        .padding(.bottom, 40)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6, alignment: .topLeading)
    }
}

//struct AddDiaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDiaryView(selectedDate: self.previews as! Binding<Date>)
//    }
//}
