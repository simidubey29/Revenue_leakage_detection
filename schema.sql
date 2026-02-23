-- Table: public.contracts

-- DROP TABLE IF EXISTS public.contracts;

CREATE TABLE IF NOT EXISTS public.contracts
(
    contract_id integer NOT NULL DEFAULT nextval('contracts_contract_id_seq'::regclass),
    customer_id integer NOT NULL,
    product_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    contracted_units integer,
    price_per_unit numeric(10,2),
    discount_percent numeric(5,2) DEFAULT 0,
    billing_frequency text COLLATE pg_catalog."default",
    CONSTRAINT contracts_pkey PRIMARY KEY (contract_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.contracts
    OWNER to postgres;

-- Table: public.invoices

-- DROP TABLE IF EXISTS public.invoices;

CREATE TABLE IF NOT EXISTS public.invoices
(
    invoice_id integer NOT NULL DEFAULT nextval('invoices_invoice_id_seq'::regclass),
    customer_id integer,
    billing_period_start date,
    billing_period_end date,
    invoice_amount numeric(10,2),
    generated_date date,
    CONSTRAINT invoices_pkey PRIMARY KEY (invoice_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.invoices
    OWNER to postgres;

-- Table: public.payments

-- DROP TABLE IF EXISTS public.payments;

CREATE TABLE IF NOT EXISTS public.payments
(
    payment_id integer NOT NULL DEFAULT nextval('payments_payment_id_seq'::regclass),
    invoice_id integer,
    payment_date date,
    amount_paid numeric(10,2),
    payment_status text COLLATE pg_catalog."default",
    CONSTRAINT payments_pkey PRIMARY KEY (payment_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.payments
    OWNER to postgres;

-- Table: public.pricing_rules

-- DROP TABLE IF EXISTS public.pricing_rules;

CREATE TABLE IF NOT EXISTS public.pricing_rules
(
    pricing_id integer NOT NULL DEFAULT nextval('pricing_rules_pricing_id_seq'::regclass),
    product_id integer,
    tier_min integer,
    tier_max integer,
    unit_price numeric(10,2),
    effective_date date,
    CONSTRAINT pricing_rules_pkey PRIMARY KEY (pricing_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.pricing_rules
    OWNER to postgres;


-- Table: public.revenue_leakage_exceptions

-- DROP TABLE IF EXISTS public.revenue_leakage_exceptions;

CREATE TABLE IF NOT EXISTS public.revenue_leakage_exceptions
(
    exception_id integer NOT NULL DEFAULT nextval('revenue_leakage_exceptions_exception_id_seq'::regclass),
    customer_id integer,
    invoice_id integer,
    leakage_type text COLLATE pg_catalog."default",
    leakage_amount numeric(10,2),
    severity text COLLATE pg_catalog."default",
    detected_date date DEFAULT CURRENT_DATE,
    CONSTRAINT revenue_leakage_exceptions_pkey PRIMARY KEY (exception_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.revenue_leakage_exceptions
    OWNER to postgres;

-- Table: public.usage_events

-- DROP TABLE IF EXISTS public.usage_events;

CREATE TABLE IF NOT EXISTS public.usage_events
(
    usage_id integer NOT NULL DEFAULT nextval('usage_events_usage_id_seq'::regclass),
    customer_id integer,
    product_id integer,
    usage_date date,
    units_used integer,
    CONSTRAINT usage_events_pkey PRIMARY KEY (usage_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.usage_events
    OWNER to postgres;
