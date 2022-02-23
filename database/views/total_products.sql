CREATE VIEW marketplace.product_details_view AS
SELECT marketplace.products.id, marketplace.products.name, marketplace.products.price, marketplace.products.brand, marketplace.product_categories.name AS category, marketplace.product_details.size, marketplace.product_details.color
FROM marketplace.products
INNER JOIN marketplace.product_details ON marketplace.products.id = marketplace.product_details.product_id
INNER JOIN marketplace.product_categories ON marketplace.products.product_categories_id = marketplace.product_categories.id;