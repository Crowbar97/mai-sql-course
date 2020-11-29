CREATE TABLE students (
    record_book numeric(5) PRIMARY KEY,

    name text NOT NULL,

    doc_ser numeric(4),
    doc_num numeric(6),
    CONSTRAINT unique_passport UNIQUE ( doc_ser, doc_num )
);

CREATE TABLE progress (
    record_book numeric(5),
    FOREIGN KEY ( record_book )
    REFERENCES students
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    subject text NOT NULL,

    acad_year text NOT NULL,

    term numeric(1) NOT NULL,
    CONSTRAINT valid_term CHECK ( term = 1 OR term = 2 ),

    mark numeric(1) DEFAULT 5,
    CONSTRAINT valid_mark CHECK ( mark >= 3 AND mark <= 5 )
);