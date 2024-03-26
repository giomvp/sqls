# High Lead - Sales and Commission Analysis

## Description
This project aims to generate sales reports and analyze sales representatives' commissions based on transactional data stored in a database. The reports require aggregating data at both the document and item line level, while tracking the flow from quote to order, invoice, and credit note (if applicable).

## Required Reports
1. **Sales Documents List**: A report listing all sales, quotes, sales orders, invoices, and credit notes, displaying relevant information such as document type, date, document number, customer details, and total amounts.

2. **Document Flow by Customer**: A report that, given a customer code, shows the sales flow for that customer, starting from the quote and following through to the invoice and credit note (if applicable).

3. **Item Flow by Quote**: A report that, given a quote number, shows the sales flow of all items, detailing the quantities and amounts at each stage (quote, sales order, invoice, and credit note).

4. **Monthly Sales Representatives' Commissions**: A report showing the monthly commissions for sales representatives based on net sales, grouped by representative and ordered by month. Commissions are calculated according to variable rates based on quantity sold tiers.

## Core Skills
- SQL
- Data Analysis
- Report Generation
- Data Modeling
- Data Analytics

## Attached Files
- **dataBase**: Database creation file.
- **dbSchema**: Graphical representation of tables, files, and keys.
- **Enunciado de Problemas**: Description of the required reports.
- **queries**: SQL queries to generate the requested reports.