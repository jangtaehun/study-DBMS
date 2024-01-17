create table tbl_parent(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    age tinyint default 1,
    gender varchar(255) default '선택안함',
    address varchar(255) not null,
    phone varchar(255) not null,
    constraint check_gender check ( gender in ('선택안함', '여자', '남자') )
);

/*
    전체를 의미한 *은 직접 컬럼을 작성한 것보다 더 많은 연산이 필요하기 때문에
    대량의 데이터 조회 시 사용을 지양한다.

    select * from tbl_parent;
*/
select id, name, age, gender, address, phone
from tbl_parent;

insert into tbl_parent
(name, age, address, phone)
values ('한동석', 20, '경기도 남양주', '01012341234');

update tbl_parent
set age = 40
where id = 1;

delete from tbl_parent
where id = 1;

/*2명의 학부모 정보 추가*/
insert into tbl_parent
(name, age, gender, address, phone)
values ('또치', 5, '여자', '경기도 남양주', '01012341234');

insert into tbl_parent
(name, age, gender, address, phone)
values ('둘리', 51, '여자', '서울시 강남구', '01055556666');

insert into tbl_parent
(name, age, gender, address, phone)
values ('마이콜', 55, '남자', '경기도 광주', '0108888999');

/*부모 중, 나이가 51세 이상인 부모의 이름 조회*/
select name, age from tbl_parent
where age >= 51;

/*경기도 남양주에 살고 있는 부모의 핸드폰 번호 조회*/
select phone, address from tbl_parent
where address = '경기도 남양주';

/*성별이 남자인 학부모를 선택안함으로 변경*/
update tbl_parent
set gender = '선택안함'
where gender = '남자';

select id, name, age, gender, address, phone from tbl_parent;

/*성별이 선택안함인 학부모를 모두 삭제*/
delete from tbl_parent
where gender = '선택안함';

select id, name, age, gender, address, phone from tbl_parent;

/*
    as(Alias): 별칭
*/

select id, name as 이름, age + 1, gender, address, phone from tbl_parent;

/*
    concatenation(연결)
    concat([string1], [string2], ...)
*/
select concat('안녕하세요 제 이름은 ', name, '입니다.') as intro from tbl_parent;

/*
    like
        포함된 문자열 값을 찾을 때 사용한다.

    예시)
    '%A': A로 끝나는 모든 값(SFDSA, FDSFDSA, ...)
    'A%': A로 시작하는 모든 값(ABC, Apple, ...)
    '%A%': A가 포함된 모든 값(Java, FFFAF, ...)
*/

select id, name, age, gender, address, phone from tbl_parent
where address like '%남양%';

select id, name, age, gender, address, phone from tbl_parent
where address like '경%';

select id, name, age, gender, address, phone from tbl_parent
where address like '%경';

/*핸드폰 번호에 5가 들어간 학부모 정보 전체 조회*/
select id, name, age, gender, address, phone from tbl_parent
where phone like '%5%';

/*주소에 서울이 들어간 학부모 정보 전체 조회*/
select id, name, age, gender, address, phone from tbl_parent
where address like '%서울%';

/*
    집계 함수

    평균 avg()
    최대값 max()
    최소값 min()
    총 합 sum()
    개수 count()
*/
create table tbl_field_trip(
    id bigint auto_increment primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    count tinyint default 0
);

insert into tbl_field_trip (title, content, count)
values ('어서와 매미농장', '매미 잡자 어서와', 20);

insert into tbl_field_trip (title, content, count)
values ('아이스크림 빨리 먹기 대회', '아이스크림 누가 더 잘먹나', 100);

insert into tbl_field_trip (title, content, count)
values ('고구마 심기', '고구마가 왕 커요', 10);

insert into tbl_field_trip (title, content, count)
values ('숭어 얼음 낚시', '숭어 잡자 추워도 참아', 80);

insert into tbl_field_trip (title, content, count)
values ('커피 체험 공장', '커비 빈 객체화', 60);

insert into tbl_field_trip (title, content, count)
values ('치즈 제작하기', '여기 치즈 저기 치즈 전부 다 치즈', 5);

insert into tbl_field_trip (title, content, count)
values ('동물 타보기', '이리야!', 9);

select id, title, content, count from tbl_field_trip;

select sum(count) as total from tbl_field_trip;
select avg(count) as average from tbl_field_trip;
select max(count) as max_count from tbl_field_trip;
select min(count) as min_count from tbl_field_trip;
select round(avg(count), 2) as average from tbl_field_trip;
select count(id) as field_trip_count from tbl_field_trip;

/*
    order by: 정렬

    order by [컬럼명] asc: 오름차순, asc 생략 가능
    order by [컬럼명] desc: 내림차순

*/

select id, title, content, count from tbl_field_trip
order by count desc;

select id, title, content, count from tbl_field_trip
order by count;

/*
    실행 순서
    1. from
    2. where
    3. select
    4. order by
*/

/*
    group by: ~별

    group by [컬럼명]
    having [조건식]
*/
create table tbl_order(
    id bigint auto_increment primary key,
    name varchar(255),
    price int default 0
);

insert into tbl_order (name, price)
values ('지우개', 3000);

insert into tbl_order (name, price)
values ('마우스', 5000);

insert into tbl_order (name, price)
values ('지우개', 3000);

insert into tbl_order (name, price)
values ('키보드', 15000);

insert into tbl_order (name, price)
values ('키보드', 15000);

insert into tbl_order (name, price)
values ('사과', 2000);

insert into tbl_order (name, price)
values ('사과', 2000);

insert into tbl_order (name, price)
values ('자두', 500);

insert into tbl_order (name, price)
values ('자두', 1000);

select name, count(name) total from tbl_order
group by name;

/*주문된 상품별 평균 가격 조회*/
select name, round(avg(price), 0) average from tbl_order
group by name;

/*
    실행 순서
    1. from
    2. where
    3. group by
    4. having
    5. select
    6. order by
*/
/*주문된 상품별 평균 가격 중 5000원 이상인 상품 조회*/
select name, round(avg(price), 0) average from tbl_order
group by name
having avg(price) >= 5000;

/*
    서브 쿼리(Sub Query)

    from절: in line view
    select절: scalar
    where절: sub query
*/
/* ============================================================================= */

/*상품별 가격 총 합과 전체 상품의 총 합 조회*/
select name, sum(price) total, (select sum(price) from tbl_order)
from tbl_order
group by name;

/*상품 중 "우"가 들어간 상품별 총 합 조회*/
select o.name, sum(o.price) from
(
    select name, price
    from tbl_order
    where name like '%우%'
) o
group by o.name;

/*상품의 평균 가격이 1000원 이하인 상품의 개별 가격 조회*/
select id, name, price from tbl_order
where name in
(
    select name
    from tbl_order
    group by name
    having avg(price) <= 1000
);

/*
    실행 순서
    1. from
    2. join
    3. on
    4. where
    5. group by
    6. having
    7. select
    8. order by
*/

create table tbl_user(
    id bigint auto_increment primary key,
    user_id varchar(255) not null unique,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);

create table tbl_post(
    id bigint auto_increment primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    create_date datetime default current_timestamp,
    user_id bigint not null,
    constraint fk_post_user foreign key(user_id)
                     references tbl_user(id)
);

create table tbl_reply(
    id bigint auto_increment primary key,
    content varchar(255) not null,
    user_id bigint not null,
    post_id bigint not null,
    constraint fk_reply_user foreign key(user_id)
                     references tbl_user(id),
    constraint fk_reply_post foreign key(post_id)
                     references tbl_post(id)
);



insert into tbl_user (user_id, password, name, address, email, birth)
values ('hds1234', '1234', '한동석', '경기도', 'test1234@gmail.com', '2000-12-04');

insert into tbl_user (user_id, password, name, address, email, birth)
values ('hgd3333', '3333', '홍길동', '서울', 'hgd1234@gmail.com', '1920-11-25');

select * from tbl_user;


insert into tbl_post (title, content, user_id)
values ('테스트 제목1', '테스트 내용1', 1);

insert into tbl_post (title, content, user_id)
values ('테스트 제목2', '테스트 내용2', 2);

insert into tbl_post (title, content, user_id)
values ('테스트 제목3', '테스트 내용3', 1);

insert into tbl_post (title, content, user_id)
values ('테스트 제목4', '테스트 내용4', 1);

select * from tbl_post;

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 1', 2, 1);

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 1', 2, 2);

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 2', 1, 1);

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 2', 2, 1);

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 1', 1, 2);

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 1', 1, 2);

select * from tbl_reply;

/*3이 포함된 게시글 제목을 조회한 뒤 작성자 전체 정보 조회*/
select u.* from tbl_user u join tbl_post p
on p.title like '%3%' and u.id = p.user_id;

/*게시글 내용이 "테스트 내용4"의 작성자가 작성한 댓글 전체 정보 조회*/
select * from tbl_post p join tbl_reply r
on p.content = '테스트 내용4' and p.user_id = r.user_id;

/*게시글 별 댓글 개수*/
select p.id, p.title, p.content, count(r.id)
from tbl_post p join tbl_reply r
on p.id = r.post_id
group by p.id, p.title, p.content;

/*회원 중 gmail을 사용하는 회원이 작성한 게시글 정보 중 제목 조회*/
select p.title from tbl_user u join tbl_post p
on u.email like '%gmail%' and u.id = p.user_id;

/*회원 중 "서울"거주자가 작성한 댓글 조회 */
select * from tbl_user u join tbl_reply r
on u.address like '%서울%' and u.id = r.user_id;

/*댓글 중 같은 게시글에 작성된 댓글 내용 조회*/
select p.id, r.content from tbl_post p join tbl_reply r
on p.id = r.post_id
group by p.id, r.content;

/*댓글 개수가 3개 이상인 게시글 전체 내용 조회 및 회원 이름 조회*/
select p.*, u.name from tbl_user u join tbl_post p
on p.id in (select post_id
               from tbl_reply
               group by post_id
               having count(id) >= 3) and u.id = p.user_id;

/*게시글 전체정보와 회원의 이메일 조회*/
select p.*, u.email from tbl_user u join tbl_post p
on u.id = p.user_id;

/*댓글 작성자 중 게시글을 등록한 회원*/
select distinct u.* from tbl_user u join tbl_post p
on p.user_id in
(select user_id from tbl_reply) and p.user_id = u.id;

/*댓글 작성자 중 게시글을 2번 이상 작성한 회원의 게시글 제목과 게시글 내용 조회*/
select title, content from tbl_post
where user_id in (
    select user_id from tbl_post
    where user_id in (select user_id
                      from tbl_reply
                      group by user_id)
    group by user_id
    having count(id) >= 2);

select p.title, p.content from tbl_post p join
(select user_id from tbl_post
    where user_id in (select user_id
                      from tbl_reply
                      group by user_id)
    group by user_id
    having count(id) >= 2) u
on p.user_id = u.user_id;

/*게시글 작성자 중 댓글을 2번 이상 작성한 회원의 정보와 작성한 댓글의 전체 정보 조회*/
select * from tbl_user u join tbl_reply r
on u.id in
(
    select r.user_id from tbl_reply r
    where r.user_id in
    (select user_id from tbl_post)
    group by r.user_id
    having count(r.id) >= 2
) and u.id = r.user_id;

/*체험학습*/
create table tbl_parent(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    age tinyint default 1,
    gender varchar(255) not null,
    address varchar(255) not null,
    phone varchar(255) not null,
    constraint check_gender check ( gender in ('선택안함', '여자', '남자') )
);

create table tbl_child(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    age tinyint default 1,
    gender varchar(255) not null,
    parent_id bigint not null,
    constraint check_child_gender check ( gender in ('선택안함', '여자', '남자') ),
    constraint fk_child_parent foreign key (parent_id)
                      references tbl_parent(id)
);

create table tbl_field_trip(
    id bigint auto_increment primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    count tinyint default 0
);

create table tbl_file(
    /* 슈퍼키 */
    id bigint auto_increment primary key,
    file_path varchar(255) not null,
    file_name varchar(255) not null
);

create table tbl_field_trip_file(
    /* 서브키 */
    id bigint primary key,
    field_trip_id bigint not null,
    constraint fk_field_trip_file_file foreign key (id)
    references tbl_file(id),
    constraint fk_field_trip_file_field_trip foreign key (field_trip_id)
    references tbl_field_trip(id)
);

create table tbl_apply(
    id bigint auto_increment primary key,
    child_id bigint not null,
    field_trip_id bigint not null,
    constraint fk_apply_child foreign key (child_id)
    references tbl_child(id),
    constraint fk_apply_field_trip foreign key (field_trip_id)
    references tbl_field_trip(id)
);

insert into tbl_field_trip (title, content, count)
values ('매미 잡기 체험학습', '매미 잡으러 떠나자!', 5);

insert into tbl_field_trip (title, content, count)
values ('메뚜기 때려 잡기 체험학습', '메뚜기 다 잡자!', 50);

insert into tbl_field_trip (title, content, count)
values ('물놀이 체험학습', '한강 수영장으로 퐁당!', 20);

insert into tbl_field_trip (title, content, count)
values ('블루베리 채집 체험학습', '맛있어 블루베리 냠냠!', 25);

insert into tbl_field_trip (title, content, count)
values ('코딩 체험학습', '나도 빌게이츠!', 20);

select * from tbl_field_trip;

insert into tbl_parent (name, age, address, phone, gender)
values ('한동석', '40', '경기도 남양주', '01012341234', '남자');

insert into tbl_parent (name, age, address, phone, gender)
values ('홍길동', '50', '서울시 강남구', '01055556666', '여자');

insert into tbl_parent (name, age, address, phone, gender)
values ('이순신', '55', '서울시 강남구', '01077778888', '여자');

select * from tbl_parent;

insert into tbl_child (name, age, gender, parent_id)
values ('김철수', 4, '남자', 1);

insert into tbl_child (name, age, gender, parent_id)
values ('김훈이', 5, '남자', 2);

insert into tbl_child (name, age, gender, parent_id)
values ('이유리', 7, '여자', 1);

insert into tbl_child (name, age, gender, parent_id)
values ('김사자', 4, '남자', 3);

insert into tbl_child (name, age, gender, parent_id)
values ('김영희', 4, '여자', 3);

select * from tbl_child;

insert into tbl_apply (child_id, field_trip_id)
values (1, 1);

insert into tbl_apply (child_id, field_trip_id)
values (2, 1);

insert into tbl_apply (child_id, field_trip_id)
values (3, 2);

insert into tbl_apply (child_id, field_trip_id)
values (4, 3);

insert into tbl_apply (child_id, field_trip_id)
values (4, 5);

insert into tbl_apply (child_id, field_trip_id)
values (5, 5);

insert into tbl_apply (child_id, field_trip_id)
values (5, 4);

insert into tbl_apply (child_id, field_trip_id)
values (5, 4);

insert into tbl_apply (child_id, field_trip_id)
values (5, 4);

insert into tbl_apply (child_id, field_trip_id)
values (5, 3);

select * from tbl_apply;

/*매미 체험학습에 신청한 아이의 전체 정보*/
/*1. 서브쿼리만 사용*/
/*2. join만 사용*/

/*체험학습을 2개 이상 신청한 아이의 정보와 부모의 정보 모두 조회*/

/*참가자(지원자) 수가 가장 적은 체험학습의 제목과 내용 조회*/

/*평균 참가자(지원자) 수보다 적은 체험학습의 제목과 내용 조회*/
