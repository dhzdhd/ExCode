CREATE TABLE
    IF NOT EXISTS codebin(
        TEXT uuid,
        TEXT content,
        TEXT language,
        DATE creationDate,
        DATE expiryDate,
    );
