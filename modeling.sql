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
 -------------------------숙제-------------------------
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

    2. 개념 모델링
        학생  교수  과목  정보
        id   id   id   id
        이름  이름  이름  학생id
        전공  전공  학점  교수id
        학년  직위       과목id
                       학점

    3. 논리 모델링
        학생       교수     과목   정보
    ----------------------------------
        id PK    id PK   id PK  id PK
    ----------------------------------
        이름NN     이름NN  이름NN  학생id FK
        전공NN     전공NN  학점NN  교수id FK
        학년NN     직위NN         과목id FK
                                학점NN

    4. 물리 모델링
    tbl_student
	----------------------------
	id bigint primary key
	----------------------------
    name varchar(255) not null
    major varchar(255) not null
    grade int not null

    tbl_professor
	----------------------------
	id bigint primary key
	----------------------------
    name varchar(255) not null
    major varchar(255) not null
    position varchar(255) not null

    tbl_subject
	----------------------------
	id bigint primary key
	----------------------------
    subject varchar(255) not null
    score varchar(255) not null

    tbl_information
	----------------------------
	id bigint primary key
	----------------------------
    student_id bigint not null
    professor_id bigint not null
    subject_id bigint not null
    score varchar(255) not null

    5. 구현
*/
create table tbl_student(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    major varchar(255) not null,
    grade int default 1
);
create table tbl_professor(
    id bigint primary key,
    name varchar(255) not null,
    major varchar(255) not null,
    position varchar(255) not null
);
create table tbl_subject(
    id bigint primary key,
    subject varchar(255) not null,
    score varchar(255)
);
create table tbl_information(
    id bigint auto_increment primary key,
    score varchar(255),
    status varchar(255) default '수강중',
    constraint check_status check (status in('수강중, 수강완료')),
    student_id bigint not null,
    professor_id bigint not null,
    subject_id bigint not null,
    constraint fk_information_student foreign key (student_id) references tbl_student(id),
    constraint fk_information_professor foreign key (professor_id) references tbl_professor(id),
    constraint fk_information_subject foreign key (subject_id) references tbl_subject(id)
);
create table tbl_lector(
    id bigint auto_increment primary key,
    professor_id bigint not null,
    subject_id bigint not null,
    constraint fk_lector_professor foreign key (professor_id) references tbl_professor(id),
    constraint fk_lector_subject foreign key (subject_id) references tbl_subject(id)
);

/*
    요구사항
    대카테고리, 소카테고리가 필요해요.

    2. 개념 모델링
        대카테고리  소카테고리
        id          id
        이름         이름
        시간         내용
                    카테고리id

    3. 논리 모델링
        대카테고리  소카테고리
    ----------------------------
        id PK         id PK
    ----------------------------
        이름NN         이름NN
        시간NN         내용NN
                      카테고리id NN FK

    4. 물리 모델링
        tbl_large_category
        ----------------------------
        id bigint primary key
        ----------------------------
        category varchar(255) not null unique
        create_time datetime default (current_time)

        tbl_small_category
        ----------------------------
        id bigint primary key
        ----------------------------
        content varchar(255) not null
        category_id bigint not null

    5. 구현
*/
create table tbl_large_category(
    id bigint primary key,
    category varchar(255) not null unique,
    create_time datetime default (current_time)
);
create table tbl_small_category(
    id bigint primary key,
    content varchar(255) not null,
    large_category_id bigint not null,
    constraint fk_small_category_large_category foreign key (large_category_id) references tbl_large_category(id)
);

/*
    요구 사항
    회의실 예약 서비스를 제작하고 싶습니다.
    회원별로 등급이 존재하고 사무실마다 회의실이 여러 개 있습니다.
    회의실 이용 가능 시간은 파트 타임으로서 여러 시간대가 존재합니다.

    2. 개념 모델링
        회원  사무실 시간  예약
        id   id    id     id
        이름  이름  회의실    시작시간
        등급      사무실id   끝시간

    3. 논리 모델링
        회원      사무실     회의실         시간          예약
    --------------------------------------------------------
        id PK    id PK    id PK         id PK       id PK
    --------------------------------------------------------
        이름NN   이름NN     회의실NN       시작시간NN       회원id NN FK
        등급NN             사무실id NN FK 끝시간NN        사무실id NN FK
                                                      시간id NN FK
                                                      예약 NN

    4. 물리 모델링
        tbl_member
        ----------------------------
        id bigint primary key
        ----------------------------
        name varchar(255) not null,
        grade varchar(255) not null

        tbl_office
        ----------------------------
        id bigint primary key
        ----------------------------
        office_name varchar(255) not null

        tbl_room
        ----------------------------
        id bigint primary key
        ----------------------------
        room varchar(255) not null
        office_id bigint not null

        tbl_time
        ----------------------------
        id bigint primary key
        ----------------------------
        start datetime not null
        end datetime not null

        tbl_reservation
        ----------------------------
        id bigint primary key
        ----------------------------
        member_id bigint not null
        office_id bigint not null
        time_id bigint not null
        reservation datetime not null

    5. 구현
*/
create table tbl_member(
    user_id varchar(255) primary key ,
    name varchar(255) not null,
    grade varchar(255) default '기본',
    constraint check_level check(grade in ('기본' or 'vip')),
    email varchar(255),
    address varchar(255) not null
);
create table tbl_office(
    id bigint auto_increment primary key,
    office_name varchar(255) not null,
    location varchar(255) not null
);
create table tbl_room(
    id bigint primary key,
    room varchar(255) not null,
    office_id bigint not null,
    constraint fk_room_office foreign key (office_id) references tbl_office(id)
);
create table tbl_time(
    id bigint primary key,
    time datetime not null,
    room_id bigint not null,
    constraint  fk_time_room foreign key (room_id) references tbl_room(id)
);

create table tbl_reservation(
    id bigint  auto_increment primary key,
    member_id varchar(255) not null,
    room_id bigint not null,
    time_id bigint not null,
    reservation datetime not null,
    constraint fk_reservation_member foreign key (member_id) references tbl_member(user_id),
    constraint fk_reservation_room foreign key (room_id) references tbl_room(id)
);

/*
    요구사항
    유치원을 하려고 하는데, 아이들이 체험학습 프로그램을 신청해야 합니다.
    아이들 정보는 이름, 나이, 성별이 필요하고 학부모는 이름, 나이, 주소, 전화번호, 성별이 필요해요
    체험학습은 체험학습 제목, 체험학습 내용, 이벤트 이미지 여러 장이 필요합니다.
    아이들은 여러 번 체험학습에 등록할 수 있어요.

    2. 개념 모델링
        어린이     부모      체험학습    이미지
        id        id        id        id
        이름       이름       제목       사진
        나이       나이       내용       체험학습id
        성        주소       아이id
                  번호
                  성
                  아이id

    3. 논리 모델링
        어린이     부모      체험학습    이미지
    --------------------------------------------------------
        id PK       id PK        id PK       id PK
    --------------------------------------------------------
        이름NN       이름NN       제목NN       사진NN
        나이NN       나이NN       내용NN       체험학습id NN FK
        성NN         주소NN      아이id NN FK
                    번호NN
                    성NN
                    아이id NN FK

    4. 물리 모델링
        tbl_children
        ----------------------------
        id bigint primary key
        ----------------------------
        name varchar(255) not null
        age int not null
        gender varchar(255) not null

        tbl_parents
        ----------------------------
        id bigint primary key
        ----------------------------
        name varchar(255) not null
        age int not null
        address varchar(255) not null
        phone varchar(255) not null
        gender varchar(255) not null
        child_id bigint not null

        tbl_experience
        ----------------------------
        id bigint primary key
        ----------------------------
        title varchar(255) not null
        content varchar(255) not null
        children_id bigint not null

        tbl_image
        ----------------------------
        id bigint primary key
        ----------------------------
        image varchar(255) not null
        experience_id bigint not null

    5. 구현
*/
create table tbl_children(
    id bigint primary key,
    name varchar(255) not null,
    age int not null,
    gender varchar(255) not null,
    constraint check_child_gender check (gender in ('선택안함', '여자', '남자')),
    parent_id bigint not null,
    constraint fk_children_children foreign key (parent_id) references tbl_parents(id)

);
create table tbl_parents(
    id bigint primary key,
    name varchar(255) not null,
    age int not null,
    address varchar(255) not null,
    phone varchar(255) not null,
    gender varchar(255) not null,
    constraint check_parent_gender check (gender in ('선택안함', '여자', '남자'))
);
create table tbl_experience(
    id bigint primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    count tinyint default 0
);
create table tbl_regist(
    id bigint primary key,
    child_id bigint not null,
    experience_id bigint not null,
    constraint fk_regist_children foreign key (child_id) references tbl_children(id),
    constraint fk_regist_experience foreign key (experience_id) references tbl_experience(id)
);
create table tbl_image(
    id bigint primary key,
    image varchar(255) not null,
    experience_id bigint not null,
    constraint fk_image_experience foreign key (experience_id) references tbl_experience(id)
);

/*
    요구사항
    안녕하세요, 광고 회사를 운영하려고 준비중인 사업가입니다.
    광고주는 기업이고 기업 정보는 이름, 주소, 대표번호, 기업종류(스타트업, 중소기업, 중견기업, 대기업)입니다.
    광고는 제목, 내용이 있고 기업은 여러 광고를 신청할 수 있습니다.
    기업이 광고를 선택할 때에는 카테고리로 선택하며, 대카테고리, 중카테고리, 소카테고리가 있습니다.

    2. 개념 모델링
        기업      광고    범주      관계
        id       id     id       id
        이름      제목    카테고리   광고id
        주소      내용             화사id
        대표번호   회사id           카테고리id
        종류

    3. 논리 모델링
        기업          광고     범주        관계
    --------------------------------------------------------
        id PK      id PK    id PK      id PK
    --------------------------------------------------------
        이름NN      제목NN    카테고리NN   광고id NN FK
        주소NN      내용NN               화사id NN FK
        대표번호NN   회사id NN FK         카테고리id NN FK
        종류NN

    4. 물리 모델링
        tbl_company
        ----------------------------
        id bigint primary key
        ----------------------------
        name varchar(255) not null
        address varchar(255) not null
        main_number varchar(255) not null
        type varchar(255) not null

        tbl_ad
        ----------------------------
        id bigint primary key
        ----------------------------
        title varchar(255) not null
        content varchar(255) not null
        company_id bigint not null

        tbl_main_category
        ----------------------------
        id bigint primary key
        ----------------------------
        category varchar(255) not null

        tbl_ad_category
        ----------------------------
        id bigint primary key
        ----------------------------
        ad_id bigint not null
        company_id bigint not null
        category_id bigint not null

    5. 구현
*/
/*
create table tbl_company_type(
    id bigint auto_increment primary key,
    type varchar(255) not null
);
 */
create table tbl_company(
    id bigint primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    main_number varchar(255) not null,
    type varchar(255) not null
    /*
    company_type bigint,
    constraint fk~~
     */
);
create table tbl_ad(
    id bigint primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    company_id bigint not null,
    constraint fk_ad_company foreign key (company_id) references tbl_company(id)
);
create table tbl_main_category_A(
    id bigint primary key,
    category varchar(255) not null
);
create table tbl_main_category_B(
    id bigint primary key,
    category varchar(255) not null
);
create table tbl_main_category_C(
    id bigint primary key,
    category varchar(255) not null
);
create table tbl_ad_category(
    id bigint primary key,
    ad_id bigint not null,
    company_id bigint not null,
    category_id bigint not null,
    constraint fk_ad_category_ad foreign key (ad_id) references tbl_ad(id),
    constraint fk_ad_category_main_category foreign key (category_id) references tbl_main_category(id)
);

/*
    요구사항
    음료수 판매 업체입니다. 음료수마다 당첨번호가 있습니다.
    음료수의 당첨번호는 1개이고 당첨자의 정보를 알아야 상품을 배송할 수 있습니다.
    당첨 번호마다 당첨 상품이 있고, 당첨 상품이 배송 중인지 배송 완료인지 구분해야 합니다.

    2. 개념 모델링
        음료수    당첨자    상품      배송
        id      id       id      id
        이름     이름      이름     배송중
        당첨번호  전화번호   당첨번호  배송완료
                주소              상품id
                당첨번호

    3. 논리 모델링
        음료수      당첨자        상품           배송
    --------------------------------------------------------
        id PK     id PK      id PF          id PK
    --------------------------------------------------------
        이름NN     이름NN      이름NN           배송중
        당첨번호NN  전화번호NN   당첨번호NN FK     배송완료
                  주소NN                      상품id NN FK
                  당첨번호NN FK

    4. 물리 모델링
        tbl_drink
        ----------------------------
        id bigint primary key
        ----------------------------
        name varchar(255) not null,
        win_num varchar(255) not null unique

        tbl_winner
        ----------------------------
        id bigint primary key
        ----------------------------
        name varchar(255) not null
        phone varchar(255) not null
        address varchar(255) not null
        win_num bigint not null unique

        tbl_win_object
        ----------------------------
        id bigint primary key
        ----------------------------
        name varchar(255) not null
        win_num bigint not null

        tbl_win_delivery
        ----------------------------
        id bigint primary key
        ----------------------------
        delivery varchar(255)
        finish varchar(255)
        object_id bigint not null

    5. 구현
*/
create table tbl_drink(
    id bigint primary key,
    name varchar(255) not null,
    win_num varchar(255) not null unique
);
create table tbl_winner(
    id bigint primary key,
    name varchar(255) not null,
    phone varchar(255) not null,
    address varchar(255) not null,
    win_num bigint not null unique ,
    drink_id bigint not null,
    constraint fk_winner_drink foreign key (drink_id) references tbl_drink(id)
);
create table tbl_win_object(
    id bigint primary key,
    name varchar(255) not null,
    win_num bigint not null,
    constraint fk_win_object_drink foreign key (win_num) references tbl_drink(id)
);
create table tbl_delivery(
    id bigint primary key,
    delivery varchar(255),
    finish varchar(255),
    object_id bigint not null,
    constraint fk_delivery_winner foreign key (object_id) references tbl_win_object(id)
);

/*
    요구사항
    이커머스 창업 준비중입니다. 기업과 사용자 간 거래를 위해 기업의 정보와 사용자 정보가 필요합니다.
    기업의 정보는 기업 이름, 주소, 대표번호가 있고
    사용자 정보는 이름, 주소, 전화번호가 있습니다.
    결제 시 사용자 정보와 기업의 정보, 결제한 카드의 정보 모두 필요하며,상품의 정보도 필요합니다.
    상품의 정보는 이름, 가격, 재고입니다.
    사용자는 등록한 카드의 정보를 저장할 수 있으며, 카드의 정보는 카드번호, 카드사, 회원 정보가 필요합니다.

    2. 개념 모델링
        회사      사용자    상품  카드       결제
        id        id      id   id       id
        이름       이름     이름  카드id    유저id
        주소       주소     가격  이름      회사id
        대표전화    번호      재고  회원id   카드id
                                        상품id

    3. 논리 모델링
        회사          사용자       상품    카드            결제
    --------------------------------------------------------
        id PK       id PK     id PK   id PK         id PK
    --------------------------------------------------------
        이름NN       이름NN     이름NN   카드id NN      유저id NN FK
        주소NN       주소NN     가격NN   이름NN         회사id NN FK
        대표전화NN    번호NN     재고NN   회원id NN FK   카드id NN FK
                                                    상품id NN FK

    4. 물리 모델링
        tbl_win_company_info
        ----------------------------
        id bigint primary key
        ----------------------------
        name varchar(255) not null
        address varchar(255) not null
        main_number varchar(255) not null

        tbl_user
        ----------------------------
        id bigint primary key
        ----------------------------
        name varchar(255) not null,
        address varchar(255) not null,
        phone varchar(255) not null

        tbl_object_info
        ----------------------------
        id bigint primary key
        ----------------------------
        name varchar(255) not null
        price int default 0
        stock int default 0

        tbl_card
        ----------------------------
        id bigint primary key
        ----------------------------
        card_id bigint not null unique
        title varchar(255) not null
        user_id bigint not null,

        tbl_payment
        ----------------------------
        id bigint primary key
        ----------------------------
        user_id bigint not null
        company_id bigint not null
        card_id bigint not null
        object_id bigint not null

    5. 구현
*/
create table tbl_company_info(
    id bigint primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    main_number varchar(255) not null
);
create table tbl_user(
    id bigint primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    phone varchar(255) not null
);
create table tbl_object_info(
    id varchar(255) primary key,
    name varchar(255) not null,
    price int default 0,
    stock int default 0
);
create table tbl_card(
    id bigint auto_increment primary key,
    card_id varchar(255) not null unique ,
    title varchar(255) not null,
    user_id bigint not null,
    constraint fk_card_user foreign key (user_id) references tbl_user(id)
);

create table tbl_sequence(
    id bigint auto_increment primary key,
    sequence bigint default 0
);
create table tbl_order(
    id bigint,
    create_date date default (current_date),
    primary key (id, create_date)
);

create table tbl_payment(
    id bigint primary key,
    company_id bigint not null,
    card_id bigint not null,
    object_id bigint not null,
    constraint fk_payment_company_info foreign key (company_id) references tbl_company_info(id),
    constraint fk_payment_object_info foreign key (card_id) references tbl_card(id),
    constraint fk_payment_card foreign key (object_id) references tbl_object_info(id)
);
