//
//  AsyncAwaitBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 4/8/25.
//

import Foundation

/*
 async
 The async keyword is placed after the function name and before throws.
 It tells the compiler that this function can suspend its execution while waiting for another asynchronous task to complete.
 A function marked async can call other async functions.
 
 func fetchUser(id: Int) async throws -> User {
     // ...
 }
 */

/*
 await: Pause and wait
 When you call an async function, you must use the await keyword.
 This tells Swift: "This function is asynchronous. Pause execution here until that function completes and returns a result."
 When await is called, the current thread is freed to do other work, avoiding blocking. When the async function completes, Swift continues running the code from where await left off.
 
 func loadUserProfile() async {
     do {
         // The code here will pause until fetchUser is complete
         let user = try await fetchUser(id: 123)
         // The code here will continue running after the result is available
         print("Downloading user information: \(user.name)")
     } catch {
         print("Error loading information: \(error)")
     }
 }
 */

/*
 Task: Environment for running asynchronous code
 You can't call an async function directly from a regular synchronous function. Async code needs an "environment" to run in. A Task is that environment.
 A Task represents an asynchronous piece of work that can run in parallel with other synchronous code.
 
 Task {
     await loadUserProfile()
 }
 
 Task {
     let result = try await someAsyncFunction()
     // ...
 }
 */

/*
 To use async/await effectively, you need to understand the following points:
 Note 1: await does not always run on the Main Thread
 await only pauses the current task, but does not guarantee that the next task will run on the Main Thread. Many async system functions (like URLSession) run on background threads.
 Important: When you need to update the user interface (UI), make sure you return to the Main Thread. The easiest way is to use MainActor.
 
 @MainActor is an extremely useful feature, helping you eliminate DispatchQueue.main.async in many cases.
 
 @MainActor // Make this func run on Main Thread
 func updateUI(with image: UIImage) async {
     imageView.image = image
 }
 
 func loadAndDisplayImage() async {
     do {
         let image = try await loadImage(from: myURL)
         // Call async function marked by @MainActor
         await updateUI(with: image)
     } catch {
         // ...
     }
 }

 /////
 
 do {
    try
 } catch {
     await MainActor.run { // return to the Main Thread to update UI
         self.error = error
     }
 }
 */

import SwiftUI

enum MyError: Error {
    case invalidImageData
}

struct SocialUser {
    let id: Int
    let name: String
}

struct UserPost {
    let userId: Int
    let post: String
}

struct UserComment {
    let userId: Int
    let comment: String
}

class AsyncAwaitVM: ObservableObject {
    @Published var errorResult: Error?
    @Published var user: SocialUser?
    @Published var image: UIImage?
    
    private func loadImage(from url: URL) async throws -> UIImage {
        try await Task.sleep(for: .seconds(2))
        let (data, ) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data.0) else {
            // Error when create Image from Data
            throw MyError.invalidImageData
        }
        return image
    }
    
    
    func startLoadImage() {
        Task {
            do {
                let url = URL(string: "https://avatars.githubusercontent.com/u/33618522?v=4")!
                let image = try await loadImage(from: url)
                await updateUI(image)
            } catch {
                await MainActor.run {
                    self.errorResult = error
                }
            }
        }
    }
    
    func startLoadImage2() async throws -> UIImage {
        //Call an function return and throws error
        return try await loadImage(from: URL(string: "https://avatars.githubusercontent.com/u/33618522?v=4")!)
    }
    
    func load() {
        Task {
            do {
                let image = try await startLoadImage2()
                await updateUI(image)
            } catch {
                await MainActor.run {
                    self.errorResult = error
                }
            }
        }
    }
    
    @MainActor
    private func updateUI(_ img: UIImage) async {
        self.image = img
    }
}

//MARK: async with error
extension AsyncAwaitVM {
    func fetchDataWithError() async throws -> String {
        try await Task.sleep(for: .seconds(1))
        if Bool.random() {
            throw URLError(.badServerResponse)
        }
        return "Data fetched successfully"
    }
    
    private func fetchUser(_ id: Int) async throws -> SocialUser {
        do {
            print("fetchUser \(id)")
            try await Task.sleep(for: .seconds(1))
        } catch {
            throw NSError(domain: "Fetch SocialUser", code: 0, userInfo: [NSLocalizedDescriptionKey: "Fetch SocialUser failed"])
        }
        return SocialUser(id: id, name: "User \(id)")
    }
    
    private func fetchPosts(_ id: Int) async throws -> [UserPost] {
        do {
            print("fetchPosts \(id)")
            try await Task.sleep(for: .seconds(1))
        } catch {
            throw NSError(domain: "Fetch UserPosts", code: 0, userInfo: [NSLocalizedDescriptionKey: "Fetch UserPosts failed"])
        }
        return [UserPost(userId: id, post: "Post 1"), UserPost(userId: id, post: "Post 2"), UserPost(userId: id, post: "Post 3")]
    }
    
    private func fetchComments(_ id: Int) async throws -> [UserComment] {
        do {
            print("fetchComments \(id)")
            try await Task.sleep(for: .seconds(1))
        } catch {
            throw NSError(domain: "Fetch Comments", code: 0, userInfo: [NSLocalizedDescriptionKey: "Fetch Comments failed"])
        }
        return [UserComment(userId: id, comment: "Comment 1"), UserComment(userId: id, comment: "Comment 2"), UserComment(userId: id, comment: "Comment 3")]
    }
}

//MARK: async let
extension AsyncAwaitVM {
    func fetchMultipleData() async {
        print("Start fetch Data...")
        let startTime = Date()
        // Method 1: Run sequentially (takes more time)
//        do {
//            let user = try await fetchUser(1)
//            let posts = try await fetchPosts(user.id)
//            let comments = try await fetchComments(posts.first?.userId ?? 0)
//            print(user)
//            print(posts)
//            print(comments)
//            print("Finish fetch Data: \(Date().timeIntervalSince(startTime)) seconds")
//        } catch {
//            await MainActor.run {
//                self.errorResult = error
//            }
//            print("FetchMultipleData Error: \(error)")
//        }
        
        //Method 2: Running in parallel with async let
        async let user = try await fetchUser(1)
        async let posts = try await fetchPosts(1)
        async let comments = try await fetchComments(1)
        
        do {
            let (user, posts, comments) = try await (user, posts, comments)
            print(user)
            print(posts)
            print(comments)
            print("Finish fetch Data: \(Date().timeIntervalSince(startTime)) seconds")
        } catch {
            await MainActor.run {
                self.errorResult = error
            }
            print("FetchMultipleData Error: \(error)")
        }
    }
}

//MARK: TaskGroup
/*
 TaskGroup for Dynamic Tasks
 If you don't know in advance how many tasks need to run in parallel, TaskGroup is the solution.
 withThrowingTaskGroup allows you to add Tasks to a group and wait for all of them to complete.
 */
extension AsyncAwaitVM {
    func processImageURLs(_ urls: [URL]) async throws -> [UIImage] {
        return try await withThrowingTaskGroup(of: UIImage.self) { [weak self] group in
            guard let self else {
                throw AppError.generic("self is nil")
            }
            for url in urls {
                group.addTask {
                    return try await self.loadImage(from: url)
                }
            }
            
            var images = [UIImage]()
            for try await image in group {
                images.append(image)
            }
            return images
        }
    }
}

//MARK: Use withCheckedContinuation to convert old asynchronous code to async/await
extension AsyncAwaitVM {
    func fetchUserData(completion: @escaping (Result<User, Error>) -> Void) {
        // Old API with closure
    }

    // Change to async await by this way
    func fetchUserDataAsync() async throws -> User {
        return try await withCheckedThrowingContinuation { continuation in
            fetchUserData { result in
                switch result {
                case .success(let user):
                    continuation.resume(returning: user)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

//MARK: VIEW
struct AsyncAwaitBootcampView: View {
    @StateObject private var vm = AsyncAwaitVM()
    
    var body: some View {
        VStack {
            if let image = vm.image {
                Image(uiImage: image)
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
//            vm.startLoadImage()
            vm.load()
        }
        .task {
            await vm.fetchMultipleData()
        }
    }
        
}

#Preview {
    AsyncAwaitBootcampView()
}
