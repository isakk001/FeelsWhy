//
//  EmojiPopUpView.swift
//  FeelsWhy
//
//  Created by Yisak on 2023/08/21.
//

import SwiftUI

struct EmojiPopUpView: View {
    
    @Binding var show: Bool
    @Binding var txt: String
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 15) {
                    
                    ForEach(self.getEmojiList(), id: \.self) { i in
                        
                        HStack(spacing: 25) {
                            
                            ForEach(i, id: \.self) { j in
                                Button {
                                    
                                    self.txt += String(UnicodeScalar(j)!)
                                    
                                } label: {
                                    if ((UnicodeScalar(j)?.properties.isEmoji) != nil) {
                                        Text(String(UnicodeScalar(j)!)).font(.system(size: 55))
                                    } else {
                                        Text("")
                                    }
                                }
                                
                            }
                        }
                    }
                }
                .padding(.top)
            }
            .cornerRadius(25)
            
            Button {
                self.show.toggle()
            } label: {
                Image(systemName: "xmark").foregroundColor(.black)
            }.padding(EdgeInsets(top: 20, leading: 2, bottom: 10, trailing: 10))
        }
    }
    
    func getEmojiList() -> [[Int]] {
        
        var emojis : [[Int]] = []
        
        for i in stride(from: 0x1F601, to: 0x1F64F, by: 4) {
            var temp : [Int] = []
            
            for j in i...i + 3 {
                temp.append(j)
            }
            
            emojis.append(temp)
        }
        return emojis
    }
}
