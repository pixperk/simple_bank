-- name: CreateAccount :one
INSERT INTO accounts (owner, balance, currency)
VALUES ($1,
        $2,
        $3) RETURNING *;

-- name: GetAccount :one
select *
from accounts
where id = $1
LIMIT 1;

-- name: GetAccountForUpdate :one
select *
from accounts
where id = $1
LIMIT 1
FOR NO KEY UPDATE; --to avoid deadlock due to foreign key constraint

-- name: ListAccounts :many
SELECT *
FROM accounts
WHERE owner = $1
order by id
LIMIT $2
OFFSET $3;

-- name: UpdateAccount :one
UPDATE accounts
SET balance = $2
WHERE id = $1
RETURNING *;

-- name: AddAccountBalance :one
UPDATE accounts
SET balance = balance + sqlc.arg(amount)
WHERE id = sqlc.arg(id)
RETURNING *;

-- name: DeleteAccount :exec
DELETE FROM accounts
WHERE id = $1;

--for deadlock -> get for update, (no key upadate) , for no circular interlocking, update in consistent order