Attribute VB_Name = "Module�2"
' MedianFilesToFile() WINDOWS & MAC versions
' FYI. on mac : sources files need to be .xlsx saved from a mac; warnings on sheet names
' FYI. region decimal separator: median function can break. If so, change the source files separator from , to . or vice versa
Sub MedianFilesToFile()
        
    ' hide program alerts
    Application.DisplayAlerts = False
    
    ' declare variables
    Dim sourcePath, sourceFile, destinationPath, destinationFile, sourceSheet, destinationSheet, columnName As String
    Dim lastLine, lastColumn, noCol, noLine As Integer
    Dim result As Double
    
    ' declare source path & files and destination path MAC
    sourcePath = "Macintosh HD:Users:Remy:Documents:Etudes:These Melissa:Macros-VBA:Tests:MedianFilesToFile:Source:"
    sourceFile = Dir(sourcePath, MacID("XLSX"))
    destinationPath = "Macintosh HD:Users:Remy:Documents:Etudes:These Melissa:Macros-VBA:Tests:MedianFilesToFile:Dest:"
    
    ' declare source path & files and destination path WINDOWS
    ' sourcePath = "C:\Users\Melissa\Desktop\SourceMedianFiles\"
    ' sourceFile = Dir(sourcePath & "*.xls")
    ' destinationPath = "C:\Users\Melissa\Desktop\DestMedianFiles\"
    
    ' new destination file name
    destinationFile = "median_results.xlsx"
    
    ' new destination file name based on source prefix
    destinationSheet = Left(destinationFile, (InStrRev(sourceFile, ".", -1, vbTextCompare) - 1))
    
    ' create new file
    Set newFile = Workbooks.Add
    
    ' add a new worksheet which name equals destination file name
    newFile.Worksheets.Add().Name = destinationSheet
        
     ' set line variable
    noLine = 1
    
    ' loop on the source folder, go through each file
    Do While Len(sourceFile) > 0
        
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
            
            ' write source file name as well as column name and the median result in new file
            newFile.Sheets(destinationSheet).Cells(noLine, 1) = sourceSheet
            newFile.Sheets(destinationSheet).Cells(noLine, noCol) = columnName
            newFile.Sheets(destinationSheet).Cells(noLine + 1, noCol) = result
        
        Next
        
        ' close current source
        wbSource.Close False
        
        ' go to next folder xls source file
        sourceFile = Dir()
        
        ' go to next line
        noLine = noLine + 3
    
    Loop

    ' save & close new file
    newFile.SaveAs Filename:=destinationPath & destinationFile
    newFile.Close
        
End Sub
