function New-ToastNotification {
  <#
  .SYNOPSIS
    Creates and displays a Windows Toast notification

  .DESCRIPTION
    Creates a Windows Toast notification and displays it to the user.

  .PARAMETER ToastTitle
    The title of the Toast notification

  .PARAMETER ToastText
    The text of the Toast notification

  .EXAMPLE
    New-ToastNotification "Hello World" "This is a Toast notification"

    Creates and displays a Toast notification with the title "Hello World" and the text "This is a Toast notification"

  .NOTES
    The function requires Windows 10 build 10586 (Anniversary Update) or higher
  #>
  [CmdletBinding()]
  param(
    [String]
    $ToastTitle,
    [String]
    [parameter(ValueFromPipeline)]
    $ToastText
  )
  
  # don't allow toast notifications on operating systems below Windows 10
  if (((Get-WmiObject -Class Win32_OperatingSystem).Version.Split('.')[0]) -lt 10) { return }

  [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
  $Template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)

  $RawXml = [xml] $Template.GetXml()
  ($RawXml.toast.visual.binding.text | Where-Object { $_.id -eq "1" }).AppendChild($RawXml.CreateTextNode($ToastTitle)) > $null
  ($RawXml.toast.visual.binding.text | Where-Object { $_.id -eq "2" }).AppendChild($RawXml.CreateTextNode($ToastText)) > $null

  $SerializedXml = New-Object Windows.Data.Xml.Dom.XmlDocument
  $SerializedXml.LoadXml($RawXml.OuterXml)

  $Toast = [Windows.UI.Notifications.ToastNotification]::new($SerializedXml)
  $Toast.Tag = "PowerShell"
  $Toast.Group = "PowerShell"
  $Toast.ExpirationTime = [DateTimeOffset]::Now.AddMinutes(1)
  
  $Notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("PowerShell")
  $Notifier.Show($Toast);
}
