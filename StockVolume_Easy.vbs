Sub stock_easy()
    '---------------------------
    'Loop through all worksheets
    '---------------------------
    For Each ws In Worksheets
        'Keep track of the row for ticker symbol in summary table
        Dim row As Integer
        row = 2
        
        'Set an initial varible for holding the total volume
        Dim vol_total As Double
        vol_total = 0

        'Add the header 'Ticker','Total stock Volume' in summary table
        ws.Cells(1, 9).Value = "Ticker"
        ws.Cells(1, 10).Value = "Total Stock Volume"
        
        'Determine the Last row in each worksheet
        LastRow = ws.Cells(Rows.Count, 1).End(xlUp).row
        
        '---------------------------------------
        'loop through all rows in each worksheet
        '---------------------------------------
        For i = 2 To LastRow
            'Add value to the column for Total Stock Volume
            vol_total = vol_total + ws.Cells(i, 7).Value
            ws.Cells(row, 10).Value = vol_total
            'Add value to the column of Ticker 
            ws.Cells(row, 9).Value = ws.Cells(i, 1).Value
            
            'Check if we are still within the same ticker, if it is not...
            If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
                'Add one to the summary table row
                row = row + 1
                'Reset the total volume
                 vol_total = 0
            End If
        Next i
            
        
    Next ws
End Sub

