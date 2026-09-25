# ER Diagram

The report defines the following major relationships:

```text
USERS
 ├── 1:1 ── STUDENTS
 └── 1:1 ── FACULTY

FACULTY
 └── 1:N ── COURSE_OFFERINGS

COURSES
 └── 1:N ── COURSE_OFFERINGS

STUDENTS
 └── 1:N ── ENROLLMENTS ── N:1 ── COURSE_OFFERINGS

COURSES
 └── 1:N ── PREREQUISITES
              └── required_course_id → COURSES

STUDENTS
 └── 1:N ── WAITLIST ── N:1 ── COURSE_OFFERINGS

STUDENTS
 └── 1:N ── PAYMENTS

NOTIFICATIONS
 └── recipient_type → STUDENT / FACULTY / ALL
```

The complete academic ER diagram is preserved in the original report under `docs/DBMS_PBL_Report.docx`.
