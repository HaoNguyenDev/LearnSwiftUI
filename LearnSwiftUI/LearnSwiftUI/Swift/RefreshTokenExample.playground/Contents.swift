import Foundation
import PlaygroundSupport

// Allow for Playground run with asynchonus
PlaygroundPage.current.needsIndefiniteExecution = true

// Mock Keychain with dictionary
class KeychainSimulator {
    private var storage: [String: String] = [:]
    
    func save(_ value: String, forKey key: String) {
        storage[key] = value
    }
    
    func get(_ key: String) -> String? {
        return storage[key]
    }
    
    func remove(_ key: String) {
        storage[key] = nil
    }
}

class APIClient {
    private var accessToken: String?
    private var refreshToken: String?
    private let keychain = KeychainSimulator()
    private var isRefreshing = false // Refresh state flag
    private var waitingRequests: [(String, (Result<String, Error>) -> Void)] = [] // List of waiting request
    private var fake401 = true
    private var nsLock = NSLock()
    
    init() {
        // Initial
        accessToken = "initial_access_token_000"
        refreshToken = "initial_refresh_token_000"
        keychain.save(accessToken!, forKey: "access_token")
        keychain.save(refreshToken!, forKey: "refresh_token")
    }
    
    func callAPI(_ url: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let accessToken = keychain.get("access_token") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No access token"])))
            return
        }
        
        print("📡 Call API \(url) with access token: \(accessToken)")
        
        // Mock server returning error 401
        if shouldSimulate401() {
            print(">>> Simulate 401 error")
            handle401Error(url: url, completion: completion)
        } else {
            completion(.success("✅ Data from \(url)"))
        }
    }
    
    private func handle401Error(url: String, completion: @escaping (Result<String, Error>) -> Void) {
        // 1. Fast locking to protect state and waiting array
        nsLock.lock()
        
        print("📄 Add request \(url) to waiting array...")
        waitingRequests.append((url, completion))
        
        // 2. Check flag: If refreshing, unlock and exit.
        if isRefreshing {
            print("⏳ Refreshing token, the request \(url) wait...")
            nsLock.unlock() // Release the lock immediately so as not to block the thread
            return
        }
        
        // 3. Set flag: This thread is selected to start token refresh.
        isRefreshing = true
        
        // 4. Unlock: Must unlock before calling asynchronous function.
        nsLock.unlock()
        
        print("🚨 Starting token refresh...")
        
        // Start calling refresh token (Asynchronous)
        refreshAccessToken { [weak self] result in
            guard let self = self else { return }
            
            // 5. Lock to process the waiting array and reset the flag
            self.nsLock.lock()
            let requestsToRetry = self.waitingRequests // Get the request list
            self.waitingRequests.removeAll()
            self.isRefreshing = false // Reset state to allow next refresh
            self.nsLock.unlock() // Release the lock after cleaning
            
            switch result {
            case .success:
                print("🎉 Refresh token success, recalling \(requestsToRetry.count) waiting requests...")
                self.fake401 = false // Disable 401 simulation after successful refresh
                
                // Recall all requests with new access token
                for (retryURL, retryCompletion) in requestsToRetry {
                    // It is recommended to call the API again on another thread to avoid blocking the current thread.
                    callAPI(retryURL, completion: retryCompletion)
                }
            case .failure(let error):
                print("❌ Refresh token failed: \(error.localizedDescription)")
                
                // Set error for all requests
                for (_, retryCompletion) in requestsToRetry {
                    retryCompletion(.failure(error))
                }
            }
        }
    }
    
    private func refreshAccessToken(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let refreshToken = keychain.get("refresh_token") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No refresh token"])))
            return
        }
        
        print("🔄 Call API refresh token with refresh token: \(refreshToken)")
        
        // Simulate calling API refresh token (wait 1 second)
        if Bool.random() {
            // Simulate server returns new token
            let newAccessToken = "new_access_token_\(Int.random(in: 1000...2000))"
            self.accessToken = newAccessToken
            self.keychain.save(newAccessToken, forKey: "access_token")
            
            // Simulate new refresh token (if provided by server)
            let newRefreshToken = "new_refresh_token_\(Int.random(in: 1000...2000))"
            self.refreshToken = newRefreshToken
            self.keychain.save(newRefreshToken, forKey: "refresh_token")
            
            print("✅ Receive new access token: \(newAccessToken) and refresh token: \(newRefreshToken)")
            completion(.success(()))
        } else {
            completion(.failure(NSError(domain: "Refresh token failed", code: 401, userInfo: [NSLocalizedDescriptionKey: "Refresh token failed"])))
        }
    }
    
    // Simulate 401 error for every request
    private func shouldSimulate401() -> Bool {
        return fake401
    }
}




// Simulate multiple API calls simultaneously
let urls1 = [
    "https://api.example.com/posts",
    "https://api.example.com/profile",
    "https://api.example.com/notifications"
]

let urls2 = [
    "https://api.example.com/promotions",
    "https://api.example.com/settings",
    "https://api.example.com/configs"
]

DispatchQueue.global(qos: .userInitiated).async {
    let client = APIClient()
    for url in urls1 {
        client.callAPI(url) { result in
            switch result {
            case .success(let data):
                print("🎉 Result from \(url): \(data)")
            case .failure(let error):
                print("❌ Error from \(url): \(error.localizedDescription)")
            }
        }
    }
    
    for url in urls2 {
        client.callAPI(url) { result in
            switch result {
            case .success(let data):
                print("🎉 Result from \(url): \(data)")
            case .failure(let error):
                print("❌ Error from \(url): \(error.localizedDescription)")
            }
        }
    }
}

/*
 This class is designed to handle API calls, specifically automatically handling authentication errors (401 Unauthorized) by refreshing the access token.
 How it works
 Token storage: APIClient uses a KeychainSimulator class to securely store the access token and refresh token.
 API calls: When the callAPI method is called, it retrieves the access token from the Keychain. It simulates the API call and, if a 401 error is encountered, triggers the token refresh mechanism.
 401 error handling:
 Checking the refresh status: It uses an isRefreshing flag to ensure that only one token refresh request is sent at a time.
 Request queue: All API requests with 401 errors are added to a waitingRequests array.
 Start refresh: If isRefreshing is false, it sets this flag to true and starts calling the API to refresh the token.
 Refresh Token:
 The refreshAccessToken method simulates calling a token refresh API using the refresh token.
 It pauses for 1 second to simulate network latency.
 After a successful refresh, it saves the access token and the new refresh token to the Keychain.
 Post-refresh processing:
 If the refresh is successful, it iterates through the waitingRequests array and calls all the paused API requests with the new access token.
 If the refresh fails, it returns an error for all requests in the queue.
 */
