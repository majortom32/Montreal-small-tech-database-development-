#MSCA 690 PROJECT MtlTech 
#The data inserted is fictional

# SEE KPIs at the bottom
# KPI 1: CUSTOMER ENGAGEMENT LEVEL - measure the average number of customer queries per municipality(account)
# KPI 2: SUPORT EFFICIENCY - KPI 2 number of queries 'Resolved' compared to total number of queries
# KPI 3: SALES PERFORMANCE - Track the number of sales project per pipeline phase



CREATE DATABASE MtlTech;

USE MtlTech;

-- SQL code to create tables 

-- Table for `office`
CREATE TABLE office (
    office_ID INT PRIMARY KEY,
    employee_ID INT,
    name VARCHAR(50),
    address VARCHAR(100),
    manager VARCHAR(100)
);

-- Table for `employee`
CREATE TABLE employee (
    e_ID INT PRIMARY KEY,
    eFName VARCHAR(50),
    eLName VARCHAR(50),
    eDOB DATE,
    e_address VARCHAR(100),
    e_email VARCHAR(100),
    e_salary DECIMAL(10,2)
);

-- Table for `expense`
CREATE TABLE expense (
    expense_ID INT PRIMARY KEY,
    e_ID INT,
    expense_date DATE,
    expense_type INT,
    expense_amount DECIMAL(10,2),
    FOREIGN KEY (e_ID) REFERENCES employee(e_ID)
);

-- Table for `customer_support_emp`
CREATE TABLE customer_support_emp (
    cse_ID INT PRIMARY KEY,
    support_tier_level INTEGER,
    customer_support_channel VARCHAR(50),
    average_response_time VARCHAR(20)
);

-- Table for `sales_emp`
CREATE TABLE sales_emp (
    se_ID INT PRIMARY KEY,
    sales_territory VARCHAR(100),
    sales_quota FLOAT,
    sales_commission_rate FLOAT
);

-- Table for `contact`
CREATE TABLE contact (
    contact_ID INT PRIMARY KEY,
    account_ID INT,
    fName VARCHAR(50),
    lName VARCHAR(50),
    e_mail VARCHAR(100),
    e_phone_number CHAR(10)
);

-- Table for `account`
CREATE TABLE account (
    account_ID INT PRIMARY KEY,
    e_ID INT,
    is_client BINARY(2),
    account_name VARCHAR(100),
    account_primary_contact VARCHAR(50),
    account_notes VARCHAR(255),
    FOREIGN KEY (e_ID) REFERENCES employee(e_ID)
);

-- Table for `customer_query`
CREATE TABLE customer_query (
    query_ID INT PRIMARY KEY,
    contact_ID INT,
    cse_ID INT,
    query_date DATE,
    query_time VARCHAR(6),
    query_type VARCHAR(50),
    query_status VARCHAR(20),
    FOREIGN KEY (contact_ID) REFERENCES contact(contact_ID),
    FOREIGN KEY (cse_ID) REFERENCES customer_support_emp(cse_ID)
);

-- Table for `call`
#used phone_call instead of call, because call is a command
CREATE TABLE phone_call (
    call_ID INT PRIMARY KEY,
    contact_ID INT,
    e_ID INT,
    call_date DATE,
    call_duration FLOAT,
    call_notes VARCHAR(255),
    FOREIGN KEY (contact_ID) REFERENCES contact(contact_ID),
    FOREIGN KEY (e_ID) REFERENCES employee(e_ID)
);

-- Table for `product`
CREATE TABLE product (
    product_ID INT PRIMARY KEY,
    product_name VARCHAR(50),
    product_version VARCHAR(20)
);

-- Table for `product_line`
CREATE TABLE product_line (
    product_line_ID INT PRIMARY KEY,
    product_ID INT,
    product_line_name VARCHAR(50),
    product_line_category VARCHAR(25),
    FOREIGN KEY (product_ID) REFERENCES product(product_ID)
);

-- Table for `sales_project`
CREATE TABLE sales_project (
    sales_project_ID INT PRIMARY KEY,
    se_ID INT,
    account_ID INT,
    sales_project_name VARCHAR(100),
    sales_project_pipeline_phase VARCHAR(20),
    sales_forecasting INT,
    FOREIGN KEY (se_ID) REFERENCES sales_emp(se_ID),
    FOREIGN KEY (account_ID) REFERENCES account(account_ID)
);

-- Table for `sales_project_product`
CREATE TABLE sales_project_product (
    spp_ID INT PRIMARY KEY,
    product_ID INT,
    sales_project_ID INT,
    FOREIGN KEY (product_ID) REFERENCES product(product_ID),
    FOREIGN KEY (sales_project_ID) REFERENCES sales_project(sales_project_ID)
);

-- Table for `estimate`
CREATE TABLE estimate (
    estimate_ID INT PRIMARY KEY,
    sales_project_ID INT,
    estimate_item VARCHAR(255),
    estimate_total VARCHAR(20),
    FOREIGN KEY (sales_project_ID) REFERENCES sales_project(sales_project_ID)
);

-- Table for `invoice`
CREATE TABLE invoice (
    invoice_ID INT PRIMARY KEY,
    estimate_ID INT,
    invoice_date DATE,
    invoice_due_date DATE,
    FOREIGN KEY (estimate_ID) REFERENCES estimate(estimate_ID)
);

-- Table for `payment`
CREATE TABLE payment (
    payment_ID INT PRIMARY KEY,
    invoice_ID INT,
    payment_date DATE,
    payment_amount VARCHAR(10),
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    FOREIGN KEY (invoice_ID) REFERENCES invoice(invoice_ID)
);

-- Table for `promotion`
CREATE TABLE promotion (
    promotion_ID INT PRIMARY KEY,
    estimate_ID INT,
    promotion_name VARCHAR(50),
    promotion_code VARCHAR(50),
    FOREIGN KEY (estimate_ID) REFERENCES estimate(estimate_ID)
);

SELECT * 
FROM promotion;

################
################
# INSERTING DATA 
################
################

-- Insert sample data into the `employee` table
INSERT INTO employee (e_ID, eFName, eLName, eDOB, e_address, e_email, e_salary) VALUES
(1, 'Étienne', 'Girard', '1980-02-15', '123 Rue de la Montagne', 'egirard@MtlTech.com', 72000.00),
(2, 'Lucie', 'Moreau', '1985-07-22', '234 Chemin du Roy', 'lmoreau@MtlTech.com', 68000.00),
(3, 'Mathieu', 'Bernard', '1990-03-14', '345 Rue Saint-Paul', 'mbernard@MtlTech.com', 71000.00),
(4, 'Sophie', 'Lefebvre', '1978-05-30', '456 Boulevard Charest', 'slefebvre@MtlTech.com', 75000.00),
(5, 'Maxime', 'Roy', '1982-11-08', '567 Rue Sherbrooke', 'mroy@MtlTech.com', 70000.00),
(6, 'Julien', 'Tessier', '1975-01-19', '678 Avenue Cartier', 'jtessier@MtlTech.com', 73000.00),
(7, 'Camille', 'Bouchard', '1988-08-25', '789 Rue Saint-Jean', 'cbouchard@MtlTech.com', 69000.00),
(8, 'Gabriel', 'Côté', '1992-04-10', '890 Boulevard Laurier', 'gcote@MtlTech.com', 67000.00),
(9, 'Isabelle', 'Perron', '1984-09-17', '901 Rue Sainte-Catherine', 'iperron@MtlTech.com', 66000.00),
(10, 'Alexandre', 'Fortin', '1979-12-05', '1023 Boulevard René-Lévesque', 'afortin@MtlTech.com', 74000.00);


-- Insert sample data into the `account` table (municipalities)
INSERT INTO account (account_ID, e_ID, is_client, account_name, account_primary_contact, account_notes) VALUES
(1, 1, 1, 'Municipalité de Gatineau', 'Jean Tremblay', 'Active client since 2021'),
(2, 2, 1, 'Ville de Montréal', 'Marie Dupuis', 'High priority account'),
(3, 3, 1, 'Ville de Québec', 'Luc Bélanger', 'Interested in urban planning tools'),
(4, 4, 1, 'Ville de Sherbrooke', 'Claire Lefebvre', 'Focusing on sustainability projects'),
(5, 5, 1, 'Municipalité de Trois-Rivières', 'Marc Gagnon', 'Engaged in public works modernization'),
(6, 6, 1, 'Ville de Laval', 'Chantal Roux', 'Inquiring about new traffic management systems'),
(7, 7, 1, 'Ville de Longueuil', 'Olivier Nadeau', 'Looking for community engagement platforms'),
(8, 8, 1, 'Municipalité de Saguenay', 'Anne Lachance', 'Requires extensive training for staff'),
(9, 9, 1, 'Ville de Lévis', 'Dominic Fortin', 'Interested in green spaces development tools'),
(10, 10, 1, 'Ville de Drummondville', 'Sophie Villeneuve', 'Exploring cultural heritage preservation');

-- Insert sample data into the `contact` table (municipal staff)
INSERT INTO contact (contact_ID, account_ID, fName, lName, e_mail, e_phone_number) VALUES
(1, 1, 'Jean', 'Tremblay', 'jtremblay@gatineau.ca', '8195550101'),
(2, 2, 'Marie', 'Dupuis', 'mdupuis@montreal.ca', '5145550202'),
(3, 3, 'Luc', 'Bélanger', 'lbelanger@quebec.ca', '4185550303'),
(4, 4, 'Claire', 'Lefebvre', 'clefebvre@sherbrooke.ca', '8195550404'),
(5, 5, 'Marc', 'Gagnon', 'mgagnon@trois-rivieres.ca', '8195550505'),
(6, 6, 'Chantal', 'Roux', 'croux@laval.ca', '4505550606'),
(7, 7, 'Olivier', 'Nadeau', 'onadeau@longueuil.ca', '4505550707'),
(8, 8, 'Anne', 'Lachance', 'alachance@saguenay.ca', '4185550808'),
(9, 9, 'Dominic', 'Fortin', 'dfortin@levis.ca', '4185550909'),
(10, 10, 'Sophie', 'Villeneuve', 'svilleneuve@drummondville.ca', '8195551010');

#more records into contact
INSERT INTO contact (contact_ID, account_ID, fName, lName, e_mail, e_phone_number) VALUES
(11, 1, 'Émile', 'Lapointe', 'elapointe@gatineau.ca', '8195550110'),
(12, 1, 'Renée', 'Lévesque', 'rlevesque@gatineau.ca', '8195550111'),
(13, 2, 'Antoine', 'Giroux', 'agiroux@montreal.ca', '5145550212'),
(14, 2, 'Julie', 'Simard', 'jsimard@montreal.ca', '5145550213'),
(15, 2, 'Léo', 'Fortier', 'lfortier@montreal.ca', '5145550214'),
(16, 3, 'Gabrielle', 'Mercier', 'gmercier@quebec.ca', '4185550315'),
(17, 4, 'Raphael', 'Tessier', 'rtessier@sherbrooke.ca', '8195550416'),
(18, 5, 'Isabelle', 'Côté', 'icote@trois-rivieres.ca', '8195550517'),
(19, 6, 'Nicolas', 'Lemieux', 'nlemieux@laval.ca', '4505550618'),
(20, 6, 'Aline', 'Boucher', 'aboucher@laval.ca', '4505550619'),
(21, 7, 'Guillaume', 'Roy', 'groy@longueuil.ca', '4505550720'),
(22, 8, 'Alexandra', 'Lapierre', 'alapierre@saguenay.ca', '4185550821'),
(23, 9, 'Maxime', 'Bernard', 'mbernard@levis.ca', '4185550922'),
(24, 10, 'Stéphanie', 'Caron', 'scaron@drummondville.ca', '8195551023'),
(25, 1, 'Véronique', 'Thibault', 'vthibault@gatineau.ca', '8195550124'),
(26, 1, 'Frédéric', 'Martel', 'fmartel@gatineau.ca', '8195550125'),
(27, 2, 'Hélène', 'Gauthier', 'hgauthier@montreal.ca', '5145550226'),
(28, 3, 'Julien', 'Lavoie', 'jlavoie@quebec.ca', '4185550327'),
(29, 4, 'Geneviève', 'Pelletier', 'gpelletier@sherbrooke.ca', '8195550428'),
(30, 5, 'Mathieu', 'Bélanger', 'mbelanger@trois-rivieres.ca', '8195550529');


-- Insert sample data into the `office` table
INSERT INTO office (office_ID, employee_ID, name, address, manager) VALUES
(1, 1, 'MtlTech HQ', '1000 Rue de la Gauchetière, Montréal', 'Martin Dubois'),
(2, 2, 'MtlTech Québec', '500 Grande Allée E, Québec', 'Nathalie Fortin'),
(3, 3, 'MtlTech Laval', '3000 Boulevard de la Concorde E, Laval', 'Serge Lemieux'),
(4, 4, 'MtlTech Gatineau', '200 Boulevard Maisonneuve, Gatineau', 'Caroline Beauchamp'),
(5, 5, 'MtlTech Sherbrooke', '150 Rue Wellington N, Sherbrooke', 'François Arbour'),
(6, 6, 'MtlTech Rimouski', '750 Boulevard Jessop, Rimouski', 'Hugo Lavoie'),
(7, 7, 'MtlTech Saguenay', '1423 Boulevard Talbot, Saguenay', 'Amelie Gagné'),
(8, 8, 'MtlTech Trois-Rivières', '1987 Rue Hart, Trois-Rivières', 'Rémi Couture'),
(9, 9, 'MtlTech Drummondville', '365 Boulevard Saint-Joseph, Drummondville', 'Lucie Poirier'),
(10, 10, 'MtlTech Granby', '55 Rue Principale, Granby', 'Mathieu Giroux');

-- Insert sample data into the `product` table (digital tools)
INSERT INTO product (product_ID, product_name, product_version) VALUES
(1, 'Urban Planner Pro', 'v1.2'),
(2, 'Green City Suite', 'v2.5'),
(3, 'Traffic Optimizer Deluxe', 'v3.8'),
(4, 'Waste Management Expert', 'v4.1'),
(5, 'Public Works Scheduler', 'v1.9'),
(6, 'Eco Energy Manager', 'v2.3'),
(7, 'Municipal Budgeting Tool', 'v1.4'),
(8, 'Community Portal Plus', 'v3.0'),
(9, 'Infrastructure Monitoring System', 'v2.1'),
(10, 'Smart City Dashboard', 'v4.0');

INSERT INTO product_line (product_line_ID, product_ID, product_line_name, product_line_category) VALUES
(1, 1, 'Urban Planning Suite', 'Software'),
(2, 1, 'Traffic Management Suite', 'Software'),
(3, 2, 'Waste Management System', 'Software'),
(4, 2, 'Public Works System', 'Software'),
(5, 3, 'City Health Dashboard', 'Analytics'),
(6, 3, 'Public Safety Alerts', 'Analytics'),
(7, 4, 'Municipal WiFi Solutions', 'Infrastructure'),
(8, 4, 'Smart Lighting Solutions', 'Infrastructure'),
(9, 5, 'Community Engagement Platform', 'Software'),
(10, 5, 'Resident Feedback System', 'Software');


INSERT INTO expense (expense_ID, e_ID, expense_date, expense_type, expense_amount) VALUES
(1, 1, '2024-01-10', 1, 123.45),
(2, 1, '2024-01-15', 2, 150.00),
(3, 2, '2024-02-01', 1, 200.00),
(4, 2, '2024-02-05', 2, 225.50),
(5, 3, '2024-03-10', 1, 75.75),
(6, 3, '2024-03-15', 2, 99.99),
(7, 4, '2024-04-10', 1, 300.00),
(8, 4, '2024-04-15', 2, 450.00),
(9, 5, '2024-05-10', 1, 120.00),
(10, 5, '2024-05-15', 2, 110.00),
(11, 6, '2024-06-10', 1, 130.30),
(12, 6, '2024-06-15', 2, 140.40),
(13, 7, '2024-07-10', 1, 160.60),
(14, 7, '2024-07-15', 2, 170.70),
(15, 8, '2024-08-10', 1, 180.80),
(16, 8, '2024-08-15', 2, 190.90),
(17, 9, '2024-09-10', 1, 210.10),
(18, 9, '2024-09-15', 2, 220.20),
(19, 10, '2024-10-10', 1, 230.30),
(20, 10, '2024-10-15', 2, 240.40);


-- Insert sample data into the `sales_project` table
INSERT INTO sales_project (sales_project_ID, se_ID, account_ID, sales_project_name, sales_project_pipeline_phase, sales_forecasting) VALUES
(1, 1, 1, 'Gatineau Urban Expansion', 'Negotiation', 100000),
(2, 2, 2, 'Montréal Traffic Control', 'Prospecting', 250000),
(3, 3, 3, 'Québec Parks Program', 'Planning', 150000),
(4, 4, 4, 'Sherbrooke Recycling Plan', 'Analysis', 80000),
(5, 5, 5, 'Trois-Rivières Festival Setup', 'Execution', 60000),
(6, 6, 6, 'Laval Smart Lighting Initiative', 'Research', 90000),
(7, 7, 7, 'Longueuil Community Wi-Fi', 'Design', 120000),
(8, 8, 8, 'Saguenay Flood Prevention System', 'Delivery', 200000),
(9, 9, 9, 'Lévis Heritage Conservation Project', 'Closing', 50000),
(10, 10, 10, 'Drummondville Virtual Town Hall Setup', 'Implementation', 110000);

# MORE DATA INTO SALES_PROJECTS

INSERT INTO sales_project (sales_project_ID, se_ID, account_ID, sales_project_name, sales_project_pipeline_phase, sales_forecasting) VALUES
(11, 1, 1, 'Gatineau Public WiFi Expansion', 'Planning', 120000),
(12, 2, 2, 'Montreal Smart Lighting Initiative', 'Execution', 95000),
(13, 3, 1, 'Gatineau Traffic Management System', 'Delivery', 200000),
(14, 4, 3, 'Québec City Green Spaces Project', 'Design', 75000),
(15, 5, 2, 'Montreal Community Portal Development', 'Negotiation', 50000),
(16, 1, 4, 'Sherbrooke Waste Management Optimization', 'Research', 80000),
(17, 2, 5, 'Trois-Rivières Solar Power Integration', 'Analysis', 150000),
(18, 3, 6, 'Laval Flood Prevention Strategy', 'Planning', 110000),
(19, 4, 7, 'Longueuil Cultural Heritage App', 'Execution', 60000),
(20, 5, 8, 'Saguenay Youth Engagement Platform', 'Delivery', 85000),
(21, 1, 9, 'Lévis Emergency Response System Upgrade', 'Design', 130000),
(22, 2, 10, 'Drummondville Public Transport Enhancement', 'Negotiation', 90000),
(23, 3, 1, 'Gatineau Smart Parking Solution', 'Research', 105000),
(24, 4, 2, 'Montreal Urban Farming Initiative', 'Analysis', 95000),
(25, 5, 3, 'Québec City Air Quality Monitoring Network', 'Planning', 125000);


-- Insert sample data into the `sales_emp` table
INSERT INTO sales_emp (se_ID, sales_territory, sales_quota, sales_commission_rate) VALUES
(1, 'Montréal', 500000, 0.05),
(2, 'Québec', 400000, 0.06),
(3, 'Laval', 300000, 0.07),
(4, 'Gatineau', 200000, 0.04),
(5, 'Sherbrooke', 250000, 0.05),
(6, 'Rimouski', 350000, 0.045),
(7, 'Saguenay', 300000, 0.05),
(8, 'Trois-Rivières', 400000, 0.055),
(9, 'Drummondville', 250000, 0.05),
(10, 'Granby', 275000, 0.04);

#######################################
#######################################
#BRIDGE ENTITY - Looks a little awkward
#######################################
#######################################

-- Insert data into `sales_project_product` table
INSERT INTO sales_project_product (spp_ID, product_ID, sales_project_ID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 1, 6),
(7, 2, 7),
(8, 3, 8),
(9, 4, 9),
(10, 5, 10);

DELETE FROM estimate WHERE estimate_ID BETWEEN 1 AND 10;


-- Insert data into `estimate` table
INSERT INTO estimate (estimate_ID, sales_project_ID, estimate_item, estimate_total) VALUES
(1, 1, 'Consultation Fee', '5000'),
(2, 2, 'Initial Setup Charge', '7500'),
(3, 3, 'Maintenance Contract', '3000'),
(4, 4, 'Training Sessions', '4000'),
(5, 5, 'Annual License', '6000'),
(6, 6, 'Hardware Installation', '2000'),
(7, 7, 'Software Customization', '3500'),
(8, 8, 'Ongoing Support Plan', '2500'),
(9, 9, 'Data Migration Services', '4500'),
(10, 10, 'Cloud Storage Setup', '5000');


-- Insert data into `invoice` table
INSERT INTO invoice (invoice_ID, estimate_ID, invoice_date, invoice_due_date) VALUES
(1, 1, '2024-01-10', '2024-02-10'),
(2, 2, '2024-01-15', '2024-02-15'),
(3, 3, '2024-01-20', '2024-02-20'),
(4, 4, '2024-01-25', '2024-02-25'),
(5, 5, '2024-01-30', '2024-03-01'),
(6, 6, '2024-02-04', '2024-03-06'),
(7, 7, '2024-02-08', '2024-03-10'),
(8, 8, '2024-02-12', '2024-03-14'),
(9, 9, '2024-02-16', '2024-03-18'),
(10, 10, '2024-02-20', '2024-03-22');

-- Insert data into `payment` table
INSERT INTO payment (payment_ID, invoice_ID, payment_date, payment_amount, payment_method, payment_status) VALUES
(1, 1, '2024-02-10', '1000.00', 'Credit Card', 'Paid'),
(2, 2, '2024-02-15', '2000.00', 'Bank Transfer', 'Paid'),
(3, 3, '2024-02-20', '1500.00', 'Check', 'Pending'),
(4, 4, '2024-02-25', '1800.00', 'Credit Card', 'Paid'),
(5, 5, '2024-03-01', '1600.00', 'Bank Transfer', 'Late'),
(6, 6, '2024-03-06', '1700.00', 'Credit Card', 'Paid'),
(7, 7, '2024-03-10', '1900.00', 'Bank Transfer', 'Paid'),
(8, 8, '2024-03-14', '1100.00', 'Check', 'Paid'),
(9, 9, '2024-03-18', '1200.00', 'Credit Card', 'Pending'),
(10, 10, '2024-03-22', '1300.00', 'Bank Transfer', 'Paid');

-- Insert data into `promotion` table
INSERT INTO promotion (promotion_ID, estimate_ID, promotion_name, promotion_code) VALUES
(1, 1, 'New Year Discount', 'NY2024'),
(2, 2, 'Spring Sale', 'SPRING2024'),
(3, 3, 'Summer Special', 'SUMMER2024'),
(4, 4, 'Autumn Offer', 'AUTUMN2024'),
(5, 5, 'Winter Deal', 'WINTER2024'),
(6, 6, 'Fiscal Year-End Promo', 'END2024'),
(7, 7, 'Holiday Discount', 'HOL2024'),
(8, 8, 'Easter Eggstravaganza', 'EAST2024'),
(9, 9, 'Canada Day Celebration', 'CAN2024'),
(10, 10, 'Labour Day Discount', 'LABOUR2024');

-- Insert data into `customer_query` table
INSERT INTO customer_query (query_ID, contact_ID, cse_ID, query_date, query_time, query_type, query_status) VALUES
(1, 1, 1, '2024-01-01', '09:00', 'Technical', 'Resolved'),
(2, 2, 2, '2024-01-02', '10:00', 'Sales', 'Pending'),
(3, 3, 3, '2024-01-03', '11:00', 'Billing', 'In Progress'),
(4, 4, 4, '2024-01-04', '12:00', 'Technical', 'Resolved'),
(5, 5, 5, '2024-01-05', '13:00', 'Sales', 'Pending'),
(6, 1, 1, '2024-01-06', '14:00', 'Billing', 'In Progress'),
(7, 2, 2, '2024-01-07', '15:00', 'Technical', 'Resolved'),
(8, 3, 3, '2024-01-08', '16:00', 'Sales', 'Pending'),
(9, 4, 4, '2024-01-09', '17:00', 'Billing', 'In Progress'),
(10, 5, 5, '2024-01-10', '18:00', 'Technical', 'Resolved');

#adding more data in customer_query

INSERT INTO customer_query (query_ID, contact_ID, cse_ID, query_date, query_time, query_type, query_status) VALUES 
(11, 6, 1, '2024-01-11', '09:15', 'Technical', 'Resolved'),
(12, 6, 1, '2024-01-12', '10:30', 'Sales', 'Pending'),
(13, 7, 2, '2024-01-13', '11:45', 'Billing', 'In Progress'),
(14, 7, 2, '2024-01-14', '12:00', 'Technical', 'Resolved'),
(15, 8, 3, '2024-01-15', '13:15', 'Sales', 'Pending'),
(16, 8, 3, '2024-01-16', '14:30', 'Billing', 'In Progress'),
(17, 9, 1, '2024-01-17', '15:45', 'Technical', 'Resolved'),
(18, 9, 1, '2024-01-18', '16:00', 'Sales', 'Pending'),
(19, 10, 2, '2024-01-19', '17:15', 'Billing', 'In Progress'),
(20, 10, 2, '2024-01-20', '18:30', 'Technical', 'Resolved'),
(21, 1, 3, '2024-01-21', '08:00', 'Maintenance', 'In Progress'),
(22, 2, 3, '2024-01-22', '08:30', 'Upgrade', 'Pending'),
(23, 3, 1, '2024-01-23', '09:00', 'Outage', 'Resolved'),
(24, 4, 1, '2024-01-24', '09:30', 'Technical', 'Resolved'),
(25, 5, 2, '2024-01-25', '10:00', 'Feedback', 'Reviewed'),
(26, 6, 2, '2024-01-26', '10:30', 'Maintenance', 'In Progress'),
(27, 7, 3, '2024-01-27', '11:00', 'Upgrade', 'Pending'),
(28, 8, 3, '2024-01-28', '11:30', 'Outage', 'Resolved'),
(29, 9, 1, '2024-01-29', '12:00', 'Technical', 'Resolved'),
(30, 10, 1, '2024-01-30', '12:30', 'Feedback', 'Reviewed');

INSERT INTO customer_query (query_ID, contact_ID, cse_ID, query_date, query_time, query_type, query_status) VALUES 
(31, 1, 1, '2024-02-01', '08:45', 'Technical', 'Resolved'),
(32, 1, 1, '2024-02-02', '09:20', 'Sales', 'Pending'),
(33, 1, 2, '2024-02-03', '10:10', 'Billing', 'In Progress'),
(34, 2, 1, '2024-02-04', '11:00', 'Technical', 'Resolved'),
(35, 2, 2, '2024-02-05', '11:45', 'Sales', 'Pending'),
(36, 3, 3, '2024-02-06', '12:30', 'Billing', 'In Progress'),
(37, 4, 1, '2024-02-07', '13:15', 'Technical', 'Resolved'),
(38, 4, 1, '2024-02-08', '14:00', 'Sales', 'Pending'),
(39, 4, 1, '2024-02-09', '14:45', 'Billing', 'In Progress'),
(40, 4, 2, '2024-02-10', '15:30', 'Technical', 'Resolved'),
(41, 5, 2, '2024-02-11', '16:15', 'Sales', 'Pending'),
(42, 6, 3, '2024-02-12', '17:00', 'Billing', 'In Progress'),
(43, 7, 1, '2024-02-13', '17:45', 'Technical', 'Resolved'),
(44, 8, 1, '2024-02-14', '18:30', 'Sales', 'Pending'),
(45, 8, 2, '2024-02-15', '08:15', 'Billing', 'In Progress'),
(46, 8, 2, '2024-02-16', '08:45', 'Technical', 'Resolved'),
(47, 9, 3, '2024-02-17', '09:20', 'Sales', 'Pending'),
(48, 10, 1, '2024-02-18', '09:55', 'Billing', 'In Progress'),
(49, 10, 1, '2024-02-19', '10:30', 'Technical', 'Resolved'),
(50, 10, 2, '2024-02-20', '11:05', 'Sales', 'Pending');

INSERT INTO customer_query (query_ID, contact_ID, cse_ID, query_date, query_time, query_type, query_status) VALUES 
(51, 11, 1, '2024-02-21', '09:30', 'Maintenance', 'Pending'),
(52, 11, 2, '2024-02-22', '10:00', 'Technical', 'Resolved'),
(53, 13, 1, '2024-02-23', '10:30', 'Technical', 'Pending'),
(54, 13, 2, '2024-02-24', '11:00', 'Sales', 'In Progress'),
(55, 14, 3, '2024-02-25', '11:30', 'Billing', 'Resolved'),
(56, 16, 1, '2024-02-26', '12:00', 'Technical', 'Pending'),
(57, 16, 2, '2024-02-27', '12:30', 'Technical', 'Resolved'),
(58, 16, 3, '2024-02-28', '13:00', 'Maintenance', 'In Progress'),
(59, 17, 1, '2024-03-01', '13:30', 'Upgrade', 'Pending'),
(60, 18, 2, '2024-03-02', '14:00', 'Sales', 'Resolved'),
(61, 20, 3, '2024-03-03', '14:30', 'Technical', 'Pending'),
(62, 20, 1, '2024-03-04', '15:00', 'Maintenance', 'In Progress'),
(63, 21, 2, '2024-03-05', '15:30', 'Upgrade', 'Resolved'),
(64, 22, 3, '2024-03-06', '16:00', 'Sales', 'Pending'),
(65, 25, 1, '2024-03-07', '16:30', 'Billing', 'In Progress'),
(66, 25, 2, '2024-03-08', '17:00', 'Technical', 'Pending'),
(67, 25, 3, '2024-03-09', '17:30', 'Technical', 'Resolved'),
(68, 26, 1, '2024-03-10', '18:00', 'Maintenance', 'In Progress'),
(69, 27, 2, '2024-03-11', '18:30', 'Upgrade', 'Pending'),
(70, 27, 3, '2024-03-12', '19:00', 'Sales', 'Resolved');


-- Insert data into `call` table
INSERT INTO phone_call (call_ID, contact_ID, e_ID, call_date, call_duration, call_notes) VALUES
(1, 1, 1, '2024-01-10', 15.5, 'Discussed upcoming updates'),
(2, 2, 2, '2024-01-11', 20.0, 'Reviewed contract terms'),
(3, 3, 3, '2024-01-12', 30.5, 'Planned training session'),
(4, 4, 4, '2024-01-13', 25.0, 'Resolved technical issue'),
(5, 5, 5, '2024-01-14', 18.0, 'Set up new account'),
(6, 6, 1, '2024-01-15', 22.0, 'Follow-up on previous call'),
(7, 7, 2, '2024-01-16', 19.5, 'Inquiry about new features'),
(8, 8, 3, '2024-01-17', 23.0, 'Customer feedback'),
(9, 9, 4, '2024-01-18', 17.5, 'Support for setup'),
(10, 10, 5, '2024-01-19', 14.0, 'Pre-sales questions');

-- Insert sample data into the `customer_support_emp` table
INSERT INTO customer_support_emp (cse_ID, support_tier_level, customer_support_channel, average_response_time) VALUES
(1, 1, 'Email', '24h'),
(2, 2, 'Phone', '1h'),
(3, 3, 'Live Chat', '5m'),
(4, 1, 'Email', '48h'),
(5, 2, 'Phone', '2h'),
(6, 3, 'Live Chat', '10m'),
(7, 1, 'Email', '36h'),
(8, 2, 'Phone', '1.5h'),
(9, 3, 'Live Chat', '15m'),
(10, 1, 'Email', '12h');

SELECT * 
FROM customer_support_emp;

# RETRIVING INFORMATION FROM KPIs

# KPI 1: CUSTOMER ENGAGEMENT LEVEL - measure the average number of customer queries per municipality (account)

SELECT 
    contact.account_ID,
    account.account_name AS MunicipalityName,
    COUNT(customer_query.query_ID) AS TotalQueriesPerMunicipality,
    COUNT(customer_query.query_ID) / COUNT(DISTINCT contact.contact_ID) AS AvgQueriesPerContact
FROM customer_query
JOIN contact ON customer_query.contact_ID = contact.contact_ID
JOIN account ON contact.account_ID = account.account_ID
GROUP BY contact.account_ID, account.account_name;

# KPI 2: SUPORT EFFICIENCY - KPI 2 number of queries 'Resolved' compared to total number of queries 

SELECT 
    account.account_name AS Municipality,
    COUNT(*) AS TotalQueries,
    SUM(CASE WHEN customer_query.query_status = 'Resolved' THEN 1 ELSE 0 END) AS ResolvedQueries,
    SUM(CASE WHEN customer_query.query_status = 'Resolved' THEN 1 ELSE 0 END) / COUNT(*) AS ResolutionRatio
FROM customer_query
JOIN contact ON customer_query.contact_ID = contact.contact_ID
JOIN account ON contact.account_ID = account.account_ID
GROUP BY account.account_name
ORDER BY account.account_name;


# KPI 3: SALES PERFORMANCE - Track the number of sales project per pipeline phase

SELECT 
    sales_project_pipeline_phase,
    COUNT(sales_project_ID) AS TotalProjects
FROM sales_project
GROUP BY sales_project_pipeline_phase
ORDER BY TotalProjects DESC;
 
# DELIVERABLE 

SELECT * FROM account;
SELECT * FROM contact;
SELECT * FROM customer_query;
SELECT * FROM customer_support_emp;
SELECT * FROM employee;
SELECT * FROM estimate;
SELECT * FROM expense;
SELECT * FROM invoice;
SELECT * FROM office;
SELECT * FROM payment;
SELECT * FROM phone_call;
SELECT * FROM product;
SELECT * FROM product_line;
SELECT * FROM promotion;
SELECT * FROM sales_emp;
SELECT * FROM sales_project;
SELECT * FROM sales_project_product;


