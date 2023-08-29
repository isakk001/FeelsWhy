//
//  QuestionView.swift
//  FeelsWhy
//
//  Created by Yisak on 2023/08/24.
//

import SwiftUI

struct QuestionView: View {
    
    @State var diarytxt: String
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
            
            TextField("write here", text: $diarytxt, axis: .vertical)
                .font(.caption)
                .padding(.leading, 5)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6, alignment: .topLeading)
    }
}

//struct QuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionView()
//    }
//}
