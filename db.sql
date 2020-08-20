# DB 세팅
DROP DATABASE IF EXISTS `hp`;
CREATE DATABASE `hp`;
USE `hp`;

# member 테이블 세팅
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	authStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    loginId CHAR(20) NOT NULL UNIQUE,
    loginPw CHAR(100) NOT NULL,
    `name` CHAR(20) NOT NULL,
    `organName` CHAR(20) NOT NULL,
    `organCode` CHAR(20) NOT NULL,
    `email` CHAR(100) NOT NULL,
    `phoneNo` CHAR(20) NOT NULL
);

# member 테이블에 테스트 데이터 삽입
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = SHA2('admin', 256),
`name` = '관리자',
`organName` = '관리병원',
`organCode` = 'a12345',
`email` = '',
`phoneNo` = '';

# 카테고리 테이블 생성
DROP TABLE IF EXISTS cateItem;
CREATE TABLE cateItem (
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
INSERT INTO adCateItem SET regDate = NOW(), `name` = '도담동';
INSERT INTO adCateItem SET regDate = NOW(), `name` = '소담동';
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
    `organWeekend` CHAR(100) NOT NULL,
    `organRemarks` CHAR(100) NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL 
);

# 게시판 테이블 추가
CREATE TABLE `board` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
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
CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    title CHAR(200) NOT NULL,
    `body` LONGTEXT NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    boardId INT(10) UNSIGNED NOT NULL
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