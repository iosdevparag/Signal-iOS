//
//  Copyright (c) 2020 Open Whisper Systems. All rights reserved.
//

private protocol TSConstantsProtocol: class {
    var textSecureWebSocketAPI: String { get }
    var textSecureServerURL: String { get }
    var textSecureCDN0ServerURL: String { get }
    var textSecureCDN2ServerURL: String { get }
    var contactDiscoveryURL: String { get }
    var keyBackupURL: String { get }
    var storageServiceURL: String { get }
    var kUDTrustRoot: String { get }

    var censorshipReflectorHost: String { get }

    var serviceCensorshipPrefix: String { get }
    var cdn0CensorshipPrefix: String { get }
    var cdn2CensorshipPrefix: String { get }
    var contactDiscoveryCensorshipPrefix: String { get }
    var keyBackupCensorshipPrefix: String { get }
    var storageServiceCensorshipPrefix: String { get }

    var contactDiscoveryEnclaveName: String { get }
    var contactDiscoveryMrEnclave: String { get }

    var keyBackupEnclaveName: String { get }
    var keyBackupMrEnclave: String { get }
    var keyBackupServiceId: String { get }

    var applicationGroup: String { get }

    var serverPublicParamsBase64: String { get }
}

// MARK: -

@objc
public class TSConstants: NSObject {

    @objc
    public static let EnvironmentDidChange = Notification.Name("EnvironmentDidChange")

    // Never instantiate this class.
    private override init() {}

    @objc
    public static var textSecureWebSocketAPI: String { return shared.textSecureWebSocketAPI }
    @objc
    public static var textSecureServerURL: String { return shared.textSecureServerURL }
    @objc
    public static var textSecureCDN0ServerURL: String { return shared.textSecureCDN0ServerURL }
    @objc
    public static var textSecureCDN2ServerURL: String { return shared.textSecureCDN2ServerURL }
    @objc
    public static var contactDiscoveryURL: String { return shared.contactDiscoveryURL }
    @objc
    public static var keyBackupURL: String { return shared.keyBackupURL }
    @objc
    public static var storageServiceURL: String { return shared.storageServiceURL }
    @objc
    public static var kUDTrustRoot: String { return shared.kUDTrustRoot }

    @objc
    public static var censorshipReflectorHost: String { return shared.censorshipReflectorHost }

    @objc
    public static var serviceCensorshipPrefix: String { return shared.serviceCensorshipPrefix }
    @objc
    public static var cdn0CensorshipPrefix: String { return shared.cdn0CensorshipPrefix }
    @objc
    public static var cdn2CensorshipPrefix: String { return shared.cdn2CensorshipPrefix }
    @objc
    public static var contactDiscoveryCensorshipPrefix: String { return shared.contactDiscoveryCensorshipPrefix }
    @objc
    public static var keyBackupCensorshipPrefix: String { return shared.keyBackupCensorshipPrefix }
    @objc
    public static var storageServiceCensorshipPrefix: String { return shared.storageServiceCensorshipPrefix }

    @objc
    public static var contactDiscoveryEnclaveName: String { return shared.contactDiscoveryEnclaveName }
    @objc
    public static var contactDiscoveryMrEnclave: String { return shared.contactDiscoveryMrEnclave }

    @objc
    public static var keyBackupEnclaveName: String { return shared.keyBackupEnclaveName }
    @objc
    public static var keyBackupMrEnclave: String { return shared.keyBackupMrEnclave }
    @objc
    public static var keyBackupServiceId: String { return shared.keyBackupServiceId }

    @objc
    public static var applicationGroup: String { return shared.applicationGroup }

    @objc
    public static var serverPublicParamsBase64: String { return shared.serverPublicParamsBase64 }

    @objc
    public static var isUsingProductionService: Bool {
        return environment == .production
    }

    private enum Environment {
        case production, staging
    }

    private static let serialQueue = DispatchQueue(label: "TSConstants")
    private static var _forceEnvironment: Environment?
    private static var forceEnvironment: Environment? {
        get {
            return serialQueue.sync {
                return _forceEnvironment
            }
        }
        set {
            serialQueue.sync {
                _forceEnvironment = newValue
            }
        }
    }

    private static var environment: Environment {
        if let environment = forceEnvironment {
            return environment
        }
        return FeatureFlags.isUsingProductionService ? .production : .staging
    }

    @objc
    public class func forceStaging() {
        forceEnvironment = .staging
    }

    @objc
    public class func forceProduction() {
        forceEnvironment = .production
    }

    private static var shared: TSConstantsProtocol {
        switch environment {
        case .production:
            return TSConstantsProduction()
        case .staging:
            return TSConstantsStaging()
        }
    }
}

// MARK: -

private class TSConstantsProduction: TSConstantsProtocol {

    public let textSecureWebSocketAPI = "wss://chat.ezifytech.com/v1/websocket/"
    public let textSecureServerURL = "https://chat.ezifytech.com/"
    public let textSecureCDN0ServerURL = "http://signalchat.s3-website-ap-southeast-1.amazonaws.com/"
    public let textSecureCDN2ServerURL = "http://signalchat.s3-website-ap-southeast-1.amazonaws.com/"
    public let contactDiscoveryURL = "https://api-staging.directory.signal.org"
    public let keyBackupURL = "https://api-staging.backup.signal.org"
    public let storageServiceURL = "https://storage-staging.signal.org"
    public let kUDTrustRoot = "Bc6WsOTyEoUtOSlhhNh2WZjBxreESRYnzkmdwC2SYa8O"

    public let censorshipReflectorHost = "europe-west1-signal-cdn-reflector.cloudfunctions.net"

    public let serviceCensorshipPrefix = "service-staging"
    public let cdn0CensorshipPrefix = "cdn-staging"
    public let cdn2CensorshipPrefix = "cdn2-staging"
    public let contactDiscoveryCensorshipPrefix = "directory-staging"
    public let keyBackupCensorshipPrefix = "backup-staging"
    public let storageServiceCensorshipPrefix = "storage-staging"

    // CDS uses the same EnclaveName and MrEnclave
    public let contactDiscoveryEnclaveName = "bd123560b01c8fa92935bc5ae15cd2064e5c45215f23f0bd40364d521329d2ad"
    public var contactDiscoveryMrEnclave: String {
        return contactDiscoveryEnclaveName
    }

    public let keyBackupEnclaveName = "823a3b2c037ff0cbe305cc48928cfcc97c9ed4a8ca6d49af6f7d6981fb60a4e9"
    public let keyBackupMrEnclave = "a3baab19ef6ce6f34ab9ebb25ba722725ae44a8872dc0ff08ad6d83a9489de87"
    public let keyBackupServiceId = "038c40bbbacdc873caa81ac793bb75afde6dfe436a99ab1f15e3f0cbb7434ced"

    public let applicationGroup = "group.com.klouddata.messagechat.group"

    // We need to discard all profile key credentials if these values ever change.
    // See: GroupsV2Impl.verifyServerPublicParams(...)
    public let serverPublicParamsBase64 = "ALgAfjQi0SdF3SCwKP+ZnK0Yhvm7amlVB9dwDWYcR0xDtHg0iiIZs4O9kYPAua2z6f9ZHMHldjXlLLik/F8/eBZQpaWjgyBVE05UPwuvQKx8J7SHUVqFNvVdjv4+pC6zeXSqn6sCwvuDNVS7mm1USI2H2KqiuLqKyWiNDw0vT90SHsTzwplWgXcBEPF7bkrd/fWr+GoktkWCk9eVBSi/oWY"
}

// MARK: -

private class TSConstantsStaging: TSConstantsProtocol {

    public let textSecureWebSocketAPI = "wss://chat.ezifytech.com/v1/websocket/"
    public let textSecureServerURL = "https://chat.ezifytech.com/"
    public let textSecureCDN0ServerURL = "http://signalchat.s3-website-ap-southeast-1.amazonaws.com/"
    public let textSecureCDN2ServerURL = "http://signalchat.s3-website-ap-southeast-1.amazonaws.com/"
    public let contactDiscoveryURL = "https://api-staging.directory.signal.org"
    public let keyBackupURL = "https://api-staging.backup.signal.org"
    public let storageServiceURL = "https://storage-staging.signal.org"
    public let kUDTrustRoot = "Bc6WsOTyEoUtOSlhhNh2WZjBxreESRYnzkmdwC2SYa8O"

    public let censorshipReflectorHost = "europe-west1-signal-cdn-reflector.cloudfunctions.net"

    public let serviceCensorshipPrefix = "service-staging"
    public let cdn0CensorshipPrefix = "cdn-staging"
    public let cdn2CensorshipPrefix = "cdn2-staging"
    public let contactDiscoveryCensorshipPrefix = "directory-staging"
    public let keyBackupCensorshipPrefix = "backup-staging"
    public let storageServiceCensorshipPrefix = "storage-staging"

    // CDS uses the same EnclaveName and MrEnclave
    public let contactDiscoveryEnclaveName = "bd123560b01c8fa92935bc5ae15cd2064e5c45215f23f0bd40364d521329d2ad"
    public var contactDiscoveryMrEnclave: String {
        return contactDiscoveryEnclaveName
    }

    public let keyBackupEnclaveName = "823a3b2c037ff0cbe305cc48928cfcc97c9ed4a8ca6d49af6f7d6981fb60a4e9"
    public let keyBackupMrEnclave = "a3baab19ef6ce6f34ab9ebb25ba722725ae44a8872dc0ff08ad6d83a9489de87"
    public let keyBackupServiceId = "038c40bbbacdc873caa81ac793bb75afde6dfe436a99ab1f15e3f0cbb7434ced"

    public let applicationGroup = "group.com.klouddata.messagechat.group"

    // We need to discard all profile key credentials if these values ever change.
    // See: GroupsV2Impl.verifyServerPublicParams(...)
    public let serverPublicParamsBase64 = "ALgAfjQi0SdF3SCwKP+ZnK0Yhvm7amlVB9dwDWYcR0xDtHg0iiIZs4O9kYPAua2z6f9ZHMHldjXlLLik/F8/eBZQpaWjgyBVE05UPwuvQKx8J7SHUVqFNvVdjv4+pC6zeXSqn6sCwvuDNVS7mm1USI2H2KqiuLqKyWiNDw0vT90SHsTzwplWgXcBEPF7bkrd/fWr+GoktkWCk9eVBSi/oWY"
}
