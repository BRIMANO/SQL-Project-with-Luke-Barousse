CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_filename VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_filename VARCHAR(255),
    status VARCHAR(50)
);

INSERT INTO job_applied
    (job_id,
    application_sent_date,
    custom_resume,
    resume_filename,
    cover_letter_sent,
    cover_letter_filename,
    status)

VALUES (1,
        '2024-02-01',
        true,
        'resume_01.pdf',
        true,
        'cover_letter_01',
        'submitted'),
        (2,
        '2024-02-02',
        false,
        'resume_02.pdf',
        false,
        NULL,
        'interview scheduled'),
        (3,
        '2024-02-03',
        true,
        'resume_03.pdf',
        false,
        NULL,
        'ghosted'),
        (4,
        '2024-02-04',
        true,
        'resume_04.pdf',
        true,
        'cover_letter_04',
        'accepted'),
        (5,
        '2024-02-05',
        false,
        NULL,
        false,
        NULL,
        'rejected');

ALTER TABLE job_applied
    ADD contacts VARCHAR(50);

UPDATE job_applied
SET contacts = 'Bimano'
WHERE job_id = 1;

UPDATE job_applied
SET contacts = 'Holu'
WHERE job_id = 2;

UPDATE job_applied
SET contacts = 'Bimano'
WHERE job_id = 3;

UPDATE job_applied
SET contacts = 'Tife'
WHERE job_id = 4;

UPDATE job_applied
SET contacts = 'Miracle'
WHERE job_id = 5;

ALTER TABLE job_applied
RENAME COLUMN contacts TO contact_name;

SELECT * 
FROM job_applied;