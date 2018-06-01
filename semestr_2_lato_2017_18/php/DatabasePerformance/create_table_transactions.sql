create table transactions (
    id serial primary key,
    pos_id int,
    date_time timestamp,
    amount numeric,
    title text,

    constraint amount_is_not_negative check (amount > 0),
    constraint title_is_not_empty check (title != '')
);
