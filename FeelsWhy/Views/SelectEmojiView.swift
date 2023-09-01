//
//  SelectEmojiView.swift
//  FeelsWhy
//
//  Created by Yisak on 2023/08/24.
//

import SwiftUI

struct SelectEmojiView: View {
    @Binding var emoji : String
    @State var show = false
    
    var body: some View {
        
        Button {
            self.show.toggle()
        } label: {
            if self.emoji != "" {
                TextField("", text: self.$emoji)
                    .font(Font.system(size: UIScreen.main.bounds.height / 9))
            } else {
                Image(systemName: "smiley")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("lightBlue"))
            }
        }
        .clipShape(Circle())
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 9)
        .padding()
        .padding(.bottom, 20)
        .sheet(isPresented: $show) {
            EmojiPopUpView(show: $show, txt: $emoji)
                .presentationDetents([.medium])
        }
    }
}

//struct SelectEmojiView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectEmojiView()
//    }
//}
