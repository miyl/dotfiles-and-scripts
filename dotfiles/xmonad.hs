import XMonad
import XMonad.Hooks.DynamicLog
import qualified Data.Map as M -- For shortcuts
import XMonad.Hooks.ManageDocks -- for removing border on fullscreen windows.
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops (fullscreenEventHook) -- Fix problwm with HTML5 video fullscreen in Firefox (see handleEventHook line)
import XMonad.Layout.NoBorders (smartBorders) -- Remove borders on fullscreen windows

import XMonad.Util.Scratchpad -- The scratchpad
import qualified XMonad.StackSet as W -- RationalRect, for the scratchpad - and for reassigning which keysym that changes the master window.

-- Assigning this outside of main so I can use it in the keysyms instead of hardcoding mod4Mask
modMaskC = mod4Mask

-- Don't launch xmobar:
--main = xmonad $ def
-- Launch xmobar with my conig
main = xmonad =<< statusBar "xmobar" myXmobarPP toggleStrutsKey def
-- Launch xmobar with my config but without the myXmobarPP section below (works!)
--main = xmonad =<< xmobar def
     { 
       modMask     = modMaskC
     , handleEventHook = fullscreenEventHook -- Fix problwm with HTML5 video fullscreen in Firefox
     , terminal    = "termite"
     --, layoutHook  = smartBorders . avoidStruts $ layoutHook def -- Remove borders on fullscreen windows
     --, layoutHook  = smartBorders (layoutHook def) -- Remove borders on fullscreen windows
     , workspaces  = myWorkspaces
     , manageHook  = myManageHook
     , borderWidth = 0
     , normalBorderColor = "#454545"  
     , focusedBorderColor = "#456def"
--     , startupHook = (W.view 0)
     , keys        = myKeys
     }

myManageHook = composeAll [
    isFullscreen --> doFullFloat, --auto-float fullscreen windows (cover xmobar)
    manageDocks, --auto-float fullscreen windows (cover xmobar)
    manageScratchPad,
--    className =? "Vlc" --> doFloat,
    className =? "Firefox"      --> doShift "ww",
    className =? "Thunderbird"  --> doShift "ii",
    className =? "Gimp"         --> doFloat,
    manageHook def
  ]

--default manage hooks's name is apparently defaultManageHook

-- |Workspaces listing
myWorkspaces = ["te", "ww", "i", "ii", "iii", "iv"]


-- SHORTCUTS:

-- Key assignments to add:
-- General things are in xbindkeysrc, while things that may not make sense in a whole lot of other WMs or DEs are here.

-- Make all dmenu commands look the same, with the new default.
dmenu_font = " -fn 'xft:Inconsolata:size=10' "
dmenu_cmd = "dmenu_run" ++ dmenu_font

keysToAdd x = [
               ((modMaskC, xK_less), spawn(dmenu_cmd)),
               --((modMaskC, xK_z), spawn(dmenu_cmd)),
               ((modMaskC, xK_minus), windows W.swapMaster),
               --((modMaskC, xK_minus), windows W.swapDown), -- dwm behaviour
               ((modMaskC, xK_Return), spawn("termite")),
               ((modMaskC, xK_p), scratchpadSpawnActionTerminal "urxvt -bg '#333' -bd pink -fn 'xft:Bitstream Vera Sans Mono:pixelsize=13'"),
               ((modMaskC, xK_x), spawn("dmenu" ++ dmenu_font ++ "-p Calculate: | xargs echo | calc -p | xargs dmenu" ++ dmenu_font ++ "-p")),
               -- Dvorak
               ((modMaskC, xK_h), windows W.focusDown),
               ((modMaskC, xK_s), windows W.focusUp)
              ]  

-- Key assignments to remove:
-- I've reassigned dmenu_run:
keysToDel y = []--[(modMaskC, xK_p)]
   
-- Logic using the config (no reason to change this):
newKeys x = M.union (M.fromList (keysToAdd x)) (keys def x) -- to include new keys to existing keys  
myKeys x = foldr M.delete (newKeys x) (keysToDel x) -- to delete the unused keys 



-- CONTROLLING WHAT XMONAD OUTPUTS TO XMOBAR (WORSKPACES, LAYOUT, WINDOW NAME):
-- Apparently this is a loghook?
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
myXmobarPP = xmobarPP

    { 
    -- current workspace 
    --ppCurrent         = xmobarColor "#303030" "#909090" . pad 
    ppCurrent         = xmobarColor "#FFD700" "" . pad 
    -- other workspaces which contain windows
    , ppHidden          = xmobarColor "#909090" "" . pad . noScratchPad

    -- Not sure what this specifies?
    --, ppVisible = xmobarColor "#f8f8f8" "LightSkyBlue4" . wrap " " " "

    -- other workspaces with no windows
    --, ppHiddenNoWindows = xmobarColor "#606060" "" . pad 
    --, ppHiddenNoWindows = pad . noScratchPad
    , ppHiddenNoWindows = (\ s -> "")

    -- the current layout
    , ppLayout          = xmobarColor "#909090" ""

    -- if a window on a hidden workspace needs my attention, color it so
    , ppUrgent          = xmobarColor "#ff0000" "" . pad

    -- I couldn't just write "" because it expects a function from String -> String, so I wrote a function that dischards its input and returns an empty string. It still leaves an extra space though.
    -- Removed that extra space from the template line in .xmobarrc
--    , ppTitle           = shorten 100 -- shorten to 100 characters
    , ppTitle           = (\ s -> "") 

    -- no separator between workspaces
    , ppWsSep           = ""

    -- put a few spaces between each object
    , ppSep             = "  "

    -- output to the handle we were given as an argument, maybe just relevant if using dzen or some such.
--    , ppOutput          = hPutStrLn h
    }
    where noScratchPad ws = if ws == "NSP" then "" else ws


-- SCRATCHPAD:

-- Determine what the scratchpad looks like:
manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h) where
    h = 0.2     -- terminal height, 10%
    w = 1.0       -- terminal width, 100%
    t = 1 - h   -- distance from top edge, 90%
    l = 1 - w   -- distance from left edge, 0%
    --l = 0.33   -- distance from left edge, 0%


-- relevant links:
-- http://www.linuxandlife.com/2011/11/how-to-configure-xmonad-arch-linux.html
-- https://stackoverflow.com/questions/19383237/how-do-you-reconfigure-the-1-9-keyboard-shorcuts-in-xmonad
