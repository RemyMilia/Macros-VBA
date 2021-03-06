Attribute VB_Name = "Module�11"
' MedianFilesToFiles() WINDOWS & MAC versions
' FYI. on mac : sources files need to be .xlsx saved from a mac; warnings on sheet names;
' FYI. region decimal separator: median function can break. If so, change the source files separator from , to . or vice versa
Sub MedianFilesToFiles()
        
    ' hide program alerts
    Application.DisplayAlerts = False
    
    ' declare variables
    Dim sourcePath, sourceFile, destinationPath, destinationFile, sourceSheet, columnName As String
    Dim lastLine, lastColumn, noCol As Integer
    Dim result As Double
    
    ' declare source path & files and destination path MAC
    sourcePath = "Macintosh HD:Users:Remy:Documents:Etudes:These Melissa:Macros-VBA:Tests:MedianFilesToFiles:Source:"
    sourceFile = Dir(sourcePath, MacID("XLSX"))
    destinationPath = "Macintosh HD:Users:Remy:Documents:Etudes:These Melissa:Macros-VBA:Tests:MedianFilesToFiles:Dest:"
    
    ' declare source path & files and destination path WINDOWS
    ' sourcePath = "C:\Users\Melissa\Desktop\SourceMedianFiles\"
    ' sourceFile = Dir(sourcePath & "*.xls")
    
    ' destinationPath = "C:\Users\Melissa\Desktop\DestMedianFiles\"
    
    ' loop on the source folder, go through each file
    Do While Len(sourceFile) > 0
        
        ' new destination file name based on source prefix MAC
        destinationFile = Left(sourceFile, (InStrRev(sourceFile, ".", -1, vbTextCompare) - 1)) & "_median.xlsx"
        
        ' new destination file name based on source prefix WINDOWS
        'destinationFile = Left(sourceFile, (InStrRev(sourceFile, ".", -1, vbTextCompare) - 1)) & "_median.xls"
        
        ' create new file
        Set newFile = Workbooks.Add
        
        ' add a new worksheet which name equals destination file name
        newFile.Worksheets.Add().Name = destinationFile
        
        ' open the current source file
        Set wbSource = Workbooks.Open(sourcePath & sourceFile)
        
        ' define the current source file's specific worksheet to work on, which name is the same as the source file
        sourceSheet = Left(sourceFile, (InStrRev(sourceFile, ".", -1, vbTextCompare) - 1))
    
        ' define the current source file's last line & last column
        lastLine = wbSource.Sheets(sourceSheet).Range("A1").End(xlDown).Row + 1
        lastColumn = wbSource.Sheets(sourceSheet).Range("A1").End(xlToRight).Column
        
        ' loop on each column
        For noCol = 2 To lastColumn
        
            ' get current column name
            columnName = wbSource.Sheets(sourceSheet).Cells(1, noCol)
            
            ' define result as the current column median
            result = WorksheetFunction.Median(wbSource.Sheets(sourceSheet).Range(wbSource.Sheets(sourceSheet). _
            Cells(2, noCol), wbSource.Sheets(sourceSheet).Cells(lastLine, noCol)))
            
            ' write the column name and the median result into new file
            newFile.Sheets(destinationFile).Cells(1, noCol) = columnName
            newFile.Sheets(destinationFile).Cells(2, noCol) = result
        
        Next
        
        ' save & close new file
        newFile.SaveAs Filename:=destinationPath & destinationFile
        newFile.Close
        
        ' close current source
        wbSource.Close False
        
        ' go to next folder xls source file
        sourceFile = Dir()
    
    Loop

End Sub

