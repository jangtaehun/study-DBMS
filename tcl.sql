create table tbl_member (
    id bigint auto_increment primary key,
    name varchar(255) not null,
    address varchar(255) not null
);

insert into tbl_member(name, address)
value ('홍길동', '서울시 강남구');

commit;

select * from tbl_member;

delete from tbl_member
where id =1;

rollback;