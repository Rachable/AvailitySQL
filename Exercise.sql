select FirstName, LastName
from customer
where LastName like 'S%' or LastName like 's%'
order by LastName desc, FirstName desc;

select CustID, FirstName, LastName, nvl(totalAmount,0)
from customer
left outer join (select CustomerID, sum(nvl(Cost,0) * nvl(Quantity,0)) as totalAmount
                 from Order o
                 left outer join OrderLine ol on o.OrderID = ol.OrdID
                 where OrderDate >= add_months(sysdate, -6)
                 group by CustomerID) t on CustID = t.CustomerID;
                 
select CustID, FirstName, LastName, totalAmount
from customer
inner join (select CustomerID, sum(nvl(Cost,0) * nvl(Quantity,0)) as totalAmount
                 from Order o
                 left outer join OrderLine ol on o.OrderID = ol.OrdID
                 where OrderDate >= add_months(sysdate, -6)
                 group by CustomerID
                 having sum(nvl(Cost,0) * nvl(Quantity,0)) between 100 and 500) t on CustID = t.CustomerID;