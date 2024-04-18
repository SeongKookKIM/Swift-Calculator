

import SwiftUI

struct ContentView: View {
    let buttons = [
        ["AC", "-/+", "N/A", "/"],
        ["7", "8", "9", "*"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["", "0", ".", "="]
    ]
    
    @State private var dotButtonClicked = false
    @State private var operatorButtonClicked = false
    @State private var result = "0"
    @State private var currentCount = ""
    @State private var totalChar = ""
    
    @State var res:Double = 0
    
    var body: some View {
        VStack {
            
            GeometryReader {geometry in
                Text(result)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.system(size: 85))
                    .padding()
                    .padding(.top, 100)
                    .foregroundStyle(Color.white)
                    .background(Color.black)
                
            }
            .frame(height: 230)
            
            
            
            ForEach(buttons, id: \.self) {row in
                HStack {
                    ForEach(row, id: \.self) { buttonChar in
                        Button(action:{
                            onClickBtn(buttonChar)
                        }){
                            Text(buttonChar)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .font(.largeTitle)
                                .background(buttonBackgroundColor(buttonChar))
                                .foregroundStyle(Color.white)
                        }
                        .clipShape(Circle())
                    }
                }
            }
        }
        .background(Color.black)
    }
    
    // 버튼 칼라
    func buttonBackgroundColor(_ buttonChar: String) -> Color {
        switch buttonChar {
        case "AC", "-/+", "N/A":
            return Color.white.opacity(0.5)
        case "+", "*", "-", "=", "/":
            return Color.orange
        case "":
            return Color.black
        default:
            return Color.white.opacity(0.3)
        }
    }
    
    // 버튼 클릭시
    func onClickBtn (_ char: String) {

        
        switch char {
        case "", "N/A":
            return
            
        case "AC":
            result = "0"
            currentCount = ""
            totalChar = ""
            operatorButtonClicked = false
            dotButtonClicked = false
            
            
        case ".":
            operatorButtonClicked = false
            
            if result.first == "0" {
                currentCount = "0."
                return result = currentCount
            } else {
                if !dotButtonClicked {
                    currentCount += char
                    dotButtonClicked = true
                    return result = currentCount
                } else {return}
            }
            
        case "-/+":
            operatorButtonClicked = false
            
            if result == "0" {
                return
            } else {
                if currentCount.first == "-" {
                    currentCount.removeFirst()
                } else {
                    currentCount = "-" + currentCount
                }
                return result = currentCount
            }
            
        case "+", "-", "*", "/":
            
            if operatorButtonClicked {
                return
            } else {
                if totalChar == "" {
                    totalChar = result + char
                    currentCount = ""
                    operatorButtonClicked = true
                    dotButtonClicked = false
                } else {
                    totalChar = totalChar + result + char
                    currentCount = ""
                    operatorButtonClicked = true
                    dotButtonClicked = false
                }
            }
        case "=":
            totalChar += currentCount
            currentCount = ""
            operatorButtonClicked = false
            dotButtonClicked = false
            
            let expression = NSExpression(format: totalChar)
            
            if let res = expression.expressionValue(with: nil, context: nil) as? Double {
                self.res = res
                var stringRes = String(res)
                // .0일경우
                if stringRes.hasSuffix(".0") {
                    stringRes = String(stringRes.dropLast(2))
                }
                result = stringRes
                totalChar = ""
                
            } else {
                self.res = 0
                totalChar = ""
                totalChar = String(res)
                return result = String(res)
            }
            
        default:
            currentCount += char
            operatorButtonClicked = false
            return result = currentCount
        }
        
    }
    
  
    
}
#Preview {
    ContentView()
}
