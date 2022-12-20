# 유저 테이블
create table users
(
    user_no INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(20) NOT NULL,
    user_pw VARCHAR(50) NOT NULL,
    user_name VARCHAR(50) NOT NULL,
    user_phone VARCHAR(20) NOT NULL,
    user_point INT UNSIGNED NOT NULL
);
-- select * from user;
-- drop table user;

# 메뉴테이블
CREATE TABLE menus
(
    menu_no INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    menu_type VARCHAR(40) NOT NULL,
    menu_name VARCHAR(200) NOT NULL,
    menu_img_url VARCHAR(200) NULL,
    menu_shot BOOLEAN NOT NULL DEFAULT false,
    menu_syrup BOOLEAN NOT NULL DEFAULT false,
    menu_price_normal INT UNSIGNED NULL,
    menu_price_small INT UNSIGNED NULL,
    menu_price_middle INT UNSIGNED NULL,
    menu_price_large INT UNSIGNED NULL
);
-- select * from menus;
-- drop table menus;

# 주문 테이블
create table orders
(
    -- 주문테이블 식별번호
    order_no INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -- 주문한 회원(회원테이블 참조)
    user_no INT UNSIGNED NULL,
    -- 총 주문 원래 가격
    menu_origin_price INT UNSIGNED NOT NULL,
    -- 회원이 사용한 포인트 금액
    order_user_use_point INT UNSIGNED NULL DEFAULT 0,
    -- 회원에 적립되는 포인트 금액
    order_user_get_point INT UNSIGNED NULL,
    order_total_price INT UNSIGNED NOT NULL,
    order_time TIMESTAMP,
    order_total_amount INT UNSIGNED NOT NULL DEFAULT 1,
    -- 매장 or 포장.
    order_type VARCHAR(20) NOT NULL DEFAULT 'store',

    foreign key (user_no) references users(user_no)

);
-- drop table orders;
-- select * from orders;

# 주문 상세 테이블
create table detail_orders
(
    detail_order_no INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    menu_no INT UNSIGNED NOT NULL,
    order_no INT UNSIGNED NOT NULL,
    detail_order_count INT UNSIGNED NOT NULL default 1,
    detail_order_shot INT UNSIGNED NULL,
    detail_order_water VARCHAR(20) NULL,
    detail_order_size VARCHAR(20) NULL,
    -- orders의 기본키 참조

    foreign key(menu_no) references menus(menu_no),
    foreign key(order_no) references orders(order_no)
);

# 결제 테이블
create table payment
(
    payment_no INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    payment_orders_no INT UNSIGNED NOT NULL,
    payment_type VARCHAR(20) NOT NULL,
    payment_progress VARCHAR(20) NOT NULL,
    -- 결제자 이름, 카드, 등.. 부수정보
    foreign key(payment_orders_no) references orders(order_no)
);