show user;

-- **** 회원 테이블 생성하기 **** --
create table tbl_member
(userid             varchar2(40)   not null  -- 회원아이디
,pwd                varchar2(200)  not null  -- 비밀번호 (SHA-256 암호화 대상)
,name               varchar2(30)   not null  -- 회원명
,email              varchar2(200)  not null  -- 이메일 (AES-256 암호화/복호화 대상)
,mobile             varchar2(200)  not null  -- 연락처 (AES-256 암호화/복호화 대상) 
,postcode           varchar2(10)   not null  -- 우편번호
,address            varchar2(200)  not null  -- 주소
,detailaddress      varchar2(200)  not null  -- 상세주소
,extraaddress       varchar2(200)            -- 참고항목
,gender             varchar2(1)    not null  -- 성별   남자:1  / 여자:2
,birthday           varchar2(10)   not null  -- 생년월일   
,registerday        date default sysdate     -- 가입일자 
,lastpwdchangedate  date default sysdate     -- 마지막으로 암호를 변경한 날짜  
,status             number(1) default 0 not null     -- 회원탈퇴유무   0: 사용가능(가입중) / 1:사용불능(탈퇴) 
,idle               number(1) default 0 not null     -- 휴면유무      0 : 활동중  /  1 : 휴면중 
,constraint PK_tbl_member_userid primary key(userid)
,constraint UQ_tbl_member_email  unique(email)
,constraint CK_tbl_member_gender check( gender in('1','2') )
,constraint CK_tbl_member_status check( status in(0,1) )
,constraint CK_tbl_member_idle check( idle in(0,1) )
);

alter table tbl_member modify birthday not null;

select *
from user_constraints
where table_name = 'TBL_MEMBER';

-- **** 회원로그인 테이블 생성하기 **** --
create table tbl_loginhistory
(fk_userid   varchar2(40) not null  -- 회원아이디
,logindate   date default sysdate not null  -- 로그인한 날짜
,clientip    varchar2(20) not null -- 로그인한 ip
,constraint FK_tbl_loginhistory foreign key(fk_userid) references tbl_member(userid)  
);



-- **** 문의게시판 테이블 생성하기 **** --
create table tbl_ask
(askno       number
,fk_userid   varchar2(40)  not null
,category    varchar2(100) not null
,name        varchar2(20)  not null
,email       varchar2(200) not null
,mobile      varchar2(200) not null
,asktitle    varchar2(50)  not null
,askcontent  varchar2(500 CHAR) not null
,askdate     date default sysdate not null

,constraint PK_tbl_ask_askno primary key(askno)
,constraint FK_tbl_ask foreign key(fk_userid) references tbl_member(userid)  
);

-- **** 문의게시판 답글 테이블 생성하기 **** --
create table tbl_answer
(answerno       number
,fk_askno       number
,answertitle    varchar2(50)  not null
,answercontent  varchar2(500 CHAR) not null
,answerdate     date default sysdate not null
,constraint PK_tbl_answer_answerno primary key(answerno)
,constraint FK_tbl_answer foreign key(fk_askno) references tbl_ask(askno)
);

-- **** 조립신청게시판 테이블 생성하기 **** --
create table tbl_assemble
(assembleno         number
,fk_userid          varchar2(40)  not null
,fk_odrcode         varchar2(20)  not null
,name               varchar2(40)  not null
,email              varchar2(200) not null
,mobile             varchar2(200) not null
,hopedate           date not null
,hopehour           varchar2(100 char)
,postcode           varchar2(10)  not null
,address            varchar2(200) not null
,detailaddress      varchar2(200) not null        
,extraaddress       varchar2(200)
,demand             varchar2(500 char)
,assembledate       date default sysdate not null

,constraint PK_tbl_assemble primary key(assembleno)
,constraint FK_tbl_assemble_userid foreign key(fk_userid) references tbl_member(userid)  
,constraint FK_tbl_assemble_odrcode foreign key(fk_odrcode) references tbl_order(odrcode)
);

-- **** 반품신청게시판 테이블 생성하기 **** --
create table tbl_return
(returnno           number        
,fk_userid          varchar2(40)  not null
,fk_odrcode         varchar2(20)  not null
,name               varchar2(40)  not null
,email              varchar2(200) not null
,mobile             varchar2(200) not null
,whyreturn          varchar2(50 char) not null
,wherebuy           varchar2(20 char) not null
,returndate         date default sysdate not null

,constraint PK_tbl_return primary key(returnno)
,constraint FK_tbl_return_userid foreign key(fk_userid) references tbl_member(userid)  
,constraint FK_tbl_return_odrcode foreign key(fk_odrcode) references tbl_order(odrcode)
);

-- **** 리뷰게시판 테이블 생성하기 **** --
create table tbl_review
(review_seq         number        
,fk_userid          varchar2(40)  not null
,fk_pnum            varchar2(10)  not null
,title              varchar2(50)  not null
,content            varchar2(4000) not null
,registerdate       date default sysdate not null

,constraint PK_tbl_review_detail primary key(review_seq)
,constraint FK_tbl_review_detail_userid foreign key(fk_userid) references tbl_member(userid) 
,constraint FK_tbl_review_detail_pnum  foreign key(fk_pnum) references tbl_product(pnum)
);

-- ***** 주문 테이블 생성하기 ***** --
create table tbl_order
(odrcode        varchar2(20),
 fk_userid      varchar2(40),
 odrtotalprice  number,
 odrdate        date default sysdate,
 constraint pk_tbl_order_odrcode primary key(odrcode),
 constraint fk_tbl_order foreign key(fk_userid) references tbl_member(userid)
);

-- ***** 주문 상세 테이블 생성하기 ***** --
create table tbl_order_detail
(odrseqnum          number        
,fk_odrcode         varchar2(20)  not null
,fk_pnum            varchar2(10)  not null
,oqty               number(4)     not null
,odrprice           number        not null
,deliverstatus      number(1) default 1 not null
,deliverdate        date default sysdate not null

,constraint PK_tbl_order_detail primary key(odrseqnum)
,constraint FK_tbl_order_detail_odrcode foreign key(fk_odrcode) references tbl_order(odrcode) 
,constraint FK_tbl_order_detail_pnum  foreign key(fk_pnum) references tbl_product(pnum)
);

-- ***** 배송지 테이블 생성하기 ***** --
create table tbl_address
(addrno             number
,fk_odrcode         varchar2(20)  not null
,name               varchar2(40)  not null
,mobile             varchar2(200) not null
,postcode           varchar2(10)  not null
,address            varchar2(200) not null
,detailaddress      varchar2(200) not null        
,extraaddress       varchar2(200)

,constraint PK_tbl_address primary key(addrno)
,constraint FK_tbl_address foreign key(fk_odrcode) references tbl_order(odrcode)
);

-- ***** 제품 카테고리 테이블 생성하기 ***** --
create table tbl_category
(cnum   varchar2(5),         -- 카테고리 번호
 cname  varchar2(100) not null,  -- 카테고리 이름
 CONSTRAINT pk_tbl_category_cnum primary key(cnum)
);

insert into tbl_category(cnum, cname)
values(1000, '사무용의자');

insert into tbl_category(cnum, cname)
values(2000, '식탁의자');

insert into tbl_category(cnum, cname)
values(3000, '어린이의자');

insert into tbl_category(cnum, cname)
values(4000, '카페의자');

insert into tbl_category(cnum, cname)
values(5000, '스툴의자');

commit;

select *
from tbl_category;

-- ***** 제품 테이블 생성하기 ***** --
create table tbl_product
(pnum       varchar2(10),           -- 상품고유번호
 fk_cnum    varchar2(5) not null,            -- 카테고리 번호
 pname      varchar2(100) not null,          -- 상품명
 price      number(8) not null,              -- 제품가격
 color      varchar2(50) not null,           -- 제품색상
 pinpupdate date default sysdate not null,   -- 제품입고일자
 pqty       number(8) not null,              -- 제품재고량
 psummary   varchar2(1000) not null,         -- 제품요약
 pcontent   varchar2(4000) not null,         -- 제품설명
 constraint pk_tbl_product_pnum primary key(pnum),
 constraint fk_tbl_product foreign key(fk_cnum) references tbl_category(cnum)
 );

update tbl_product set color='블랙'
where pnum='10009002';

insert into tbl_product(pnum, fk_cnum, pname, price, color, pqty, psummary, pcontent)
values(1000||seq_pnum.nextval, 1000, 'NILSERIK 닐세리크', 69900, '베이지/비슬레 다크그레이', 20, '편하게 자세를 바꿀 수 있고 앉는 자세가 좋아집니다.', '편하게 자세를 바꿀 수 있고 앉는 자세가 좋아집니다. 좌식/입식 겸용 책상과 함께 사용하면 좋습니다.');

insert into tbl_product(pnum, fk_cnum, pname, price, color, pqty, psummary, pcontent)
values(1000||seq_pnum.nextval, 1000, 'NILSERIK 닐세리크', 69900, '블랙/비슬레 다크그레이', 15, '편하게 자세를 바꿀 수 있고 앉는 자세가 좋아집니다.', '편하게 자세를 바꿀 수 있고 앉는 자세가 좋아집니다. 좌식/입식 겸용 책상과 함께 사용하면 좋습니다.');


select * from tbl_product
order by pnum;

commit;


-- 제품번호 시퀀스 -- 
create sequence seq_pnum        -- 상품제품번호 일부뒷자리 4자리
start with 9001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ***** 제품 이미지 테이블 생성하기 ***** --
create table tbl_imagefile
(imgfileno      number,         -- 상품이미지파일 번호
 fk_pnum        varchar2(10) not null,     -- 상품고유번호
 imgfilename    varchar2(100) not null,  -- 상품이미지 파일명
 constraint pk_tbl_imagefile_fileno primary key(imgfileno),
 constraint fk_tbl_imagefile foreign key(fk_pnum) references tbl_product(pnum)
);

-- 이미지번호 시퀀스 -- 
create sequence seq_img
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_imagefile(imgfileno, fk_pnum, imgfilename)
values(seq_img.nextval, 10009001, '닐세리크1.webp');

insert into tbl_imagefile(imgfileno, fk_pnum, imgfilename)
values(seq_img.nextval, 10009001, '닐세리크2.webp');


select * from tbl_product
order by pnum;

select *
from tbl_imagefile
order by imgfileno;

commit;

-- ***** 장바구니 테이블 생성하기 ***** --
create table tbl_cart
(cartno     number,         -- 장바구니 고유번호
 fk_userid  varchar2(40) not null,   -- 로그인유저 아이디
 fk_pnum    varchar2(10) not null,      -- 상품고유번호
 oqty       number(4) default 1 not null,      -- 상품수량
 constraint pk_tbl_cart_cartno primary key(cartno),
 constraint fk_tbl_cart_fk_userid foreign key(fk_userid) references tbl_member(userid),
 constraint fk_tbl_cart_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
 );
 
create sequence seq_cartno  -- 장바구니 고유번호
start with 101
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ***** 위시리스트 테이블 생성하기 ***** --
create table tbl_wishlist
(wishno     number,         -- 위시리스트 고유번호
 fk_userid  varchar2(40) not null,   -- 로그인 유저 아이디
 fk_pnum    varchar2(10) not null,   -- 상품고유번호
 constraint pk_tbl_wishlist_wishno primary key(wishno),
 constraint fk_tbl_wishlist_fk_userid foreign key(fk_userid) references tbl_member(userid),
 constraint fk_tbl_wishlist_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
 );

create sequence seq_wishno  -- 위시리스트 고유번호
start with 501
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ***** 매장찾기 테이블 생성하기 ***** --
create table tbl_shoppingmap
(storeid     number
,storename   varchar2(50) not null
,storemobile varchar2(200) not null
,postcode           varchar2(10)  not null
,address            varchar2(200) not null
,detailaddress      varchar2(200) not null        
,extraaddress       varchar2(200)
);

select * from tab;