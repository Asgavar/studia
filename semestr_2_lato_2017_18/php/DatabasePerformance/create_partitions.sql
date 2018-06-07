create table transactions_q1 (
    check (extract(month from date_time) between 1 and 3)
) inherits (transactions);

create table transactions_q2 (
    check (extract(month from date_time) between 4 and 6)
) inherits (transactions);

create table transactions_q3 (
check (extract(month from date_time) between 7 and 9)
) inherits (transactions);

create table transactions_q4 (
check (extract(month from date_time) between 10 and 12)
) inherits (transactions);

create or replace function transactions_partition_function()
returns trigger as $$
declare
    transaction_month double precision := extract(month from new.date_time);
begin
    if (transaction_month between 1 and 3) then
        insert into transactions_q1 values (new.*);
    elsif (transaction_month between 4 and 6) then
        insert into transactions_q2 values (new.*);
    elsif (transaction_month between 7 and 9) then
        insert into transactions_q3 values (new.*);
    elsif (transaction_month between 10 and 12) then
        insert into transactions_q4 values (new.*);
    end if;
    return null;
end;
$$
language plpgsql;

create trigger insert_transactions_trigger
    before insert on transactions
    for each row execute procedure transactions_partition_function();
