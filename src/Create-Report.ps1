<#
  .SYNOPSIS
  Converts the XML report produced by JetBrains CLI InspectCode into a beautiful readable HTML report.
  .DESCRIPTION
  The free JetBrains CLI InspectCode tool produces an XML report which is meant for integration with other software tools.
  However, developers may not have any other tools and want to inspect this output directly. The final HTML report leverages
  libraries such us Bootstrap and Bootstrap-table to beautify the output and provide searching and filtering capabilities.
  This work is inspired by scripts created by Maarten Balliauw (maartenba).
  .PARAMETER InputFile
  Path of the XML report to be transformed into HTML.
  .LINK
  [1] Maarten Balliauw's Github Gists page: https://gist.github.com/maartenba/099d79374e5e23c40dc31ba6b7bfd9ca

  .LINK
  [2] Resharper command line tools: https://www.jetbrains.com/help/resharper/ReSharper_Command_Line_Tools.html#install-and-use-resharper-command-line-tools-as-net-core-tools
  .EXAMPLE
  PS> .\Create-Report.ps1 .\ResharperCliOutput.xml
  .EXAMPLE
  PS> Get-Help .\Create-Report.ps1 -Full
#>

[CmdletBinding()]
param (
	[Parameter(Mandatory = $true)]
	[string]$InputFile
)

Set-StrictMode -Version 2
$ErrorActionPreference = 'Stop'

trap [Exception] {
	Write-Host $_.Exception;
}

[System.IO.FileInfo]$InputFile = Join-Path -Path $PWD.Path -ChildPath $InputFile;
$filename = [io.path]::GetFileNameWithoutExtension($InputFile);

[System.IO.FileInfo]$output = Join-Path -Path $PWD.Path -ChildPath "$filename`_Report`_$(get-date -f yyyyMMddTHHmmss).html";

$xslt = New-Object System.Xml.Xsl.XslCompiledTransform;
$xslt.Load("$PSScriptRoot\InspectCodeTemplate.xslt");
$xslt.Transform($InputFile, $output);

Invoke-Item "$output"