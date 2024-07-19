import SwiftUI
import Assets

public struct SheetHeader: View {
    public init(title: String, leading: AnyView?, actions: AnyView?) {
        self.title = title
        self.leading = leading
        self.actions = actions
    }
    
    public let title: String
    public let leading: AnyView?
    public let actions: AnyView?
    
    public var body: some View {
        let customColors = CustomColors(theme: .light)
        
        ZStack {
            Text(title)
                .font(.system(size: 20, weight: Font.Weight.bold))
            HStack {
                leading
                Spacer()
                actions
            }
        }
        .padding([.top, .bottom], 20)
        .padding([.leading, .trailing], 15)
        .background(customColors.colorGray2)
    }
}

#Preview {
    SheetHeader(title: "title", leading: nil, actions: nil)
}
