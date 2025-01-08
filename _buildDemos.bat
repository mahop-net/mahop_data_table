cd ./mahop_data_table_examples

rem build the web and the Windows Version
flutter build web
flutter build windows

rem Build the msi
dotnet build "C:\TFS2\Apps\Web\Flutter.MaHop\Flutter.MaHop.DataTableSetup\Flutter.MaHop.DataTableSetup.wixproj"