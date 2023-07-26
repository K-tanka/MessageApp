import UIKit

public enum LowkeyFont {
    public static func regular(size: CGFloat) -> UIFont {
        return LowkeySharedResourcesFontFamily.Poppins.regular.font(size: size)
    }
}


public enum RandomAvatarProvider {
    public static func randomAvatarProvider() -> UIImage {
        let images = [
            LowkeySharedResourcesAsset.avataaars,
            LowkeySharedResourcesAsset.avataaars1,
            LowkeySharedResourcesAsset.avataaars2,
            LowkeySharedResourcesAsset.avataaars3,
            LowkeySharedResourcesAsset.avataaars4
        ]
        let img = images.randomElement()!
        return img.image
    }
}

public enum RandomNameProvider {
    public static func randomName() -> String {
        let names = [
            "Peter Soul", "Andre Cru", "Ales Hill",
            "Marisa Merk", "Tom Poul"
        ]

        return names.randomElement()!
    }
}

public enum RandomMessageProvider {
    public static func randomMessage() -> String {
        let messages = [
            "Hello", "How are you?", "Who is here?",
            "Blah blah message", "Ha"
        ]

        return messages.randomElement()!
    }
}
