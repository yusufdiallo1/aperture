<div align="center">

<img src="docs/banner.svg" width="100%" alt="Camera — a camera for the Mac, wearing the iPhone's interface">

<br>

### Install

```bash
brew install --cask yusufdiallo1/tap/cam
```

**or [⬇ download the DMG](../../releases/latest)**
&nbsp;·&nbsp;
[📖 setup guide](docs/SETUP.md)

<sub>Homebrew clears the quarantine flag for you, so there is no right-click dance.</sub>

<br>

![macOS 14+](https://img.shields.io/badge/macOS-14%2B-1F1F22?style=flat-square&labelColor=0B0B0D)
![Apple silicon](https://img.shields.io/badge/Apple_silicon-FFD629?style=flat-square&labelColor=0B0B0D&color=FFD629)
![No dependencies](https://img.shields.io/badge/dependencies-none-1F1F22?style=flat-square&labelColor=0B0B0D)
![No network](https://img.shields.io/badge/network-never-1F1F22?style=flat-square&labelColor=0B0B0D)

<br>

<table>
<tr>
<td width="25%" align="center"><b>Capture</b><br><sub>Six modes, iPhone interface</sub></td>
<td width="25%" align="center"><b>Record</b><br><sub>Screen or a single window</sub></td>
<td width="25%" align="center"><b>Edit</b><br><sub>Crop, grade, trim, clean audio</sub></td>
<td width="25%" align="center"><b>Keep</b><br><sub>Straight into Photos</sub></td>
</tr>
</table>

</div>

> Downloads live here. The source is kept in a private repository.

---

## What it is

A replacement for Photo Booth. It puts the iPhone camera interface on macOS —
mode carousel, control cluster, filters, the lot — and adds the things a Mac
camera app actually needs: screen recording, an editor, and direct saving to
your Photos library.

Everything runs on your machine. **No account, no server, no network calls, no
telemetry.** The app has never made an outbound connection and does not contain
the code to make one.

## At a glance

| | |
| --- | --- |
| **Six modes** | Photo · Video · Time Lapse · Slo-Mo · Portrait · Cinematic |
| **Screen** | Whole display or a single window, with system audio |
| **Effects** | 23 across five groups, live in the viewfinder |
| **Editing** | Crop, rotate, grade, trim, clean up speech — all non-destructive |
| **Storage** | Straight into Photos, add-only permission |
| **Profiles** | Several people per Mac, no server, no passwords |
| **Widgets** | Shot count, recent captures, mode shortcuts |

## Capture modes

| Mode | What it does |
| --- | --- |
| **Photo** | Stills in HEIF or JPEG |
| **Video** | H.264 with audio |
| **Time Lapse** | Keeps one frame in *n* — 5×, 15×, 30× or 60× |
| **Slo-Mo** | Synthesised slow motion at 2×, 4× or 8× |
| **Portrait** | Subject separation with background blur |
| **Cinematic** | Portrait plus a focus pull between detected faces |

### About Portrait, Cinematic and Slo-Mo

These three are **software simulations**, and the app says so on screen rather
than letting the interface imply otherwise.

macOS gives an app no depth data at all: `AVCaptureDevice.Format`'s
`supportedDepthDataFormats` is marked `API_UNAVAILABLE(macos)` in the SDK. So
Portrait and Cinematic separate the subject with Vision person-segmentation and
blur what is left. It is a silhouette separation, not a distance one — a hand
held toward the camera blurs exactly as much as the shoulder behind it, and
fine hair against a busy background is where it shows.

Slo-Mo has the same honesty problem from the other direction. Most Mac webcams
cap at 30 fps, so there is no high-speed footage to slow down. The app
synthesises the in-between frames with optical flow, falls back to blending if
that is unavailable, and falls back again to a plain time-stretch rather than
producing something that looks broken. **It reports which method it used** after
every clip.

Anything the hardware cannot do — flash, depth capture, Night Mode — appears
in Settings under "Not available on this Mac", with the reason. Controls that
cannot work are dimmed and explain themselves rather than sitting there looking
live.

## Effects

Twenty-three creative effects, in Portrait and Cinematic:

| Group | Effects |
| --- | --- |
| **Multiply** | Army, Crowd, Kaleidoscope, Mirror |
| **Distort** | Bulge, Pinch, Twirl, Fisheye |
| **Stylize** | X-Ray, Comic, Edges, Posterize, Thermal, Night Vision |
| **Illustrated** | Soft Ink, Cartoon, Sketch, Watercolour |
| **Retro** | CRT, Halftone, Crystal, Pixels, Dream |

They appear live in the viewfinder, not only on the saved file, and they clear
themselves when you leave Portrait or Cinematic so an effect can never stay
applied somewhere you cannot switch it off.

**These are stylisations, not redrawings.** They flatten and outline the real
frame using smoothing, posterisation and edge detection. Turning a face into a
drawn character needs a trained neural model rather than a filter chain, and
this app does not ship one — so nothing here is named for a look it cannot
actually produce.

## Screen recording

Records the whole display, or **a single window** so everything else you do
stays out of the capture. System audio and cursor visibility are both
switchable. macOS shows its own recording indicator throughout — the app says
so on screen, because a screen recorder that hides itself is not one anybody
should trust.

When a recording finishes, the clip appears for a few seconds with an Edit
button, then clears itself.

## Editing

Non-destructive throughout. Every export writes a **new file**; the original is
never modified.

**Photos** — exposure, contrast, highlights, shadows, saturation, temperature,
tint, sharpness, vignette, eleven filters, crop with the usual aspect presets,
and quarter-turn rotation.

**Auto Enhance** measures the image — mean luminance, contrast spread,
saturation, clipped highlights and shadows — and derives adjustments from what
it finds rather than applying a fixed recipe. It tells you what it saw, and
tells an already-good photo that it is already good.

**Videos** — trim by time range, colour grade with the same controls, and clean
up the audio.

### Audio cleanup

Five stages: high-pass to remove rumble, downward expansion to lower the noise
floor between phrases, a presence lift around 3 kHz where consonants live, a
compressor to even out level, and a limiter.

Downward expansion rather than a noise gate, deliberately: a gate chops the
tails off words and sounds worse than the noise it removes.

## Widgets

Three, in the desktop widget gallery. **Open Camera once first** — macOS only
registers a widget extension after its host app has run.

| Widget | Shows |
| --- | --- |
| **Shot Count** | How much you have captured; opens the camera |
| **Recent Captures** | Your latest thumbnails; opens the library |
| **Camera Modes** | Buttons that open a specific mode |

To add one: right-click the desktop → **Edit Widgets** → search **Camera**.

A widget cannot show a live viewfinder, and no app's can — macOS renders
widgets as still snapshots on a schedule rather than running views. These show
what you captured, not what the camera sees right now.

## Profiles

Several people can share one Mac, each with their own settings, filters and
capture history. The owner profile gets an Admin tab showing the other profiles
and their capture counts.

**Admin never shows anyone else's photos.** That boundary is enforced by the
data model rather than by convention: the type the Admin view reads carries
counts and dates and no image data or file paths, so there is nothing there to
display even by mistake. Each person's captures go to their own Photos library,
which the app cannot read.

There is no password, no server and no network, so there is no credential store
to leak.

## Where captures go

Into your **Photos library**, in an album called Camera, plus a copy in the
app's own folder that the Library tab reads.

The app asks only for *add* permission — it never reads your existing photos.
If you decline, captures go to the folder alone and everything still works.

## Installing

Easiest is Homebrew, which clears the quarantine flag for you:

```bash
brew install --cask yusufdiallo1/tap/cam
```

Otherwise download the DMG from **[Releases](../../releases/latest)**, open it,
and drag Camera to Applications.

**If the DMG will not open**, macOS has quarantined it — everything downloaded
from a browser gets that flag, and a quarantined disk image will not open
unless Apple has notarized it. One command clears it:

```bash
xattr -dr com.apple.quarantine ~/Downloads/Camera*.dmg
```

**On first launch, right-click the app and choose Open.** Same cause: this
project does not pay for Apple notarization, so the right-click is the standard
one-time bypass. macOS remembers it.

The app then asks for camera, microphone and Photos access as it needs them,
and screen recording only when you first open the Screen tab.

**[Full setup guide →](docs/SETUP.md)** — every permission, what it is for, and
what to do when macOS keeps saying no.

## What it is built on

Apple frameworks only. **No third-party dependencies, no API keys, nothing to
sign up for.**

AVFoundation · ScreenCaptureKit · Core Image · Vision · Photos · SwiftUI ·
AppKit · Accelerate · ImageIO · WidgetKit

## Troubleshooting

**"Camera access is off"** — grant it in System Settings › Privacy & Security ›
Camera, then quit and reopen the app.

**Screen tab says recording is off after enabling it** — ScreenCaptureKit reads
the permission when the process starts, so quit and reopen the app.

**Thumbnails will not load** — the Library reads the app's own capture folder.
If a file was moved or deleted outside the app, its thumbnail shows a
placeholder icon.

**Something else** — the app writes a startup trace to
`~/Library/Containers/com.yusufdiallo.camera/Data/Library/Logs/Camera-boot.log`.
Its last line is where things stopped.

## Known limits

- **Not notarized**, hence the right-click-to-open step. Notarization needs a
  paid Apple Developer account.
- **Time Lapse and Slo-Mo record no audio.** Their footage no longer runs at
  real time, so real-time sound would drift against the picture immediately.
- **Apple silicon only.** Adding Intel is a one-line change to the build script
  but has not been tested.

## Licence

Copyright © 2026 Yusuf Diallo. All rights reserved.

This software is distributed as a compiled application. The source is kept in a
private repository and is not licensed for redistribution or derivative works.
