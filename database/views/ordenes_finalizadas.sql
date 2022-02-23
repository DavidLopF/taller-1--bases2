CREATE VIEW marketplace.total_purchase_complete AS
SELECT marketplace.buyer.id, marketplace.buyer.user_id, SUM(marketplace.order.price) AS total_purchase
FROM marketplace.buyer
INNER JOIN marketplace.order ON marketplace.buyer.id = marketplace.order.buyer_id
WHERE marketplace.order.status = 'complete'
GROUP BY marketplace.buyer.id;