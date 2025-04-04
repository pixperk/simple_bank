-- name: CreateUser :one
INSERT INTO users (username, hashed_password, full_name, email)
VALUES ($1,
        $2,
        $3,
        $4) RETURNING *;

-- name: GetUser :one
select *
from users
where username = $1
LIMIT 1;
