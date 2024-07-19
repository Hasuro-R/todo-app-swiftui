import Foundation
import SwiftUI

public enum Theme {
    case light
    case dark
}

protocol ColorsProtocol {
    static var textColorMain: Color { get }
    static var textColorSub: Color { get }
    static var textColorPale: Color { get }
}


public struct CustomColors {
    public var theme: Theme
    
    public init(theme: Theme) {
        self.theme = theme
    }
    
    private var colors: ColorsProtocol.Type {
        switch theme {
        case .light:
            return LightTheme.self
        case .dark:
            return DarkTheme.self
        }
    }
    
    public var white: Color { return Color(hex: "#ffffff") }
    public var colorBlue0: Color { return Color(hex: "#eff5ff") }
    public var colorBlue1: Color { return Color(hex: "#dbeafe") }
    public var colorBlue2: Color { return Color(hex: "#bfdbfe") }
    public var colorBlue3: Color { return Color(hex: "#93c5fd") }
    public var colorBlue4: Color { return Color(hex: "#60a5fa") }
    public var colorBlue5: Color { return Color(hex: "#3b82f6") }
    public var colorBlue6: Color { return Color(hex: "#2563ed") }
    public var colorBlue7: Color { return Color(hex: "#1d4ed8") }
    public var colorBlue8: Color { return Color(hex: "#1e40af") }
    public var colorBlue9: Color { return Color(hex: "#1e3a8a") }
    public var colorBlue10: Color { return Color(hex: "#172554") }
    public var colorGray2: Color { return Color(hex: "#e2e8f0") }

    public var textColorMain: Color { return colors.textColorMain }
    public var textColorSub: Color { return colors.textColorSub }
    public var textColorPale: Color { return colors.textColorPale }
}

struct LightTheme: ColorsProtocol {
    static let textColorMain = Color(hex: "#1e293b")
    static let textColorSub = Color(hex: "#64748b")
    static let textColorPale = Color(hex: "#94a3b8")
}

struct DarkTheme: ColorsProtocol {
    static let textColorMain = Color(hex: "#eff6ff")
    static let textColorSub = Color(hex: "#64748b")
    static let textColorPale = Color(hex: "#94a3b8")
}
