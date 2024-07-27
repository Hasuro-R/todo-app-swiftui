import Foundation
import MainAPIClient
import Models

public struct WorkspaceListResponse: Codable {
    public let workspaces: [WorkspaceModel]
    
    public init(workspaces: [WorkspaceModel]) {
        self.workspaces = workspaces
    }
}

public struct CreateWorkspaceRequestBody: Codable {
    public let title: String
    public let emoji: String
    
    public init(title: String, emoji: String) {
        self.title = title
        self.emoji = emoji
    }
}

public let fetchWorkspacesAPIClient = ApiClient(urlString: "workspaces", method: .get)
public let createWorkspaceAPIClient = ApiClient(urlString: "workspaces", method: .post)
