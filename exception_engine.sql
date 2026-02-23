-- ============================================
-- Revenue Leakage Exception Table
-- ============================================

CREATE TABLE IF NOT EXISTS revenue_leakage_exceptions (
    exception_id SERIAL PRIMARY KEY,
    customer_id INT,
    billing_month DATE,
    leakage_type TEXT,
    expected_revenue NUMERIC(10,2),
    actual_revenue NUMERIC(10,2),
    leakage_amount NUMERIC(10,2),
    severity TEXT,
    detected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Insert Usage vs Invoice Leakage
-- ============================================

INSERT INTO revenue_leakage_exceptions (
    customer_id,
    billing_month,
    leakage_type,
    expected_revenue,
    actual_revenue,
    leakage_amount,
    severity
)
SELECT
    customer_id,
    billing_month,
    'USAGE_VS_INVOICE' AS leakage_type,
    expected_revenue,
    invoice_amount AS actual_revenue,
    leakage_amount,
    CASE
        WHEN leakage_amount > 1000 THEN 'CRITICAL'
        WHEN leakage_amount BETWEEN 500 AND 1000 THEN 'HIGH'
        ELSE 'MEDIUM'
    END AS severity
FROM usage_invoice_leakage;