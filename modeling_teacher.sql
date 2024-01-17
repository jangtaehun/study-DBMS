/*
   회원          주문              상품
   ----------------------------------------
   번호PK      번호PK          번호PK
   ----------------------------------------
   아이디U, NN   날짜NN          이름NN
   비밀번호NN   회원번호FK, NN   가격D=0
   이름NN      상품번호FK, NN   재고D=0
   주소NN
   이메일
   생일
*/
create table tbl_user(
    id bigint primary key,
    user_id varchar(255) not null unique,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);

create table tbl_product(
    id bigint primary key,
    name varchar(255) not null,
    price int default 0,
    stock int default 0
);

create table tbl_order(
    id bigint primary key,
    order_date datetime default current_timestamp,
    user_id bigint not null,
    product_id bigint not null,
    constraint fk_order_user foreign key(user_id)
    references tbl_user(id),
    constraint fk_order_product foreign key(product_id)
    references tbl_product(id)
);

drop table tbl_order;
drop table tbl_user;
drop table tbl_product;

show tables;

/*
    1. 요구사항 분석
        꽃 테이블과 화분 테이블 2개가 필요하고,
        꽃을 구매할 때 화분도 같이 구매합니다.
        꽃은 이름과 색상, 가격이 있고,
        화분은 제품번호, 색상, 모양이 있습니다.
        화분은 모든 꽃을 담을 수 없고 정해진 꽃을 담아야 합니다.

    2. 개념 모델링
    3. 논리 모델링
    4. 물리 모델링
    5. 구현
*/

create table tbl_flower(
    id bigint primary key,
    name varchar(255) not null,
    color varchar(255) not null,
    price int default 0
);

create table tbl_pot(
    id bigint primary key,
    color varchar(255) not null,
    shape varchar(255) not null,
    flower_id bigint not null,
    constraint fk_pot_flower foreign key(flower_id)
    references tbl_flower(id)
);

drop table tbl_pot;
drop table tbl_flower;

show tables;


/*
    복합키(조합키): 하나의 PK에 여러 컬럼을 설정한다.
*/
create table tbl_flower(
    name varchar(255) not null,
    color varchar(255) not null,
    price int default 0,
    primary key(name, color)
);

create table tbl_pot(
    id bigint primary key,
    color varchar(255) not null,
    shape varchar(255) not null,
    flower_name varchar(255) not null,
    flower_color varchar(255) not null,
    constraint fk_pot_flower foreign key(flower_name, flower_color)
    references tbl_flower(name, color)
);

drop table tbl_pot;
drop table tbl_flower;

show tables;

/*
    1. 요구사항 분석
        안녕하세요, 동물병원을 곧 개원합니다.
        동물은 보호자랑 항상 같이 옵니다. 가끔 보호소에서 오는 동물도 있습니다.
        보호자가 여러 마리의 동물을 데리고 올 수 있습니다.
        보호자는 이름, 나이, 전화번호, 주소가 필요하고
        동물은 병명, 이름, 나이, 몸무게가 필요합니다.

    2. 개념 모델링
    3. 논리 모델링
    4. 물리 모델링
    5. 구현
*/

create table owner(
    id bigint primary key,
    name varchar(255) not null,
    age int default 0,
    phone varchar(255) not null,
    address varchar(255) not null
);

alter table owner rename tbl_owner;

create table pet(
    id bigint primary key,
    name varchar(255) default '사랑',
    ill_name varchar(255) not null,
    age int default 0,
    weight decimal(3, 2) default 0.0,
    owner_id bigint,
    constraint fk_pet_owner foreign key(owner_id)
                references tbl_owner(id)
);

alter table pet rename tbl_pet;

drop table tbl_pet;
drop table tbl_owner;

show tables;

/*
    1. 요구사항 분석
        안녕하세요 중고차 딜러입니다.
        이번에 자동차와 차주를 관리하고자 방문했습니다.
        자동차는 여러 명의 차주로 히스토리에 남아야 하고,
        차주는 여러 대의 자동차를 소유할 수 있습니다.
        그래서 우리는 항상 등록증(Registration)을 작성합니다.
        자동차는 브랜드, 모델명, 가격, 출시날짜가 필요하고
        차주는 이름, 전화번호, 주소가 필요합니다.

    2. 개념 모델링
    3. 논리 모델링
    4. 물리 모델링
    5. 구현
*/
create table tbl_car(
    id bigint primary key,
    brand varchar(255) not null,
    model varchar(255) not null,
    price bigint default 0,
    release_date date default (current_date)
);

create table tbl_car_owner(
    id bigint primary key,
    name varchar(255) not null,
    phone varchar(255) not null,
    address varchar(255) not null
);

create table tbl_car_registration(
    id bigint primary key,
    car_id bigint not null,
    car_owner_id bigint not null,
    constraint fk_car_registration_car foreign key(car_id)
                                 references tbl_car(id),
    constraint fk_car_registration_car_owner foreign key(car_owner_id)
                                 references tbl_car_owner(id)
);

drop table tbl_car_registration;
drop table tbl_car;
drop table tbl_car_owner;

show tables;

/*
    요구 사항
    커뮤니티 게시판을 만들고 싶어요.
    게시판에는 게시글 제목과 게시글 내용, 작성한 시간, 작성자가 있고,
    게시글에는 댓글이 있어서 댓글 내용들이 나와야 해요.
    작성자는 회원(tbl_user)정보를 그대로 사용해요.
    댓글에도 작성자가 필요해요.
*/
create table tbl_user(
    id bigint primary key,
    user_id varchar(255) not null unique,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);

create table tbl_post(
    id bigint primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    create_date datetime default current_timestamp,
    user_id bigint not null,
    constraint fk_post_user foreign key(user_id)
                     references tbl_user(id)
);

create table tbl_reply(
    id bigint primary key,
    content varchar(255) not null,
    user_id bigint not null,
    post_id bigint not null,
    constraint fk_reply_user foreign key(user_id)
                     references tbl_user(id),
    constraint fk_reply_post foreign key(post_id)
                     references tbl_post(id)
);

drop table tbl_reply;
drop table tbl_post;
drop table tbl_user;

show tables;

/*
    요구사항

    마이페이지에서 회원 프로필을 구현하고 싶습니다.
    회원당 프로필을 여러 개 설정할 수 있고,
    대표 이미지로 선택된 프로필만 화면에 보여주고 싶습니다.
*/
create table tbl_user(
    id bigint primary key,
    user_id varchar(255) not null unique,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);

create table tbl_file(
    id bigint primary key,
    file_path varchar(255) default '/upload/',
    file_name varchar(255),
    is_main varchar(255) default 'ELSE',
    user_id bigint,
    constraint fk_file_user foreign key(user_id)
                     references tbl_user(id)
);

drop table tbl_file;
drop table tbl_user;

show tables;

/*
 ---------------------------------------------------------------------------------------
 ------------------------------------------숙제------------------------------------------
 ---------------------------------------------------------------------------------------
 */

/*
    요구사항

    학사 관리 시스템에 학생과 교수, 과목을 관리합니다.
    학생은 학번, 이름, 전공, 학년이 필요하고
    교수는 교수 번호, 이름, 전공, 직위가 필요합니다.
    과목은 고유한 과목 번호와 과목명, 학점이 필요합니다.
    학생은 여러 과목을 수강할 수 있으며,
    교수는 여러 과목을 강의할 수 있습니다.
    학생이 수강한 과목은 성적(점수)이 모두 기록됩니다.
*/
    create table tbl_student(
        id bigint auto_increment primary key,
        name varchar(255) not null,
        major varchar(255) not null,
        grade int default 1
    );

    create table tbl_professor(
        id bigint auto_increment primary key,
        name varchar(255) not null,
        major varchar(255) not null,
        position varchar(255) not null
    );

    create table tbl_subject(
        id bigint auto_increment primary key,
        name varchar(255) not null,
        score int default 0
    );

    create table tbl_student_subject(
        id bigint auto_increment primary key,
        grade varchar(255),
        status varchar(255) default '수강중',
        student_id bigint not null,
        subject_id bigint not null,
        professor_id bigint not null,
        constraint check_status check (status in('수강중', '수강완료')),
        constraint fk_student_subject_student foreign key (student_id)
                                    references tbl_student(id),
        constraint fk_student_subject_subject foreign key (subject_id)
                                    references tbl_subject(id),
        constraint fk_student_subject_professor foreign key (professor_id)
                                    references tbl_professor(id)
    );

    create table tbl_lecture(
        id bigint auto_increment primary key,
        professor_id bigint not null,
        subject_id bigint not null,
        constraint fk_lecture_professor foreign key(professor_id)
                            references tbl_professor(id),
        constraint fk_lecture_subject foreign key(subject_id)
                            references tbl_subject(id)
    );

/*
    요구사항

    대카테고리, 소카테고리가 필요해요.
*/
    create table tbl_category_A(
        id bigint auto_increment primary key,
        name varchar(255) not null
    );

    create table tbl_category_B(
        id bigint auto_increment primary key,
        name varchar(255) not null,
        category_A_id bigint not null,
        constraint fk_category_B_category_A foreign key(category_A_id)
                               references tbl_category_A(id)
    );

/*
    요구 사항

    회의실 예약 서비스를 제작하고 싶습니다.
    회원별로 등급이 존재하고 사무실마다 회의실이 여러 개 있습니다.
    회의실 이용 가능 시간은 파트 타임으로서 여러 시간대가 존재합니다.

*/
create table tbl_user(
    id varchar(255) primary key,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date,
    level varchar(255) default '기본',
    constraint check_level check ( level in ('기본', '단골') )
);

create table tbl_office(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    location varchar(255) not null
);

create table tbl_conference_room(
    id bigint auto_increment primary key,
    office_id bigint not null,
    constraint fk_conference_room_office foreign key(office_id)
                                references tbl_office(id)
);

create table tbl_part_time(
    id bigint auto_increment primary key,
    time time not null,
    conference_room_id bigint not null,
    constraint fk_part_time_conference_room foreign key(conference_room_id)
                                references tbl_conference_room(id)
);

create table tbl_reservation(
    id bigint auto_increment primary key,
    time time not null,
    created_date datetime default (current_timestamp),
    user_id varchar(255) not null,
    conference_room_id bigint not null,
    constraint fk_reservation_user foreign key (user_id)
                            references tbl_user(id),
    constraint fk_reservation_conference_room foreign key (conference_room_id)
                            references tbl_conference_room(id)
);


/*
    요구사항

    유치원을 하려고 하는데, 아이들이 체험학습 프로그램을 신청해야 합니다.
    아이들 정보는 이름, 나이, 성별이 필요하고 학부모는 이름, 나이, 주소, 전화번호, 성별이 필요해요
    체험학습은 체험학습 제목, 체험학습 내용, 이벤트 이미지 여러 장이 필요합니다.
    아이들은 여러 번 체험학습에 등록할 수 있어요.
*/
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

/*
    요구사항

    안녕하세요, 광고 회사를 운영하려고 준비중인 사업가입니다.
    광고주는 기업이고 기업 정보는 이름, 주소, 대표번호, 기업종류(스타트업, 중소기업, 중견기업, 대기업)입니다.
    광고는 제목, 내용이 있고 기업은 여러 광고를 신청할 수 있습니다.
    기업이 광고를 선택할 때에는 카테고리로 선택하며, 대카테고리, 중카테고리, 소카테고리가 있습니다.
*/
create table tbl_company_type(
    id bigint auto_increment primary key,
    type varchar(255)
);

create table tbl_company(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    company_type_id bigint,
    constraint fk_company_company_type foreign key (company_type_id)
                        references tbl_company_type(id)
);

create table tbl_ad_category_A(
    id bigint auto_increment primary key,
    name varchar(255) not null
);

create table tbl_ad_category_B(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    ad_category_A_id bigint not null,
    constraint fk_ad_category_B_ad_category_A foreign key (ad_category_A_id)
                           references tbl_ad_category_A(id)
);

create table tbl_ad_category_C(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    ad_category_B_id bigint not null,
    constraint fk_ad_category_C_ad_category_B foreign key (ad_category_B_id)
                           references tbl_ad_category_B(id)
);


create table tbl_advertisement(
    id bigint auto_increment primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    ad_category_C_id bigint not null,
    constraint fk_advertisement_ad_category_C foreign key (ad_category_C_id)
                           references tbl_ad_category_C(id)
);

create table tbl_ad_apply(
    id bigint auto_increment primary key,
    company_id bigint not null,
    advertisement_id bigint not null,
    created_date datetime default current_timestamp,
    updated_date datetime default current_timestamp on update current_timestamp,
    constraint fk_apply_company foreign key (company_id)
                           references tbl_company(id),
    constraint fk_apply_advertisement foreign key (advertisement_id)
                           references tbl_advertisement(id)
);


/*
    요구사항

    음료수 판매 업체입니다. 음료수마다 당첨번호가 있습니다.
    음료수의 당첨번호는 1개이고 당첨자의 정보를 알아야 상품을 배송할 수 있습니다.
    당첨 번호마다 당첨 상품이 있고, 당첨 상품이 배송 중인지 배송 완료인지 구분해야 합니다.
*/
create table tbl_member(
    id varchar(255) primary key,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);

create table tbl_soft_drink(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    price int default 0
);

create table tbl_product(
    id bigint auto_increment primary key,
    name varchar(255) not null
);

create table tbl_lottery(
    id bigint auto_increment primary key,
    number varchar(255) not null,
    product_id bigint,
    constraint fk_lottery_product foreign key (product_id)
                        references tbl_product(id)
);

create table tbl_circulation(
    id bigint auto_increment primary key,
    soft_drink_id bigint not null,
    lottery_id bigint not null,
    constraint fk_circulation_soft_drink foreign key (soft_drink_id)
                            references tbl_soft_drink(id),
    constraint fk_circulation_lottery foreign key (lottery_id)
                            references tbl_lottery(id)
);

create table tbl_delivery(
    id bigint auto_increment primary key,
    status varchar(255),
    member_id varchar(255) not null,
    product_id bigint not null,
    constraint check_delivery_status check ( status in ('상품준비중', '배송중', '배송완료') ),
    constraint fk_delivery_member foreign key (member_id)
                         references tbl_member(id),
    constraint fk_delivery_product foreign key (product_id)
                         references tbl_product(id)
);


/*
    요구사항

    이커머스 창업 준비중입니다. 기업과 사용자 간 거래를 위해 기업의 정보와 사용자 정보가 필요합니다.
    기업의 정보는 기업 이름, 주소, 대표번호가 있고
    사용자 정보는 이름, 주소, 전화번호가 있습니다. 결제 시 사용자 정보와 기업의 정보, 결제한 카드의 정보 모두 필요하며,
    상품의 정보도 필요합니다. 상품의 정보는 이름, 가격, 재고입니다.
    사용자는 등록한 카드의 정보를 저장할 수 있으며, 카드의 정보는 카드번호, 카드사, 회원 정보가 필요합니다.
*/
create table tbl_corporation(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    tel varchar(255) not null
);

create table tbl_client(
    id varchar(255) primary key,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);

create table tbl_card(
    id bigint auto_increment primary key,
    number varchar(255) not null,
    company varchar(255) not null,
    client_id varchar(255) not null,
    constraint fk_card_client foreign key (client_id)
                     references tbl_client(id)
);

create table tbl_item(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    price int default 0,
    stock int default 0,
    corporation_id bigint not null,
    constraint fk_item_corporation foreign key (corporation_id)
                     references tbl_corporation(id)
);

create table tbl_sequence(
    id bigint auto_increment primary key,
    sequence bigint default 0
);

create table tbl_order(
    id bigint,
    created_date date default (current_date),
    primary key (id, created_date)
);

create table tbl_order_item(
    id bigint auto_increment primary key,
    order_id bigint,
    order_created_date date,
    item_id bigint,
    constraint fk_order_item_order foreign key (order_id, order_created_date)
                              references tbl_order(id, created_date),
    constraint fk_order_item_product foreign key (item_id)
                              references tbl_item(id)
);

create table tbl_pay(
    id bigint auto_increment primary key,
    order_id bigint,
    order_created_date date,
    card_id bigint,
    count int default 0,
    constraint fk_pay_order foreign key (order_id, order_created_date)
                              references tbl_order(id, created_date),
    constraint fk_pay_card foreign key (card_id)
                    references tbl_card(id)
);