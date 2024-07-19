import Foundation

public struct WorkspaceModel: Equatable, Identifiable {
    public var id: Int
    public var title: String
    public var emoji: String
    public var user_id: Int
    public var created_at: String
    
    public init(id: Int, title: String, emoji: String, user_id: Int, created_at: String) {
        self.id = id
        self.title = title
        self.emoji = emoji
        self.user_id = user_id
        self.created_at = created_at
    }
}
