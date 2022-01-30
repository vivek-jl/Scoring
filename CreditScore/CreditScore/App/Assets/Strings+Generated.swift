// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Details {
    /// Current Long Term Debt
    internal static let currentLongTermDebt = L10n.tr("Localizable", "Details.currentLongTermDebt")
    /// Months Since Last Defaulted
    internal static let monthsSinceLastDefaulted = L10n.tr("Localizable", "Details.monthsSinceLastDefaulted")
    /// Percentage Credit Used
    internal static let percentageCreditUsed = L10n.tr("Localizable", "Details.percentageCreditUsed")
  }

  internal enum General {
    /// OK
    internal static let ok = L10n.tr("Localizable", "General.OK")
  }

  internal enum Home {
    /// Unable to load credit score at this time. Please try again
    internal static let errorDetails = L10n.tr("Localizable", "Home.ErrorDetails")
    /// Error in data
    internal static let errorTitle = L10n.tr("Localizable", "Home.ErrorTitle")
    /// Dashboard
    internal static let navbarTitle = L10n.tr("Localizable", "Home.NavbarTitle")
    /// out of %d
    internal static func subtitle(_ p1: Int) -> String {
      return L10n.tr("Localizable", "Home.Subtitle", p1)
    }
    /// Your Credit Score is
    internal static let title = L10n.tr("Localizable", "Home.Title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
