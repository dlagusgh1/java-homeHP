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

# 좋아요
CREATE TABLE `articleLike` (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY(id),
  regDate DATETIME NOT NULL,
  articleId INT(10) UNSIGNED NOT NULL,
  memberId INT(10) UNSIGNED NOT NULL,
  `point` TINYINT(1) UNSIGNED NOT NULL
);

# article 테이블 세팅
DROP TABLE IF EXISTS `reply`;
CREATE TABLE reply (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    memberId INT(10) UNSIGNED NOT NULL,
    articleId INT(10) UNSIGNED NOT NULL,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    `body` LONGTEXT NOT NULL
);

# articleReply 테이블에 테스트 데이터 삽입
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
articleId = 1,
displayStatus = 1,
`body` = '내용1';

ALTER TABLE `reply` ADD COLUMN `relTypeCode` CHAR(50) NOT NULL AFTER `memberId`,
CHANGE `articleId` `relId` INT(10) UNSIGNED NOT NULL;
ALTER TABLE `st_n35_wori`.`reply` ADD INDEX (`relId`, `relTypeCode`);
UPDATE reply
SET relTypeCode = 'article'
WHERE relTypeCode = '';

/* 파일 테이블 생성 */
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
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
ALTER TABLE `st_n35_wori`.`file` DROP INDEX `relId`, ADD INDEX (`relId` , `relTypeCode` , `typeCode` , `type2Code` , `fileNo`); 

# firstAid 테이블 세팅
DROP TABLE IF EXISTS `firstAid`;
CREATE TABLE firstAid (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    title CHAR(200) NOT NULL,
    `body` LONGTEXT NOT NULL
);

insert  into `firstAid`(`id`,`regDate`,`updateDate`,`delDate`,`delStatus`,`displayStatus`,`title`,`body`) values 
(1,'2020-11-05 11:34:10','2020-11-05 11:34:10',NULL,0,1,'심폐 소생술','1. 의식 / 호흡 확인 및 도움 요청\r\n<br>\r\n2. 가슴 압박 30회 (분당 100 ~ 120회 / 약 5cm 이상의 깊이)\r\n<br>\r\n3. 기도 개방 및 인공 호흡 2회\r\n<br>\r\n4. 가슴 압박과 인공호흡 반복\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099713&cid=51010&categoryId=51010\" target=\"_blank\">[네이버 지식백과] 성인 심폐소생술 (응급처치 가이드, 서울대학교병원)</a>'),
(2,'2020-11-05 11:34:10','2020-11-05 11:34:10',NULL,0,1,'기도 이물 폐쇄','1. 상태체크 및 119 신고\r\n<br>\r\n2. 기침 유발\r\n<br>\r\n3. 복부 밀어내기\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099716&cid=51010&categoryId=51010\" target=\"_blank\">[네이버 지식백과] 성인 기도 이물 폐쇄 (응급처치 가이드, 서울대학교병원)</a>'),
(3,'2020-11-05 11:34:10','2020-11-05 11:34:10',NULL,0,1,'자동 심장 충격기','1. 전원 켜기\r\n<br>\r\n2. 패드 부착\r\n<br>\r\n3. 심장리듬 분석\r\n<br>\r\n4. 전기 충격\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099712&cid=51010&categoryId=51010\" target=\"_blank\">[네이버 지식백과] 자동 심장충격기 (응급처치 가이드, 서울대학교병원)</a>\r\n\r\n\r\n'),
(4,'2020-11-05 11:34:10','2020-11-05 11:34:10',NULL,0,1,'증상별 적정 자세','1. 의식이 없을 때\r\n- 기도를 쉽게 확보해주면서 분비물이 폐로 유입되는것을 방지하지 위한 자세.\r\n- 무릎을 직각으로 세워 옆으로 눕힌다.\r\n- 이때 손을 뺨 아래에 괴어 턱을 들어올려 기도를 연다.\r\n<br>\r\n2. 호흡이 곤란 할 때\r\n- 호흡을 편하게 해주는 기본 자세. \r\n- 상체를 일으켜 뒤에 기댄다.\r\n<br>\r\n3. 복통이나 배에 상처가 있을 때\r\n- 베개 없이 수평으로 눕힌다.\r\n- 복통이 심할 경우 양 무릎 밑에 모포, 베개 등을 넣어 무플을 세워준다.\r\n<br>\r\n4. 쇼크 발생, 다리에 출혈이 있을 때\r\n- 심장, 뇌에 피가 많이 가도록 머리를 약간 낮추고 쇼파 등에 발쪽을 올리는 자세로 눕힌다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099718&cid=51010&categoryId=51010\" target=\"_blank\">[네이버 지식백과] 증상별 적정 자세 (응급처치 가이드, 서울대학교병원)</a>'),
(5,'2020-11-05 11:34:10','2020-11-05 11:34:10',NULL,0,1,'동물 및 곤충에 물렸을 때','# 동물에 물렸을 때\r\n- 동물에 물린 상처는 비눗물을 이용하여 흐르는 물에 깨끗이 씻도록 한다.\r\n- 얼굴이나 두피에 발생한 6시간 이내의 깨끗한 상처는 상처 발생 시 바로 봉합하는 경우도 있으나 그 외 부위에 발생한 상처는 깨끗이 씻어내고 주변 죽은 조직을 제거하고 24~48시간 후 다시 평가하여 봉합하게 된다.\r\n- 광견병 위험 동물에 물렸을 경우에는 백신 접종이 필요하다. 대부분의 일반 병원에는 준비되어 있지 않으나 정해진 절차를 거친 후 희귀의약품센터를 통해 구할 수 있으므로 바로 병원에 방문할 것을 권하고 있다.\r\n- 광견병 바이러스를 옮길 수 있는 숙주 동물로는 개, 늑대, 너구리, 스컹크, 코요테, 박쥐 등이 있다. 다람쥐, 햄스터, 기니피그, 들쥐, 집쥐, 생쥐 등은 광견병 발생이 매우 드물어 사후 백신 접종이 필요하지 않다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099722&cid=51010&categoryId=51010\" target=\"_blank\">[네이버 지식백과] 동물에 물렸을 때 (응급처치 가이드, 서울대학교병원)</a>\r\n<br>\r\n# 뱀에 물렸을 때\r\n- 모든 뱀에 물린 상처는 응급으로 생각하고, 우선 환자를 뱀과 격리해야 한다.\r\n- 뱀 독이 빨리 퍼지는 것을 막기 위해 환자를 안정시키고 물린 곳을 고정하고 아무것도 먹게 해서는 안 된다. 특히 음주는 독을 빨리 퍼지게 한다고 한다. 일부 TV 등에서 나오는 것처럼 물린 부위를 입으로 빨아내거나 칼을 사용하여 절개를 하고 빨아내는 등의 행위는 하지 말아야 한다. 빨아내는 사람뿐만 아니라 절개를 하면서 이차 손상이 있을 수도 있기 때문이다.\r\n- 얼음 찜질은 독을 늦추는 데 도움이 되지 않지만 통증을 줄여주는 데는 도움이 된다고 하며, 온 찜질은 절대 해서는 안 된다. 마지막으로 모든 뱀에 물린 환자는 반드시 응급실을 방문해야 한다.\r\n- 독사에 물렸을 경우에는 우선 주변에 있는 옷가지나 기타 묶을 수 있는 도구를 사용하여 물린 부위 위쪽 상부를 가볍게 묶어 준다. 이때 주의 할 점은 물린 환자가 편할 정도로 해야 하며, 손가락 한 개가 아래로 지나갈 수 있을 정도로 묶어주며, 보통 물린 후 30분 이내에만 사용해야 한다. 물론 자신감이 없으면 시행하지 않는 것이 좋다. 심한 압력으로 압박을 했을 경우에는 오히려 물린 사람에게 해가 될 수 있다.\r\n- 주변에 압박붕대가 있다면 상지에서 40~70mmHg의 압력으로 물린 부위 전체에 압박붕대를 하는 것과 하지에서 55~70mmHg의 압력으로 압박붕대를 하는 것이 뱀 독이 전신으로 확산되는 것을 막는 데 도움이 된다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099723&cid=51010&categoryId=51010&expCategoryId=51010\" target=\"_blank\">[네이버 지식백과] 뱀에 물렸을 때 (응급처치 가이드, 서울대학교병원)</a>\r\n<br>\r\n# 벌에 쏘였을 때\r\n- 추가적인 벌에 쏘임을 막기 위해서 안전한 장소로 이동한다. \r\n- 벌침을 제거하기 위해 신용카드의 모서리로 살살 긁어 낸다. (단 무리하게 시도해서는 안 된다.) \r\n- 벌침 끝 부분에 남아 있는 벌독이 몸 안으로 더 들어 갈 수 있기 때문에 손으로는 잡아 뽑지 않는 게 좋다. \r\n- 벌침을 제거한 후에는 2차적인 감염을 예방하기 위해 비눗물로 상처부위를 깨끗이 세척한다. 이후 얼음찜질을 시행하여 부종을 감소시키고 부종이 심할 때는 물린 부위를 높게 한 후 안정시킨다.\r\n- 알러지 반응으로 호흡곤란이나 혈압강하 소견이 관찰되면 즉시 119에 신고하거나 응급실을 방문해야 한다.\r\n- 쏘인 부위가 붓거나, 통증 등의 국소반응만 있다 하더라도 대부분의 경우 약물 치료가 필요하기 때문에 병원을 방문해야 한다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099724&cid=51010&categoryId=51010&expCategoryId=51010\" target=\"_blank\">[네이버 지식백과] 벌에 쏘였을 때 (응급처치 가이드, 서울대학교병원)</a>'),
(6,'2020-11-05 11:34:10','2020-11-05 11:34:10',NULL,0,1,'이물질이 들어갔을 때','# 눈에 일반적인 이물질이 들어갔을 때\r\n- 바람에 의한 티끌 등 알갱이로 된 이물이 눈에 들어갔을 경우 흐르는 물로 이물질이 들어간 눈을 아래로 해서 물을 코 쪽 방향부터 흘러내리게 하고 눈을 깜빡여 씻어 낸다.\r\n- 눈을 손으로 비비면 각막에 물리적 손상을 가할 수 있으므로 절대 손으로 눈을 비비지 않는다. \r\n- 눈을 충분히 씻어 내고도 이물감이 지속되거나 통증이 있고 시력 저하가 동반되면 남아있는 이물과 각막 손상을 의심해 안과적 검진을 받고 적절한 처치를 받는다. \r\n- 드물지만 실험실 등에서 물에 반응하는 화학 물질이 눈에 들어간 경우 의료진에 의해 확인할 수 있는 이물을 모두 제거한 후 세척이 이루어져야 한다. \r\n- 이런 반응성 물질이 남아있는 경우 물로 세척 시 폭발적인 반응과 반응열로 손상이 가중될 수 있다.\r\n<br>\r\n# 눈에 독성이 있는 액체가 들어갔을 때\r\n- 독성이 있는 액체가 눈에 들어가면 위와 같이 흐르는 물로 15분 이상 충분히 씻어 낸다. \r\n- 위와 같이 이물감, 통증이 지속되거나 시력 저하가 동반되면 병원 진료를 받는다. \r\n- 산, 알칼리 등 심각한 손상을 유발할 수 있는 물질의 경우 한 시간 이상 세척이 필요한 경우도 흔하며 눈의 산도를 측정하며 충분히 중화될 때까지 세척을 지속해야 한다. \r\n- 이 경우에는 무증상인 경우에도 병원 진료가 필수적이다. \r\n- 산, 알칼리 등의 손상에서는 각막의 손상과 재생에 동반되는 흉으로 각막 혼탁이 생기고 이로 인해 시력을 잃을 수 있다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099727&cid=51010&categoryId=51010\" target=\"_blank\">[네이버 지식백과]눈 이물질 응급처치 (응급처치 가이드, 서울대학교병원)</a>'),
(7,'2020-11-05 11:34:10','2020-11-05 11:34:10',NULL,0,1,'중독 되었을 때','- 중독 환자의 1차 치료는 몸에서 독성 물질을 제거하는 것이다.\r\n- 독을 먹었을 경우에는 가정에서 할 수 있는 처지는 거의 없다. \r\n- 특히 억지로 구토를 하거나, 구토를 유발하는 약을 먹는 것은 효과가 없으며, 오히려 토사물 흡인 등의 합병증만 유발할 수 있으므로 삼가도록 한다. \r\n- 우유나 물을 먹어서 희석 시키는 행위도 뚜렷한 효과가 밝혀지지 않아 제한적인 경우에서만 시행되므로 가정에서 의료진의 도움 없이 시행하는 것은 피하도록 한다.\r\n- 피부를 통하여 흡수되는 중독물질의 경우 몸이나 옷에 묻어있는 경우 물로 씻어 주는 것이 도움이 된다. \r\n- 단, 이러한 과정에서 옆에서 도와주는 보호자의 몸에 묻어서 중독되지 않도록 주의하여야 한다. \r\n- 특히 독성 가스에 노출된 경우에는 무리하지 말고 즉시 119에 연락하여 전문가에 의하여 구조가 이루어지도록 한다.\r\n- 독성 물질에 노출되고 나서 최대한 빨리 응급실로 방문하는 것이 중요하다. \r\n- 중독 증상을 유발하는 물질이 무엇인지 아는 것이 추후 치료 계획을 세우는 데 핵심적이다. \r\n- 가능하다면 중독을 유발한 물질의 이름이나 성분을 알아오도록 하며, 여의치 않으면 그 용기를 응급실로 가져오도록 한다. \r\n- 용기는 운반 도중에 추가적인 중독 현상이 일어나는 것을 막기 위하여 잘 밀봉하여 운반하도록 한다.\r\n- 일반적으로 음독 치료라고 하면 위세척을 떠올리는 경우가 많다. \r\n- 하지만 모든 상황에서 효과적인 것은 아니며, 경우에 따라서는 위벽 손상, 기도 흡인 등의 부작용을 유발하기도 한다. 이에 대하여는 의사의 판단에 따르도록 한다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099733&cid=51010&categoryId=51010\" target=\"_blank\">[네이버 지식백과] 중독 응급처치 (응급처치 가이드, 서울대학교병원)</a>'),
(8,'2020-11-05 11:34:10','2020-11-05 11:34:10',NULL,0,1,'뼈 및 근육이 손상되었을 때','- 우선 다친 사람을 편안한 자세로 눕게 하고 피가 나는 경우 출혈 부위를 지혈이 되게 눌러주는 것이 원칙이다. \r\n- 이 때 지혈을 목적으로 지혈제 등을 절단 부위에 뿌리는 것은 좋지 않다. \r\n- 추후 재접합 수술 등을 고려할 때 방해가 될 수 있기 때문이다. \r\n- 출혈 부위를 누르고 심장보다 높이 들어주는 것으로도 효과적인 지혈이 될 수 있다.\r\n- 절단된 손가락을 찾아 깨끗한 거즈나 손수건 등으로 싼 뒤 비닐 주머니에 넣어 밀봉하고 이를 다시 얼음이 채워진 비닐 봉지에 넣어 보관하도록 한다. \r\n- 이 때 절단된 수지를 직접 얼음에 담그는 것은 피해야 하는데 조직의 손상을 증가시켜 접합 수술을 할 수 없게 만들 수 있기 때문이다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099733&cid=51010&categoryId=51010\" target=\"_blank\">[네이버 지식백과] 손가락 절단 응급처치 (응급처치 가이드, 서울대학교병원)</a>'),
(9,'2020-11-05 11:34:10','2020-11-05 11:34:10',NULL,0,1,'열 및 냉에 의한 손상이 되었을 때','# 열사병\r\n- 체온이 상승되어있고 의식변화 등의 중추신경계 장애를 보이고 더위나 고온 환경에 노출된 병력이 있다면 열사병으로 가정하고 즉시 치료를 시작해야 한다.\r\n- 열사병의 치료는 즉시 체온을 낮추는 것이 중요하며 방법은 증발기법이 가장 효율적이다. \r\n- 열사병의 증상을 보이는 환자의 의복을 제거하고 고온의 환경에서 대피시키도록 한다. \r\n- 젖은 수건 등으로 환자의 몸을 감싸주고 스프레이 등을 이용해 천에 물을 뿌려 젖은 상태를 유지시켜주고 얼굴이나 신체에 부채질이나 선풍기 바람을 이용하여 증발에 의한 체온 강하를 극대화시키도록 한다.\r\n\r\n[네이버 지식백과] 열사병 응급처치 (응급처치 가이드, 서울대학교병원)\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099743&cid=51010&categoryId=51010\" target=\"_blank\">바로가기</a>\r\n\r\n# 저체온증\r\n- 저체온증의 경우 특별한 약은 없고 환자의 중심 체온을 올리는 것이 목표이며 환자를 부드럽게 다루어야 한다.\r\n- 우선 환자를 추위에 노출된 장소로부터 대피시키고 환자의 의복을 제거 후 따뜻한 옷으로 교체한다. \r\n- 바람이 부는 경우 바람을 차단하거나 불지 않는 곳으로 이동시킨다. \r\n- 환자가 의식이 있는 경증의 저체온증의 경우 따뜻한 물과 고열량의 음식물을 섭취하게 하고 마른 담요나 이불로 몸(몸 전체 혹은 목, 가슴, 사타구니 부위)을 감싸서 체온을 올리는 방법으로 호전을 기대할 수 있다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099746&cid=51010&categoryId=51010&expCategoryId=51010\" target=\"_blank\">[네이버 지식백과] 저체온증 응급처치 (응급처치 가이드, 서울대학교병원)</a>'),
(10,'2020-11-05 11:34:10','2020-11-05 11:34:10',NULL,0,1,'사고에 의한 응급 상황일 때','# 감전\r\n- 감전 환자가 발생 시 구조자는 현장이 안전한가를 반드시 먼저 확인해야 한다. \r\n- 안전하다고 판단되면 감전자를 현장에서 대피시키도록 한다. \r\n- 감전사고로 쓰러진 상태로 발견하였을 경우 이송 시 경추 및 척추 손상을 예방하기 위해 고정을 시키고 이송하도록 한다. \r\n- 환자의 호흡, 움직임 등을 관찰하고 심정지 상태라고 판단되면 즉시 심폐소생술을 시행하도록 한다. \r\n- 감전 사고로 화상이 발상하였을 경우 깨끗한 물로 세척 후 멸균 드레싱을 하도록 한다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099749&cid=51010&categoryId=51010\" target=\"_blank\">[네이버 지식백과] 감전 응급처치 (응급처치 가이드, 서울대학교병원)</a>\r\n<br>\r\n# 낙뢰\r\n- 모든 낙뢰 손상 환자는 입원을 필요로 한다. \r\n- 즉시 119 신고를 하고 감전자의 호흡상태, 의식상태, 반응상태 등을 확인하고 상태에 따라 기도확보 및 소생술을 시행하도록 한다.\r\n- 낙뢰 손상을 입을 경우 전류는 주로 눈, 코, 귀, 입을 통하여 신체 내부로 전파되며 심장이나 중추신경계, 호흡중추 등에 강한 자극을 주어 심장마비와 호흡마비가 일어난다. \r\n- 이때 심장은 정지되었다가 자율성이 스스로 회복되어 다시 박동을 하게 되나, 호흡 마비는 지속되어 이차적으로 저산소증이 발생하게 된다. \r\n- 이로 인해 다시 심장이 정지하는 과정이 발생하게 된다. \r\n- 따라서 낙뢰 환자에게 있어서 가장 우선되는 처치는 기도확보 및 인공호흡이다. \r\n- 일반적으로 대규모 자연재해나 건물 붕괴 등의 대량 재해가 발생하였을 경우 현장에서 사망한 사람의 구조보다는 사망하지 않은 손상 환자의 치료가 우선적으로 시행되는 데 비해 낙뢰 손상 시 동시에 여러 명의 감전자가 발생하였을 경우에는 심정지 환자를 우선적으로 치료해야 한다. \r\n- 이러한 사람들은 적극적인 심폐소생술로 생존할 가능성이 높기 때문이다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099750&cid=51010&categoryId=51010&expCategoryId=51010\" target=\"_blank\">[네이버 지식백과] 낙뢰 응급처치 (응급처치 가이드, 서울대학교병원)</a>\r\n<br>\r\n# 익수\r\n- 물에 빠진 사람을 발견하거나 물에 빠지는 것을 목격하였다면 우선 119에 도움을 요청하도록 한다. \r\n- 경추 손상이 동반된 경우가 많으므로 구조 및 이송 시에 최대한 목을 움직이지 않도록 주의한다. \r\n- 경추 보호대가 있다면 사용하도록 한다. \r\n- 구조 후 호흡정지 상태라면 구조 호흡을 시행한다. \r\n- 환자의 코를 막은 다음에 가슴이 올라가는 것이 보일 정도로 숨을 불어넣어 주는 행위를 두 번 반복한다. \r\n- 만약 반응이 없다면 심폐소생술을 시작한다.\r\n- 의식이 있다면 몸의 수분을 닦아주고 젖은 옷은 벗긴 후에 마른 옷으로 바꿔 입게 해주거나 깨끗한 수건 등으로 몸을 감싸주어 체온이 떨어지는 것을 막아주도록 한다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099751&cid=51010&categoryId=51010&expCategoryId=51010\" target=\"_blank\">[네이버 지식백과] 익수 응급처치 (응급처치 가이드, 서울대학교병원)</a>'),
(11,'2020-11-05 11:34:10','2020-11-05 11:34:10',NULL,0,1,'응급 증상일 때','# 저혈당\r\n- 의식이 있는 환자에게 저혈당 증상이 있다면 식사 혹은 당정제, 사탕, 주스, 비다이어트 음료 등의 단 음식을 섭취하며 회복될 수 있다. \r\n- 만약 저혈당 환자가 의식이 없고 입으로 음식을 먹을 수 없는 상황일 때는 즉시 응급의료 지원센터에 전화를 해야 하며 병원에서 즉각적인 당 정맥 주사를 맞음으로써 치료가 가능하다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099753&cid=51010&categoryId=51010\" target=\"_blank\">[네이버 지식백과] 저혈당 응급처치 (응급처치 가이드, 서울대학교병원)</a>\r\n<br>\r\n# 두통\r\n- 두통은 누구나 한번쯤은 앓아 본 적이 있을 정도로 흔한 증상으로 보통 병원을 방문하지 않고 진통제를 복용하는 경우가 많다. 흔히 우리가 앓게 되는 두통은 그 원인에 따라 3가지 정도로 나눌 수 있다. 첫째로 목과 얼굴주위 근육의 긴장으로 인한 긴장성 두통, 뇌 혈관의 이상으로 인한 편두통, 경추의 이상이나 부비동염 등 머리 주변부위의 염증으로 인한 두통이 대표적인 예이다.\r\n- 이 중 긴장성 두통은 10명 중 4명의 인구가 일생에 한번은 경험하는 가장 흔한 형태로, 질병이 아니라 종종 정상 두통이라고 간주된다. 긴장성 두통의 증상은 양쪽 머리 모두가 누르는 듯 또는 쥐어짜는 듯 아프고 목 뒤나 어깨 쪽으로 통증이 퍼지는 경우도 있으며 이런 증상이 4~6 시간 지속되거나 더 오래 지속되기도 한다. 증상은 아침보다 오후에 주로 나타나게 되며 대부분 일과성으로 지나가지만 소수는 만성두통으로 진행하게 된다. 원인으로는 정서적인 스트레스, 잘못된 자세로 장시간 근무했을 때, 잠을 충분히 자지 못했을 때 등이 있다.\r\n- 두 번째로 흔한 편두통은 흔히 한쪽 머리가 아픈 두통으로 생각하기 쉬우나 의학적 의미로는 특징적인 증상을 동반할 경우를 말한다. 이는 두통이 생기기 전 시야에 까맣게 안 보이는 암점이 생기거나, 사물이 지그재그모양으로 깨져 보이는 등의 전조 증상을 들 수 있으며 이 전조증상이 사라지면서 두통이 생긴다. 주로 한쪽 머리가 맥박 뛰듯이 욱씬욱씬 거리는 양상이 일반적이나 양쪽 머리가 아픈 경우도 꽤 있으며 심하게 아픈 경우가 많기 때문에 주로 머리를 싸매고 드러눕게 되며 속이 안 좋거나 토하는 경우도 발생한다. 소리에 민감해지거나 빛에 민감해져서 밖에 나가면 눈이 부신 경우도 있다.\r\n- 긴장형 두통이나 편두통은 유발 인자를 피하거나 약물 치료 등으로 증상을 조절할 수 있다. 약물 없이도, 혹은 이따금 약물을 써서 두통을 조절할 수 있다면 전문의를 찾을 필요는 없다. 그러나 이와 달리 가볍게 넘길 수 없는 두통이 있는데 뇌출혈이나 뇌 종양, 뇌수막염 등의 감염 질환 등 뇌의 이상으로 인해 두통이 발생할 때이다.\r\n- 진통제를 매일 쓸 정도로 지속되며 심한 두통, 시간이 지날수록 강도와 빈도가 증가하는 두통, 두부 손상 후 일어난 두통, 고열이나 구토를 동반한 두통, 시력 소실, 말하는 게 어렵거나 팔다리의 마비나 위약을 동반한 두통, 의식 소실을 동반하거나 갑자기 시작되는 심한 두통은 반드시 빠른 시간 내에 의사의 진료가 필요하다.\r\n- 긴장형 두통은 초기에는 거의 일시적이며 증상이 심하지 않으나 진통제 등을 남용하는 경우 만성으로 이행하게 될 수 있으므로 적절한 진단과 치료가 필요하다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099754&cid=51010&categoryId=51010&expCategoryId=51010\" target=\"_blank\">[네이버 지식백과] 두통 응급처치 (응급처치 가이드, 서울대학교병원)</a>\r\n<br>\r\n# 두드러기\r\n- 대부분의 단순한 두드러기는 금방 없어지며, 피부도 수 시간 안에 정상으로 돌아오므로 특별한 치료가 필요 없는 경우가 많다. 만약 두드러기가 수일간 지속되거나, 가려움으로 인해 잠을 잘 수 없거나 정상적인 활동을 하지 못한다면 의사의 진료가 필요할 수 있다. 또한 새로운 약을 복용하기 시작하거나 벌레에 쏘인 뒤에 두드러기가 나타난다면 의사를 찾아가야 한다.\r\n- 특히 두드러기가 전신 반응의 조기 징후일 경우 혀나 입술이나 얼굴의 부기, 어지러움, 가슴 답답함, 호흡곤란, 쌕쌕거림 등과 같은 또 다른 증상이 있는지 확인해야 한다. 만약 이런 증상들이 발생한다면 생명을 위협할 수 있는 상태인 아나필락시스가 생길 수 있으므로 즉시 응급처치를 받아야 한다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099755&cid=51010&categoryId=51010&expCategoryId=51010\" target=\"_blank\">[네이버 지식백과] 두드러기 응급처치 (응급처치 가이드, 서울대학교병원)</a>\r\n<br>\r\n# 팔, 다리 마비\r\n- 환자가 의식이 있는 상태에서 갑자기 팔다리 마비가 발생했을 경우에는 3시간 이내에 근처 병원에 방문하여 약물치료의 대상이 되는지 또는 뇌출혈, 뇌동맥류 파열 등으로 인한 증상 여부를 확인하는 영상검사(CT, MRI 등) 등을 시행해야 한다. 증상 발생 시간을 알 수 없는 경우에도 발견 즉시 병원을 방문하여 정확한 검사가 필요하다. 뇌졸중은 치료도 중요하나 2차 예방도 중요하므로 증상이 오래 경과되었다고 해서 방치하지 말고 병원을 방문하여 원인 및 약물 치료를 시작하도록 하는 것이 필요하다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099757&cid=51010&categoryId=51010&expCategoryId=51010\" target=\"_blank\">[네이버 지식백과] 팔다리 마비 응급처치 (응급처치 가이드, 서울대학교병원)</a>\r\n<br>\r\n# 의식 소실\r\n- 대개는 증상이 지속시간이 짧으며 자연적으로 완전히 회복되므로 특별한 소생술은 필요하지 않다. 환자가 실신을 했을 경우는 우선 뇌혈류량을 최대로 늘리기 위해 머리를 최대한 내려주는 것이 필요하다. 앉아 있는 경우에는 머리를 양 무릎 사이로 내리고 누워 있다면 다리를 올려야 한다. 꼭 조이는 옷은 느슨하게 풀어주고 머리를 측면으로 혀가 기도를 막지 않도록 주의한다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099759&cid=51010&categoryId=51010&expCategoryId=51010\" target=\"_blank\">[네이버 지식백과] 의식 소실 응급처치 (응급처치 가이드, 서울대학교병원)</a>\r\n'),
(12,'2020-11-05 11:34:10','2020-11-05 11:34:10',NULL,0,1,'소아 응급 증상일 때','# 열성 경련\r\n- 가장 중요한 것은 부모나 보호자가 당황하지 않는 것이 중요하다.\r\n- 우선 옷을 벗기고 시원하게 해주는 것이 좋으며, 아이가 경련을 하는 동안 다른 주위 물건에 부딪혀서 다칠 수가 있기 때문에 주위의 위험한 물건을 치워주는 것이 좋다. 또한 구토를 동반하는 경우도 있기 때문에 구토를 하는 경우에는 기도로 음식물이 들어가서 심각한 상황이 초래되는 것을 막기 위해서 고개를 옆으로 돌려주는 것이 좋다.\r\n- 일부 보호자는 열을 떨어뜨리기 위해 해열제를 먹이는 경우가 있는데, 의식이 없는 아이에게 억지로 해열제를 먹일 경우에는 기도 흡인의 위험성이 있기 때문에, 의식이 없는 아이에게 해열제를 먹이는 것은 오히려 해가 될 수 있음을 알아야 한다. 일부 보호자의 경우에는 경련하는 동안 아이의 손발을 꽉 잡거나 주무르는 경향이 있는데, 불필요한 자극을 주지 말고 경련의 양상을 주의 깊게 관찰하는 것이 중요하다.\r\n- 마지막으로 대부분의 열성경련 어린이들은 저절로 호전이 되기 때문에 바로 응급실에 올 필요는 없지만, 경련이 오래 지속되면(일반적으로 5분 이상), 드물지만 30분 이상 지속되는 간질 중첩증에 빠질 수 있기 때문에 119에 신고한 후 가까운 응급실을 방문하면 된다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099761&cid=51010&categoryId=51010\" target=\"_blank\">[네이버 지식백과] 열성 경련 응급처치 (응급처치 가이드, 서울대학교병원)</a>\r\n<br>\r\n# 고열\r\n- 응급처치의 기본은 해열제이다. 해열제를 사용 시에 알아두어야 할 사항은 크게 두 가지가 있는데, 첫 번째는 해열제는 감염 질환을 치료하는 약이 아니며, 병의 경과에 영향을 끼치지 않는다는 것이고, 두 번째는 아이가 평상시처럼 잘 먹고 잘 놀며, 잠도 잘 자는 경우에는 굳이 해열제를 투여하지 않아도 된다는 것이다.\r\n- 시중에서 크게 사용되는 해열제는 두 가지가 있다.\r\n1) 타이레놀 시럽 사용법\r\n- 4~6시간 간격으로 투여할 수 있다. 단 하루에 5회 이상은 투여해서는 안된다.\r\n- 용량은 10~15mg/kg(몸무게당 0.3~0.5cc , 예를 들어 10Kg이면 3-5cc, 20Kg이면 7-8cc)이다. 타이레놀을 먹은 후 효과가 나타나기까지 1시간이 걸리므로 복용 후 1시간까지는 열이 떨어지지 않을 수 있다. 부작용은 거의 없지만 장기간 사용 시 신기능 장애, 대량복용 시에는 간기능 장애가 있을 수 있다.\r\n\r\n2) 부루펜(이부프로펜) 시럽 사용법\r\n- 6~8시간 간격으로 투여할 수 있다. 즉 하루에 5회 이상은 투여해서는 안된다.\r\n- 타이레놀 보다 지속시간이 길고 진통작용이 더 좋다고 한다. 밤새 통증이 있거나 열이 있는 경우에는 유용하게 사용할 수 있다. 5-10mg/kg(몸무게당 0.3 ~0.5cc) 역시 용량은 타이레놀과 동일하게 주면 된다. 부작용은 거의 없지만 일부에서 소화불량, 구역감 등이 있을 수 있고 아주 드물게 위장출혈, 신기능장애를 일으킬 수 있다고 되어 있어 탈수가 심한 아이에게는 신중히 투여해야 한다.\r\n- 기본적으로 해열제를 투여한 후에 차선책으로 해볼 수 있는 방법은 미지근한 물로 닦아주는 것이다. 보통 대야에 30도 전후에 미지근한 물로 채운 후에(손목이나 손등으로 느꼈을 때 약간 따뜻한 정도면 적당하다.) 스펀지나 물수건으로 목, 등, 겨드랑이, 사타구니를 닦아준다. 닦아줄 때 아이가 몸을 떨면서 오한이 있을 때는 오히려 열이 더 발생할 수 있기 때문에 중단하는 것이 좋다. 중요한 것은 아이가 열이 날 때는 해열제보다 먼저 앞서서 닦아주기를 하는 것은 바람직 하지 않다.\r\n<br>\r\n[열이 날 때 병원에 빨리 가야 하는 경우]\r\n- 아이가 열이 나면서 의식이 없거나 점점 나빠지거나, 전혀 먹으려 하지 않고 쳐져 있으면서 소변양이 감소하여 심한 탈수가 예상되는 경우나, 목이 뻣뻣해지면서 경련을 하거나, 3개월 이하의 아이가 열이 날 때는 반드시 병원에 가야 한다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099762&cid=51010&categoryId=51010&expCategoryId=51010\" target=\"_blank\">[네이버 지식백과] 고열 응급처치 (응급처치 가이드, 서울대학교병원)</a>\r\n<br>\r\n# 탈수\r\n- 가장 중요한 것은 지속적인 탈수를 막는 것이다. 보통 위장관염(장염)이 동반되어 구토나 설사를 하는 아이들은 잘 먹지 않으려는 경향을 보이거나 먹으면 구토를 하려는 증상을 보이기 때문에, 탈수가 점점 더 심해지는 양상을 보이게 된다. 이를 막기 위해서는 소량씩 자주 먹이는 게 중요하다. 일부에서는 차갑게 해서 먹이는 게 효과가 있다고 되어 있다. 이런 방법을 사용해도 아이가 지속적으로 토하거나 설사가 지속된다면, 지체 없이 응급실을 방문해야 한다. 아이가 먹었는데도 구토를 하지 않고 어느 정도 안정화되었다고 판단이 되면 섭취량을 점점 늘려가면서 향후 소아과 의사를 방문하는 게 좋다.\r\n\r\n<a href=\"https://terms.naver.com/entry.nhn?docId=2099763&cid=51010&categoryId=51010&expCategoryId=51010\" target=\"_blank\">[네이버 지식백과] 탈수 응급처치 (응급처치 가이드, 서울대학교병원)</a>');
