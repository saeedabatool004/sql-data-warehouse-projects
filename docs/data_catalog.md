# Gold Layer Data Catalog

## About This Document

The Gold Layer holds clean, business-ready data that is organised for analysis and reporting. It follows a simple star-style layout made up of two kinds of tables:

- **Dimension tables** describe the "who" and "what" of the business (customers and products).
- **Fact tables** record the measurable events (sales transactions).

| Table | Type | What It Covers |
|-------|------|----------------|
| `gold.dim_customers` | Dimension | Customer details, including demographic and location information |
| `gold.dim_products` | Dimension | Product details and attributes |
| `gold.fact_sales` | Fact | Individual sales transaction records |

### How the Tables Connect

The sales table links to the two dimension tables through surrogate keys:

- `gold.fact_sales.customer_key` → `gold.dim_customers.customer_key`
- `gold.fact_sales.product_key` → `gold.dim_products.product_key`

This means each sales record can be matched to the customer who bought and the product that was sold.

---

## 1. gold.dim_customers

**Purpose:** Holds one record per customer, combining personal, demographic and country information so sales can be analysed by customer profile.

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| `customer_key` | INT | System-generated surrogate key that uniquely identifies each row in this table. Used to join with the sales table. |
| `customer_id` | INT | Numeric ID given to each customer. |
| `customer_number` | NVARCHAR(50) | Alphanumeric code for the customer, used to track and refer to them. |
| `first_name` | NVARCHAR(50) | Customer's given name as stored in the system. |
| `last_name` | NVARCHAR(50) | Customer's family name (surname). |
| `country` | NVARCHAR(50) | Country where the customer lives, for example 'Australia'. |
| `marital_status` | NVARCHAR(50) | Customer's marital status, for example 'Married' or 'Single'. |
| `gender` | NVARCHAR(50) | Customer's gender, for example 'Male', 'Female' or 'n/a' when not available. |
| `birthdate` | DATE | Customer's date of birth in YYYY-MM-DD format, for example 1971-10-06. |
| `create_date` | DATE | Date on which the customer's record was first created in the system. |

---

## 2. gold.dim_products

**Purpose:** Holds one record per product, with its identifiers, classification, cost and other attributes, so sales can be analysed by product.

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| `product_key` | INT | System-generated surrogate key that uniquely identifies each row in this table. Used to join with the sales table. |
| `product_id` | INT | Unique ID given to the product, used internally for tracking and reference. |
| `product_number` | NVARCHAR(50) | Structured alphanumeric product code, commonly used for categorisation or inventory purposes. |
| `product_name` | NVARCHAR(50) | Name of the product, including key details such as type, colour and size. |
| `category_id` | NVARCHAR(50) | Identifier of the category the product belongs to, linking it to its high-level grouping. |
| `category` | NVARCHAR(50) | Main group the product falls under (for example 'Bikes' or 'Components'), used to organise related products. |
| `subcategory` | NVARCHAR(50) | More specific grouping within the category, such as the type of product. |
| `maintenance_required` | NVARCHAR(50) | Shows whether the product needs maintenance, with values such as 'Yes' or 'No'. |
| `cost` | INT | Base cost or price of the product, in monetary units. |
| `product_line` | NVARCHAR(50) | Product series or line the item belongs to, for example 'Road' or 'Mountain'. |
| `start_date` | DATE | Date from which the product became available for sale or use. |

---

## 3. gold.fact_sales

**Purpose:** Stores sales transaction data, with each row representing a line item of an order, for use in analysis and reporting.

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| `order_number` | NVARCHAR(50) | Unique alphanumeric ID of the sales order, for example 'SO54496'. |
| `product_key` | INT | Surrogate key that connects the order line to the product in `gold.dim_products`. |
| `customer_key` | INT | Surrogate key that connects the order line to the customer in `gold.dim_customers`. |
| `order_date` | DATE | Date the order was placed. |
| `shipping_date` | DATE | Date the order was shipped to the customer. |
| `due_date` | DATE | Date by which payment for the order was due. |
| `sales_amount` | INT | Total sales value of the line item, in whole currency units (for example 25). |
| `quantity` | INT | Number of units of the product ordered on the line item (for example 1). |
| `price` | INT | Price of a single unit of the product on the line item, in whole currency units (for example 25). |

---

## Quick Notes

- **Surrogate keys** (`customer_key`, `product_key`) are used to join tables, while IDs and numbers (`customer_id`, `product_id`, etc.) are business identifiers from the source data.
- **Data types:** `NVARCHAR(50)` columns hold text up to 50 characters; `INT` columns hold whole numbers; `DATE` columns hold calendar dates.
- **Monetary values** (`cost`, `sales_amount`, `price`) are stored as whole numbers.