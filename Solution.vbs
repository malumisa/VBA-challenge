Sub Multiple_year_stock_data()

Dim Ws As Worksheet
   'Set initial variables for worksheet and last row
Dim Ws As Worksheet
    For Each Ws In ActiveWorkbook.Worksheets
    Ws.Activate
    
        LastRow = Ws.Cells(Rows.Count, 1).End(xlUp).Row
        
        'Print header row starting with column I
        Cells(1, 9).Value = "Ticker"
        Cells(1, 10).Value = "Yearly Change"
        Cells(1, 11).Value = "Percent Change"
        Cells(1, 12).Value = "Total Stock Volume"
        
       ' Set initial values for holding Opening price, Closing prie, Yearly change, Ticker name, ercentage change and volume
        Dim OpenPrice As Double
        Dim ClosePrice As Double
        Dim YearlyChange As Double
        Dim TickerName As String
        Dim PercentChange As Double
        Dim Volume As Double
        Dim Row As Double
        Dim Column As Integer
        Dim i As Long
        
        Volume = 0
        Row = 2
        Column = 1
        
        OpenPrice = Cells(2, Column + 2).Value
        
        For i = 2 To LastRow
        
        ' Check if we are still within the same Tick, if we are not ...
        If Cells(i + 1, Column).Value <> Cells(i, Column).Value Then
        TickerName = Cells(i, Column).Value
        Cells(Row, Column + 8).Value = TickerName
        ClosePrice = Cells(i, Column + 5).Value
        YearlyChange = ClosePrice - OpenPrice
        Cells(Row, Column + 9).Value = YearlyChange
        If (OpenPrice = 0 And ClosePrice = 0) Then
        PercentChange = 0
        ElseIf (OpenPrice = 0 And ClosePrice <> 0) Then
        PercentChange = 1
        Else
        PercentChange = YearlyChange / OpenPrice
        Cells(Row, Column + 10).Value = PercentChange
        Cells(Row, Column + 10).NumberFormat = "0.00%"
        End If
        Volume = Volume + Cells(i, Column + 6).Value
        Cells(Row, Column + 11).Value = Volume
        Row = Row + 1
        OpenPrice = Cells(i + 1, Column + 2)
        Volume = 0
        Else
        Volume = Volume + Cells(i, Column + 6).Value
        End If
        Next i
        
        'Colour index
        YearlyChangeLastRow = Ws.Cells(Rows.Count, Column + 8).End(xlUp).Row
        For j = 2 To YearlyChangeLastRow
        If (Cells(j, Column + 9).Value > 0 Or Cells(j, Column + 9).Value = 0) Then
        Cells(j, Column + 9).Interior.ColorIndex = 10
        ElseIf Cells(j, Column + 9).Value < 0 Then
        Cells(j, Column + 9).Interior.ColorIndex = 3
        End If
        Next j
        
        ' Greatest increase, decrease, greatest total volume
        Cells(2, Column + 14).Value = "Greatest % Increase"
        Cells(3, Column + 14).Value = "Greatest % Decrease"
        Cells(4, Column + 14).Value = "Greatest Total Volume"
        Cells(1, Column + 15).Value = "Ticker"
        Cells(1, Column + 16).Value = "Value"
        
        For Z = 2 To YearlyChangeLastRow
        If Cells(Z, Column + 10).Value = Application.WorksheetFunction.max(Ws.Range("K2:K" & YearlyChangeLastRow)) Then
        Cells(2, Column + 15).Value = Cells(Z, Column + 8).Value
        Cells(2, Column + 16).Value = Cells(Z, Column + 10).Value
        Cells(2, Column + 16).NumberFormat = "0.00%"
        ElseIf Cells(Z, Column + 10).Value = Application.WorksheetFunction.Min(Ws.Range("K2:K" & YearlyChangeLastRow)) Then
        Cells(3, Column + 15).Value = Cells(Z, Column + 8).Value
        Cells(3, Column + 16).Value = Cells(Z, Column + 10).Value
        Cells(3, Column + 16).NumberFormat = "0.00%"
        ElseIf Cells(Z, Column + 11).Value = Application.WorksheetFunction.max(Ws.Range("L2:L" & YearlyChangeLastRow)) Then
        Cells(4, Column + 15).Value = Cells(Z, Column + 8).Value
        Cells(4, Column + 16).Value = Cells(Z, Column + 11).Value
        End If
        Next Z
        Next Ws     
End Sub
