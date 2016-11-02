import           XMonad                          hiding ((|||))
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.FadeInactive       as FI
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.UrgencyHook
import           XMonad.Layout.DecorationMadness
import           XMonad.Layout.IM
import           XMonad.Layout.LayoutCombinators (JumpToLayout (..), (|||))
import           XMonad.Layout.Named
import           XMonad.Layout.NoBorders
import           XMonad.Layout.PerWorkspace
import           XMonad.Layout.Reflect
import           XMonad.Prompt
import           XMonad.Prompt.Input
import qualified XMonad.StackSet                 as W
import           XMonad.Util.Run                 (spawnPipe)
import           XMonad.Util.Scratchpad
 
import qualified Data.Map                        as M
import           Data.Ratio
import           System.Exit
import           System.IO
 
myTerminal :: String
myTerminal = "urxvt"

myBorderWidth :: Dimension
myBorderWidth = 1
 
myModMask :: KeyMask
myModMask = mod4Mask

myNumlockMask :: KeyMask
myNumlockMask = mod2Mask

myAltMask :: KeyMask
myAltMask = mod1Mask
 
myWorkspaces :: [String]
myWorkspaces = [ "1.web", "2.code", "3", "4", "5", "6", "7", "8"
               , "9" ]
 
myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor  = "grey"
myFocusedBorderColor = "green"
 
myDefaultGaps :: [(Integer, Integer, Integer, Integer)]
myDefaultGaps = [(0,0,0,0)]
 
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modMask,               xK_p     ), spawn "dmenu_run")
    , ((modMask .|. shiftMask, xK_c     ), kill)
    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask,               xK_b     ), sendMessage ToggleStruts)
    , ((modMask,               xK_n     ), refresh)
    , ((myAltMask,             xK_Tab   ), windows W.focusDown)
    , ((modMask,               xK_j     ), windows W.focusDown)
    , ((modMask,               xK_k     ), windows W.focusUp  )
    , ((modMask,               xK_m     ), windows W.focusMaster  )
    , ((modMask,               xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((modMask,               xK_h     ), sendMessage Shrink)
    , ((modMask,               xK_l     ), sendMessage Expand)
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)
    , ((modMask,               xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask,               xK_period), sendMessage (IncMasterN (-1)))
    , ((myAltMask .|. controlMask,xK_l    ), spawn "gnome-screensaver-command -l")
    --, ((0,                    0x1008FF11), spawn "amixer set Master 2-")
    --, ((0,                    0x1008FF13), spawn "amixer set Master 2+")
    , ((modMask .|. shiftMask, xK_q     ), io exitSuccess)
    , ((modMask,               xK_q     ), restart "xmonad" True)
    ]
    ++
 
    [ ((m .|. modMask, k), windows $ f i)
         | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]
    ++
 
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]
    ++
 
    --
    -- my Additional Keybindings
    --
    [ ((modMask,                 xK_f           ), spawn "firefox")
    --, ((modMask,                 xK_m           ), spawn "icedove")
    --, ((modMask,                 xK_e           ), spawn "vim")
    --, ((modMask,                 xK_f           ), spawn "pcmanfm")
    --, ((modMask,                 xK_bracketleft ), spawn "pidgin")
    --, ((modMask,                 xK_bracketright), spawn "skype")
    --, ((mod1Mask,                xK_u           ),
    --                         scratchpadSpawnActionTerminal myTerminal)
    , ((modMask,                 xK_y           ), focusUrgent)
    , ((modMask .|. controlMask, xK_space       ), myLayoutPrompt)
    ]

myMouseBindings :: XConfig t -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList
    [ ((modMask, button1), \w -> focus w >> mouseMoveWindow w)
    , ((modMask, button2), \w -> focus w >> windows W.swapMaster)
    , ((modMask, button3), \w -> focus w >> mouseResizeWindow w)
    ]
 
basic :: Tall a
basic = Tall nmaster delta ratio
  where
    nmaster = 1
    delta   = 3/100
    ratio   = 1/2
 
myLayout = smartBorders $ onWorkspace "8" imLayout standardLayouts
  where
    standardLayouts = tall ||| full ||| wide
    tall   = named "tall"   $ avoidStruts basic
    wide   = named "wide"   $ avoidStruts $ Mirror basic
    circle = named "circle" $ avoidStruts circleSimpleDefaultResizable
    full   = named "full"   $ avoidStruts $ noBorders Full
 
   -- IM layout (http://pbrisbin.com/posts/xmonads_im_layout)
    imLayout =
        named "im" $ avoidStruts $ withIM (18/100) pidginRoster $ reflectHoriz $
                                   withIM (1%8) skypeRoster standardLayouts
    pidginRoster = ClassName "Pidgin" `And` Role "buddy_list"
    skypeRoster  = ClassName "Skype"  `And` Role "MainWindow"
 
-- Set up the Layout prompt
myLayoutPrompt :: X ()
myLayoutPrompt = inputPromptWithCompl myXPConfig "Layout"
                 (mkComplFunFromList' allLayouts) ?+ (sendMessage . JumpToLayout)
  where
    allLayouts = ["tall", "wide", "full"]
 
    myXPConfig :: XPConfig
    myXPConfig = defaultXPConfig {
        autoComplete= Just 1000
    }
 
------------------------------------------------------------------------
-- Window rules:
 
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook :: ManageHook
myManageHook = scratchpadManageHookDefault <+> manageDocks
               <+> fullscreenManageHook <+> myFloatHook
               <+> manageHook defaultConfig
  where fullscreenManageHook = composeOne [ isFullscreen -?> doFullFloat ]
 
myFloatHook = composeAll
    [ className =? "GIMP"                  --> doFloat
    , className =? "feh"                   --> doFloat
    , className =? "Firefox"               --> moveToWeb
    , className =? "Vim"                 --> moveToCode
    , className =? "Thunderbird"           --> moveToMail
    , className =? "Icedove"               --> moveToMail
    , className =? "MPlayer"               --> moveToMedia
    , className =? "Pidgin"                --> moveToIM
    , classNotRole ("Pidgin", "")          --> doFloat
    , className =? "Skype"                 --> moveToIM
    , classNotRole ("Skype", "MainWindow") --> doFloat
    , className =? "Gajim"                 --> moveToIM
    , classNotRole ("Gajim", "roster")     --> doFloat
    , manageDocks]
  where
    moveToMail  = doF $ W.shift "9"
    moveToIM    = doF $ W.shift "8"
    moveToWeb   = doF $ W.shift "1.web"
    moveToMedia = doF $ W.shift "7"
    moveToCode  = doF $ W.shift "2.code"
 
    classNotRole :: (String, String) -> Query Bool
    classNotRole (c,r) = className =? c <&&> role /=? r
 
    role = stringProperty "WM_WINDOW_ROLE"
 
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
 
myStartupHook :: X ()
myStartupHook = return ()
 
myLogHook :: X ()
myLogHook = fadeInactiveLogHook 0.8
 
defaults = defaultConfig {
      terminal           = myTerminal
    , focusFollowsMouse  = myFocusFollowsMouse
    , borderWidth        = myBorderWidth
    , modMask            = myModMask
    , workspaces         = myWorkspaces
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , keys               = myKeys
    , mouseBindings      = myMouseBindings
    , layoutHook         = myLayout
    , manageHook         = myManageHook
    , logHook            = myLogHook
    , startupHook        = myStartupHook
}
 
main :: IO ()
main = do
    mapM_ spawn [""]
    xmproc <- spawnPipe "`which xmobar` ~/.xmonad/xmobar"
    xmonad $ withUrgencyHook NoUrgencyHook defaults {
        logHook = do FI.fadeInactiveLogHook 0xbbbbbbbb
                     dynamicLogWithPP $ xmobarPP {
                           ppOutput = hPutStrLn xmproc
                         , ppTitle  = xmobarColor "#1793d0" "" . shorten 32
                         , ppUrgent = xmobarColor "yellow" "red" . xmobarStrip
                     }
    }
