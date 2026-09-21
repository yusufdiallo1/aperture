# Setting up Camera

Five minutes, once. After that the app just opens.

---

## 1 · Open the DMG

**If double-clicking the downloaded DMG appears to do nothing**, that is
expected, and this fixes it:

```bash
xattr -dr com.apple.quarantine ~/Downloads/Camera*.dmg
```

Then double-click it normally.

Anything downloaded from a browser gets a quarantine flag, and macOS refuses to
open a quarantined disk image unless Apple has notarized it. Notarization costs
$99 a year and this project does not pay it, so the flag has to come off by
hand. The command above removes exactly that one attribute and nothing else.

Alternatively: **right-click the DMG → Open**, and confirm.

> Want to check the download first? The release page lists the file's SHA-256.
> Run `shasum -a 256 Camera-1.0.dmg` and compare before doing anything else.

## 2 · Open the app the first time

Drag **Camera** into Applications, then **right-click it and choose Open**.
Double-clicking will not work yet.

The same warning appears for the same reason. Click **Open**; macOS remembers
the decision and it opens normally from then on. If it still refuses:

```bash
xattr -dr com.apple.quarantine /Applications/Camera.app
```

---

## 3 · Camera and microphone

The app asks the first time it opens. Click **Allow** for each.

If you clicked Don't Allow, or the viewfinder says *Camera access is off*:

1. Open **System Settings › Privacy & Security › Camera**
2. Turn on **Camera**
3. Do the same under **Microphone** if you want sound with video
4. **Quit and reopen Camera** — macOS only re-reads this at launch

The app has a shortcut: the button on the "Camera access is off" screen opens
that settings pane directly.

---

## 4 · Photos

Asked the first time you take a shot. Choosing **Allow** lets the app *add*
photos to your library — it cannot read the photos already there, and the
permission macOS grants is specifically add-only.

Declining is fine. Captures then go to a folder instead, and everything else
still works. You can see where they are landing in **Settings › Storage**.

---

## 5 · Screen recording

Only needed if you use the Screen tab. macOS will not prompt automatically, so:

1. Open the **Screen** tab
2. Click **Open Privacy Settings**
3. Turn on **Camera** in the list under **Screen & System Audio Recording**
4. **Quit and reopen the app**

That last step is not optional. ScreenCaptureKit reads the permission once when
the process starts, so a running app keeps reporting "off" until it is
relaunched — even though the switch is already on.

---

## 6 · Widgets

Open the app once, then:

1. Right-click your desktop and choose **Edit Widgets**
   *(or click the date in the menu bar, then Edit Widgets at the bottom)*
2. Search for **Camera**
3. Drag one out

Three are available:

| Widget | Shows |
| --- | --- |
| **Shot Count** | How much you have captured; opens the camera |
| **Recent Captures** | Your latest thumbnails; opens the library |
| **Camera Modes** | Buttons that open a specific mode |

A widget cannot show a live viewfinder, and no app's can — macOS renders
widgets as still snapshots on a schedule rather than running views, so there is
no live feed to display. These show what you captured, not what the camera sees
right now.

---

## Troubleshooting

**"Camera access is off" even though it is on in Settings**
Quit the app completely (⌘Q) and reopen it. Permissions are read at launch.

**Screen tab still says recording is off**
Same cause, same fix: quit and reopen. This one catches almost everyone.

**The app asks for permission again after an update**
Only if it was replaced with a differently signed build. A normal reinstall of
the same release keeps its permissions.

**Widgets do not appear in the gallery**
Open the app once first — macOS registers the widgets when the host app runs.
If they still do not show, log out and back in.

**Something else**
The app writes a startup log:

```bash
cat ~/Library/Containers/com.yusufdiallo.camera/Data/Library/Logs/Camera-boot.log
```

The last line is where it stopped.

---

## Removing it

```bash
rm -rf /Applications/Camera.app
rm -rf ~/Library/Containers/com.yusufdiallo.camera
```

The first removes the app, the second removes its settings and cached
captures. Anything already saved to Photos stays in Photos.
