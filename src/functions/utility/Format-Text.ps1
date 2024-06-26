function Format-Text {
  <#
  .SYNOPSIS
    Writes text with color and formatting

  .DESCRIPTION
    Writes text with color, formatting and RGB support
  
  .INPUTS
    This function accepts pipeline input.

  .PARAMETER Text
    The text to be written

  .PARAMETER Foreground
    The foreground color of the text to be written.
    Accepts a valid color name, 8-bit 0-255 integer value, 24-bit RGB 0,0,0 format.

  .PARAMETER Background
    The background color of the text to be written.
    Accepts a valid color name, 8-bit 0-255 integer value, 24-bit RGB 0,0,0 format.

  .PARAMETER Formatting
    The text formatting options to be applied to the text.
    Accepts a list of valid formatting options:
      - Bold
      - Dim
      - Underline
      - Blink
      - Reverse
      - Hidden

  .PARAMETER BitDepth
    The bit depth of the text to be written.
    Accepts values: 8 or 24
  
  .EXAMPLE
    Format-Text -Text "This is some red text on a black background" -Foreground Red -Background Black
  
  .EXAMPLE
    Write-Host "This text: $(Format-Text -Text "is green and underlined" -Foreground Green -Formatting Bold, Underline). Cool right?"


  .EXAMPLE
    Format-Text -Console -Foreground Blue -Background White
    
    This example shows how to change the color of the console.

  .EXAMPLE
    "Lorem ipsum dolor sit amet" | Format-Text -BitDepth 8 -Foreground 166 -Formatting Bold
    
    "Lorem ipsum dolor sit amet" | Format-Text -BitDepth 24 -Foreground 12,66,34 -Formatting Underline

    This example shows how to pipe text to the function with color in 8 and 24 bit depth.

  .NOTES
    8-bit color format:
    
    ESC[38;5;⟨n⟩m Select foreground color, where `n` is a number from the table below
    ESC[48;5;⟨n⟩m Select background color, where `n` is a number from the table below
    
        0-7:  standard colors (as in ESC [ 30-37 m)
      8-15:  high intensity colors (as in ESC [ 90-97 m)
    16-231:  6 × 6 × 6 cube (216 colors): 16 + 36 × r + 6 × g + b (0 ≤ r, g, b ≤ 5)
    232-255:  grayscale from dark to light in 24 steps


    RGB color format:

    ESC[38;2;⟨r⟩;⟨g⟩;⟨b⟩ m Select RGB foreground color
    ESC[48;2;⟨r⟩;⟨g⟩;⟨b⟩ m Select RGB background color

  .NOTES
    Filename: Format-Text.ps1
    Version: 1.3
    Author:  neuralpain
    Created: 2024-03-17
    Updated: 2024-04-20

    Version history:

    1.0  -  Initial release
    
    1.1  -  Add complete color set for both foreground and background

    1.2  -  Add support for 8-bit and 24-bit colors

    1.3  -  Add proper support for Light and Dark colors on Forground and Background; and fixed bug on text formatting
  #>
  [CmdletBinding()]
  param(
    [switch]$Console,
    [switch]$ConsoleReset, # unavailable on for now
    [Parameter(Position = 0, Mandatory = $false, HelpMessage = "The text to be written", ValueFromPipeline = $true)]
    [String]$Text,
    [Parameter(Mandatory = $false, HelpMessage = "The bit depth of the text to be written")]
    [ValidateSet(8, 24)]
    [Int]$BitDepth,
    [Parameter(Mandatory = $false, HelpMessage = "The foreground color of the text to be written")]
    [ValidateCount(1, 3)]
    [String[]]$Foreground,
    [Parameter(Mandatory = $false, HelpMessage = "The background color of the text to be written")]
    [ValidateCount(1, 3)]
    [String[]]$Background,
    [Parameter(Mandatory = $false, HelpMessage = "The text formatting options to be applied to the text")]
    [String[]]$Formatting
  )
  
  $Esc = [char]27
  $Reset = "${Esc}[0m"

  if ($Console) {
    # Set the foreground color
    $Host.UI.RawUI.ForegroundColor = $Foreground
    # Set the background color
    $Host.UI.RawUI.BackgroundColor = $Background
    # Clear the screen to apply the changes
    Clear-Host
    return
  }

  switch ($BitDepth) {
    8 {
      # if the value is less than 0, set it to 0
      if ($null -eq $Foreground -or $Foreground -lt 0) { $Foreground = 0 }
      if ($null -eq $Background -or $Background -lt 0) { $Background = 0 }
      
      # if the value is greater than 255, set it to 255
      if ($Foreground -gt 255) { $Foreground = 255 }
      if ($Background -gt 255) { $Background = 255 }

      $Foreground = "${Esc}[38;5;${Foreground}m"
      $Background = "${Esc}[48;5;${Background}m"
      break
    }
    24 {
      foreach ($color in $Foreground) {
        if ($null -eq $color -or $color -lt 0) { $color = 0 }
        if ($color -gt 255) { $color = 255 }
        $_foreground += ";${color}"
      }
      
      foreach ($color in $Background) {
        if ($null -eq $color -or $color -lt 0) { $color = 0 }
        if ($color -gt 255) { $color = 255 }
        $_background += ";${color}"
      }

      $Foreground = "${Esc}[38;2${_foreground}m"
      $Background = "${Esc}[48;2${_background}m"
      break
    }
    default {
      # Text Color:
      switch ($Foreground) { 
        'Black'        { $Foreground = "${Esc}[30m"  }
        'DarkRed'      { $Foreground = "${Esc}[31m"  }
        'DarkGreen'    { $Foreground = "${Esc}[32m"  }
        'DarkYellow'   { $Foreground = "${Esc}[33m"  }
        'DarkBlue'     { $Foreground = "${Esc}[34m"  }
        'DarkMagenta'  { $Foreground = "${Esc}[35m"  }
        'DarkCyan'     { $Foreground = "${Esc}[36m"  }
        'Gray'         { $Foreground = "${Esc}[37m"  }
        'DarkGray'     { $Foreground = "${Esc}[90m"  }
        'Red'          { $Foreground = "${Esc}[91m"  }
        'Green'        { $Foreground = "${Esc}[92m"  }
        'Yellow'       { $Foreground = "${Esc}[93m"  }
        'Blue'         { $Foreground = "${Esc}[94m"  }
        'Magenta'      { $Foreground = "${Esc}[95m"  }
        'Cyan'         { $Foreground = "${Esc}[96m"  }
        'White'        { $Foreground = "${Esc}[97m"  }
        default        { $Foreground = ""            }
      }
      # Background Color:
      switch ($Background) {
        'Black'        { $Background = "${Esc}[40m"  }
        'DarkRed'      { $Background = "${Esc}[41m"  }
        'DarkGreen'    { $Background = "${Esc}[42m"  }
        'DarkYellow'   { $Background = "${Esc}[43m"  }
        'DarkBlue'     { $Background = "${Esc}[44m"  }
        'DarkMagenta'  { $Background = "${Esc}[45m"  }
        'DarkCyan'     { $Background = "${Esc}[46m"  }
        'Gray'         { $Background = "${Esc}[47m"  }
        'DarkGray'     { $Background = "${Esc}[100m" }
        'Red'          { $Background = "${Esc}[101m" }
        'Green'        { $Background = "${Esc}[102m" }
        'Yellow'       { $Background = "${Esc}[103m" }
        'Blue'         { $Background = "${Esc}[104m" }
        'Magenta'      { $Background = "${Esc}[105m" }
        'Cyan'         { $Background = "${Esc}[106m" }
        'White'        { $Background = "${Esc}[107m" }
        default        { $Background = ""            }
      }
      break
    }
  }

  # Text Formatting:
  if ($Formatting.Length -eq 0) {
    $Format = ""
  }
  else { 
    $i = 0
    $Format = "${Esc}["
    foreach ($type in $Formatting) {
      switch ($type) {
        'Bold'      { $Format += "1" }
        'Dim'       { $Format += "2" }
        'Underline' { $Format += "4" }
        'Blink'     { $Format += "5" }
        'Reverse'   { $Format += "7" }
        'Hidden'    { $Format += "8" }
        default     { $Format += ""  }
      }
      $i++
      if ($i -lt ($Formatting.Length)) { $Format += ";" } 
      else { $Format += "m"; break }
    }
  }
  
  $OutString = "${Foreground}${Background}${Format}${Text}${Reset}"
  Write-Output $OutString
}
