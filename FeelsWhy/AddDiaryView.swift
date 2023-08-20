//
//  AddDiaryView.swift
//  FeelsWhy
//
//  Created by Yisak on 2023/08/20.
//

import SwiftUI

struct AddDiaryView: View {
    var body: some View {
        VStack {
            Text("How do you feel today?")
                .foregroundColor(Color(red: 0.28, green: 0.35, blue: 0.46))
                .font(.title)
            Text("Add emoji to express your feeling")
                .foregroundColor(Color(red: 0.39, green: 0.51, blue: 0.7))
            Button {
                // select emoji
            } label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .font(.largeTitle)
                    .padding(10)
            }
            QuestionView(title: "Why?", subtitle: "Why did you feel that way? What happened?")
            QuestionView(title: "Why?", subtitle: "Why did this situation evoke such feelings in you?")
            QuestionView(title: "How?", subtitle: "How would you process this feeling/situation?")
        }
        .padding(EdgeInsets(top: 50, leading: 5, bottom: 0, trailing: 5))
    }
}

struct QuestionView: View {
    
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
                    .font(.title2)
                    .padding(.trailing, -3)
                    .foregroundColor(Color(red: 0.28, green: 0.35, blue: 0.46))
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(Color(red: 0.39, green: 0.51, blue: 0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, -8)
            Image(systemName: "greaterthan")
                .resizable()
                .scaledToFit()
                .padding(EdgeInsets(top: 0, leading: -180, bottom: 92, trailing: 0))
                .foregroundColor(.gray)
        }
        .padding()
    }
}

struct AddDiaryView_Previews: PreviewProvider {
    static var previews: some View {
        AddDiaryView()
    }
}
