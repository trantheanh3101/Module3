# 1. Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
SELECT oID,oDate,oTotalPrice
FROM `Order`;
# 2. Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
SELECT
    c.cID AS CustomerID,
    c.cName AS CustomerName,
    p.pID AS ProductID,
    p.pName AS ProductName,
    od.odQTY AS Quantity,
    od.odQTY * p.pPrice AS TotalPrice
FROM Customer c
LEFT JOIN`Order` o ON c.cID = o.cID
LEFT JOIN OrderDetail od ON o.oID = od.oID
LEFT JOIN Product p ON od.pID = p.pID
ORDER BY c.cID, o.oID, p.pID;

# 3. Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT c.cID AS CustomerID,c.cName AS CustomerName
FROM Customer c
LEFT JOIN `Order` o ON c.cID = o.cID
WHERE o.oID IS NULL;

# 4. Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán
# của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
SELECT o.oID AS OrderID, o.oDate AS OrderDate,
    SUM(od.odQTY * p.pPrice) AS TotalPrice
FROM `Order` o
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID
GROUP BY o.oID, o.oDate;
