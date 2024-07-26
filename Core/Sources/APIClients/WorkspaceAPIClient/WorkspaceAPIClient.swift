import Foundation
import MainAPIClient
import Models

public struct WorkspaceListResponse: Codable {
    public let workspaces: [WorkspaceModel]
    
    public init(workspaces: [WorkspaceModel]) {
        self.workspaces = workspaces
    }
}

public let fetchWorkspacesAPIClient = ApiClient(urlString: "workspaces", method: .get)
