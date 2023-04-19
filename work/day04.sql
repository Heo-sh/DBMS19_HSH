/* JOIN
 * - 서로 다른 테이블을 오가면서 데이터를 가지고 오는 형태
 * - 전제조건: PK와 FK로 연결이 되어 있는 상태여야 한다.
 * 
 * JOIN의 종류
 * - INNER JOIN
 *   - 교집합의 연산
 * - OUTER JOIN
 *   - 교집합의 연산과 차집합의 연산을 합친것
 * 		- LEFT OUTER JOIN: 왼쪽 테이블에만 존재하는 데이터만 결과로 출력
 * 		- RIGHT OUTER JOIN: 오른쪽 테이블에만 존재하는 데이터만 결과로 출력
 *   - 합집합의 연산
 * 		- FULL OUTER JOIN
 */

-- INNER JOIN
SELECT D.DEPARTMENT_NAME, L.CITY
FROM DEPARTMENTS D JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;

SELECT DEPARTMENT_NAME, CITY
FROM DEPARTMENTS D, LOCATIONS L
WHERE D.LOCATION_ID = L.LOCATION_ID;

-- 사원, 부서 테이블로부터 이름, 부서 번호, 부서 이름을 조회하라
SELECT E.FIRST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 지역과 나라 테이블을 조회하여 도시 명과 국가 명 조회
SELECT L.CITY, C.COUNTRY_NAME
FROM LOCATIONS L JOIN COUNTRIES C
ON L.COUNTRY_ID = C.COUNTRY_ID;

-- 사원, 부서, 지역 테이블로부터 이름, 이메일, 부서번호, 부서이름, 지역번호, 도시명을
-- 출력하되, CITY가 'Seattle'인 경우만 출력
SELECT E.FIRST_NAME, E.EMAIL, D.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.LOCATION_ID, L.CITY
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
AND L.CITY = 'Seattle';

-- OUTER JOIN
SELECT *
FROM DEPARTMENTS D 
LEFT OUTER JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;

SELECT *
FROM LOCATIONS L
RIGHT OUTER JOIN DEPARTMENTS D
ON D.LOCATION_ID = L.LOCATION_ID;

SELECT *
FROM LOCATIONS L
FULL OUTER JOIN DEPARTMENTS D
ON D.LOCATION_ID = L.LOCATION_ID;

/* VIEW
 * - 기존의 테이블은 그대로 놔둔 채
 *   필요한 컬럼들 및 새로운 컬럼을 만든 가상의 테이블
 * - 실제 데이터가 저장되는 것은 아니지만
 *   VIEW를 통해서 데이터를 관리할 수 있다.
 * 
 * VIEW의 특징
 * - 독립성: 다른 곳에서 변경 불가
 * - 편리성: 긴 QUERY문을 짧게 가능
 * - 보안성: 짧게 만들기 때문에 기존의 QUERY는 보이지 않는다.
 * 
 * VIEW 만드는 법
 * CREATE VIEW 뷰 이름 AS
 * (
 * 		쿼리문
 * );  
 * */
CREATE VIEW MY_EMPL AS (
	SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, (SALARY * COMMISSION_PCT) COMM
	FROM EMPLOYEES
);

SELECT * FROM MY_EMPL
WHERE COMM IS NOT NULL;

DROP VIEW MY_EMPL;

CREATE VIEW DATA_PLUS AS (
	SELECT E.SALARY, RANK() OVER(ORDER BY SALARY DESC) "RANK"
	FROM EMPLOYEES E
);
-- RANK() OVER(): 순위를 매겨주는 함수
SELECT * FROM DATA_PLUS;

-----------------------------------------------------------
/* DB의 자료형
 * 1. 숫자: NUMBER(자리수)
 * 		   NUMBER: 22byte까지 입력 가능(38자리)
 * 2. 문자: VARCHAR2(길이) -> 가변형
 * 3. 날짜: DATE -> format(형식)에 맞춰 날짜를 저장하는 타입
 * */

/* 테이블 만드는 법
 * CREATE TABLE 테이블명 (
 * 		컬럼명 자료형1(길이),
 * 		컬럼명 자료형2(길이),
 * 		컬럼명 자료형3(길이),
 * 		컬럼명 자료형4(길이)
 * );
 * */

CREATE TABLE TT(
	ID VARCHAR2(30) PRIMARY KEY, --기본 키
	PWD VARCHAR2(30) NOT NULL, --NULL 데이터 추가 X
	NAME VARCHAR2(50) NOT NULL,
	EMAIL VARCHAR2(50) NOT NULL UNIQUE,
	PHONE VARCHAR2(20) UNIQUE,
	REG_DATE DATE
);

SELECT * FROM TT;

-- 테이블 만든 후 컬럼 추가하기
ALTER TABLE TT ADD AGE NUMBER(3) FIRST;

-- 컬럼 수정하기
--ALTER TABLE TT MODIFY AGE NUMBER(길이);

-- 컬럼 삭제
ALTER TABLE TT DROP COLUMN AGE;

-- TABLE 삭제
DROP TABLE TT;

-- 게시글 TABLE 만들기
CREATE TABLE MEMO (
	IDX NUMBER(3) PRIMARY KEY,
	TITLE VARCHAR2(50) NOT NULL,
	CONTENT VARCHAR2(4000),
	PWD VARCHAR2(20) NOT NULL,
	WRITTER VARCHAR2(100) NOT NULL,
	IP VARCHAR2(30),
	WRITE_DATE DATE
);

-- INSERT문(추가하기)
INSERT INTO MEMO VALUES(1, '제목1', '내용1', '1111', '홍길동', '192.1.1', SYSDATE);
INSERT INTO MEMO VALUES(2, '제목1', '내용1', '1111', '홍길동', '192.1.1', SYSDATE);
INSERT INTO MEMO VALUES(3, '제목1', '내용1', '1111', '홍길동', '192.1.1', SYSDATE);
INSERT INTO MEMO VALUES(4, '제목1', '내용1', '1111', '홍길동', '192.1.1', SYSDATE);
INSERT INTO MEMO VALUES(5, '제목1', '내용1', '1111', '홍길동', '192.1.1', SYSDATE);

SELECT * FROM MEMO;

DROP TABLE MEMO;

/* UPDATE문(수정하기)
 *
 * UPDATE 테이블명 SET
 * 컬럼명 = 데이터,
 * 컬럼명 = 데이터
 * WHERE 조건식
 * */
 
/* DELETE문(삭제)
 * 
 * DELETE FROM 테이블명
 * WHERE IDX = 1;
 * */
 
-- SEQUENCE: 테이블에 값을 추가할 때 자동으로 순차적인 정수값이
--			  들어가도록 설정해주는 객체
CREATE SEQUENCE MEMO_SEQ; 

INSERT INTO MEMO VALUES(MEMO_SEQ.NEXTVAL, '제목1', '내용1', '1111', '홍길동', '192.1.1', SYSDATE);

SELECT * FROM MEMO;
 