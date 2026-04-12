# force-hidpi

A menu bar app that restores true 4K HiDPI on M4/M5 Macs.

Source: [sammcj/force-hidpi](https://github.com/sammcj/force-hidpi)

---

## The Problem

Starting with **M4/M5**, Apple Silicon Macs can no longer offer full-resolution HiDPI on standard 4K external displays. The maximum HiDPI resolution caps at **3360×1890** instead of 3840×2160, forcing a trade-off between blurry native 4K or sharp but cramped lower resolution.

### Root Cause

The M4/M5 Display Coprocessor (DCP) firmware restructured pixel budget allocation from a shared 7680-pixel pool (M2/M3) to per-sub-pipe budgets. The single-stream sub-pipe used by standard 4K displays is hardcoded to **6720 pixels** (constant `0x1A40` in `t605xdcp.im4p`).

This 6720-pixel cap permits only a 6720×3780 backing store — enough for 3360×1890 HiDPI — but not the 7680×4320 needed for true 3840×2160 HiDPI. The constraint is enforced at two levels:

- **MaxSrcRectWidthForPipe[0]** — governs which modes WindowServer enumerates
- **MaxVideoSrcDownscalingWidth** — runtime validation, also set to 6720 on external controllers

Both values are set at boot and cannot be changed at runtime. EDID patching, IOKit registry edits, and private API calls all fail to bypass them.

---

## The Workaround

`force-hidpi` uses CoreGraphics' `CGVirtualDisplay` API to create a **virtual 7680×4320 display** that hardware-mirrors the physical 4K panel. This sidesteps the pipe budget check entirely, delivering true 3840×2160 HiDPI output.

---

## Installation

```bash
# Build and install (places binary in ~/.local/bin, ~/bin, or /usr/local/bin)
make build
make install

# Lifecycle
make start        # Start the app
make stop         # Stop the app
make uninstall    # Remove binary and LaunchAgent
```

Automatic startup at login can be toggled from the menu bar dropdown.

---

## Requirements

- Apple Silicon **M4 or M5** Mac
- External **4K (3840×2160)** display
- macOS 26 or later
- Swift 5.9+ toolchain (to build from source)

---

## Features

- **Scale factors** from 2× to 4× — adjusts logical resolution and render buffer size
- **16-bit compositing** with PQ gamma correction (toggleable)
- Color profile matching between virtual and physical display
- Consistent display identity preservation across restarts
- Hardware-based scaling

---

## Caveats

- The app **must stay running** — quitting it removes the virtual display
- An extra display entry appears in System Settings > Displays
- Relies on **private CoreGraphics APIs** — may break with future macOS updates
- Text sharpness may differ slightly from native M1/M2/M3 HiDPI
- This is a workaround pending an Apple firmware fix (changing `0x1A40` → `0x1E00`)
