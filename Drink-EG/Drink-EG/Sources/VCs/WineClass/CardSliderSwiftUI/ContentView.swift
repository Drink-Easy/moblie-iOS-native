//
//  ContentView.swift
//  Drink-EG
//
//  Created by 김도연 on 8/16/24.
//
import SwiftUI

struct ContentView: View {
    struct Card : Identifiable {
        var id : Int
        var name: String
        var poster: String
        var offset: CGFloat
    }
    
    @State var cards = [
        Card(id: 0, name: "card1", poster: "Dos Copas", offset: 0),
        Card(id: 1, name: "card2", poster: "Dos Copas", offset: 0),
        Card(id: 2, name: "card3", poster: "Dos Copas", offset: 0)
    ]
    
    @State var move = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(cards.reversed()) { card in
                    VStack {
                        Image(card.poster)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                width: geometry.size.width * 0.7, // 화면 너비에 비례하여 설정
                                height: geometry.size.height * 0.5 - CGFloat(card.id - move) * 40
                            )
                            .cornerRadius(15)
                            .shadow(radius: 10)
                            .offset(x: card.id - move <= 2 ? CGFloat(card.id - move) * 20 : 60)
                        
                        Text("\(card.name)")
                            .font(.footnote)
                    }
                    .offset(x: card.offset)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .gesture(DragGesture().onChanged({ value in
                        withAnimation {
                            if value.translation.width < 0 {
                                if -value.translation.width < 0 && card.id != cards.last?.id {
                                    cards[card.id].offset = value.translation.width
                                } else {
                                    if card.id > 0 {
                                        cards[card.id].offset = -((geometry.size.width - 50) + 60) + value.translation.width
                                    }
                                }
                            }
                        }
                    }).onEnded({ value in
                        withAnimation {
                            if value.translation.width < 0 {
                                if -value.translation.width > 180 && card.id != cards.last?.id {
                                    cards[card.id].offset = -((geometry.size.width - 50) + 60)
                                    move += 1
                                } else {
                                    cards[card.id].offset = 0
                                }
                            } else {
                                if card.id > 0 {
                                    cards[card.id - 1].offset = -((geometry.size.width - 50) + 60)
                                    
                                    if value.translation.width > 180 {
                                        cards[card.id - 1].offset = 0
                                        move -= 1
                                    } else {
                                        cards[card.id].offset = -((geometry.size.width - 50) + 60)
                                    }
                                }
                            }
                        }
                    }))
                    
                }
            }
        }
        .edgesIgnoringSafeArea(.all) // GeometryReader가 전체 화면을 사용하도록 설정
    }
}

#Preview {
    ContentView()
}
