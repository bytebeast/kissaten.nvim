-- VS Code color theme (also VSCodium, Cursor, Windsurf and other VS Code
-- forks). Built from kissaten's roles like every other extra: token colors
-- reuse the bat theme's TextMate rules, semantic tokens follow the Neovim
-- semantic-token groups, and the workbench is laid out like Neovim's UI
-- (sidebars and panels in the mantle shade, accent for focus and titles).
-- The files live in an extension folder (extras/vscode) with a package.json
-- listing all five styles; see extras/vscode/README.md.
local Util = require("kissaten.util")
local Bat = require("kissaten.extras.bat")

local M = {}

--- `color` with an alpha channel: what VS Code draws over other decorations.
---@param color string
---@param alpha number 0..1
local function a(color, alpha)
  return ("%s%02x"):format(color, math.floor(alpha * 255 + 0.5))
end

--- A translucent color that renders as `target` over `bg`: VS Code wants
--- translucent colors for highlights drawn on top of text decorations (find
--- matches, word highlights, diff), and this keeps them identical to the
--- solid colors Neovim uses. Picks the most transparent alpha that can.
---@param target string
---@param bg string
---@param base? string color to mix (default: as transparent as possible)
local function over(target, bg, base)
  local tr, tg, tb = Util.rgb(target)
  local br, bgg, bb = Util.rgb(bg)
  if base then
    -- alpha such that base over bg is closest to target (least squares)
    local xr, xg, xb = Util.rgb(base)
    local num = (tr - br) * (xr - br) + (tg - bgg) * (xg - bgg) + (tb - bb) * (xb - bb)
    local den = (xr - br) ^ 2 + (xg - bgg) ^ 2 + (xb - bb) ^ 2
    return a(base, den > 0 and math.max(0.04, math.min(1, num / den)) or 0)
  end
  local alpha = 0.04
  for _, p in ipairs({ { tr, br }, { tg, bgg }, { tb, bb } }) do
    local t, b = p[1], p[2]
    if t > b then
      alpha = math.max(alpha, (t - b) / (255 - b))
    elseif t < b then
      alpha = math.max(alpha, (b - t) / b)
    end
  end
  alpha = math.min(1, math.ceil(alpha * 255) / 255)
  local function ch(t, b)
    return math.max(0, math.min(255, (t - (1 - alpha) * b) / alpha))
  end
  return a(Util.hex(ch(tr, br), ch(tg, bgg), ch(tb, bb)), alpha)
end

--- Workbench colors, in VS Code's own grouping. Every key is checked against
--- VS Code's color registry by the test suite.
---@param c kissaten.Colors
---@return {[1]: string, [2]: string}[]
function M.workbench(c)
  local ui, g, d = c.ui, c.git, c.diag
  local bg, mantle, crust = c.bg, ui.bg_sidebar, c.crust
  local accent, on_badge = ui.accent, ui.on_badge
  local float, popup = ui.bg_float, ui.bg_popup
  local border = ui.border -- the crust line between panes, as in Neovim
  local b = c.brackets
  local t = c.terminal
  local function tint(color, amount)
    return Util.tint(color, bg, amount)
  end
  -- stylua: ignore
  return {
    -- base
    { "foreground", c.fg },
    { "disabledForeground", c.overlay0 },
    { "descriptionForeground", c.subtext },
    { "errorForeground", d.error },
    { "icon.foreground", c.subtext },
    { "focusBorder", accent },
    { "contrastBorder", "#00000000" },
    { "selection.background", ui.bg_visual },
    { "widget.shadow", a(c.light and c.overlay0 or "#000000", c.light and 0.25 or 0.45) },
    { "widget.border", ui.border_float },
    { "sash.hoverBorder", accent },
    { "scrollbar.shadow", a("#000000", c.light and 0.08 or 0.3) },
    { "scrollbarSlider.background", a(c.surface2, 0.55) },
    { "scrollbarSlider.hoverBackground", a(c.surface2, 0.8) },
    { "scrollbarSlider.activeBackground", c.surface2 },
    { "progressBar.background", accent },
    { "badge.background", accent },
    { "badge.foreground", on_badge },
    { "activityBarBadge.background", accent },
    { "activityBarBadge.foreground", on_badge },
    { "textLink.foreground", c.teal },
    { "textLink.activeForeground", c.sky },
    { "textPreformat.foreground", c.teal },
    { "textPreformat.background", c.surface0 },
    { "textBlockQuote.background", mantle },
    { "textBlockQuote.border", c.surface2 },
    { "textCodeBlock.background", mantle },
    { "textSeparator.foreground", c.surface2 },

    -- window chrome: title bar and command center on crust, like the tabline fill
    { "titleBar.activeBackground", crust },
    { "titleBar.activeForeground", c.subtext },
    { "titleBar.inactiveBackground", crust },
    { "titleBar.inactiveForeground", c.overlay0 },
    { "titleBar.border", border },
    { "commandCenter.background", mantle },
    { "commandCenter.foreground", c.subtext },
    { "commandCenter.activeBackground", c.surface0 },
    { "commandCenter.activeForeground", c.fg },
    { "commandCenter.border", c.surface0 },
    { "commandCenter.inactiveBorder", c.surface0 },
    { "menubar.selectionBackground", c.surface0 },
    { "menubar.selectionForeground", c.fg },
    { "menu.background", popup },
    { "menu.foreground", c.fg },
    { "menu.selectionBackground", ui.bg_sel },
    { "menu.selectionForeground", c.fg },
    { "menu.separatorBackground", c.surface1 },
    { "menu.border", ui.border_float },

    -- activity bar and sidebars: the Neovim sidebar shade
    { "activityBar.background", crust },
    { "activityBar.foreground", accent },
    { "activityBar.inactiveForeground", c.overlay0 },
    { "activityBar.activeBorder", accent },
    { "activityBar.activeBackground", mantle },
    { "activityBar.border", border },
    { "sideBar.background", mantle },
    { "sideBar.foreground", ui.fg_sidebar },
    { "sideBar.border", border },
    { "sideBarTitle.foreground", accent },
    { "sideBarSectionHeader.background", mantle },
    { "sideBarSectionHeader.foreground", c.fg },
    { "sideBarSectionHeader.border", c.surface0 },
    { "sideBar.dropBackground", a(accent, 0.15) },
    { "tree.indentGuidesStroke", ui.indent },
    { "tree.inactiveIndentGuidesStroke", a(ui.indent, 0.6) },

    -- lists (explorer, outline, quick pick, completion)
    { "list.activeSelectionBackground", ui.bg_sel },
    { "list.activeSelectionForeground", c.fg },
    { "list.activeSelectionIconForeground", c.fg },
    { "list.inactiveSelectionBackground", c.surface0 },
    { "list.inactiveSelectionForeground", c.fg },
    { "list.hoverBackground", c.surface0 },
    { "list.hoverForeground", c.fg },
    { "list.focusBackground", ui.bg_sel },
    { "list.focusForeground", c.fg },
    { "list.focusOutline", "#00000000" },
    { "list.focusAndSelectionOutline", "#00000000" },
    { "list.highlightForeground", ui.pmenu_match },
    { "list.focusHighlightForeground", ui.pmenu_match },
    { "list.errorForeground", d.error },
    { "list.warningForeground", d.warn },
    { "list.invalidItemForeground", d.error },
    { "list.deemphasizedForeground", c.comment },
    { "list.dropBackground", a(accent, 0.15) },
    { "listFilterWidget.background", float },
    { "listFilterWidget.outline", accent },
    { "listFilterWidget.noMatchesOutline", d.error },

    -- editor groups and tabs: active tab is the editor, the rest sit in mantle
    { "editorGroup.border", border },
    { "editorGroup.dropBackground", a(accent, 0.12) },
    { "editorGroupHeader.tabsBackground", mantle },
    { "editorGroupHeader.tabsBorder", border },
    { "editorGroupHeader.noTabsBackground", mantle },
    { "editorGroupHeader.border", border },
    { "tab.activeBackground", bg },
    { "tab.activeForeground", c.fg },
    { "tab.activeBorderTop", accent },
    { "tab.activeBorder", bg },
    { "tab.unfocusedActiveBackground", bg },
    { "tab.unfocusedActiveForeground", c.subtext },
    { "tab.unfocusedActiveBorderTop", c.surface2 },
    { "tab.inactiveBackground", mantle },
    { "tab.inactiveForeground", c.comment },
    { "tab.unfocusedInactiveForeground", c.overlay0 },
    { "tab.hoverBackground", c.surface0 },
    { "tab.hoverForeground", c.fg },
    { "tab.border", border },
    { "tab.lastPinnedBorder", c.surface2 },
    { "tab.activeModifiedBorder", c.orange },
    { "tab.inactiveModifiedBorder", Util.blend(c.orange, mantle, 0.5) },
    { "breadcrumb.background", bg },
    { "breadcrumb.foreground", c.comment },
    { "breadcrumb.focusForeground", c.fg },
    { "breadcrumb.activeSelectionForeground", accent },
    { "breadcrumbPicker.background", float },

    -- editor
    { "editor.background", bg },
    { "editor.foreground", c.fg },
    { "editorLineNumber.foreground", ui.fg_gutter },
    { "editorLineNumber.activeForeground", ui.fg_gutter_cur },
    { "editorLineNumber.dimmedForeground", c.surface2 },
    { "editorCursor.foreground", c.fg },
    { "editorCursor.background", bg },
    { "editorMultiCursor.primary.foreground", c.fg },
    { "editorMultiCursor.secondary.foreground", c.pink },
    { "editor.lineHighlightBackground", ui.bg_cursorline },
    { "editor.lineHighlightBorder", "#00000000" },
    { "editor.selectionBackground", ui.bg_visual },
    { "editor.inactiveSelectionBackground", over(Util.blend(ui.bg_visual, bg, 0.6), bg, c.blue) },
    { "editor.selectionHighlightBackground", over(ui.bg_read, bg) },
    { "editor.wordHighlightBackground", over(ui.bg_read, bg) },
    { "editor.wordHighlightTextBackground", over(ui.bg_read, bg) },
    { "editor.wordHighlightStrongBackground", over(ui.bg_write, bg, c.pink) },
    { "editor.findMatchBackground", a(ui.bg_cursearch, 0.6) },
    { "editor.findMatchForeground", c.fg },
    { "editor.findMatchBorder", ui.bg_cursearch },
    { "editor.findMatchHighlightBackground", over(ui.bg_search, bg, c.yellow) },
    { "editor.findRangeHighlightBackground", a(c.surface1, 0.5) },
    { "editor.rangeHighlightBackground", a(c.surface1, 0.5) },
    { "editor.hoverHighlightBackground", over(ui.bg_read, bg) },
    { "editor.symbolHighlightBackground", over(ui.bg_search, bg, c.yellow) },
    { "editor.linkedEditingBackground", a(c.pink, 0.15) },
    { "editor.foldBackground", over(c.surface0, bg) },
    { "editor.foldPlaceholderForeground", c.comment },
    { "editorWhitespace.foreground", ui.whitespace },
    { "editorIndentGuide.background1", ui.indent },
    { "editorIndentGuide.activeBackground1", ui.indent_scope },
    { "editorRuler.foreground", c.surface1 },
    { "editorCodeLens.foreground", c.comment },
    { "editorLink.activeForeground", c.teal },
    { "editorUnnecessaryCode.opacity", "#00000088" },
    { "editorGhostText.foreground", c.comment },
    { "editorInlayHint.foreground", c.comment },
    { "editorInlayHint.background", Util.blend(c.surface0, bg, 0.6) },
    { "editorInlayHint.typeForeground", c.comment },
    { "editorInlayHint.parameterForeground", c.comment },
    { "editorLightBulb.foreground", c.yellow },
    { "editorLightBulbAutoFix.foreground", c.teal },
    { "editorStickyScroll.background", mantle },
    { "editorStickyScrollHover.background", c.surface0 },
    { "editorStickyScroll.shadow", a("#000000", c.light and 0.1 or 0.35) },
    { "editorBracketMatch.background", ui.bg_match },
    { "editorBracketMatch.border", "#00000000" },
    -- bracket pair colors follow `rainbow`, in rainbow-delimiters' order
    { "editorBracketHighlight.foreground1", b.red },
    { "editorBracketHighlight.foreground2", b.yellow },
    { "editorBracketHighlight.foreground3", b.blue },
    { "editorBracketHighlight.foreground4", b.orange },
    { "editorBracketHighlight.foreground5", b.green },
    { "editorBracketHighlight.foreground6", b.violet },
    { "editorBracketHighlight.unexpectedBracket.foreground", d.error },
    { "editorBracketPairGuide.activeBackground1", a(b.red, 0.6) },
    { "editorBracketPairGuide.activeBackground2", a(b.yellow, 0.6) },
    { "editorBracketPairGuide.activeBackground3", a(b.blue, 0.6) },
    { "editorBracketPairGuide.activeBackground4", a(b.orange, 0.6) },
    { "editorBracketPairGuide.activeBackground5", a(b.green, 0.6) },
    { "editorBracketPairGuide.activeBackground6", a(b.violet, 0.6) },

    -- gutter, overview ruler, minimap
    { "editorGutter.background", bg },
    { "editorGutter.addedBackground", g.add },
    { "editorGutter.modifiedBackground", g.change },
    { "editorGutter.deletedBackground", g.delete },
    { "editorGutter.foldingControlForeground", c.overlay0 },
    { "editorOverviewRuler.border", "#00000000" },
    { "editorOverviewRuler.background", bg },
    { "editorOverviewRuler.addedForeground", a(g.add, 0.7) },
    { "editorOverviewRuler.modifiedForeground", a(g.change, 0.7) },
    { "editorOverviewRuler.deletedForeground", a(g.delete, 0.7) },
    { "editorOverviewRuler.errorForeground", d.error },
    { "editorOverviewRuler.warningForeground", d.warn },
    { "editorOverviewRuler.infoForeground", d.info },
    { "editorOverviewRuler.findMatchForeground", a(c.orange, 0.7) },
    { "editorOverviewRuler.selectionHighlightForeground", a(c.subtext, 0.5) },
    { "editorOverviewRuler.wordHighlightForeground", a(c.subtext, 0.5) },
    { "editorOverviewRuler.wordHighlightStrongForeground", a(c.pink, 0.6) },
    { "editorOverviewRuler.bracketMatchForeground", a(c.orange, 0.6) },
    { "minimap.background", bg },
    { "minimap.selectionHighlight", a(ui.bg_visual, 0.9) },
    { "minimap.findMatchHighlight", a(c.orange, 0.6) },
    { "minimap.errorHighlight", d.error },
    { "minimap.warningHighlight", d.warn },
    { "minimapGutter.addedBackground", g.add },
    { "minimapGutter.modifiedBackground", g.change },
    { "minimapGutter.deletedBackground", g.delete },
    { "minimapSlider.background", a(c.surface2, 0.4) },
    { "minimapSlider.hoverBackground", a(c.surface2, 0.6) },
    { "minimapSlider.activeBackground", a(c.surface2, 0.8) },

    -- diagnostics: squiggles in the diagnostic colors, like `undercurl`
    { "editorError.foreground", d.error },
    { "editorWarning.foreground", d.warn },
    { "editorInfo.foreground", d.info },
    { "editorHint.foreground", d.hint },
    { "problemsErrorIcon.foreground", d.error },
    { "problemsWarningIcon.foreground", d.warn },
    { "problemsInfoIcon.foreground", d.info },
    { "editorMarkerNavigation.background", float },
    { "editorMarkerNavigationError.background", d.error },
    { "editorMarkerNavigationWarning.background", d.warn },
    { "editorMarkerNavigationInfo.background", d.info },

    -- widgets: hover, suggest (completion), find, peek, inline chat
    { "editorWidget.background", float },
    { "editorWidget.foreground", c.fg },
    { "editorWidget.border", ui.border_float },
    { "editorWidget.resizeBorder", accent },
    { "editorHoverWidget.background", float },
    { "editorHoverWidget.foreground", c.fg },
    { "editorHoverWidget.border", ui.border_float },
    { "editorHoverWidget.statusBarBackground", mantle },
    { "editorHoverWidget.highlightForeground", ui.pmenu_match },
    { "editorSuggestWidget.background", popup },
    { "editorSuggestWidget.foreground", c.fg },
    { "editorSuggestWidget.border", ui.border_float },
    { "editorSuggestWidget.selectedBackground", ui.bg_sel },
    { "editorSuggestWidget.selectedForeground", c.fg },
    { "editorSuggestWidget.highlightForeground", ui.pmenu_match },
    { "editorSuggestWidget.focusHighlightForeground", ui.pmenu_match },
    { "editorSuggestWidgetStatus.foreground", c.comment },
    { "editorSuggestWidget.selectedIconForeground", c.fg },
    { "peekView.border", accent },
    { "peekViewTitle.background", mantle },
    { "peekViewTitleLabel.foreground", accent },
    { "peekViewTitleDescription.foreground", c.comment },
    { "peekViewEditor.background", float },
    { "peekViewEditorGutter.background", float },
    { "peekViewEditor.matchHighlightBackground", over(ui.bg_search, float, c.yellow) },
    { "peekViewResult.background", mantle },
    { "peekViewResult.fileForeground", c.fg },
    { "peekViewResult.lineForeground", c.subtext },
    { "peekViewResult.matchHighlightBackground", over(ui.bg_search, mantle, c.yellow) },
    { "peekViewResult.selectionBackground", ui.bg_sel },
    { "peekViewResult.selectionForeground", c.fg },
    { "debugExceptionWidget.background", float },
    { "debugExceptionWidget.border", d.error },

    -- quick input (command palette, Ctrl-P): the picker panels of `borderless`
    { "quickInput.background", ui.picker.list },
    { "quickInput.foreground", c.fg },
    { "quickInputTitle.background", mantle },
    { "quickInputList.focusBackground", ui.picker.sel },
    { "quickInputList.focusForeground", c.fg },
    { "quickInputList.focusIconForeground", c.fg },
    { "pickerGroup.foreground", accent },
    { "pickerGroup.border", c.surface1 },
    { "keybindingLabel.background", c.surface0 },
    { "keybindingLabel.foreground", c.fg },
    { "keybindingLabel.border", c.surface1 },
    { "keybindingLabel.bottomBorder", c.surface2 },

    -- inputs, dropdowns, buttons, checkboxes
    { "input.background", ui.picker.prompt },
    { "input.foreground", c.fg },
    { "input.border", c.surface1 },
    { "input.placeholderForeground", c.comment },
    { "inputOption.activeBackground", a(accent, 0.25) },
    { "inputOption.activeBorder", accent },
    { "inputOption.activeForeground", c.fg },
    { "inputValidation.errorBackground", tint(d.error, 0.15) },
    { "inputValidation.errorBorder", d.error },
    { "inputValidation.warningBackground", tint(d.warn, 0.15) },
    { "inputValidation.warningBorder", d.warn },
    { "inputValidation.infoBackground", tint(d.info, 0.15) },
    { "inputValidation.infoBorder", d.info },
    { "dropdown.background", popup },
    { "dropdown.listBackground", popup },
    { "dropdown.foreground", c.fg },
    { "dropdown.border", c.surface1 },
    { "button.background", accent },
    { "button.foreground", on_badge },
    { "button.hoverBackground", Util.blend(accent, c.fg, 0.85) },
    { "button.separator", a(on_badge, 0.4) },
    { "button.border", "#00000000" },
    { "button.secondaryBackground", c.surface1 },
    { "button.secondaryForeground", c.fg },
    { "button.secondaryHoverBackground", c.surface2 },
    { "checkbox.background", ui.picker.prompt },
    { "checkbox.border", c.surface2 },
    { "checkbox.foreground", accent },
    { "radio.activeBackground", a(accent, 0.25) },
    { "radio.activeForeground", c.fg },
    { "radio.activeBorder", accent },
    { "radio.inactiveForeground", c.subtext },
    { "radio.inactiveBorder", c.surface2 },
    { "toolbar.hoverBackground", c.surface0 },
    { "toolbar.activeBackground", c.surface1 },

    -- panel (terminal, problems, output) and status bar
    { "panel.background", mantle },
    { "panel.border", border },
    { "panelTitle.activeForeground", c.fg },
    { "panelTitle.activeBorder", accent },
    { "panelTitle.inactiveForeground", c.comment },
    { "panelSection.border", border },
    { "panelSectionHeader.background", mantle },
    { "panelInput.border", c.surface1 },
    { "outputView.background", mantle },
    { "statusBar.background", ui.bg_statusline },
    { "statusBar.foreground", c.subtext },
    { "statusBar.border", border },
    { "statusBar.noFolderBackground", ui.bg_statusline },
    { "statusBar.noFolderForeground", c.subtext },
    { "statusBar.debuggingBackground", c.orange },
    { "statusBar.debuggingForeground", on_badge },
    { "statusBar.focusBorder", accent },
    { "statusBarItem.hoverBackground", c.surface0 },
    { "statusBarItem.hoverForeground", c.fg },
    { "statusBarItem.activeBackground", c.surface1 },
    { "statusBarItem.prominentBackground", c.surface1 },
    { "statusBarItem.prominentForeground", c.fg },
    { "statusBarItem.prominentHoverBackground", c.surface2 },
    -- the remote indicator at the far left is the mode block of a Neovim statusline
    { "statusBarItem.remoteBackground", ui.modes.normal },
    { "statusBarItem.remoteForeground", on_badge },
    { "statusBarItem.remoteHoverBackground", Util.blend(ui.modes.normal, c.fg, 0.85) },
    { "statusBarItem.remoteHoverForeground", on_badge },
    { "statusBarItem.errorBackground", d.error },
    { "statusBarItem.errorForeground", on_badge },
    { "statusBarItem.warningBackground", d.warn },
    { "statusBarItem.warningForeground", on_badge },
    { "statusBarItem.errorHoverBackground", Util.blend(d.error, c.fg, 0.85) },
    { "statusBarItem.warningHoverBackground", Util.blend(d.warn, c.fg, 0.85) },
    { "statusBarItem.focusBorder", accent },

    -- notifications
    { "notifications.background", float },
    { "notifications.foreground", c.fg },
    { "notifications.border", c.surface1 },
    { "notificationCenter.border", ui.border_float },
    { "notificationCenterHeader.background", mantle },
    { "notificationCenterHeader.foreground", c.fg },
    { "notificationToast.border", ui.border_float },
    { "notificationLink.foreground", c.teal },
    { "notificationsErrorIcon.foreground", d.error },
    { "notificationsWarningIcon.foreground", d.warn },
    { "notificationsInfoIcon.foreground", d.info },

    -- git: decorations in the explorer, diff editor, merge editor
    { "gitDecoration.addedResourceForeground", g.add },
    { "gitDecoration.modifiedResourceForeground", g.change },
    { "gitDecoration.deletedResourceForeground", g.delete },
    { "gitDecoration.renamedResourceForeground", g.change },
    { "gitDecoration.untrackedResourceForeground", g.untracked },
    { "gitDecoration.ignoredResourceForeground", g.ignore },
    { "gitDecoration.conflictingResourceForeground", g.conflict },
    { "gitDecoration.stageModifiedResourceForeground", Util.blend(g.change, mantle, 0.7) },
    { "gitDecoration.stageDeletedResourceForeground", Util.blend(g.delete, mantle, 0.7) },
    { "gitDecoration.submoduleResourceForeground", c.lavender },
    { "git.blame.editorDecorationForeground", c.comment },
    { "diffEditor.insertedLineBackground", over(c.diff.add, bg, g.add) },
    { "diffEditor.removedLineBackground", over(c.diff.delete, bg, g.delete) },
    -- changed words: a step deeper than the line, still 4.5:1 for the text on it
    { "diffEditor.insertedTextBackground", over(tint(g.add, 0.28), bg, g.add) },
    { "diffEditor.removedTextBackground", over(tint(g.delete, 0.28), bg, g.delete) },
    { "diffEditor.border", border },
    { "diffEditor.diagonalFill", a(c.surface2, 0.5) },
    { "diffEditorGutter.insertedLineBackground", over(c.diff.add, bg, g.add) },
    { "diffEditorGutter.removedLineBackground", over(c.diff.delete, bg, g.delete) },
    { "diffEditor.unchangedRegionBackground", mantle },
    -- merge conflicts: the same sides as the git-conflict.nvim integration
    { "merge.currentHeaderBackground", a(g.add, (c.light and 0.4 or 0.34) * Util.tint_scale) },
    { "merge.currentContentBackground", a(g.add, (c.light and 0.2 or 0.17) * Util.tint_scale) },
    { "merge.incomingHeaderBackground", a(c.orange, (c.light and 0.4 or 0.34) * Util.tint_scale) },
    { "merge.incomingContentBackground", a(c.orange, (c.light and 0.2 or 0.17) * Util.tint_scale) },
    { "merge.commonHeaderBackground", over(c.surface2, bg) },
    { "merge.commonContentBackground", over(c.surface2, bg) },
    { "editorOverviewRuler.currentContentForeground", g.add },
    { "editorOverviewRuler.incomingContentForeground", c.orange },
    { "editorOverviewRuler.commonContentForeground", c.surface2 },
    { "mergeEditor.change.background", over(c.diff.change, bg, g.change) },
    { "mergeEditor.change.word.background", over(c.diff.text, bg, g.change) },
    { "mergeEditor.conflict.unhandledUnfocused.border", a(g.conflict, 0.5) },
    { "mergeEditor.conflict.unhandledFocused.border", g.conflict },
    { "mergeEditor.conflict.handledUnfocused.border", a(g.add, 0.4) },
    { "mergeEditor.conflict.handledFocused.border", g.add },

    -- debugging
    { "debugToolBar.background", float },
    { "debugToolBar.border", ui.border_float },
    { "editor.stackFrameHighlightBackground", tint(c.yellow, 0.14) },
    { "editor.focusedStackFrameHighlightBackground", tint(c.green, 0.14) },
    { "debugIcon.breakpointForeground", d.error },
    { "debugIcon.breakpointDisabledForeground", c.overlay0 },
    { "debugIcon.breakpointUnverifiedForeground", c.comment },
    { "debugIcon.breakpointCurrentStackframeForeground", c.yellow },
    { "debugIcon.breakpointStackframeForeground", c.green },
    { "debugTokenExpression.name", c.syn.property },
    { "debugTokenExpression.value", c.subtext },
    { "debugTokenExpression.string", c.syn.string },
    { "debugTokenExpression.number", c.syn.number },
    { "debugTokenExpression.boolean", c.syn.boolean },
    { "debugTokenExpression.error", d.error },
    { "debugConsole.infoForeground", d.info },
    { "debugConsole.warningForeground", d.warn },
    { "debugConsole.errorForeground", d.error },
    { "debugConsole.sourceForeground", c.subtext },
    { "testing.iconPassed", d.ok },
    { "testing.iconFailed", d.error },
    { "testing.iconErrored", d.error },
    { "testing.iconQueued", d.warn },
    { "testing.iconSkipped", c.overlay0 },
    { "testing.runAction", d.ok },

    -- symbol icons (outline, breadcrumbs, completion) match the code
    { "symbolIcon.classForeground", c.syn.type },
    { "symbolIcon.constantForeground", c.syn.constant },
    { "symbolIcon.constructorForeground", c.syn.constructor },
    { "symbolIcon.enumeratorForeground", c.syn.type },
    { "symbolIcon.enumeratorMemberForeground", c.syn.constant },
    { "symbolIcon.eventForeground", c.syn.special },
    { "symbolIcon.fieldForeground", c.syn.property },
    { "symbolIcon.fileForeground", c.fg },
    { "symbolIcon.folderForeground", c.blue },
    { "symbolIcon.functionForeground", c.syn.func },
    { "symbolIcon.interfaceForeground", c.syn.type },
    { "symbolIcon.keyForeground", c.syn.property },
    { "symbolIcon.keywordForeground", c.syn.keyword },
    { "symbolIcon.methodForeground", c.syn.func },
    { "symbolIcon.moduleForeground", c.syn.module },
    { "symbolIcon.namespaceForeground", c.syn.module },
    { "symbolIcon.nullForeground", c.syn.constant },
    { "symbolIcon.numberForeground", c.syn.number },
    { "symbolIcon.objectForeground", c.syn.constant },
    { "symbolIcon.operatorForeground", c.syn.operator },
    { "symbolIcon.packageForeground", c.syn.module },
    { "symbolIcon.propertyForeground", c.syn.property },
    { "symbolIcon.referenceForeground", c.teal },
    { "symbolIcon.snippetForeground", c.teal },
    { "symbolIcon.stringForeground", c.syn.string },
    { "symbolIcon.structForeground", c.syn.type },
    { "symbolIcon.textForeground", c.fg },
    { "symbolIcon.typeParameterForeground", c.syn.type },
    { "symbolIcon.unitForeground", c.syn.type },
    { "symbolIcon.variableForeground", c.syn.variable },
    { "symbolIcon.booleanForeground", c.syn.boolean },
    { "symbolIcon.arrayForeground", c.syn.punct },
    { "symbolIcon.colorForeground", c.syn.special },

    -- terminal: the same 16 colors as the terminal extras
    { "terminal.background", mantle },
    { "terminal.foreground", c.fg },
    { "terminal.border", border },
    { "terminal.selectionBackground", ui.bg_visual },
    { "terminalCursor.foreground", c.fg },
    { "terminal.ansiBlack", t.black },
    { "terminal.ansiRed", t.red },
    { "terminal.ansiGreen", t.green },
    { "terminal.ansiYellow", t.yellow },
    { "terminal.ansiBlue", t.blue },
    { "terminal.ansiMagenta", t.magenta },
    { "terminal.ansiCyan", t.cyan },
    { "terminal.ansiWhite", t.white },
    { "terminal.ansiBrightBlack", t.black_bright },
    { "terminal.ansiBrightRed", t.red_bright },
    { "terminal.ansiBrightGreen", t.green_bright },
    { "terminal.ansiBrightYellow", t.yellow_bright },
    { "terminal.ansiBrightBlue", t.blue_bright },
    { "terminal.ansiBrightMagenta", t.magenta_bright },
    { "terminal.ansiBrightCyan", t.cyan_bright },
    { "terminal.ansiBrightWhite", t.white_bright },
    { "terminal.findMatchBackground", a(ui.bg_cursearch, 0.6) },
    { "terminal.findMatchHighlightBackground", over(ui.bg_search, mantle, c.yellow) },
    { "terminalCommandDecoration.successBackground", d.ok },
    { "terminalCommandDecoration.errorBackground", d.error },
    { "terminalCommandDecoration.defaultBackground", c.overlay0 },

    -- settings editor, welcome page, extensions, misc
    { "settings.headerForeground", c.fg },
    { "settings.modifiedItemIndicator", c.orange },
    { "settings.focusedRowBackground", c.surface0 },
    { "settings.rowHoverBackground", a(c.surface0, 0.6) },
    { "settings.dropdownForeground", c.fg },
    { "settings.textInputBackground", ui.picker.prompt },
    { "settings.numberInputBackground", ui.picker.prompt },
    { "settings.checkboxBackground", ui.picker.prompt },
    { "welcomePage.background", bg },
    { "welcomePage.tileBackground", mantle },
    { "welcomePage.tileHoverBackground", c.surface0 },
    { "walkThrough.embeddedEditorBackground", mantle },
    { "extensionButton.prominentBackground", accent },
    { "extensionButton.prominentForeground", on_badge },
    { "extensionButton.prominentHoverBackground", Util.blend(accent, c.fg, 0.85) },
    { "extensionBadge.remoteBackground", accent },
    { "extensionBadge.remoteForeground", on_badge },
    { "extensionIcon.starForeground", c.yellow },
    { "editorGroup.emptyBackground", bg },
    { "chat.requestBorder", c.surface1 },
    { "chat.slashCommandBackground", c.surface1 },
    { "chat.slashCommandForeground", accent },
    { "inlineChat.background", float },
    { "inlineChat.border", ui.border_float },
    { "inlineChatInput.background", ui.picker.prompt },
    { "inlineChatInput.border", c.surface1 },
    { "inlineChatDiff.inserted", over(c.diff.add, bg, g.add) },
    { "inlineChatDiff.removed", over(c.diff.delete, bg, g.delete) },
  }
end

--- Semantic token rules (VS Code's selector syntax), mirroring the Neovim
--- semantic-token groups: links to the same roles, plus the modifier styles.
---@param c kissaten.Colors
function M.semantic(c)
  local s, st = c.syn, c._styles or {}
  local function attrs(cat)
    local out = {}
    for _, attr in ipairs({ "bold", "italic", "underline", "strikethrough" }) do
      if cat and cat[attr] then
        out[attr] = true
      end
    end
    return next(out) and out or nil
  end
  --- a color, or { foreground, bold?, italic?, ... } when a style applies
  local function style(color, cat)
    local out = attrs(cat)
    if not out then
      return color
    end
    out.foreground = color
    return out
  end
  -- stylua: ignore
  local rules = {
    { "namespace", style(s.module) },
    { "class", style(s.type, st.types) },
    { "struct", style(s.type, st.types) },
    { "enum", style(s.type, st.types) },
    { "type", style(s.type, st.types) },
    { "interface", { foreground = s.type, italic = true } },
    { "typeParameter", { foreground = s.type, italic = true } },
    { "builtinType", style(s.type_builtin, st.types) },
    { "class.defaultLibrary", style(s.type_builtin, st.types) },
    { "struct.defaultLibrary", style(s.type_builtin, st.types) },
    { "type.defaultLibrary", style(s.type_builtin, st.types) },
    { "enum.defaultLibrary", style(s.type_builtin, st.types) },
    { "function", style(s.func, st.functions) },
    { "method", style(s.func, st.functions) },
    { "function.defaultLibrary", style(s.func_builtin, st.functions) },
    { "method.defaultLibrary", style(s.func_builtin, st.functions) },
    { "macro", style(s.macro) },
    { "decorator", style(s.attribute) },
    { "parameter", style(s.parameter, st.parameters) },
    { "property", style(s.property) },
    { "enumMember", style(s.constant, st.constants) },
    { "enumMember.defaultLibrary", style(s.constant, st.constants) },
    { "variable.defaultLibrary", style(s.variable_builtin) },
    { "variable.static", style(s.constant, st.constants) },
    { "selfKeyword", style(s.variable_builtin) },
    { "selfTypeKeyword", style(s.variable_builtin) },
    { "label", style(s.label) },
    { "event", style(s.type) },
    { "keyword", style(s.keyword, st.keywords) },
    { "operator", style(s.operator) },
    { "regexp", style(s.regex) },
    { "lifetime", style(s.attribute) },
    { "formatSpecifier", style(s.punct_special) },
    { "escapeSequence", style(s.escape) },
    { "unresolvedReference", { underline = true } },
    { "*.deprecated", { strikethrough = true } },
  }
  -- modifier styles (`styles.mutable`, `readonly`, `statics`, `globals`):
  -- attribute only, so the token keeps its color
  for _, m in ipairs({
    { "*.mutable", st.mutable },
    { "*.readonly", st.readonly },
    { "*.static", st.statics },
    { "*.global", st.globals },
    { "*.globalScope", st.globals },
  }) do
    local v = attrs(m[2])
    if v then
      rules[#rules + 1] = { m[1], v }
    end
  end
  return rules
end

--- TextMate token colors from the bat theme's rules.
---@param c kissaten.Colors
function M.tokens(c)
  local out = {}
  for _, rule in ipairs(Bat.rules) do
    local name, scope, role, st = rule[1], rule[2], rule[3], rule[4]
    local color = Bat.resolve(c, role)
    assert(Util.is_hex(color), ("vscode: rule '%s' has no color for role '%s'"):format(name, role))
    local settings = { { "foreground", color } }
    local font = Bat.font_style(st, c._styles)
    if font then
      settings[#settings + 1] = { "fontStyle", font }
    end
    local scopes = {}
    for sc in scope:gmatch("[^,]+") do
      scopes[#scopes + 1] = vim.trim(sc)
    end
    out[#out + 1] = { name = name, scope = scopes, settings = settings }
  end
  return out
end

-- ── a small ordered JSON writer (VS Code reads JSON with comments, but the
-- files stay plain JSON so any tool can read them) ─────────────────────────
local function str(s)
  return vim.json.encode(s)
end

local function value(v, indent)
  if type(v) == "table" then
    local pad = ("  "):rep(indent + 1)
    local keys = vim.tbl_keys(v)
    table.sort(keys, function(x, y)
      -- foreground first, then attributes alphabetically
      if x == "foreground" then
        return true
      elseif y == "foreground" then
        return false
      end
      return x < y
    end)
    local parts = {}
    for _, k in ipairs(keys) do
      parts[#parts + 1] = pad .. str(k) .. ": " .. value(v[k], indent + 1)
    end
    return "{\n" .. table.concat(parts, ",\n") .. "\n" .. ("  "):rep(indent) .. "}"
  end
  return str(v)
end

---@param c kissaten.Colors
function M.generate(c)
  local lines = {
    "{",
    '  "$schema": "vscode://schemas/color-theme",',
    ('  "name": %s,'):format(str(c._display)),
    ('  "type": %s,'):format(str(c.light and "light" or "dark")),
    '  "semanticHighlighting": true,',
    '  "colors": {',
  }
  local wb = M.workbench(c)
  for i, kv in ipairs(wb) do
    lines[#lines + 1] = ("    %s: %s%s"):format(str(kv[1]), str(kv[2]), i < #wb and "," or "")
  end
  lines[#lines + 1] = "  },"
  lines[#lines + 1] = '  "semanticTokenColors": {'
  local sem = M.semantic(c)
  for i, kv in ipairs(sem) do
    lines[#lines + 1] = ("    %s: %s%s"):format(str(kv[1]), value(kv[2], 2), i < #sem and "," or "")
  end
  lines[#lines + 1] = "  },"
  lines[#lines + 1] = '  "tokenColors": ['
  local tokens = M.tokens(c)
  for i, tk in ipairs(tokens) do
    local settings = {}
    for _, kv in ipairs(tk.settings) do
      settings[#settings + 1] = ("%s: %s"):format(str(kv[1]), str(kv[2]))
    end
    local scopes = {}
    for _, sc in ipairs(tk.scope) do
      scopes[#scopes + 1] = str(sc)
    end
    lines[#lines + 1] = "    {"
    lines[#lines + 1] = ('      "name": %s,'):format(str(tk.name))
    lines[#lines + 1] = ('      "scope": [%s],'):format(table.concat(scopes, ", "))
    lines[#lines + 1] = ('      "settings": { %s }'):format(table.concat(settings, ", "))
    lines[#lines + 1] = "    }" .. (i < #tokens and "," or "")
  end
  lines[#lines + 1] = "  ]"
  lines[#lines + 1] = "}"
  return table.concat(lines, "\n") .. "\n"
end

--- The extension manifest: extras/vscode is an installable VS Code extension
--- folder (copy it into ~/.vscode/extensions, or package it with vsce).
function M.static()
  local styles = require("kissaten.config").styles
  local themes = {}
  for i, style in ipairs(styles) do
    local label = "Kissaten " .. style:sub(1, 1):upper() .. style:sub(2)
    themes[#themes + 1] = ('      {\n        "label": %s,\n        "uiTheme": %s,\n        "path": %s\n      }%s'):format(
      str(label),
      str(require("kissaten.palettes." .. style)._background == "light" and "vs" or "vs-dark"),
      str("./kissaten_" .. style .. ".json"),
      i < #styles and "," or ""
    )
  end
  local version = require("kissaten.config").version
  -- vsce wants a LICENSE next to package.json; keep it the repo's own
  local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h:h:h")
  local license = assert(io.open(root .. "/LICENSE")):read("*a")
  return {
    ["LICENSE"] = license,
    ["package.json"] = table.concat({
      "{",
      '  "name": "kissaten",',
      '  "displayName": "Kissaten",',
      '  "description": "A coffee-house color theme in five styles, from paper-light to black. Every syntax color meets WCAG AA. Generated from kissaten.nvim.",',
      ('  "version": %s,'):format(str(version)),
      '  "publisher": "bytebeast",',
      '  "license": "MIT",',
      '  "repository": {',
      '    "type": "git",',
      '    "url": "https://github.com/bytebeast/kissaten.nvim"',
      "  },",
      '  "engines": {',
      '    "vscode": "^1.70.0"',
      "  },",
      '  "categories": ["Themes"],',
      '  "keywords": ["theme", "color-theme", "dark", "light", "kissaten", "neovim"],',
      '  "contributes": {',
      '    "themes": [',
      table.concat(themes, "\n"),
      "    ]",
      "  }",
      "}",
      "",
    }, "\n"),
  }
end

return M
