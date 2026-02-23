-- Sample data for Revenue Leakage Detection System
-- Data intentionally includes billing & payment issues

-- CONTRACTS
INSERT INTO contracts (
    customer_id,
    product_id,
    start_date,
    end_date,
    contracted_units,
    price_per_unit,
    discount_percent,
    billing_frequency
)
VALUES
(101, 1, '2024-01-01', '2024-12-31', 1000, 5.00, 10, 'monthly'),
(102, 1, '2024-01-01', '2024-12-31', 500, 6.00, 0, 'monthly');

-- USAGE EVENTS (actual usage)
INSERT INTO usage_events (
    customer_id,
    product_id,
    usage_date,
    units_used
)
VALUES
(101, 1, '2024-03-15', 1200),  -- exceeds contract
(102, 1, '2024-03-18', 400);   -- within limit

-- INVOICES (under-billing case)
INSERT INTO invoices (
    customer_id,
    billing_period_start,
    billing_period_end,
    invoice_amount,
    generated_date
)
VALUES
(101, '2024-03-01', '2024-03-31', 5000, '2024-04-01'),
(102, '2024-03-01', '2024-03-31', 2400, '2024-04-01');

-- PAYMENTS (partial payment case)
INSERT INTO payments (
    invoice_id,
    payment_date,
    amount_paid,
    payment_status
)
VALUES
(1, '2024-04-10', 4500, 'partial'),
(2, '2024-04-05', 2400, 'paid');