Sub stock_hard()
    '---------------------------
    'Loop through all worksheets
    '---------------------------
    For Each ws In Worksheets
        'For summary table I
        ws.Cells(1, 9).Value = "Ticker"
        ws.Cells(1, 10).Value = "Yearly Change"
        ws.Cells(1, 11).Value = "Percent Change"
        ws.Cells(1, 12).Value = "Total Stock Volume"
        'For summary table II
        ws.Cells(2, 15).Value = "Greatest % Increase"
        ws.Cells(3, 15).Value = "Greatest % Decrease"
        ws.Cells(4, 15).Value = "Greatest Total Volume"
        ws.Cells(1, 16).Value = "Ticker"
        ws.Cells(1, 17).Value = "Value"
        
        
        'Determine the last row in each worksheet
        LastRow = ws.Cells(Rows.Count, 1).End(xlUp).row
        'Keep track of the row for ticker symbol in summary table I
        Dim row As Integer
        row = 2
        'Keep track of the row for the first open volume of each ticker
        Dim m As Long
        m = 2
        'Set an initial varible for holding the total volume
        Dim total_vol As Double
        total_vol = 0
        'Set varibles for 'open volume','close volume',
        ''greatest increase percentage','greatest increase percentage',
        'and 'greatest stock volume'
        Dim open_vol As Double
        Dim close_vol As Double
        Dim great_incre As Double
        Dim great_decre As Double
        Dim great_vol As Double
        
        '---------------------------------------
        'loop through all rows in each worksheet
        '---------------------------------------
        For i = 2 To LastRow
            'Add value to the column for  Total Stock Volume
            total_vol = total_vol + ws.Cells(i, 7).Value
            ws.Cells(row, 12).Value = total_vol
            'Add value to the column for Ticker
            ws.Cells(row, 9).Value = ws.Cells(i, 1).Value
            'Set initial value for open volume
            open_vol = ws.Cells(m, 3).Value
            'Check if we are still within the same ticker, if it is not...
            If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
                total_vol = 0
                'Set value for close volume
                close_vol = ws.Cells(i, 6).Value
                ws.Cells(row, 10).Value = close_vol - open_vol
                'Set value for column of Percent Change convert the cell format to percentage
                If open_vol = 0 Then
                    ws.Cells(row, 11).Value = 0
                Else
                    ws.Cells(row, 11).Value = ws.Cells(row, 10).Value / open_vol
                    ws.Cells(row, 11).NumberFormat = "0.00%"
                End If
                
                'Conditional highlight positive/negtive
                If ws.Cells(row, 11).Value > 0 Then
                    ws.Cells(row, 11).Interior.ColorIndex = 4
                Else
                    ws.Cells(row, 11).Interior.ColorIndex = 3
                                 
                End If
           'Reset the row of open volume
            m = i + 1
            'Reset the row of summary table
            row = row + 1
            End If
        Next i
        
        'Determine the last row in each worksheet
        lastrow2 = ws.Cells(Rows.Count, "I").End(xlUp).row
        great_incre = Cells(2, 11).Value
        great_decre = Cells(2, 11).Value
        great_value = Cells(2, 12).Value
        
         '---------------------------------------
        'loop through all rows in summary table I
        '---------------------------------------
        For j = 2 To lastrow2
            'Find the greatest increse pertetage and his ticker symbol
            If ws.Cells(j, 11).Value > great_incre Then
                great_incre = ws.Cells(j, 11).Value
                ws.Cells(2, 17).Value = great_incre
                ws.Cells(2, 17).NumberFormat = "0.00%"
                ws.Cells(2, 16).Value = ws.Cells(j, 9).Value
            'Find the greatest decrese pertetage and his ticker symbol
            ElseIf ws.Cells(j, 11).Value < great_decre Then
                great_decre = ws.Cells(j, 11).Value
                ws.Cells(3, 17).Value = great_decre
                ws.Cells(3, 17).NumberFormat = "0.00%"
                ws.Cells(3, 16).Value = ws.Cells(j, 9).Value
            
            'Find the greatest volume
            ElseIf great_value < ws.Cells(j, 12).Value Then
                great_value = ws.Cells(j, 12).Value
                ws.Cells(4, 17).Value = great_value
                ws.Cells(4, 16).Value = ws.Cells(j, 9).Value
                
            
            End If
        
        Next j
                
            
    Next ws
End Sub
