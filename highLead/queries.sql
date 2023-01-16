-- Report No1
--------------------------------------------------------------------

select 
	'Quotation' as 'Document Type',
    strftime('%d-%m-%Y', a.DocDate) as 'Document Date', 
    a.DocNum as 'Document Number', 
    c.CardCode  as 'Client Code', 
    c.CardName  as 'Client Name', 
    c.LicTradNum  as 'RUC', 
    printf("%.2f", sum(b.LineTotal - b.VatSum)) as SubTotal, 
    printf("%.2f",sum( b.VatSum))  as 'Tax', 
    printf("%.2f",sum (b.LineTotal))  as 'Total'
    
from QUT1 b 
	inner join OQUT a on b.DocEntry = a.DocEntry
	inner join OCRD c on a.CardCode = c.CardCode

group by 
    a.DocDate, 
    a.DocNum, 
    c.CardCode, 
    c.CardName, 
    c.LicTradNum

union all

select 
	'Sell Order' as 'Document Type',
    strftime('%d-%m-%Y', a.DocDate) as 'Document Date', 
    a.DocNum as 'Document Number', 
    c.CardCode  as 'Client Code', 
    c.CardName  as 'Client Name', 
    c.LicTradNum  as 'RUC', 
    printf("%.2f", sum(b.LineTotal - b.VatSum)) as SubTotal, 
    printf("%.2f",sum( b.VatSum))  as 'Tax', 
    printf("%.2f",sum (b.LineTotal))  as 'Total'
    
from RDR1 b 
	inner join ORDR a on b.DocEntry = a.DocEntry
	inner join OCRD c on a.CardCode = c.CardCode

group by 
    a.DocDate, 
    a.DocNum, 
    c.CardCode, 
    c.CardName, 
    c.LicTradNum
    
union all

select 
	'Invoice' as 'Document Type',
    strftime('%d-%m-%Y', a.DocDate) as 'Document Date', 
    a.DocNum as 'Document Number', 
    c.CardCode  as 'Client Code', 
    c.CardName  as 'Client Name', 
    c.LicTradNum  as 'RUC', 
    printf("%.2f", sum(b.LineTotal - b.VatSum)) as SubTotal, 
    printf("%.2f",sum( b.VatSum))  as 'Tax', 
    printf("%.2f",sum (b.LineTotal))  as 'Total'
    
from INV1 b 
	inner join OINV a on b.DocEntry = a.DocEntry
	inner join OCRD c on a.CardCode = c.CardCode

group by 
    a.DocDate, 
    a.DocNum, 
    c.CardCode, 
    c.CardName, 
    c.LicTradNum
    
union all

select 
	'Credit Note' as 'Document Type',
    strftime('%d-%m-%Y', a.DocDate) as 'Document Date', 
    a.DocNum as 'Document Number', 
    c.CardCode  as 'Client Code', 
    c.CardName  as 'Client Name', 
    c.LicTradNum  as 'RUC', 
    printf("%.2f", sum(b.LineTotal - b.VatSum)) as SubTotal, 
    printf("%.2f",sum( b.VatSum))  as 'Tax', 
    printf("%.2f",sum (b.LineTotal))  as 'Total'
    
from RIN1 b 
	inner join ORIN a on b.DocEntry = a.DocEntry
	inner join OCRD c on a.CardCode = c.CardCode

group by 
    a.DocDate, 
    a.DocNum, 
    c.CardCode, 
    c.CardName, 
    c.LicTradNum;
    

 -- Report No2
--------------------------------------------------------------------

select 
	distinct c.CardName  as 'Client Name', 
    c.LicTradNum  as 'RUC',
    a.DocEntry as 'Quotation #',
    b.DocEntry as 'Sell Order #',
    d.DocEntry as 'Invoice #',
    e.DocEntry as 'Credit Note #'
    
from OQUT a 
	left join OCRD c on a.CardCode = c.CardCode
    left join RDR1 b on a.DocEntry = b.BaseEntry
    left join INV1 d on b.DocEntry = d.BaseEntry
    left join RIN1 e on d.DocEntry = e.BaseEntry
    
Where
	a.CardCode = 'C20000';

    
-- Report No3
--------------------------------------------------------------------

select
    a.ItemCode  as 'Item Code',
    a.ItemName  as 'Item Name',
    a.CodBars  as 'Bar Code',
    b.Quantity  as 'Quoted Qty',
    b.LineTotal  as 'Total Cost',  
    c.DocEntry  as 'Sell Order #',
	c.Quantity  as 'Sell Order Qty',
    c.LineTotal  as 'Sell Order Total',
    d.DocEntry  as 'Invoice #',
    d.Quantity  as 'Invoice Qty',
    d.LineTotal  as 'Invoice Total',
    e.DocEntry as 'Credit Note #',
    e.Quantity as 'Credit Note Qty',
    e.LineTotal  as 'Credit Note Total'
        
from QUT1 b 
	left join OITM a on a.ItemCode = b.ItemCode
	left join RDR1 c on b.DocEntry = c.BaseEntry and b.LineNum = c.BaseLine
	left join INV1 d on c.DocEntry = d.BaseEntry and c.LineNum = d.BaseLine
	left join RIN1 e on d.DocEntry = e.BaseEntry and d.LineNum = e.BaseLine
     
where
	b.DocEntry = '484'
    
group by 
	a.ItemCode; 


-- Report No4
--------------------------------------------------------------------

--declare @NumMonths int = 3;

select
	Seller,
    Month,
    Total_Sells as 'Total Sales',
    Total_Comition as 'Total Comitions',
    one as '1.00%',
    fifty as '0.50%',
    twentyfive as '0.025%',
    printf("%.2f", sum(Total_Comition) OVER (Partition by Seller  Order by Month)) as 'Cumulative Total'

from
	(

        select
            b.SlpName as 'Seller',
            strftime('%m', a.DocDate) as 'Month',
            printf("%.2f", sum(c.LineTotal - c.VatSum)) as 'Total_Sells',
        
        
            printf("%.2f", sum(case 
                when c.Quantity >= 20 then (c.LineTotal - c.VatSum )* 0.01
                when c.Quantity >= 7 and c.Quantity < 20 then  (c.LineTotal - c.VatSum)*0.005
                when c.Quantity < 7 then  (c.LineTotal - c.VatSum)*0.0025 
                else 0 
            end)) as 'Total_Comition',
        
            printf("%.2f", sum(case when c.Quantity >= 20 then (c.LineTotal - c.VatSum )*0.01 else 0 end)) as 'one',
            printf("%.2f", sum(case when c.Quantity >= 7 and c.Quantity < 20 then  (c.LineTotal - c.VatSum )*0.005 else 0 end)) as 'fifty',
            printf("%.2f", sum(case when c.Quantity < 7 then (c.LineTotal - c.VatSum )*0.0025 else 0 end)) as 'twentyFive'

        from OINV a 
            inner join INV1 c on a.DocEntry = c.DocEntry
            left join OSLP b on a.SlpCode = b.SlpCode
        
        -- where 
            -- a.DocDate between DATE('now', '-@NumMonths months') and date()
      		-- a.DocDate between DATE('now', '-3 months') and date()    --Example
            -- seller = 'José Pérez'   -- Case Study
      
        group by 
            seller,month
)

