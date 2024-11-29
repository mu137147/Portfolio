VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Sheet2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Private Sub Worksheet_Change(ByVal Target As Range)
    ' Check if the change is in the relevant columns
    If Not Intersect(Target, Me.Range("A1:M1000")) Is Nothing Then ' Adjust for LinkedIn
        Call UpdateMasterSheet(Me, Target)
    End If
End Sub


