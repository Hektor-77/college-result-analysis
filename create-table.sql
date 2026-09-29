-- Creating table into database

CREATE TABLE college_results (
    pdf_page INTEGER,
    department TEXT,
    degree TEXT,
    sr_no INTEGER,
    roll_no TEXT,
    registration_no TEXT,
    name TEXT,
    result_status TEXT,
    sgpa NUMERIC(3,2),
    cgpa NUMERIC(3,2),
    failing_subjects TEXT
);



-- importing data into table


\copy college_results
FROM 'path  of  .csv file'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    ENCODING 'UTF8'
);