import Foundation

public struct WorkspaceModel: Equatable, Identifiable, Codable {
    public var id: Int
    public var title: String
    public var emoji: String
    public var userId: Int
    public var createdAt: String
    
    public init(id: Int, title: String, emoji: String, userId: Int, createdAt: String) {
        self.id = id
        self.title = title
        self.emoji = emoji
        self.userId = userId
        self.createdAt = createdAt
    }
}
