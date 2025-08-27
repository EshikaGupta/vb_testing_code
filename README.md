# VB6 Oracle Search Form Example

This project demonstrates a simple **Visual Basic 6.0 application** that connects to **Oracle Database** using ADO, calls a stored procedure, and displays results in a `ListView`.

## Contents

- `vb_form/Form1.frm` – VB6 form with search textbox, button, and ListView.
- `db/create_db.sql` – Script to create `emp` table and insert sample data.
- `db/search_employees_proc.sql` – Oracle stored procedure returning a REF CURSOR.

## Setup Instructions

### Oracle

1. Connect to your Oracle database as a user with privileges.
2. Run `db/create_db.sql` to create and populate the `emp` table.
3. Run `db/search_employees_proc.sql` to create the stored procedure.

### VB6

1. Open `Form1.frm` in VB6 IDE.
2. Go to **Project → References** and enable:
   - Microsoft ActiveX Data Objects 2.x Library
   - Microsoft Windows Common Controls 6.0 (SP6)
3. Update the connection string in `Form1.frm`:
   ```vb
   cn.Open "Provider=OraOLEDB.Oracle;Data Source=ORCL;User Id=hr;Password=hr;"
   ```
   Replace `ORCL`, `hr`, `hr` with your database service name, username, and password.
4. Run the project. Enter a name (e.g. "John") in the search box and click **Search**.

## Notes

- Requires Oracle OLE DB Provider installed (`OraOLEDB.Oracle`).
- ListView columns are initialized in `Form_Load`.
- Procedure returns employees filtered by name using `LIKE`.
