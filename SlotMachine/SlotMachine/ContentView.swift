//
//  ContentView.swift
//  SlotMachine
//
//  Created by Gurjinder Singh on 27/10/23.
//

import SwiftUI

struct Hexagona: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let p1 = CGPoint(x: 0, y: 20)
            let p2 = CGPoint(x: 0, y: rect.height - 20)
            let p3 = CGPoint(x: rect.width/2, y: rect.height)
            let p4 = CGPoint(x: rect.width, y: rect.height - 20)
            let p5 = CGPoint(x: rect.width, y: 20)
            let p6 = CGPoint(x: rect.width/2, y: 0)
            path.move(to: p1)
            
            path.addArc(tangent1End: p1, tangent2End: p2, radius: 10)
            path.addArc(tangent1End: p2, tangent2End: p3, radius: 10)
            path.addArc(tangent1End: p3, tangent2End: p4, radius: 10)
            path.addArc(tangent1End: p4, tangent2End: p5, radius: 10)
            path.addArc(tangent1End: p5, tangent2End: p6, radius: 10)
            path.addArc(tangent1End: p6, tangent2End: p1, radius: 10)
        }
    }
}

enum Choice: Int, Identifiable {
    var id: Int {
        rawValue
    }
    case success, failure
}
struct ContentView: View {
    
    @State private var isWon: Bool = false
    @State public var numbers: [Int] = [0, 1, 2]
    @State public var counter: Int = 0
    @State private var showingAlert: Choice?
    
    var body: some View {
        ZStack {
            
            Image("bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 50) {
                
                    HStack(alignment: .center) {
                        Image(systemName: "clock")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Slot Machine")
                            .font(.title2)
                            .padding()
                        Image(systemName: "hourglass.badge.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 40, alignment: .center)
                
                Text("Spin Left \(6 - self.counter)")
                    .foregroundColor(.white)
                    .font(.system(.subheadline))
                    .fontWeight(.semibold)
                VStack{
                    HStack(alignment: .center, spacing: 40) {
                        Hexagona()
                            .fill(isWon ? .yellow : .white)
                            .frame(width: 100, height: 120)
                            .overlay {
                                Text("\(numbers[0])")
                                    .font(.largeTitle)
                            }
                        Hexagona()
                            .fill(isWon ? .yellow : .white)
                            .frame(width: 100, height: 120)
                            .overlay {
                                Text("\(numbers[1])")
                                    .font(.largeTitle)
                            }
                    }
                    Hexagona()
                        .fill(isWon ? .yellow : .white)
                        .frame(width: 100, height: 120)
                        .overlay {
                            Text("\(numbers[2])")
                                .font(.largeTitle)
                        }
                    HStack(alignment: .center, spacing: 40) {
                        Hexagona()
                            .fill(isWon ? .yellow : .white)
                            .frame(width: 100, height: 120)
                            .overlay {
                                Text("\(numbers[2])")
                                    .font(.largeTitle)
                            }
                        Hexagona()
                            .fill(isWon ? .yellow : .white)
                            .frame(width: 100, height: 120)
                            .overlay {
                                Text("\(numbers[1])")
                                    .font(.largeTitle)
                            }
                    }
                }
                Button {
                    print("tes")
                    self.numbers[0] = Int.random(in: 0...numbers.count - 1)
                    self.numbers[1] = Int.random(in: 0...numbers.count - 1)
                    self.numbers[2] = Int.random(in: 0...numbers.count - 1)
                    counter += 1
                    if self.numbers[0] == self.numbers[1] && self.numbers[1] == self.numbers[2] {
                        self.counter = 0
                        self.showingAlert = .success
                        self.isWon.toggle()
                    }
                    if counter > 5 {
                        self.counter = 0
                        self.showingAlert = .failure
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                        .overlay {
                            Text("Spin")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                        }
                        .frame(width: 250, height: 40)
                        .shadow(color: .black, radius: 1,y: 1)
                }

            }
            .alert(item: $showingAlert) { alert in
                switch alert {
                case .failure:
                    return Alert(title: Text("Sorry Try Again"), message: Text("Be Patience"), dismissButton: .cancel())
                case .success:
                    return Alert(title: Text("Yahhh! you won"), message: Text("Born with the charm"), dismissButton: .cancel(Text("Ok"), action: {
                        self.isWon.toggle()
                    }))
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
