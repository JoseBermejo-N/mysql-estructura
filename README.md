# TascaS2.01
MySQL Bases de dades

Exercises to learn Relational Database Design, Schema Generation, and EER Modeling using MySQL
EER Diagrams, Foreign Keys, Relational Constraints & Database Scripts

# MySQL Relational Database Design
Welcome to my MySQL database learning repository! This space is dedicated to collecting practical exercises, database schemas, and EER diagrams regarding Relational Database Design that I develop as I progress through my training by ITAcademy.

## 🚀 Development Environment
- **Database Server:** MySQL (Version 8.0)
- **Design & Administration Tool:** MySQL Workbench
- **Local Server Environment:** XAMPP / Local MySQL Service
- **Editor:** Visual Studio Code

## 📂 Repository Structure
The project is currently focused on the foundational database designs corresponding to **Nivel 1**. Higher difficulty levels will be added as they are completed.

### 📌 Nivel 1
- **optica/** : Relational database model designed for an optics store management system.
  - `tascaS2.01.optica.sql` : The complete database script containing the schema definition, structural architecture, and data population.
  - `optica_diagram.png` : Enhanced Entity-Relationship (EER) diagram showing tables, fields, and cardinalities.
- **pizzeria/** : Relational database model designed for a food delivery service.
  - `tascaS2.01.pizzeria.sql` : The forward-engineered SQL script defining the database structure, constraints, tables, and data population.
  - `pizzeria_diagram.png` : Enhanced Entity-Relationship (EER) diagram mapping customers, orders, employees, and roles.

### ⏳ Nivel 2 & Nivel 3
- *Work in Progress* 🛠️: Advanced database schemas and complex relational modeling exercises will be uploaded here upon completion.

## 🛠️ How to Run This Project
To set up, inspect, and test these databases, you will need a running MySQL instance and administration tools like **MySQL Workbench**. Follow these steps to execute the code:

1. **Clone this repository:** 
   Navigate to your local projects directory and clone the repository:
   ```bash
   git clone https://github.com/JoseBermejo-N/mysql-estructura.git
   cd TascaS2.01
   ```
2. **Open MySQL Workbench:** Connect to your local or remote MySQL server instance.
3. **Deploy the Schemas & Data:** 
   - Go to `File -> Open SQL Script...` and select either `tascaS2.01.optica.sql` or `tascaS2.01.pizzeria.sql` from their respective folders.
   - Click the **Lightning Bolt icon (Execute)** to build the database schema and automatically populate the tables.
4. **View Visual Diagrams:**
   - You can review the database layouts and relationships directly via the `optica_diagram.png` and `pizzeria_diagram.png` images inside each folder without opening MySQL Workbench.

Alternatively, you can run the files directly via the MySQL Command Line Client:

1. **Log in to your MySQL terminal:**
   ```bash
   mysql -u tu_usuario -p
   ```
2. **Source the files:**
   ```sql
   -- Example for the Pizzeria database
   SOURCE C:/ruta/al/proyecto/pizzeria/tascaS2.01.pizzeria.sql;
   ```

---

Jose - @JoseBermejo-N
