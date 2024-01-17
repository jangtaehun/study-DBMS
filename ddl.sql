show databases;
use test;

create table tbl_member(
    member_name varchar(255),
    member_age int
);

show tables;

drop table tbl_member;
/*
  범위 주석
 */

 /*
  자동차 테이블 생성
  1. 자동차 번호
  2. 자동차 브랜드
  3. 출시 날짜
  4. 색상
  5. 가격
  */
create table tbl_car(
    car_number bigint primary key,
    car_brand varchar(255),
    car_data date,
    car_color varchar(255),
    car_price int
);
show tables;
drop table tbl_car;


/*
    동물 테이블 생성
    1. 번호
    2. 종류
    3. 먹이
 */
 create table tbl_animal(
     animal_number bigint primary key,
     anima_type varchar(255) not null unique,
     animal_feed varchar(255)
 );
show tables;

drop table tbl_animal;
drop table tbl_product;
drop table tbl_user;
