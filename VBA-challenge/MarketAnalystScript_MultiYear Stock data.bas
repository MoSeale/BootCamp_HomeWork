Attribute VB_Name = "Module1"
'VBA Homework
'This script was developed on test data
' Test data file is "alphabetical_testing.xlsx"

''''''''''''''''''''''''''''''''''''''''''''''''
Sub StkMktInfo():


'''Variable Declaration

Dim ticker_symbol, pcnt_inc_ticker, pcnt_dec_ticker, max_ticker As String
Dim yearly_change, pcnt_chg, greatest_pcnt_inc, greatest_pcnt_dec As Double
Dim total_stock_volume, stock_volume, lastRow, ticker_counter, status_date, first_date, last_date As Long
Dim opening_price, high_price, low_price, closing_price, first_date_open_price, last_date_close_price, max_total_volume As Double
Dim ws As Worksheet

Worksheets("2016").Activate

'' Loop through all sheets
    
    For Each ws In ThisWorkbook.Worksheets
        ws.Activate
        ws.Range("I:U").ClearContents
        ws.Range("I:U").ClearFormats

        lastRow = ws.Cells(Rows.Count, "A").End(xlUp).Row - 1
        'MsgBox lastRow
            
        ticker_counter = 0
        greatest_pcnt_inc = 0
        greatest_pcnt_dec = 0
        max_total_volume = 0
        
        Cells(1, 9).Value = "Ticker"
        Cells(1, 10).Value = "Yearly Change"
        Cells(1, 11).Value = "Percent Change"
        Cells(1, 12).Value = "Total Stock Volume"
        Cells(1, 13).Value = "first_date"
        Cells(1, 14).Value = "last_date"
        
        Cells(1, 15).Value = "first_date_open_price"
        Cells(1, 16).Value = "last_date_close_price"
        
        
        
        Cells(1, 20).Value = "Ticker"
        Cells(1, 21).Value = "Value"
        Cells(2, 19).Value = "Greatest % Increase"
        Cells(3, 19).Value = "Greatest % Decrease"
        Cells(4, 19).Value = "Greatest Total Volume"
    
        ''Gather data
        
        For i = 2 To lastRow
        
            ticker_symbol = Cells(i, 1).Value  '<ticker>
            status_date = Cells(i, 2).Value  '<date>
            opening_price = Cells(i, 3).Value  '<open>
            high_price = Cells(i, 4).Value  '<high>
            low_price = Cells(i, 5).Value  '<low>
            closing_price = Cells(i, 6).Value  '<close>
            stock_volume = Cells(i, 7).Value  '<vol>
            
                
            If (Cells(i, 1).Value <> Cells(i - 1, 1).Value) Then
            'MsgBox (Cells(i, 1).Value) ' basic assignment
            
                total_stock_volume = 0
                ticker_counter = ticker_counter + 1
                Cells(ticker_counter + 1, 9).Value = ticker_symbol 'unique ticker names
                'Cells(ticker_counter + 1, 12).Value = Cells(ticker_counter + 1, 12).Value + stock_volume 'Total Stock Volume
                
                If (opening_price = 0) Then
                
                Else
                    first_date = status_date   'first date
                    last_date = status_date   'last date
                    first_date_open_price = opening_price 'first date open price
                    last_date_close_price = closing_price   'last date close price
                    total_stock_volume = total_stock_volume + stock_volume
                End If

            Else


'
                 If (opening_price = 0) Then
                    
                 
                 Else
                    If (first_date > status_date) Then
                        first_date = status_date
                        first_date_open_price = opening_price
                    End If
    
                    If (last_date < status_date) Then
                        last_date = status_date
                        last_date_close_price = closing_price
                    End If
                    
                 End If
                 
                 
                     total_stock_volume = total_stock_volume + stock_volume
                 
            End If
            
            Cells(ticker_counter + 1, 12).Value = total_stock_volume 'Total Stock Volume
            Cells(ticker_counter + 1, 13).Value = first_date 'first_date
            
            Cells(ticker_counter + 1, 14).Value = last_date 'last_date
            Cells(ticker_counter + 1, 15).Value = first_date_open_price
            Cells(ticker_counter + 1, 16).Value = last_date_close_price
        
        Next i
        
        For j = 2 To ticker_counter + 1
            yearly_change = Cells(j, 16).Value - Cells(j, 15).Value
            first_date_open_price = Cells(j, 15).Value
            
            'conditional formatting

            If (yearly_change >= 0) Then
                Cells(j, 10).Interior.Color = vbGreen
            Else
                 Cells(j, 10).Interior.Color = vbRed
            End If


            If (first_date_open_price = 0) Then
            
                prcnt_chg = "N/A"
            
            Else
                pcnt_chg = Round((yearly_change / first_date_open_price) * 100, 2)
    
                If pcnt_chg >= 0 And pcnt_chg > greatest_pcnt_inc Then
                    greatest_pcnt_inc = pcnt_chg
                    pcnt_inc_ticker = Cells(j, 9).Value
                End If
    
                If pcnt_chg < 0 And pcnt_chg < greatest_pcnt_dec Then
                    greatest_pcnt_dec = pcnt_chg
                    pcnt_dec_ticker = Cells(j, 9).Value
                End If
            End If
            
            If (Cells(j, 12).Value > max_total_volume) Then
                max_total_volume = Cells(j, 12).Value
                max_ticker = Cells(j, 9).Value
            End If



            'Output
            Cells(j, 10).Value = yearly_change
            Cells(j, 11).Value = Str(pcnt_chg) + "%"

            'Challenge

            Cells(2, 20).Value = pcnt_inc_ticker
            Cells(2, 21).Value = Str(greatest_pcnt_inc) + "%"
            Cells(3, 20).Value = pcnt_dec_ticker
            Cells(3, 21).Value = Str(greatest_pcnt_dec) + "%"
            Cells(4, 20).Value = max_ticker
            Cells(4, 21).Value = max_total_volume

        Next j
        

    Next ws
    
MsgBox ("All done!")

End Sub

