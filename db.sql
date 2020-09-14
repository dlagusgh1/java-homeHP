# DB 세팅
DROP DATABASE IF EXISTS `st_n35_wori`;
CREATE DATABASE `st_n35_wori`;
USE `st_n35_wori`;

# member 테이블 세팅
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	authStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    loginId CHAR(20) NOT NULL UNIQUE,
    loginPw CHAR(100) NOT NULL,
    `name` CHAR(20) NOT NULL,
    `organName` CHAR(20) NOT NULL,
    `email` CHAR(100) NOT NULL,
    `phoneNo` CHAR(20) NOT NULL,
    `level` INT(1) UNSIGNED DEFAULT 0 NOT NULL
);

# 관리자 생성
INSERT
INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
authStatus = 0,
loginId = 'admin',
loginPw = SHA2('admin', 256),
`name` = '관리자',
`organName` = '관리자',
email = 'dlagusgh1@gmail.com',
phoneNo = '010-1234-5678',
`level` = 10

# 카테고리 테이블 생성
DROP TABLE IF EXISTS `cateItem`;
CREATE TABLE `cateItem` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    `name` CHAR(100) NOT NULL UNIQUE
);

# 카테고리 추가
INSERT INTO cateItem SET regDate = NOW(), `name` = '병원';
INSERT INTO cateItem SET regDate = NOW(), `name` = '약국';

# 행정구역 구분 카테고리 테이블 생성
DROP TABLE IF EXISTS adCateItem;
CREATE TABLE adCateItem (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    `name` CHAR(100) NOT NULL UNIQUE
);

# 행정구역 구분 카테고리 추가
# 세종시 행정구역(동)
INSERT INTO adCateItem SET regDate = NOW(), `name` = '한솔동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '가람동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '도담동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '어진동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '해밀동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '산울동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '소담동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '반곡동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '집현동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '합강동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '나성동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '새롬동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '보람동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '다정동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '아름동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '종촌동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '고운동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '대평동';
# 세종시 행정구역(읍,면)
INSERT INTO adCateItem SET regDate = NOW(), `name` = '조치원읍';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '연기면';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '연동면';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '부강면';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '금남면';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '장군면';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '연서면';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '전의면';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '전동면';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '소정면';

# 기관 테이블 생성
DROP TABLE IF EXISTS `organ`;
CREATE TABLE `organ` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`organNumber` INT(10) UNSIGNED NOT NULL,
	`organName` CHAR(100) NOT NULL UNIQUE,
    `organAddress` CHAR(100) NOT NULL,
    `organAdmAddress` CHAR(100) NOT NULL,
    `organTel` CHAR(20) NOT NULL,
    `organTime` CHAR(100) NOT NULL,
    `organWeekendTime` CHAR(100) NOT NULL,
    `organWeekend` CHAR(100) NOT NULL,
    `organRemarks` CHAR(100) NOT NULL,
    `organLocation1` CHAR(100),
    `organLocation2` CHAR(100),
    memberId INT(10) UNSIGNED NOT NULL 
);

# 로컬db에서 저장 후 서버쪽으로 옮기기 
LOAD DATA INFILE  "st_n35_wori/list1.csv" INTO TABLE `organ` FIELDS TERMINATED BY ','
LOAD DATA INFILE  "st_n35_wori/list2.csv" INTO TABLE `organ` FIELDS TERMINATED BY ','

# 게시판 테이블 추가
DROP TABLE IF EXISTS `board`;
CREATE TABLE `board` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    `code` CHAR(20) NOT NULL UNIQUE,
	`name` CHAR(20) NOT NULL UNIQUE
);

INSERT INTO `board`
SET regDate = NOW(),
updateDAte = NOW(),
`code` = 'free',
`name` = '자유';

INSERT INTO `board`
SET regDate = NOW(),
updateDAte = NOW(),
`code` = 'notice',
`name` = '공지';

# article 테이블 세팅
DROP TABLE IF EXISTS `article`;
CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    title CHAR(200) NOT NULL,
    `body` LONGTEXT NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    boardId INT(10) UNSIGNED NOT NULL,
    hit INT(10) UNSIGNED NOT NULL DEFAULT 0
);

# article 테이블에 테스트 데이터 삽입
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1',
memberId = '1',
boardId = '1';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2',
displayStatus = 1,
memberId = '1',
boardId = '1';

# 부가정보테이블 
# 댓글 테이블 추가
DROP TABLE IF EXISTS `attr`;
CREATE TABLE attr (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `relTypeCode` CHAR(20) NOT NULL,
    `relId` INT(10) UNSIGNED NOT NULL,
    `typeCode` CHAR(30) NOT NULL,
    `type2Code` CHAR(30) NOT NULL,
    `value` TEXT NOT NULL
);

# attr 유니크 인덱스 걸기
## 중복변수 생성금지
## 변수찾는 속도 최적화
ALTER TABLE `attr` ADD UNIQUE INDEX (`relTypeCode`, `relId`, `typeCode`, `type2Code`); 

## 특정 조건을 만족하는 회원 또는 게시물(기타 데이터)를 빠르게 찾기 위해서
ALTER TABLE `attr` ADD INDEX (`relTypeCode`, `typeCode`, `type2Code`);

# attr에 만료날짜 추가
ALTER TABLE `attr` ADD COLUMN `expireDate` DATETIME NULL AFTER `value`;


/* 파일 테이블 생성 */
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	relTypeCode CHAR(50) NOT NULL,
	relId INT(10) UNSIGNED NOT NULL,
    originFileName VARCHAR(100) NOT NULL,
    fileExt CHAR(10) NOT NULL,
    typeCode CHAR(20) NOT NULL,
    type2Code CHAR(20) NOT NULL,
    fileSize INT(10) UNSIGNED NOT NULL,
    fileExtTypeCode CHAR(10) NOT NULL,
    fileExtType2Code CHAR(10) NOT NULL,
    fileNo TINYINT(2) UNSIGNED NOT NULL,
    `body` LONGBLOB
);

# 파일 테이블에 유니크 인덱스 추가
ALTER TABLE `file` ADD UNIQUE INDEX (`relId`, `relTypeCode`, `typeCode`, `type2Code`, `fileNo`); 

# 파일 테이블의 기존 인덱스에 유니크가 걸려 있어서 relId가 0 인 동안 충돌이 발생할 수 있다. 그래서 일반 인덱스로 바꾼다.
ALTER TABLE `file` DROP INDEX `relId`, ADD INDEX (`relId` , `relTypeCode` , `typeCode` , `type2Code` , `fileNo`); 

DROP TABLE IF EXISTS `covidData`;
CREATE TABLE `covidData` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	country CHAR(20) NOT NULL UNIQUE,
	diffFromPrevDay INT(10) UNSIGNED,
	domesticInflow INT(10) UNSIGNED,
	overseasInflow INT(10) UNSIGNED,
	total CHAR(20) NOT NULL,
	quarantine CHAR(20),
	quarantineRelease CHAR(20),
	death INT(10),
	incidence CHAR(20)
);