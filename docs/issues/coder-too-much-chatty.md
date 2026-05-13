I’ll add the missing aspect ratio picker now, wire it into the Canvas generation request mapping, and validate with focused tests plus a desktop build.

Updated todo list

I’m pulling the current Canvas UI and request builder code so I can add the picker with the smallest safe change.

I’m implementing the picker by adding an Aspect Ratio combo box, then wiring generation dimensions to the selected ratio instead of always using Square defaults.

The big patch failed cleanly, so I’m applying the wiring in smaller targeted edits to avoid collateral changes.

I’m updating the Canvas tests to lock in the new aspect-ratio behavior and adjusted summary text.

I’m running focused validation now: Canvas tests first, then a desktop build to verify XAML/bindings compile with the new picker.

Implemented. The Canvas now has an aspect ratio picker before proceeding further with wiring.

What changed

Added an Aspect Ratio selector to the Canvas controls in CanvasWindow.axaml.
Wired generation to use both selected tier and selected aspect ratio in CanvasWindow.axaml.cs.
Added view model state for:
AspectRatios
SelectedAspectRatioName
aspect-aware ResolutionSummary
updated preview badge text (PreviewBadgeText)
Updated request builder logic to resolve dimensions from the chosen ratio (not always Square), with overload compatibility preserved.
Updated tests in CanvasWindowViewModelTests.cs to cover aspect-ratio-aware behavior.
What was validated

dotnet test Kira.Tests.csproj --filter CanvasWindowViewModelTests passed (10 tests, 0 failures).
dotnet build src/Kira.Desktop/Kira.Desktop.csproj passed.
Diagnostics show no errors in touched files.
What remains open

The picker currently uses resolution names (e.g., Phone Wallpaper, Square) as aspect options.
If you want, next slice is a web-style aspect ratio menu with explicit ratio labels and low/balanced/quality stepping UI.