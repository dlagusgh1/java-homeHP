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
    `organRemarks` CHAR(100) NOT NULL
);