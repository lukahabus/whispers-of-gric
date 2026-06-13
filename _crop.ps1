Add-Type -AssemblyName System.Drawing

$root = "C:\Users\habus\OneDrive\Documents\Development\gricka sjena"
$out  = Join-Path $root "assets"
if(!(Test-Path $out)){ New-Item -ItemType Directory -Path $out | Out-Null }

function Crop($src,$name,$l,$t,$r,$b){
  $img = [System.Drawing.Image]::FromFile((Join-Path $root $src))
  $W=$img.Width; $H=$img.Height
  $x=[int]($l*$W); $y=[int]($t*$H)
  $w=[int](($r-$l)*$W); $h=[int](($b-$t)*$H)
  $crop = New-Object System.Drawing.Bitmap $w,$h
  $g=[System.Drawing.Graphics]::FromImage($crop)
  $g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $destRect = New-Object System.Drawing.Rectangle 0,0,$w,$h
  $g.DrawImage($img,$destRect,$x,$y,$w,$h,[System.Drawing.GraphicsUnit]::Pixel)
  $g.Dispose()
  $crop.Save((Join-Path $out $name),[System.Drawing.Imaging.ImageFormat]::Png)
  $crop.Dispose(); $img.Dispose()
  "saved $name = ${w}x${h}"
}

# ---------- PORTRAITS ----------
Crop "UI_mockup_6.png"   "p_marta.png"   0.135 0.12 0.50 0.655
Crop "Concept_art_2.png" "p_juraj.png"   0.045 0.165 0.225 0.40
Crop "Concept_art_1.png" "p_blaz.png"    0.755 0.095 0.875 0.42
Crop "3.png"             "p_dorica.png"  0.410 0.345 0.492 0.480   # new woman character sheet
Crop "Concept_art_1.png" "p_player.png"  0.05 0.10 0.165 0.34
Crop "3.png"             "p_stjepan.png" 0.868 0.345 0.988 0.520   # new cloaked scholar
Crop "Cover_art.png"     "p_guard.png"   0.04 0.355 0.17 0.56

# ---------- SCENE STRIPS (band-mode, full width) ----------
Crop "Game_mockup_2.png" "bg_alley.png"    0.0 0.185 1.0 0.44
Crop "Game_mockup_1.png" "bg_bridge.png"   0.0 0.19 1.0 0.575
# ---------- FULL-FRAME SCENES (new art 1/2/3.png, fill-mode) ----------
Crop "3.png" "bg_square.png"    0.012 0.655 0.330 0.985   # St. Mark's church @ Markov trg
Crop "2.png" "bg_kaptol.png"    0.006 0.51  0.330 0.99    # cathedral facade (Kaptol ext)
Crop "1.png" "bg_shrine.png"    0.34  0.52  0.66  0.98    # cathedral interior (Kaptol int)
Crop "3.png" "bg_workshop.png"  0.508 0.02  0.988 0.315   # candlelit goldsmith workshop
Crop "3.png" "bg_crypt.png"     0.012 0.02  0.492 0.315   # vaulted crypt + shrine
Crop "3.png" "bg_archive.png"   0.340 0.655 0.658 0.985   # library / sealed archive
Crop "2.png" "bg_market.png"    0.340 0.51  0.660 0.99    # night market street (Dolac)
Crop "image (2).png"     "bg_nero.png"     0.0 0.0 1.0 1.0
