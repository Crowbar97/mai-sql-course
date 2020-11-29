CREATE TABLE students (
    record_book numeric(5) PRIMARY KEY,

    name text NOT NULL,

    doc_ser numeric(4),
    doc_num numeric(6),
    CONSTRAINT unique_passport UNIQUE ( doc_ser, doc_num )
);