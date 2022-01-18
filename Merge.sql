use g2;

/*Introduction SQL Server MERGE Statement
Suppose, you have two table called source and target tables, and you need to update the target table based on the values matched from the source table. There are three cases:

The source table has some rows that do not exist in the target table.
In this case, you need to insert rows that are in the source table into the target table.

The target table has some rows that do not exist in the source table. 
In this case, you need to delete rows from the target table.

The source table has some rows with the same keys as the rows in the target table. 
However, these rows have different values in the non-key columns. 
In this case, you need to update the rows in the target table with the values coming from the source table.*/

/*If you use the INSERT, UPDATE, and DELETE statement individually, you have to construct three separate statements to update the data to the target table with the matching rows from the source table.

However, SQL Server provides the MERGE statement that allows you to perform three actions at the same time. 

The following shows the syntax of the MERGE statement:*/

/*
MERGE target_table USING source_table
ON merge_condition
WHEN MATCHED
    THEN update_statement
WHEN NOT MATCHED
    THEN insert_statement
WHEN NOT MATCHED BY SOURCE
    THEN DELETE;
	*/

select * from Productslock;
select * from Productslockbackup;
SELECT * INTO Productslockbackup FROM Productslock;

MERGE Productslockbackup t 
    USING Productslock s
ON (s.id = t.id)
WHEN MATCHED
    THEN UPDATE SET 
        t.name = s.name,
        t.quantity = s.quantity
		
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (id,name,quantity)
         VALUES (s.id,s.name,s.quantity)
WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

	insert into Productslock values(1007,'hard disk',100);
	update Productslock set quantity=50 where id=1001;
	insert into Productslockbackup values(1008,'usb',100);



