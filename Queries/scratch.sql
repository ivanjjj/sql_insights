
-- Question Set 1

-- Question 1
-- SELECT BillingCountry, COUNT(*) AS total_invoices
-- FROM Invoice
-- GROUP BY BillingCountry
-- ORDER BY total_invoices DESC

-- Question 2
-- SELECT BillingCity, SUM(Total) AS sum_total
-- FROM Invoice
-- GROUP BY BillingCity
-- ORDER BY sum_total DESC
-- LIMIT 1

-- Question 3
-- SELECT Customer.FirstName || ' ' || Customer.LastName AS full_name, Customer.CustomerId, SUM(Invoice.Total) AS sum_total
-- FROM Invoice
-- JOIN Customer
-- ON Invoice.CustomerId = Customer.CustomerId
-- GROUP BY full_name
-- ORDER BY sum_total DESC
-- LIMIT 1

-- Question Set 2

-- Question 1
-- SELECT DISTINCT Customer.Email, Customer.FirstName, Customer.LastName, Genre.Name AS Name
-- FROM Customer
-- JOIN Invoice
-- ON Invoice.CustomerId = Customer.CustomerId
-- JOIN InvoiceLine
-- ON Invoice.InvoiceId = InvoiceLine.InvoiceId
-- JOIN Track
-- ON InvoiceLine.TrackId = Track.TrackId
-- JOIN Genre
-- ON Track.GenreId = Genre.GenreId
-- WHERE Track.GenreId = 1

-- Question 2
-- SELECT Artist.ArtistId, Artist.Name, COUNT(*) AS total_songs
-- FROM Artist
-- JOIN Album
-- ON Artist.ArtistId = Album.ArtistId
-- JOIN Track
-- ON Album.AlbumId = Track.AlbumId
-- JOIN Genre
-- ON Track.GenreId = Genre.GenreId
-- WHERE Genre.GenreId = 1
-- GROUP BY Artist.ArtistId
-- ORDER BY total_songs DESC
-- LIMIT 10

-- Question 3a
-- SELECT Artist.ArtistId, Artist.Name, SUM(InvoiceLine.Quantity * InvoiceLine.UnitPrice) AS amount_spent
-- FROM Artist
-- JOIN Album
-- ON Artist.ArtistId = Album.ArtistId
-- JOIN Track
-- ON Album.AlbumId = Track.AlbumId
-- JOIN InvoiceLine
-- ON InvoiceLine.TrackId = Track.TrackId
-- JOIN Invoice
-- ON InvoiceLine.InvoiceId = Invoice.InvoiceId
-- GROUP BY Artist.ArtistId
-- ORDER BY amount_spent DESC
-- LIMIT 10

-- Question 3b
-- SELECT Artist.ArtistId,
-- Artist.Name, SUM(InvoiceLine.Quantity * InvoiceLine.UnitPrice) AS amount_spent,
-- Customer.CustomerId,
-- Customer.FirstName,
-- Customer.LastName
-- FROM Artist
-- JOIN Album
-- ON Artist.ArtistId = Album.ArtistId
-- JOIN Track
-- ON Album.AlbumId = Track.AlbumId
-- JOIN InvoiceLine
-- ON InvoiceLine.TrackId = Track.TrackId
-- JOIN Invoice
-- ON InvoiceLine.InvoiceId = Invoice.InvoiceId
-- JOIN Customer
-- ON Customer.CustomerId = Invoice.CustomerId
-- WHERE Artist.ArtistId = 90
-- GROUP BY Artist.ArtistId, Customer.CustomerId
-- ORDER BY amount_spent DESC
-- LIMIT 10

-- Question Set 3

-- Question 1

WITH table_1 AS (SELECT COUNT(*) as total_purchases, Customer.Country, Genre.Name, Genre.GenreId
FROM Invoice
JOIN InvoiceLine
ON Invoice.InvoiceId = InvoiceLine.InvoiceId
JOIN Customer
ON Customer.CustomerId = Invoice.CustomerId
JOIN Track
ON InvoiceLine.TrackId = Track.TrackId
JOIN Genre
ON Track.GenreId = Genre.GenreId
GROUP BY Customer.Country, Genre.GenreId),

table_2 AS (SELECT Country, MAX(total_purchases) Purchases

FROM table_1
GROUP BY 1)

SELECT table_2.Purchases, table_1.Country, table_1.Name, table_1.GenreId
FROM table_1
JOIN table_2
ON table_1.Country = table_2.Country
WHERE Purchases = table_1.total_purchases
GROUP BY 1, 2, 3
ORDER BY 1