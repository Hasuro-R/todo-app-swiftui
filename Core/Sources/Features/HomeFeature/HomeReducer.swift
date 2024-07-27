import Foundation
import Code
import ComposableArchitecture
import Models
import WorkspaceAPIClient

@Reducer
public struct HomeReducer {
    @ObservableState
    public struct State: Equatable {
        var showSheet = false
        var workspaces: [WorkspaceModel] = []
        var workspaceTitle = ""
        var isLoading = false
    }
    public enum Action: BindableAction {
        case firstFetch
        case firstFetchResponse(Result<[WorkspaceModel], Error>)
        case toggleShowState
        case changeWorkspaceTitle(String)
        case createWorkspace
        case createWorkspaceResponse(Result<WorkspaceModel, Error>)
        case binding(BindingAction<State>)
    }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
            .onChange(of: \.showSheet) { oldVal, newVal in
            }
        
        Reduce { state, action in
            switch action {
            case .firstFetch:
                state.isLoading = true
                return .run { send in
                    do {
                        let workspaceData = try await fetchWorkspacesAPIClient.fetchData(responseType: WorkspaceListResponse.self, requestBody: nil as EmptyBody?)
                        await send(.firstFetchResponse(.success(workspaceData.workspaces)))
                    } catch {
                        await send(.firstFetchResponse(.failure(error)))
                    }
                }
            case let .firstFetchResponse(.success(workspaces)):
                state.workspaces = workspaces
                state.isLoading = false
                return .none
            case let .firstFetchResponse(.failure(error)):
                print(error)
                state.isLoading = false
                return .none
            case .toggleShowState:
                state.showSheet = !state.showSheet
                return .none
            case let .changeWorkspaceTitle(newText):
                state.workspaceTitle = newText
                return .none
            case .createWorkspace:
                let requestBody = CreateWorkspaceRequestBody(title: state.workspaceTitle, emoji: "⭐️")
                
                return .run { send in
                    do {
                        let newWorkspaceData = try await createWorkspaceAPIClient.fetchData(responseType: WorkspaceModel.self, requestBody: requestBody)
                        await send(.createWorkspaceResponse(.success(newWorkspaceData)))
                    } catch {
                        await send(.createWorkspaceResponse(.failure(error)))
                    }
                }
            case let .createWorkspaceResponse(.success(workspace)):
                state.workspaces.append(workspace)
                state.workspaceTitle = ""
                state.showSheet = false
                return .none
            case let .createWorkspaceResponse(.failure(error)):
                print(error)
                return .none
            case .binding(\.showSheet):
                return .none
            case .binding(\.workspaceTitle):
                return .none
            case .binding(_):
                return .none
            }
        }
    }
}
