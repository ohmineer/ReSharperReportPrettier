
# ReSharper Report Prettier

A tool that converts the XML report produced by JetBrains command line InspectCode tool into a beautiful readable HTML report.

The free JetBrains CLI InspectCode tool produces an XML report which is meant for integration with other software tools (CI/CD).
However, developers may not have any other tools and/or want to inspect this output directly.

Using the script provided, the initial XML report is converted into an HTML report which leverages libraries popular frontend libraries such us Bootstrap and Bootstrap-table to beautify the output and provide searching and filtering capabilities.

This work is inspired by scripts created by Maarten Balliauw ([@maartenba](https://github.com/maartenba)).

## Usage/Examples

Assuming both the script and the XML report are in the same directory, type the following command in a terminal window:

```powershell
PS> .\Create-Report.ps1 .\NameOfResharperCLTReport.xml
```

## Screenshots
The screenshot of HTML reports shown below was generated by running ReSharper InspectCode tool on a couple of projects cloned from GitHub.

Actual report files along with initial XML can be found in examples folder.

![Humanizer](https://user-images.githubusercontent.com/8396492/149666833-05e76ec9-fe29-4090-b37b-08becd08c640.png)

![Newtonsoft.Json](https://user-images.githubusercontent.com/8396492/149666883-e3a78f66-99f7-4a7a-8215-3002141aedfb.png)
## Contributing

Contributions are always welcome!

My experience with some of the tools used here is limited so I am sure many things can be improved. If you find anything terribly wrong just let me know so that we can fix it.


## Related

1. [Resharper command line tools](https://www.jetbrains.com/help/resharper/ReSharper_Command_Line_Tools.html#install-and-use-resharper-command-line-tools-as-net-core-tools)
2. [Maarten Balliauw's Github Gists page](https://gist.github.com/maartenba/099d79374e5e23c40dc31ba6b7bfd9ca)