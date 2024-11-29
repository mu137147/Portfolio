Attribute VB_Name = "Module1"
Sub UpdateMasterSheet(wsSource As Worksheet, Target As Range)
    Dim wsMaster As Worksheet
    Set wsMaster = ThisWorkbook.Sheets("Master Worksheet")
    
    ' Call your AppendWithMapping function
    AppendWithMapping wsSource, Target
End Sub

Sub AppendWithMapping(wsSource As Worksheet, Target As Range)
    Dim wsMaster As Worksheet
    Dim lastRowMaster As Long
    Dim sourceRow As Range
    Dim masterRow As Range
    Dim isRowComplete As Boolean
    Dim i As Integer
    Dim lastColumn As Integer
    Dim foundDuplicate As Boolean
    Dim existingRow As Long

    ' Set reference to the Master Worksheet
    Set wsMaster = ThisWorkbook.Sheets("Master Worksheet")

    ' Determine the last column based on the source worksheet
    If wsSource.name = "Upwork" Then
        lastColumn = 13 ' Upwork has data in columns A to N (1 to 14)
    ElseIf wsSource.name = "LinkedIn" Or wsSource.name = "Email" Then
        lastColumn = 9 ' LinkedIn and Email have data in columns A to L (1 to 12)
    End If

    ' Check if all values in the specified columns are filled
    isRowComplete = True
    For i = 1 To lastColumn
        If wsSource.Cells(Target.Row, i).value = "" Then
            isRowComplete = False
            Exit For
        End If
    Next i

    ' If the row is complete, check for duplicates and append/update in the Master Worksheet
    If isRowComplete Then
        ' Check for existing row based on the unique identifier (assumed to be in Column A for all sheets)
        existingRow = FindExistingRow(wsMaster, wsSource.Cells(Target.Row, 1).value)

        If existingRow > 0 Then
            ' Update existing row in Master Worksheet
            Set masterRow = wsMaster.Rows(existingRow)
            UpdateMasterRow wsSource, masterRow, Target.Row
            ' Optional: Print a message for debugging purposes
            Debug.Print "Updated row: " & existingRow & " in Master Worksheet from " & wsSource.name
        Else
            ' Find the first completely empty row in the Master Worksheet
            lastRowMaster = FindFirstEmptyRow(wsMaster)

            ' Define the range of the source row that you want to copy
            Set sourceRow = wsSource.Rows(Target.Row)

            ' Use lastRowMaster to determine where to append in the Master Worksheet
            Set masterRow = wsMaster.Rows(lastRowMaster)

            ' Depending on the source worksheet, map columns to Master Worksheet
            If wsSource.name = "Upwork" Then
                ' Map Upwork columns A-N to Master Worksheet columns A-N
                For i = 1 To 13
                    masterRow.Cells(1, i).value = sourceRow.Cells(1, i).value ' A-N
                Next i
            ElseIf wsSource.name = "LinkedIn" Or wsSource.name = "Email" Then
               ' Map LinkedIn and Email columns A-L to Master Worksheet columns based on the updated mapping
masterRow.Cells(1, 2).value = sourceRow.Cells(1, 1).value ' Date (A) -> Master Date (O, column 15)
masterRow.Cells(1, 14).value = sourceRow.Cells(1, 2).value ' Name (B) -> Master Name (B, column 2)
masterRow.Cells(1, 15).value = sourceRow.Cells(1, 3).value ' Designation (C) -> Master Designation (P, column 16)
masterRow.Cells(1, 16).value = sourceRow.Cells(1, 4).value ' Company (D) -> Master Company (Q, column 17)
masterRow.Cells(1, 6).value = sourceRow.Cells(1, 5).value ' LinkedIn Profile (E) -> Master LinkedIn Profile (R, column 18)
masterRow.Cells(1, 17).value = sourceRow.Cells(1, 6).value ' Email (F) -> Master Email (S, column 6)
masterRow.Cells(1, 4).value = sourceRow.Cells(1, 7).value ' Location (G) -> Master Location (T, column 19)
masterRow.Cells(1, 18).value = sourceRow.Cells(1, 8).value ' Response (H) -> Master Response (U, column 4)
masterRow.Cells(1, 19).value = sourceRow.Cells(1, 9).value ' F1 (I) -> Master F1 (V, column 20)

            End If
            

            ' Optional: Print a message for debugging purposes
            Debug.Print "Appending row: " & Target.Row & " from " & wsSource.name & " to row: " & lastRowMaster
        End If
    End If
End Sub

Function FindExistingRow(ws As Worksheet, uniqueValue As Variant) As Long
    Dim i As Long
    Dim lastRow As Long

    lastRow = ws.Cells(ws.Rows.Count, 1).End(xlUp).Row

    ' Loop through the Master Worksheet to find the existing row
    For i = 1 To lastRow
        If ws.Cells(i, 1).value = uniqueValue Then ' Assuming unique identifier is in Column A
            FindExistingRow = i ' Return the found row number
            Exit Function
        End If
    Next i

    ' If no existing row is found, return 0
    FindExistingRow = 0
End Function

Sub UpdateMasterRow(wsSource As Worksheet, masterRow As Range, sourceRowIndex As Long)
    Dim i As Integer
    Dim lastColumn As Integer

    ' Determine the last column based on the source worksheet
    If wsSource.name = "Upwork" Then
        lastColumn = 13 ' Upwork has data in columns A to N (1 to 14)
    ElseIf wsSource.name = "LinkedIn" Or wsSource.name = "Email" Then
        lastColumn = 9 ' LinkedIn and Email have data in columns A to L (1 to 12)
    End If

    ' Update the Master Worksheet with values from the source worksheet
    If wsSource.name = "Upwork" Then
        ' Update Upwork columns A-N in Master Worksheet columns A-N
        For i = 1 To 13
            masterRow.Cells(1, i).value = wsSource.Cells(sourceRowIndex, i).value ' A-N
        Next i
    ElseIf wsSource.name = "LinkedIn" Or wsSource.name = "Email" Then
        ' Update LinkedIn and Email columns A-L in Master Worksheet columns O, B, P-X
 masterRow.Cells(1, 2).value = wsSource.Cells(sourceRowIndex, 1).value ' Date (A) -> Master Date (O, column 15)
masterRow.Cells(1, 14).value = wsSource.Cells(sourceRowIndex, 2).value ' Name (B) -> Master Name (B, column 2)
masterRow.Cells(1, 15).value = wsSource.Cells(sourceRowIndex, 3).value ' Designation (C) -> Master Designation (P, column 16)
masterRow.Cells(1, 16).value = wsSource.Cells(sourceRowIndex, 4).value ' Company (D) -> Master Company (Q, column 17)
masterRow.Cells(1, 6).value = wsSource.Cells(sourceRowIndex, 5).value ' LinkedIn Profile (E) -> Master LinkedIn Profile (R, column 18)
masterRow.Cells(1, 17).value = wsSource.Cells(sourceRowIndex, 6).value ' Email (F) -> Master Email (S, column 6)
masterRow.Cells(1, 4).value = wsSource.Cells(sourceRowIndex, 7).value ' Location (G) -> Master Location (T, column 19)
masterRow.Cells(1, 4).value = wsSource.Cells(sourceRowIndex, 8).value ' Response (H) -> Master Response (U, column 4)
masterRow.Cells(1, 18).value = wsSource.Cells(sourceRowIndex, 9).value ' F1 (I) -> Master F1 (V, column 20)


    End If
End Sub

Function FindFirstEmptyRow(ws As Worksheet) As Long
    Dim i As Long
    Dim lastRow As Long
    Dim isEmpty As Boolean

    lastRow = ws.Cells(ws.Rows.Count, 1).End(xlUp).Row

    ' Start checking from the first row down to the last used row
    For i = 1 To lastRow + 1 ' Check until the next row after the last used row
        isEmpty = Application.CountA(ws.Rows(i)) = 0
        If isEmpty Then
            FindFirstEmptyRow = i ' Return the first empty row
            Exit Function
        End If
    Next i

    ' If no empty row is found, return the next row after last used
    FindFirstEmptyRow = lastRow + 1
End Function


